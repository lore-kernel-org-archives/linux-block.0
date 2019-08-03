Return-Path: <SRS0=u38M=V7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51A7C433FF
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 08:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614BD21783
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 08:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfHCIp7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Aug 2019 04:45:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbfHCIp7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 3 Aug 2019 04:45:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B32CD8830A;
        Sat,  3 Aug 2019 08:45:58 +0000 (UTC)
Received: from localhost (ovpn-116-62.ams2.redhat.com [10.36.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CC5119D7A;
        Sat,  3 Aug 2019 08:45:54 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@mail.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 1/4] COPYING: update to latest LGPL v2.1 text
Date:   Sat,  3 Aug 2019 09:45:23 +0100
Message-Id: <20190803084526.3837-2-stefanha@redhat.com>
In-Reply-To: <20190803084526.3837-1-stefanha@redhat.com>
References: <20190803084526.3837-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 03 Aug 2019 08:45:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rpmlint spotted that the LGPL v2.1 license file is outdated so I've
replaced it with the latest one from
https://www.gnu.org/licenses/old-licenses/lgpl-2.1.txt.

The Free Software Foundation address is outdated in COPYING and the file
still mentions LGPL v2 where the latest text mentions v2.1:

     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Lesser General Public
     License as published by the Free Software Foundation; either
-    version 2 of the License, or (at your option) any later version.
+    version 2.1 of the License, or (at your option) any later version.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
I'm not sure if the v2 vs v2.1 issue matters to the copyright holders of
liburing.  The reason I am posting this patch is to make rpmlint happy
but we could leave the file unchanged if you prefer.
---
 COPYING | 79 ++++++++++++++++++++++++---------------------------------
 1 file changed, 33 insertions(+), 46 deletions(-)

diff --git a/COPYING b/COPYING
index c4792dd..e5ab03e 100644
--- a/COPYING
+++ b/COPYING
@@ -1,9 +1,8 @@
-
                   GNU LESSER GENERAL PUBLIC LICENSE
                        Version 2.1, February 1999
 
  Copyright (C) 1991, 1999 Free Software Foundation, Inc.
-     59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -23,8 +22,7 @@ specially designated software packages--typically libraries--of the
 Free Software Foundation and other authors who decide to use it.  You
 can use it too, but we suggest you first think carefully about whether
 this license or the ordinary General Public License is the better
-strategy to use in any particular case, based on the explanations
-below.
+strategy to use in any particular case, based on the explanations below.
 
   When we speak of free software, we are referring to freedom of use,
 not price.  Our General Public Licenses are designed to make sure that
@@ -57,7 +55,7 @@ modified by someone else and passed on, the recipients should know
 that what they have is not the original version, so that the original
 author's reputation will not be affected by problems that might be
 introduced by others.
-^L
+
   Finally, software patents pose a constant threat to the existence of
 any free program.  We wish to make sure that a company cannot
 effectively restrict the users of a free program by obtaining a
@@ -89,8 +87,7 @@ libraries.  However, the Lesser license provides advantages in certain
 special circumstances.
 
   For example, on rare occasions, there may be a special need to
-encourage the widest possible use of a certain library, so that it
-becomes
+encourage the widest possible use of a certain library, so that it becomes
 a de-facto standard.  To achieve this, non-free programs must be
 allowed to use the library.  A more frequent case is that a free
 library does the same job as widely used non-free libraries.  In this
@@ -114,7 +111,7 @@ modification follow.  Pay close attention to the difference between a
 "work based on the library" and a "work that uses the library".  The
 former contains code derived from the library, whereas the latter must
 be combined with the library in order to run.
-^L
+
                   GNU LESSER GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 
@@ -139,8 +136,7 @@ included without limitation in the term "modification".)
   "Source code" for a work means the preferred form of the work for
 making modifications to it.  For a library, complete source code means
 all the source code for all modules it contains, plus any associated
-interface definition files, plus the scripts used to control
-compilation
+interface definition files, plus the scripts used to control compilation
 and installation of the library.
 
   Activities other than copying, distribution and modification are not
@@ -162,7 +158,7 @@ Library.
   You may charge a fee for the physical act of transferring a copy,
 and you may at your option offer warranty protection in exchange for a
 fee.
-
+
   2. You may modify your copy or copies of the Library or any portion
 of it, thus forming a work based on the Library, and copy and
 distribute such modifications or work under the terms of Section 1
@@ -220,7 +216,7 @@ instead of to this License.  (If a newer version than version 2 of the
 ordinary GNU General Public License has appeared, then you can specify
 that version instead if you wish.)  Do not make any other change in
 these notices.
-^L
+
   Once this change is made in a given copy, it is irreversible for
 that copy, so the ordinary GNU General Public License applies to all
 subsequent copies and derivative works made from that copy.
