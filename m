Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F0C433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 08:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiBPInI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:43:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBPInH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 03:43:07 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8402D1704E2
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 00:42:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id x4so1487148plb.4
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 00:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qY0+CcAiCiceVtxes8e3Q80Ldr0PhM46jmJFDF3A7ao=;
        b=mLdrZdU4n4hLz+N3Llpx0+c6nTTU2S6rggBmN5QzR6DWCTWxzGr/FkJHfcr3iGgcQZ
         2euVNeKqQpiYwCSF0KlsIdjN4NwxBBNTZbN4kdfF0Z4Gx9qeGC167tW0D1VvgIyP0EMs
         S+C9QXMT/rWSDOJdrZiILLrk9pmNgG11fbo0X/n8z/0DZksRX7HvQ7Ha2kqFK7QISewo
         6OyBMAIIbd7i0PrFwA3IXHKXNLotKsSjmGfnAD+NfDQh74JwJ3Ey7jSHcoi0tCkfJHqf
         gOmwtxDZCSh46JRfLyCFSWz8NwMAiAoE1YFz2ZRn6OQHa3XS2o/edgymSC0n23HJl24p
         er3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qY0+CcAiCiceVtxes8e3Q80Ldr0PhM46jmJFDF3A7ao=;
        b=Lf1kZA6bUmSj68Oqw2LSwKVSd032AN17oV4TtHS4Ckoi1F4w9YGS0SyBA+WiVfsGB8
         1WQm6/zIivTmqKZbTgI/S9ewctc0YxnzIIR1MzPje4TDJgIyM2bYGagt0jTislbFomgf
         gUS92CJZW5wMxQtbdJuAF/FVDL4KzVpqYkC5k0Scy73q+677YNP50A2pu3mGLKiYnDPa
         EHK2wa3gekY+3P+hX7wERc4UscHBWpec7r5n43eMs/LhQIDqQRM7mn+Was4/G9Bb2qYq
         Mj1QJMBFHW3VwOU7vBg/LWzv6G9H5yUcsNSLXB/61tigW80N9UUtF3iw1tRcxNwsdEUi
         7OjQ==
X-Gm-Message-State: AOAM5313H0Xb/XzGtIB0wjyC4+FbhyIj+LIiceKtnB/E1bjI7Ipfs5DU
        +LJ6yfnZObMXyYtcWt5Dgl9FvZL2RN4=
X-Google-Smtp-Source: ABdhPJwtHDsJFe3QosyD2uHzDXuy4WnT1LcwQE4N6kCZcuyueb3iBlh/JG83bFAvykbUC7E6AVRkJw==
X-Received: by 2002:a17:902:9a0a:b0:14a:199:bc5c with SMTP id v10-20020a1709029a0a00b0014a0199bc5cmr1531421plp.10.1645000974936;
        Wed, 16 Feb 2022 00:42:54 -0800 (PST)
Received: from ELIJAHBAI-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id g11sm5390491pfj.83.2022.02.16.00.42.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Feb 2022 00:42:54 -0800 (PST)
From:   Haimin Zhang <tcs.kernel@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Haimin Zhang <tcs.kernel@gmail.com>
Subject: [PATCH] block-map: add __GFP_ZERO flag for alloc_page in function bio_copy_kern
Date:   Wed, 16 Feb 2022 16:40:38 +0800
Message-Id: <20220216084038.15635-1-tcs.kernel@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add __GFP_ZERO flag for alloc_page in function bio_copy_kern to initialize
the buffer of a bio.

Signed-off-by: Haimin Zhang <tcs.kernel@gmail.com>
---
This can cause a kernel-info-leak problem.
0. This problem occurred in function scsi_ioctl. If the parameter cmd is SCSI_IOCTL_SEND_COMMAND, the function scsi_ioctl will call sg_scsi_ioctl to further process.
1. In function sg_scsi_ioctl, it creates a scsi request and calls blk_rq_map_kern to map kernel data to a request.
3. blq_rq_map_kern calls bio_copy_kern to request a bio.
4. bio_copy_kern calls alloc_page to request the buffer of a bio. In the case of reading, it wouldn't fill anything into the buffer.

