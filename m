Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C669C04EBA
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E53D220645
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XkwHIhk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53D220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404014AbeKVMdW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391622AbeKVMdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9D8eW6GOVmmM2gpA2eEdouwWlydtxoK5sk96NMKv5oE=; b=XkwHIhk5KCLuCcMwXbld15rGf
        kSOH/NenvXk9sJA9ZTxt72hiykecv7Gvs+3MZnTSypL7E2hv3f05H+orhnNDEGig6ZfMUusUIGW/Y
        /hOLTUzS0GKDu09pnWAdULWenMvA58fLqy4c0Rsu8v7H/QXowwUdWzXD8G1VNb5OS+D7wB0O6E3yz
        ofS4kj83nMvOhJpP7TGqWMlhPnYEHG03leYKKFApf2EX2B0kCWX87BEL6nFUeh+WAANkiYoh0rAFp
        ltt55ujeGoV0TKXLaohUGfXWrOhrgGQKtalkfjsWQn1Bu3lqPQVQnWJ7xAjinTALutcGcN5u5GD01
        wdraYkOMQ==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeE6-0006v0-9x; Thu, 22 Nov 2018 01:56:18 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 03/13] iov_iter: pass void csum pointer to csum_and_copy_to_iter
Date:   Wed, 21 Nov 2018 17:56:01 -0800
Message-Id: <20181122015615.15763-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

The single caller to csum_and_copy_to_iter is skb_copy_and_csum_datagram
and we are trying to unite its logic with skb_copy_datagram_iter by passing
a callback to the copy function that we want to apply. Thus, we need
to make the checksum pointer private to the function.

Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 include/linux/uio.h | 2 +-
 lib/iov_iter.c      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 55ce99ddb912..41d1f8d3313d 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -266,7 +266,7 @@ static inline void iov_iter_reexpand(struct iov_iter *i, size_t count)
 {
 	i->count = count;
 }
-size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
+size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump, struct iov_iter *i);
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7ebccb5c1637..db93531ca3e3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1432,10 +1432,11 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 }
 EXPORT_SYMBOL(csum_and_copy_from_iter_full);
 
-size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
+size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 			     struct iov_iter *i)
 {
 	const char *from = addr;
+	__wsum *csum = csump;
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-- 
2.17.1

