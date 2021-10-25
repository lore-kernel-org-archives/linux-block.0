Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B01C4332F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE1C604AC
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhJYJtf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhJYJsK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:48:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA04C061243
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 02:45:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id oa4so7833699pjb.2
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 02:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TqXG0/tzAMme0lqJcgyNBNW84HzqzOSloOMxwNDMqnk=;
        b=kJn8WmBPxx2lPt7y+97D6FpgwkUWAAljn+Zm+aBrEBCA99yKW7fVRUnA2WZKE1sYeK
         +N7QI6AvoMlxnStRSMsS6WyoC9ZeLJllS7sftIqEP8tBbAMPgwh6a7+Tuak6los3qU57
         1YtBkzgTlJWbyRd8qlOZo6Aktn3XtwW71ZLwdKY/RPjX3LLOgSrt5btja+2VCTtchCY0
         mUjfmvk+xybbjbz55fxHZ4vrCckGLOSI/A5pf8bp+OHNVHVJ25uFHaykX99gEh3L5vFt
         2bmQzUEQhfeghTXEeSdLw2dEyyePTaP9UMSGeK1SyBQRzuCk1kochTNqsrk/h/jYtFW+
         5Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqXG0/tzAMme0lqJcgyNBNW84HzqzOSloOMxwNDMqnk=;
        b=1u3iaZDFIzD1+GdFjBup8TYa0c9PmCIVYZE07x9v6cjPBl1qnXR8kvgIxsSdGl4HCz
         hZzCcgM4fAgHBdIm1pF1PvH1ZNbYhHjc4D4ZaKAtHa2zDM/LfrU8OgL7BuXX7ZXz7szl
         u/Q9R7udc0yA5jIgPuGVN86Z62g5gZcMjCT3gbIgeHIh4wVHMWAvBeXUcW+OfSmgczWG
         6MScw1lxiNuOcJMd4ndKhLVIKSLN+Zi6fJ26iTbBrgs7IbMn8/r37ws8qKnksX01JMcA
         SMi4h7WFQEsgAEvG7xyDiEzWnClixE8zh5+r2JO5Q/piZOiigVEsJGB/77cAFOJH0QJh
         xNqQ==
X-Gm-Message-State: AOAM533yMbONRocqnvBunTqUxhGmhxeku73dRKi4REFh2fIOnaro9Y3r
        jPZIbBlISrr5P8q/7VCYWEYP
X-Google-Smtp-Source: ABdhPJyYnUBUJBlE5vmoLy7tjBAXomLv28tkul4/ceDm5JlLpp1BoaCPHDhe79iQ//++rOpn7NVmAQ==
X-Received: by 2002:a17:90a:bd04:: with SMTP id y4mr19448627pjr.99.1635155147764;
        Mon, 25 Oct 2021 02:45:47 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id f17sm4738576pfv.69.2021.10.25.02.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 02:45:47 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     axboe@kernel.dk, hch@lst.de, josef@toxicpanda.com, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, kwolf@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 1/4] block: Add a helper to validate the block size
Date:   Mon, 25 Oct 2021 17:43:03 +0800
Message-Id: <20211025094306.97-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025094306.97-1-xieyongji@bytedance.com>
References: <20211025094306.97-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There are some duplicated codes to validate the block
size in block drivers. This limitation actually comes
from block layer, so this patch tries to add a new block
layer helper for that.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 include/linux/blkdev.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 12b9dbcc980e..805cd02d7914 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -235,6 +235,14 @@ struct request {
 	void *end_io_data;
 };
 
+static inline int blk_validate_block_size(unsigned int bsize)
+{
+	if (bsize < 512 || bsize > PAGE_SIZE || !is_power_of_2(bsize))
+		return -EINVAL;
+
+	return 0;
+}
+
 static inline bool blk_op_is_passthrough(unsigned int op)
 {
 	op &= REQ_OP_MASK;
-- 
2.11.0

