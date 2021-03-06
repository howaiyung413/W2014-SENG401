/*
*
* @file DatabaseLoader.java
*
* Copyright (C) 2006-2009 Tensegrity Software GmbH
*
* This program is free software; you can redistribute it and/or modify it
* under the terms of the GNU General Public License (Version 2) as published
* by the Free Software Foundation at http://www.gnu.org/copyleft/gpl.html.
*
* This program is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
* FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
* more details.
*
* You should have received a copy of the GNU General Public License along with
* this program; if not, write to the Free Software Foundation, Inc., 59 Temple
* Place, Suite 330, Boston, MA 02111-1307 USA
*
* If you are developing and distributing open source applications under the
* GPL License, then you are free to use JPalo Modules under the GPL License.  For OEMs,
* ISVs, and VARs who distribute JPalo Modules with their products, and do not license
* and distribute their source code under the GPL, Tensegrity provides a flexible
* OEM Commercial License.
*
* @author Philipp Bouillon <Philipp.Bouillon@tensegrity-software.com>
*
* @version $Id: DatabaseLoader.java,v 1.7 2010/02/12 13:49:50 PhilippBouillon Exp $
*
*/

package com.tensegrity.wpalo.server.childloader.reportstructure;

import com.tensegrity.palo.gwt.core.client.models.XObject;
import com.tensegrity.palo.gwt.core.client.models.account.XAccount;
import com.tensegrity.palo.gwt.core.client.models.palo.XServer;
import com.tensegrity.palo.gwt.core.server.services.UserSession;
import com.tensegrity.wpalo.server.childloader.ChildLoader;

public class DatabaseLoader implements ChildLoader {

	public boolean accepts(XObject parent) {
		return parent instanceof XAccount &&
			parent.getType().equals(XServer.TYPE);
	}

	public XObject[] loadChildren(XObject parent, UserSession userSession) {
//		XAccount node = (XAccount) parent;
//		XUser xUser = node.getUser();
//		AuthUser user = (AuthUser) XObjectMatcher.getNativeObject(xUser);
//		if (user == null) {
//			return null;
//		}
//		Account acc = (Account) XObjectMatcher.getNativeObject(node);
//		if (acc == null || !(acc instanceof PaloAccount)) {
//			return null;
//		}
//		
//		List <XDatabase> allDatabases = new ArrayList<XDatabase>();
//		Connection con = ((PaloAccount) acc).login();
//		for (Database db: con.getDatabases()) {
//			if (db.isSystem()) {
//				continue;
//			}
//			XDatabase xdb = (XDatabase)XConverter.createX(db);
////			new XDatabase(db.getId(), db.getName(), 
////					db.getDimensionCount() > 0, xUser);
////			xdb.setType(XConstants.TYPE_DATABASE_NO_CUBES);
//			XObjectMatcher.put(xdb, db);
//			allDatabases.add(xdb);
//		}
//		return allDatabases.toArray(new XDatabase[0]);
		return new XObject[0];
	}
}
