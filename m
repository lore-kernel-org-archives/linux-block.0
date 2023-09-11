Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8543CCA0EC3
	for <linux-block@archiver.kernel.org>; Mon, 11 Sep 2023 23:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjIKX4o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Sep 2023 19:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbjIKXxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Sep 2023 19:53:04 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E8714AE3A
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 16:47:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c3257c8971so71643025ad.0
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 16:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694475988; x=1695080788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VtlA+KB8kDzwUN9dvFmpQoLjgzbj73lXqnrIpi3kP44=;
        b=g90ZU3pLsHI+eR2giAbU6hCuT5IAuZ7EIZ7XHjAVBmdmS+NHKcJASDjZG0FofubUYY
         ykxZeHXpZzXb0FY0RSp0nKFe6HtL63R6TJIufJLzWkj+1Dvtu4P8vpaFtK0Z/YnkCxcE
         +T4kgIpo+d4Wr/5H3v4PMsoLicOUSFr3wIn3nGTnOhiCVRZTvlvlXk2eIFbiunIC678Y
         Ob9pGsJa23/h9EgQFq465RzbXr3RrTuGC6FEgfOGVLKu253qft8O35BiAJ1RNeezixM4
         IJMaSiLkRYfPMZipq9ht82zg1+VQcyMuhkuwHmbvQkxJqcznEeieV3Hu1bYlh5RM73XM
         Pzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694475988; x=1695080788;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VtlA+KB8kDzwUN9dvFmpQoLjgzbj73lXqnrIpi3kP44=;
        b=hmhzmaLej6PJmhqZrdPAG/lU9BvAlGkO8hjqw61P+KD/8+IdoPEbBzPPNC+2PNmG33
         VvkThX4nm/cr89VrrUYewk5+TQY2DESUZsJVDiIFWqVOgZky0OJOUvMC1XAESgA7DU0p
         CmllgmdQt1sTTxM6LsPDMM0upKU89PXanCnw9KnIcTesCN44xtp6qKSU6VPVZEmU0Bqj
         pnzt3yQdPjADYkPfGNLQJcq2SJ7EQ4wLncIiI5YK4INHlVlSJHvFg76zXeTdsMNqXbvY
         dvI4B2h0UOMTM+hCe+rByma/KcA91oQBksXeHxDw1U8nT01SXWDqYISlTN9YFayS21sf
         5+Xw==
X-Gm-Message-State: AOJu0YwD/q6lMRldJpbWnesSo06YBZgnWbDwnOE8tZ+JQAtupPR2ocCJ
        2kVB9FTFr+xSeq+ANksSPX/GiFmV/FSotEf84Q==
X-Google-Smtp-Source: AGHT+IGz+NEEOx+kTbptMq4j+qCzNxFKiPoF3JBZuUXHlbhZqlK9zFaMBms4PxAmrlhTc5ZEYgefWanCKL3AQYpMWA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:108f:b0:d78:3c2e:b186 with
 SMTP id v15-20020a056902108f00b00d783c2eb186mr249352ybu.5.1694468808319; Mon,
 11 Sep 2023 14:46:48 -0700 (PDT)
Date:   Mon, 11 Sep 2023 21:46:47 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMaK/2QC/x3NTQ6CQAxA4auQrm1CGX+CVzHEDEPVhrGQVomGc
 HcnLr/Neys4m7DDuVrBeBGXSQtoV0F6RL0zylAMTd2EuiVCf5mm+YuDycLm2OcpjajvnK99HvE ZRTHhKexbOgSmdIxQWrPxTT7/z6Xbth9z69SrdwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694468807; l=2611;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=OWFJFfLu6R2MwsjnUT9XcLBqmI6CZTKqrnm0bDPTtIs=; b=LosAEspLXhaxEqoWCE/7ubiC5QsQX1wQYH8Q5dr8Rfy5EG7JDg1ORMnj9pREXDAE8Nr93Ab+Y
 J92caMRvcnwDaSGYgXwZQ8Lx07/ZJwt/KYaxiWbdy76qkHtaDS+f8AL
X-Mailer: b4 0.12.3
Message-ID: <20230911-strncpy-drivers-block-null_blk-main-c-v1-1-3b3887e7fde4@google.com>
Subject: [PATCH] null_blk: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should favor a more robust and less ambiguous interface.

We know `nullb->disk_name` is NUL-terminated and we expect that
`disk->disk_name` also be NUL-terminated:
|     snprintf(nullb->disk_name, sizeof(nullb->disk_name),
|              "%s", config_item_name(&dev->group.cg_item));

It seems like NUL-padding may be required due to __assign_disk_name()
utilizing a memcpy as opposed to a `str*cpy` api.
| static inline void __assign_disk_name(char *name, struct gendisk *disk)
| {
| 	if (disk)
| 		memcpy(name, disk->disk_name, DISK_NAME_LEN);
| 	else
| 		memset(name, 0, DISK_NAME_LEN);
| }

This puzzles me as immediately after assigning the disk name we
go and print it with `__print_disk_name` which wraps `nullb_trace_disk_name()`.
| #define __print_disk_name(name) nullb_trace_disk_name(p, name)

This function obviously expects a NUL-terminated string.
| const char *nullb_trace_disk_name(struct trace_seq *p, char *name)
| {
| 	const char *ret = trace_seq_buffer_ptr(p);
|
| 	if (name && *name)
| 		trace_seq_printf(p, "disk=%s, ", name);
| 	trace_seq_putc(p, 0);
|
| 	return ret;
| }

I suspect that NUL-padding is _not_ needed but to be overly cautious
let's use `strscpy_pad` (although I strongly suspect that whole memcpy
thing should be changed).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 864013019d6b..994919c63f05 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1938,7 +1938,7 @@ static int null_gendisk_register(struct nullb *nullb)
 	else
 		disk->fops		= &null_bio_ops;
 	disk->private_data	= nullb;
-	strncpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
+	strscpy(disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
 
 	if (nullb->dev->zoned) {
 		int ret = null_register_zoned_dev(nullb);

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230911-strncpy-drivers-block-null_blk-main-c-7349153e1c6a

Best regards,
--
Justin Stitt <justinstitt@google.com>