```
__alloc_pages+0xbbf/0x1090 build/../mm/page_alloc.c:5409
alloc_pages+0x8a5/0xb80
bio_copy_kern build/../block/blk-map.c:449 [inline]
blk_rq_map_kern+0x813/0x1400 build/../block/blk-map.c:640
sg_scsi_ioctl build/../drivers/scsi/scsi_ioctl.c:618 [inline]
scsi_ioctl+0x40c0/0x4600 build/../drivers/scsi/scsi_ioctl.c:932
sg_ioctl_common build/../drivers/scsi/sg.c:1112 [inline]
sg_ioctl+0x3351/0x4c10 build/../drivers/scsi/sg.c:1165
vfs_ioctl build/../fs/ioctl.c:51 [inline]
__do_sys_ioctl build/../fs/ioctl.c:874 [inline]
__se_sys_ioctl+0x2df/0x4a0 build/../fs/ioctl.c:860
__x64_sys_ioctl+0xd8/0x110 build/../fs/ioctl.c:860
do_syscall_x64 build/../arch/x86/entry/common.c:51 [inline]
do_syscall_64+0x54/0xd0 build/../arch/x86/entry/common.c:82
entry_SYSCALL_64_after_hwframe+0x44/0xae
```

5. Then this request will be sent to the disk driver. When bio is finished, bio_copy_kern_endio_read will copy the readed content back to parameter data from the bio.
But if the block driver didn't process this request, the buffer of bio is still unitialized.

```
memcpy_from_page build/../include/linux/highmem.h:346 [inline]
memcpy_from_bvec build/../include/linux/bvec.h:207 [inline]
bio_copy_kern_endio_read+0x4a3/0x620 build/../block/blk-map.c:403
bio_endio+0xa7f/0xac0 build/../block/bio.c:1491
req_bio_endio build/../block/blk-mq.c:674 [inline]
blk_update_request+0x1129/0x22d0 build/../block/blk-mq.c:742
scsi_end_request+0x119/0xe40 build/../drivers/scsi/scsi_lib.c:543
scsi_io_completion+0x329/0x810 build/../drivers/scsi/scsi_lib.c:939
scsi_finish_command+0x6e3/0x700 build/../drivers/scsi/scsi.c:199
scsi_complete+0x239/0x640 build/../drivers/scsi/scsi_lib.c:1441
blk_complete_reqs build/../block/blk-mq.c:892 [inline]
blk_done_softirq+0x189/0x260 build/../block/blk-mq.c:897
__do_softirq+0x1ee/0x7c5 build/../kernel/softirq.c:558
```

6. Finally, the internal buffer's content is copied to the user buffer which is specified by the parameter sic->data of sg_scsi_ioctl.
_copy_to_user+0x1c9/0x270 build/../lib/usercopy.c:33
copy_to_user build/../include/linux/uaccess.h:209 [inline]
sg_scsi_ioctl build/../drivers/scsi/scsi_ioctl.c:634 [inline]
scsi_ioctl+0x44d9/0x4600 build/../drivers/scsi/scsi_ioctl.c:932
sg_ioctl_common build/../drivers/scsi/sg.c:1112 [inline]
sg_ioctl+0x3351/0x4c10 build/../drivers/scsi/sg.c:1165
vfs_ioctl build/../fs/ioctl.c:51 [inline]
__do_sys_ioctl build/../fs/ioctl.c:874 [inline]
__se_sys_ioctl+0x2df/0x4a0 build/../fs/ioctl.c:860
__x64_sys_ioctl+0xd8/0x110 build/../fs/ioctl.c:860
do_syscall_x64 build/../arch/x86/entry/common.c:51 [inline]
do_syscall_64+0x54/0xd0 build/../arch/x86/entry/common.c:82
entry_SYSCALL_64_after_hwframe+0x44/0xae
 block/blk-map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 4526adde0156..c7f71d83eff1 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -446,7 +446,7 @@ static struct bio *bio_copy_kern(struct request_queue *q, void *data,
 		if (bytes > len)
 			bytes = len;
 
-		page = alloc_page(GFP_NOIO | gfp_mask);
+		page = alloc_page(GFP_NOIO | __GFP_ZERO | gfp_mask);
 		if (!page)
 			goto cleanup;
 
-- 
2.30.1 (Apple Git-130)

