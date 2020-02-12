Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644F4C2BA83
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 17:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372552073C
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 17:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVeiDX04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgBLRkd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:40:33 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33187 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLRkd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 12:40:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so3472402wrt.0
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2020 09:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=F5ZTwP5u+x69l52vZ6Yyj25MwyIu5EIbeHVmFxpD+fY=;
        b=dVeiDX04U8d+XNLfQD+pWt/fqqC8rogHA18ckgOfJKVtuwkUMez97024wLXgC+5fnD
         ChjKlh4V5CPA/hQ/NW38EQggMSCuMotJY15XKheE+NlvdxZo9QBZodirGpCAdO/bYcWQ
         0umq+GEilDiEWCIZBi61MGInrf+7gM/7H0W7dqTQJPk1/U0kb23bwDovmCEBo9tzcJVn
         pe1khX+pI/AZVqb/SNd7j74jgolHc3WUXQ2RLXPVn1uzuGnwwun48YPc9Uix7ou7smj6
         nWHmTtAds6l4MlWzcTDBDnygbPgKH0lm0cjzDHRSinPjeTCZeU5DnqxFzaSw78a5e6ox
         Exeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=F5ZTwP5u+x69l52vZ6Yyj25MwyIu5EIbeHVmFxpD+fY=;
        b=Wy2RFoZIRNOn2pGShR57WhwoBaWZ/db5nYL6aep+7Brq0zFDFUrIwZ4rBVfMZw94MC
         SvQBB1MrDaM7ZiRv02JTtJLmAzTV7dg6G0s7aD+ZnBWQnp7VQV/K2wCOpnuIj+2AmQeB
         QRG1p5xkwitt27CwYyp071NlBzPUmjNDr0dGLN5xuSpyEbvxZsmGFP1h8Z8F0dLg39Gp
         PJs4QbfPJ7gtkPnXhkMhyXFH2/ExTKmMCdTNFxLPo36upd0iivNObB050Op8mKMfc60t
         5y4ZLJ5DB4dXjfNv8Qf0PqsFp2JNrgeUE9AjQ+C4spKssgBZ9aPPTEbW2neG3XbGsGiM
         XwRw==
X-Gm-Message-State: APjAAAUNVTHcCC6VbMuN7pvwVRlZhQd0ouaTqYLARObw4OG8hibvRzJ3
        vuueO255bTnXO+aNJ8svk6SAbis=
X-Google-Smtp-Source: APXvYqwQaluT7cGzS3XYBm4Y8RoceEJ1VTQBvvAwDXf4MAhiqevIDsAsYW7T0nn8yGDwiH/E9Rq2qg==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr15452491wrq.98.1581529231007;
        Wed, 12 Feb 2020 09:40:31 -0800 (PST)
Received: from avx2 ([46.53.253.3])
        by smtp.gmail.com with ESMTPSA id l131sm1538722wmf.31.2020.02.12.09.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 09:40:30 -0800 (PST)
Date:   Wed, 12 Feb 2020 20:40:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hare@suse.de
Subject: [PATCH] block, zoned: fix integer overflow with BLKRESETZONE et al
Message-ID: <20200212174027.GA3535@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Check for overflow in addition before checking for end-of-block-device.

Steps to reproduce:

	#define _GNU_SOURCE 1
	#include <sys/ioctl.h>
	#include <sys/types.h>
	#include <sys/stat.h>
	#include <fcntl.h>

	typedef unsigned long long __u64;

	struct blk_zone_range {
	        __u64 sector;
	        __u64 nr_sectors;
	};

	#define BLKRESETZONE    _IOW(0x12, 131, struct blk_zone_range)

	int main(void)
	{
	        int fd = open("/dev/nullb0", O_RDWR|O_DIRECT);
	        struct blk_zone_range zr = {4096, 0xfffffffffffff000ULL};
	        ioctl(fd, BLKRESETZONE, &zr);
	        return 0;
	}

BUG: KASAN: null-ptr-deref in submit_bio_wait+0x74/0xe0
Write of size 8 at addr 0000000000000040 by task a.out/1590

CPU: 8 PID: 1590 Comm: a.out Not tainted 5.6.0-rc1-00019-g359c92c02bfa #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190711_202441-buildvm-armv7-10.arm.fedoraproject.org-2.fc31 04/01/2014
Call Trace:
 dump_stack+0x76/0xa0
 __kasan_report.cold+0x5/0x3e
 kasan_report+0xe/0x20
 submit_bio_wait+0x74/0xe0
 blkdev_zone_mgmt+0x26f/0x2a0
 blkdev_zone_mgmt_ioctl+0x14b/0x1b0
 blkdev_ioctl+0xb28/0xe60
 block_ioctl+0x69/0x80
 ksys_ioctl+0x3af/0xa50

Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
---

 block/blk-zoned.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -173,7 +173,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 	if (!op_is_zone_mgmt(op))
 		return -EOPNOTSUPP;
 
-	if (!nr_sectors || end_sector > capacity)
+	if (end_sector <= sector || end_sector > capacity)
 		/* Out of range */
 		return -EINVAL;
 
