Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38564C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 15:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381851AbhLCPmB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 10:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381867AbhLCPmA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 10:42:00 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142DEC061353
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 07:38:36 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id j21so3089724ila.5
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0F2twjIx4NmxUZNO6rvzL0OidoPYFlJudXfQWPXRJI=;
        b=HOYS28dB+hf7PjSdhk0KEDvwuC5KVLlJPN5YqZZZeFpwh8+wgfG6WE3Y7xlAXUNK00
         riELvOdzKOTEmTmSBb+trw1x9oUpxw1UZqyOjnz0zLRLXYcMCcS3dmjaOmUffQVxQyWs
         4VeJjqwe+mOtQ3u133rotKSCR5U3vawPNBedcF8wtFZrah9Ajeb42I9KLxdKj2NWFEz0
         QvdC9dbengdqfr5dpD50D/WlahrRAOc/wEUI6yZgsHVrufF5mOX6Zcih6rKfmf3jVo/D
         nD3idtZJws1ItQ71mu/xBTJWti1NjCa85o7CVYgFxv2x/IhSO9uVmXXEEPD6/2MAedbG
         bScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0F2twjIx4NmxUZNO6rvzL0OidoPYFlJudXfQWPXRJI=;
        b=3MZwkHx40L7awQmscW1UuDiQDgNEFj6JdXkSvpiSNJ52UsETY7+Zl/lFKRPrewKjfg
         ocI8W54sGyQznirvh+3cwJd2szuH99d+Pcjl4HtHC+y5iS0CHThBupDbFinmDg/qVjeB
         P5s7y96YidWVwsvqvSjhBOey2zVlJpPan7coEynlhvgnI10mlqPlNZHblqnqb5sY4zw9
         Opvw+91cqEeXAc00ldOpmzv1Qb/lpsaASOnJB/OZLY0z9PHqrQTARcCpgKXU0YbRdgPw
         63R1U+XrUiUf/bsnx6cxMDcNJImRHg21mknJmpkm1WwYE7QmNRv0VxELixAcLuznh9WM
         pJ/A==
X-Gm-Message-State: AOAM532mIFTYyJy1yKTkKI+aKJ014mqC/bJCDLH/gn0Swehm1w/k+R3p
        t9EDLQLUpcJiMYoJ/5tQXt98QLzT8nwKkhwK
X-Google-Smtp-Source: ABdhPJypBb2scW85GQGRdq2BTbwmtkv74gMtEvSbk1YgLbiD/4HFcK6ryenFEVuW9Pac/1fyDooBww==
X-Received: by 2002:a92:4a04:: with SMTP id m4mr18093924ilf.103.1638545915002;
        Fri, 03 Dec 2021 07:38:35 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c15sm1753042ilq.50.2021.12.03.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 07:38:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-mm@kvack.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: move direct_IO into our own read_iter handler
Date:   Fri,  3 Dec 2021 08:38:29 -0700
Message-Id: <20211203153829.298893-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203153829.298893-1-axboe@kernel.dk>
References: <20211203153829.298893-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't call into generic_file_read_iter() if we know it's O_DIRECT, just
set it up ourselves and call our own handler. This avoids an indirect call
for O_DIRECT.

Fall back to filemap_read() if we fail.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/fops.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 93bb5bf66f69..10015e1a5b01 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -566,21 +566,48 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct block_device *bdev = iocb->ki_filp->private_data;
 	loff_t size = bdev_nr_bytes(bdev);
+	size_t count = iov_iter_count(to);
 	loff_t pos = iocb->ki_pos;
 	size_t shorted = 0;
-	ssize_t ret;
+	ssize_t ret = 0;
 
-	if (unlikely(pos + iov_iter_count(to) > size)) {
+	if (unlikely(pos + count > size)) {
 		if (pos >= size)
 			return 0;
 		size -= pos;
-		if (iov_iter_count(to) > size) {
-			shorted = iov_iter_count(to) - size;
+		if (count > size) {
+			shorted = count - size;
 			iov_iter_truncate(to, size);
 		}
 	}
 
-	ret = generic_file_read_iter(iocb, to);
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		struct address_space *mapping = iocb->ki_filp->f_mapping;
+
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (filemap_range_needs_writeback(mapping, iocb->ki_pos,
+						iocb->ki_pos + count - 1))
+				return -EAGAIN;
+		} else {
+			ret = filemap_write_and_wait_range(mapping,
+						iocb->ki_pos,
+					        iocb->ki_pos + count - 1);
+			if (ret < 0)
+				return ret;
+		}
+
+		file_accessed(iocb->ki_filp);
+
+		ret = blkdev_direct_IO(iocb, to);
+		if (ret >= 0) {
+			iocb->ki_pos += ret;
+			count -= ret;
+		}
+		if (ret < 0 || !count)
+			return ret;
+	}
+
+	ret = filemap_read(iocb, to, ret);
 
 	if (unlikely(shorted))
 		iov_iter_reexpand(to, iov_iter_count(to) + shorted);
-- 
2.34.1

