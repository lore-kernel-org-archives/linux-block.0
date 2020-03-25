Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2797AC54FD4
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 11:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19402077D
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 11:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qDDgqwli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgCYLFz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:05:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgCYLFy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 07:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0Q/PsNYhgC9YP8YaZ52QUXhrmyKsMuJKExt0WQ6jMiI=; b=qDDgqwliiP/3oezLXBj2Sd+CDR
        nABsix3LAQf9zr7jOUraGeneW9xn7bTyxfnGO5SfvasDDnTQBXDS4TaKfnRO48qVeR3Ki6DDgz1OQ
        1K187Hy76DIqXKO5ekSUBZhedz8yBVWEUk3xy8Cs/CcoO20Lca32y343z8gyxPjeVLQeBFlUAmcWw
        QcGQqMzFlBUHZKMiS+lL8FqTDu1oGwZp90dXsmcDiWawV3hKuoAVVGYVKJXMFgIU7U+3cDIpID+dH
        mqHhpvRTUS8RXudaZcQIrkzEkRt0nP5hGLQl34wlQ2kgTWFIvtYJMFh9+GSNIRxwF11owk/SwBEA6
        /un+ylSw==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH3r8-0001sv-2C; Wed, 25 Mar 2020 11:05:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] block: mark block_depr static
Date:   Wed, 25 Mar 2020 12:03:31 +0100
Message-Id: <20200325110338.1029232-2-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325110338.1029232-1-hch@lst.de>
References: <20200325110338.1029232-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 2 +-
 include/linux/genhd.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index f7d60b620b97..52841f41d6eb 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -27,7 +27,7 @@
 #include "blk.h"
 
 static DEFINE_MUTEX(block_class_lock);
-struct kobject *block_depr;
+static struct kobject *block_depr;
 
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index da62b44b15be..7310108f5351 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -27,7 +27,6 @@
 #define part_to_dev(part)	(&((part)->__dev))
 
 extern struct device_type part_type;
-extern struct kobject *block_depr;
 extern struct class block_class;
 
 #define DISK_MAX_PARTS			256
-- 
2.25.1

