Return-Path: <SRS0=GSyA=X4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1935DC47404
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 02:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE305222C2
	for <linux-block@archiver.kernel.org>; Thu,  3 Oct 2019 02:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NaPJx9TM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfJCCXU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Oct 2019 22:23:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfJCCXT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Oct 2019 22:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:Cc:From:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U7ID//fmK0I3/mly5XIM1JAun9eRn8qOXb/xC1yOZ7s=; b=NaPJx9TMnJtomA/xHlMbJXJx/
        Kv5U6nRpEOmnvcwREafAzIkHSylrg5f9ndQnIXh6YOr3uIZNpOMrYhBQsD4qgBssYZsmn6ROzYX4E
        fh1mOxtv0iFAcnMtHgaeGZertTYtI5+i/3Fp7DSDFZX1//+MWqeODnzAq6+I3nn1er7tMfD80t+gD
        Yn/IXRUf/sYyJCS39srLolLw6nsxh6Bg1ncociCRUQsgArB3ZhfMhbQNU3ngh6dxQfGmRRD8yoIO2
        tXtNiYrU8pWys8SxfjzORRVqeynIkzLaKx0tObmgvXshcGRJsijadIfxBB72hoBe6zL5bQnry7kWn
        QeaBdRTAg==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFqlv-0007r3-Mb; Thu, 03 Oct 2019 02:23:15 +0000
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, axboe <axboe@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>
Subject: [PATCH 2/2] block: sed-opal: fix sparse warning: convert __be64 data
Message-ID: <82f70133-7242-d113-f041-9b89694685c0@infradead.org>
Date:   Wed, 2 Oct 2019 19:23:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

sparse warns about incorrect type when using __be64 data.
It is not being converted to CPU-endian but it should be.

Fixes these sparse warnings:

../block/sed-opal.c:375:20: warning: incorrect type in assignment (different base types)
../block/sed-opal.c:375:20:    expected unsigned long long [usertype] align
../block/sed-opal.c:375:20:    got restricted __be64 const [usertype] alignment_granularity
../block/sed-opal.c:376:25: warning: incorrect type in assignment (different base types)
../block/sed-opal.c:376:25:    expected unsigned long long [usertype] lowest_lba
../block/sed-opal.c:376:25:    got restricted __be64 const [usertype] lowest_aligned_lba

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Scott Bauer <scott.bauer@intel.com>
Cc: Rafael Antognolli <rafael.antognolli@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
If this code is known to work as is, it would be nice to have an
explanation of it.  Oh: maybe it's just that these fields are not
used after they are saved/set.

 block/sed-opal.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-54-rc1.orig/block/sed-opal.c
+++ lnx-54-rc1/block/sed-opal.c
@@ -372,8 +372,8 @@ static void check_geometry(struct opal_d
 {
 	const struct d0_geometry_features *geo = data;
 
-	dev->align = geo->alignment_granularity;
-	dev->lowest_lba = geo->lowest_aligned_lba;
+	dev->align = be64_to_cpu(geo->alignment_granularity);
+	dev->lowest_lba = be64_to_cpu(geo->lowest_aligned_lba);
 }
 
 static int execute_step(struct opal_dev *dev,


