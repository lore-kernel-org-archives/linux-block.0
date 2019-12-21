Return-Path: <SRS0=rhTN=2L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EF8C2D0C0
	for <linux-block@archiver.kernel.org>; Sat, 21 Dec 2019 12:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B7F2070C
	for <linux-block@archiver.kernel.org>; Sat, 21 Dec 2019 12:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfLUMpi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Dec 2019 07:45:38 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:53001 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfLUMpi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Dec 2019 07:45:38 -0500
Received: from klappe2.local ([80.187.114.20]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.130]) with ESMTPSA (Nemesis) id
 1M6H7o-1ic2Qo3cN6-006gyn; Sat, 21 Dec 2019 13:45:35 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] compat_ioctl: block: add missing include
Date:   Sat, 21 Dec 2019 12:45:30 +0000
Message-Id: <1576932330-32095-1-git-send-email-arnd@arndb.de>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:PGahc2NOKbsTSPnDNuX3+86D+trvODF3aHNu7G5NN1Hz2/N1DIc
 S9BZNZm2USvCvy6OP2xsecwgDeRwv8vPrxNL67cILWzBFyts3JAERh1qPsINCOUPRbgJrM1
 9JRiwnGfIu83sp2akK5/j5Gw82EThJKKFp/ZkhDAMrzHpZuAoVHxPus5mXlCCg4eO6/zlNS
 sJ2pN6ZcEccndNu2FFGMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lKdnAMuUh90=:KUCWhSgpkqP5rvClKQnded
 J5UE0BluTjGir3/f9D0vXxKZ1oF85zu6cQPM8avBEKV5ridznQsc6yyet6Yhb8TeBDKs80NCj
 HKoP5IMNrGYJbmgBDmzoP7FEmHAGh2fP5YjcTy6QdCoOPpCRMAEDK9XzzEdUR/cvEHVbNsJ3z
 2tHGg2nU1JA1gQJINDkIAajVpFPSdehf0PnhNZln66YbkStuCMXU1p+/3IUworVH1/rjPZWmH
 DyvIcEnICxuisAaNFrI6BopLyvZH4E3icyxIcdigwZ+KqbcVsGeYUOeVAKpXn8kQ+FxW1YDk+
 1qkos3UpP3mxr44LpTPoB2FnsHRixajAMzXuAwUwp4QLfS30J3xDp21ikDPPS3t5/tt9Q8IDy
 9TToA/7rFOkksnXW/juWPjczeyDI8G8POb0Dy9mkRtMHcMpIR9kHZ2KanKDWFTrMRg06zJUhP
 FsVFrsIN5rz8Npg4wvdQApFeqXkhwZGS8iNuYAuGUq95UQ48aIcMl/bgltNX9eirIUkSwEKaI
 sey1KI36hbaToHFW+74MNaQLCCHQE1eRjK3OtHn7ESYCiRv50d4aQdUWXVJ0z3xNi6o9WB+If
 CIVESQgMzfSf+hHIYmHEAlsoWIa0kU5fkMO1gn1GqENP9hFb2BbcCswao7LuTbZVWrgcDkEkh
 HHNNQvB2QfYigKHydxgSA6GpkznHeg3aYrWo2BIt2bAJ8qH7gLhzKBoJfNC6p6K7k41bp3T4W
 bmO9NYxC34fnaXrNgZ0qCLK20bmfZuFLBhUKwAB8krkNd3xl0ltTS4usnKYPFQxoxeGjv5KnM
 Th7b48kaQWnobDvnNf/OpngrKXcNNI12GpjmqOYQDMNRjJcJ+Ng+SAcRuD0TpagfY1G0spHGA
 JYDlbyIQ7Zvx9im1PjOg==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As the 0day bot pointed out, a header inclusion is missing in
my earlier bugfixes:

block/compat_ioctl.c: In function 'compat_blkdev_ioctl':
 block/compat_ioctl.c:411:7: error: 'IOC_PR_REGISTER' undeclared (first use in this function); did you mean 'TRACE_REG_REGISTER'?

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/compat_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index f16ae92..3ed7a0f 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -6,6 +6,7 @@
 #include <linux/compat.h>
 #include <linux/elevator.h>
 #include <linux/hdreg.h>
+#include <linux/pr.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
 #include <linux/types.h>
-- 
2.7.4

