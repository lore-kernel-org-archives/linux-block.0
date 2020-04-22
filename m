Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31BBC55189
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF111206A2
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oRwTvjUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgDVHjT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726496AbgDVHjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 03:39:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA1AC03C1A6;
        Wed, 22 Apr 2020 00:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=asQV3F7IslXMHtlCxbVhPvV8Zub514qkpUIfxyxKXq8=; b=oRwTvjUQ/k8mWzHLiI6zzEYPyW
        QitGJwxRfIWdE27d8EXalFiXqJddJoR8XsSP4hF6kXNqzXPFSXcn9WPNNaAPBXTVbfTkpmlajKVZz
        LsMT+al29YPykhD7/9CZDvbEHSGmKSZ5ckWoCyFyGvxxBDbpHCsMvd2XXi9N54e5ejiK35w/X2waO
        my7uk6Lh5IxzCUi1VZ8efgMIUkbi2C7j7rlAvltNWniQJdRNFs6UqQV0rRseDkpK8fnNlqNtsqxW/
        lNFpLIkePOawHGdpKp5qwSnt7R0BAbKKsv8ZSnFnoS2xnywOVMN5xAi1JVRihJYADQz+ZpKsLYRYc
        bZI5to0w==;
Received: from [2001:4bb8:191:e12c:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9yO-0000BX-1u; Wed, 22 Apr 2020 07:39:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] bdi: unexport bdi_register_va
Date:   Wed, 22 Apr 2020 09:38:48 +0200
Message-Id: <20200422073851.303714-7-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422073851.303714-1-hch@lst.de>
References: <20200422073851.303714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bdi_register_va is only used by super.c, which can't be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/backing-dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index efc5b83acd2d..eb6b51e49d11 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -964,7 +964,6 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	trace_writeback_bdi_register(bdi);
 	return 0;
 }
-EXPORT_SYMBOL(bdi_register_va);
 
 int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...)
 {
-- 
2.26.1

