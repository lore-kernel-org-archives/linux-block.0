Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F86BC43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 20:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD7B222C4
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 20:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haEST2d9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfLIUO5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:14:57 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43943 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLIUO4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 15:14:56 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so13366625oth.10;
        Mon, 09 Dec 2019 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G4ssoJVMzXYKSaITeXCbCdqWsNm++w07wgKnILG/bgg=;
        b=haEST2d94B5TmCZrM6JPC6BcdhKhvdNK1ez37JXwt8b1vTyX2uql97OBBZepl9hgh0
         Aro/zgnNe+82W8KdhOviCVboGuBF+/B+4B7jckmAQv6Mh9eBErJy3v7HYwHq6JhnAOr5
         ugOcjw3VtBQQmYiDrZGc2CN8wAPAmsmDcerXFTMLly5hGp6hwPdTG73Pb3ioBIJuwcmH
         LVCx9Uj3EuqWgw0pQdq7eFZe4uUGrR9B1sDYT/FqU6Sq9rBSWnfKp7AllvGgkamAyY1D
         XK1AjGS6WuGZw7vyiKOcEp7zfHtx6DmahqOQJqm0QS045g61YP/46rE9GcmDW8qIsQgn
         cpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G4ssoJVMzXYKSaITeXCbCdqWsNm++w07wgKnILG/bgg=;
        b=BxOJNKkLOneg5MjMCYK/8oskhgfbdIE+xy/bPfBqfJ77SFNU4Jx56pyYGhgAiaXkgR
         FvGAdOgg7xn/9/spsUpvYPHbO2PXnag/MBs5rJ9SpUrOsJl++Q2aUI+SyA0Ho3KUrxdA
         ZELFYEX7GdNmijkNvQ8g5D3VOBP7QyQIKK2zlvNdLw44FU+JYa1kiUTVzG03FhGwoa51
         Y/voHsad/ey6/gjg2tusxncFTu1GaZYFaGUnTurll3R9WT8Ng4OERGZKTK8xmbo2m87t
         G6nyyGbqVIm/o6Pzt5XXE/L7SfSzMTFzsRTY6u7XQRjGS3X1DlgiO6uvV0AIaymXtvbH
         iEYw==
X-Gm-Message-State: APjAAAW8GWeUaa/jxlaMCnlL+iTfOm1pHnhct3aXiLyDi1DfzEw3cPzv
        laG8gs9qDcr4RkodTeiIiZPEvyfwC6U=
X-Google-Smtp-Source: APXvYqwtJH5AIBsowE8iyT5Wwd/+RpbfvNZzd2/T/yaZlpHGDcKsUA8xSbkAO2wxxt1C7Oi7XlTpyg==
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr22298966otq.126.1575922495982;
        Mon, 09 Dec 2019 12:14:55 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id z21sm339576oto.52.2019.12.09.12.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 12:14:55 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] xen/blkfront: Adjust indentation in xlvbd_alloc_gendisk
Date:   Mon,  9 Dec 2019 13:14:44 -0700
Message-Id: <20191209201444.33243-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Clang warns:

../drivers/block/xen-blkfront.c:1117:4: warning: misleading indentation;
statement is not part of the previous 'if' [-Wmisleading-indentation]
                nr_parts = PARTS_PER_DISK;
                ^
../drivers/block/xen-blkfront.c:1115:3: note: previous statement is here
                if (err)
                ^

This is because there is a space at the beginning of this line; remove
it so that the indentation is consistent according to the Linux kernel
coding style and clang no longer warns.

While we are here, the previous line has some trailing whitespace; clean
that up as well.

Fixes: c80a420995e7 ("xen-blkfront: handle Xen major numbers other than XENVBD")
Link: https://github.com/ClangBuiltLinux/linux/issues/791
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/block/xen-blkfront.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index a74d03913822..c02be06c5299 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1113,8 +1113,8 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 	if (!VDEV_IS_EXTENDED(info->vdevice)) {
 		err = xen_translate_vdev(info->vdevice, &minor, &offset);
 		if (err)
-			return err;		
- 		nr_parts = PARTS_PER_DISK;
+			return err;
+		nr_parts = PARTS_PER_DISK;
 	} else {
 		minor = BLKIF_MINOR_EXT(info->vdevice);
 		nr_parts = PARTS_PER_EXT_DISK;
-- 
2.24.0