@@ -271,7 +267,7 @@ Library will still fall under Section 6.)
 distribute the object code for the work under the terms of Section 6.
 Any executables containing that work also fall under Section 6,
 whether or not they are linked directly with the Library itself.
-^L
+
   6. As an exception to the Sections above, you may also combine or
 link a "work that uses the Library" with the Library to produce a
 work containing portions of the Library, and distribute that work
@@ -333,7 +329,7 @@ restrictions of other proprietary libraries that do not normally
 accompany the operating system.  Such a contradiction means you cannot
 use both them and the Library together in an executable that you
 distribute.
-^L
+
   7. You may place library facilities that are a work based on the
 Library side-by-side in a single library together with other library
 facilities not covered by this License, and distribute such a combined
@@ -374,7 +370,7 @@ subject to these terms and conditions.  You may not impose any further
 restrictions on the recipients' exercise of the rights granted herein.
 You are not responsible for enforcing compliance by third parties with
 this License.
-^L
+
   11. If, as a consequence of a court judgment or allegation of patent
 infringement or for any other reason (not limited to patent issues),
 conditions are imposed on you (whether by court order, agreement or
@@ -388,10 +384,9 @@ all those who receive copies directly or indirectly through you, then
 the only way you could satisfy both it and this License would be to
 refrain entirely from distribution of the Library.
 
-If any portion of this section is held invalid or unenforceable under
-any particular circumstance, the balance of the section is intended to
-apply, and the section as a whole is intended to apply in other
-circumstances.
+If any portion of this section is held invalid or unenforceable under any
+particular circumstance, the balance of the section is intended to apply,
+and the section as a whole is intended to apply in other circumstances.
 
 It is not the purpose of this section to induce you to infringe any
 patents or other property right claims or to contest validity of any
@@ -409,11 +404,11 @@ be a consequence of the rest of this License.
 
   12. If the distribution and/or use of the Library is restricted in
 certain countries either by patents or by copyrighted interfaces, the
-original copyright holder who places the Library under this License
-may add an explicit geographical distribution limitation excluding those
-countries, so that distribution is permitted only in or among
-countries not thus excluded.  In such case, this License incorporates
-the limitation as if written in the body of this License.
+original copyright holder who places the Library under this License may add
+an explicit geographical distribution limitation excluding those countries,
+so that distribution is permitted only in or among countries not thus
+excluded.  In such case, this License incorporates the limitation as if
+written in the body of this License.
 
   13. The Free Software Foundation may publish revised and/or new
 versions of the Lesser General Public License from time to time.
@@ -427,7 +422,7 @@ conditions either of that version or of any later version published by
 the Free Software Foundation.  If the Library does not specify a
 license version number, you may choose any version ever published by
 the Free Software Foundation.
-^L
+
   14. If you wish to incorporate parts of the Library into other free
 programs whose distribution conditions are incompatible with these,
 write to the author to ask for permission.  For software which is
@@ -461,30 +456,27 @@ SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
 DAMAGES.
 
                      END OF TERMS AND CONDITIONS
-^L
+
            How to Apply These Terms to Your New Libraries
 
   If you develop a new library, and you want it to be of the greatest
 possible use to the public, we recommend making it free software that
 everyone can redistribute and change.  You can do so by permitting
-redistribution under these terms (or, alternatively, under the terms
-of the ordinary General Public License).
+redistribution under these terms (or, alternatively, under the terms of the
+ordinary General Public License).
 
-  To apply these terms, attach the following notices to the library.
-It is safest to attach them to the start of each source file to most
-effectively convey the exclusion of warranty; and each file should
-have at least the "copyright" line and a pointer to where the full
-notice is found.
+  To apply these terms, attach the following notices to the library.  It is
+safest to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least the
+"copyright" line and a pointer to where the full notice is found.
 
-
-    <one line to give the library's name and a brief idea of what it
-does.>
+    <one line to give the library's name and a brief idea of what it does.>
     Copyright (C) <year>  <name of author>
 
     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Lesser General Public
     License as published by the Free Software Foundation; either
-    version 2 of the License, or (at your option) any later version.
+    version 2.1 of the License, or (at your option) any later version.
 
     This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -493,23 +485,18 @@ does.>
 
     You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the Free Software
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
+    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 
-Also add information on how to contact you by electronic and paper
-mail.
+Also add information on how to contact you by electronic and paper mail.
 
-You should also get your employer (if you work as a programmer) or
-your
+You should also get your employer (if you work as a programmer) or your
 school, if any, to sign a "copyright disclaimer" for the library, if
 necessary.  Here is a sample; alter the names:
 
   Yoyodyne, Inc., hereby disclaims all copyright interest in the
-  library `Frob' (a library for tweaking knobs) written by James
-Random Hacker.
+  library `Frob' (a library for tweaking knobs) written by James Random Hacker.
 
   <signature of Ty Coon>, 1 April 1990
   Ty Coon, President of Vice
 
 That's all there is to it!
-
-
-- 
2.21.0

