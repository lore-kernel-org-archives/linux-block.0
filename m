Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B5FC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 11:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF76A218FD
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 11:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfCULu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:50:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfCULu2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Mar 2019 07:50:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C60A63082AF0;
        Thu, 21 Mar 2019 11:50:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 261B760BF2;
        Thu, 21 Mar 2019 11:50:24 +0000 (UTC)
Subject: [RFC PATCH 0/6] Convert mount_single-using filesystems to fs_context
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, squashfs-devel@lists.sourceforge.net,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Nicolas Pitre <nico@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Date:   Thu, 21 Mar 2019 11:50:24 +0000
Message-ID: <155316902426.29884.2476392753144421312.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 21 Mar 2019 11:50:28 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Al,

Here's a set of patches that convert romfs, cramfs, jffs2 and squashfs to
use the new fs_context struct and replace mount_mtd().  They have
prerequisite commits (such as replacing mount_bdev()) that can be found in
the branch detailed below.

 (1) Provide a replacement for mount_mtd() that takes an fs_context to
     specify the parameters.

     I also put an mtd device pointer into the fs_context struct for use in
     the sget_fc() test and set functions plus a destructor because
     put_fs_context() can't reach into the mtd module.

 (2) Convert romfs.

 (3) Convert cramfs.

 (4) Convert jffs2.

 (5) Get rid of the now-obsolete mount_mtd() function.

 (6) Convert squashfs.

These can be found in the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-viro

Thanks,
David
---
David Howells (6):
      mtd: Provide fs_context-aware mount_mtd() replacement
      romfs: Convert to fs_context
      cramfs: Convert to fs_context
      jffs2: Convert to fs_context
      mtd: Kill off mount_mtd()
      squashfs: Convert to fs_context


 drivers/mtd/mtdcore.h      |    1 
 drivers/mtd/mtdsuper.c     |  181 ++++++++++++++++++++++----------------------
 fs/cramfs/inode.c          |   69 +++++++++--------
 fs/fs_context.c            |    2 
 fs/jffs2/fs.c              |   21 +++--
 fs/jffs2/os-linux.h        |    4 -
 fs/jffs2/super.c           |  172 ++++++++++++++++++++----------------------
 fs/romfs/super.c           |   46 +++++++----
 fs/squashfs/super.c        |  100 +++++++++++++-----------
 include/linux/fs_context.h |    2 
 include/linux/mtd/super.h  |    6 +
 11 files changed, 316 insertions(+), 288 deletions(-)

