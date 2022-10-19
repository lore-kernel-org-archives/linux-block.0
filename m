Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CB1C4332F
	for <linux-block@archiver.kernel.org>; Wed, 19 Oct 2022 05:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJSFNF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Oct 2022 01:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJSFNE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Oct 2022 01:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B069368CC4
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 22:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666156382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=R3AS0X/jznNhwixCN0gHK3mAPrwZ5Tn1LzHbc/Livsw=;
        b=TZjwbpBlFdQsNEkwFmGwYDJUChRyrMCKoDVKu7ABr0fvtods4d5NP7n3QhcT0j74bOAemu
        7awb761bwOLqaGusNMatIvmpqYYk9LeX4yeReec/NnhUYbPrJG9340tZ6Iwpbt9xECbzJe
        f1nr2rnQrhT5R77O2ZRNXU0R8QrrUC4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-l5yRt_oePMuidJkXk1cMkQ-1; Wed, 19 Oct 2022 01:12:59 -0400
X-MC-Unique: l5yRt_oePMuidJkXk1cMkQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2892A8027EB;
        Wed, 19 Oct 2022 05:12:59 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23EB49D48D;
        Wed, 19 Oct 2022 05:12:56 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     logang@deltatee.com, shinichiro.kawasaki@wdc.com
Cc:     linux-block@vger.kernel.org, sandeen@sandeen.net
Subject: [PATCH blktests] common/xfs: ignore the 32M log size during mkfs.xfs
Date:   Wed, 19 Oct 2022 13:12:44 +0800
Message-Id: <20221019051244.810755-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The new minimum size for the xfs log is 64MB which introudced from
xfsprogs v5.19.0, let's ignore it, or nvme/013 will be failed at:

$ mkfs.xfs -l size=32m -f /dev/nvme0n1
Log size must be at least 64MB.
Usage: mkfs.xfs
/* blocksize */		[-b size=num]
/* config file */	[-c options=xxx]
/* metadata */		[-m crc=0|1,finobt=0|1,uuid=xxx,rmapbt=0|1,reflink=0|1,
			    inobtcount=0|1,bigtime=0|1]
/* data subvol */	[-d agcount=n,agsize=n,file,name=xxx,size=num,
			    (sunit=value,swidth=value|su=num,sw=num|noalign),
			    sectsize=num
/* force overwrite */	[-f]
/* inode size */	[-i perblock=n|size=num,maxpct=n,attr=0|1|2,
			    projid32bit=0|1,sparse=0|1,nrext64=0|1]
/* no discard */	[-K]
/* log subvol */	[-l agnum=n,internal,size=num,logdev=xxx,version=n
			    sunit=value|su=num,sectsize=num,lazy-count=0|1]
/* label */		[-L label (maximum 12 characters)]
/* naming */		[-n size=num,version=2|ci,ftype=0|1]
/* no-op info only */	[-N]
/* prototype file */	[-p fname]
/* quiet */		[-q]
/* realtime subvol */	[-r extsize=num,size=num,rtdev=xxx]
/* sectorsize */	[-s size=num]
/* version */		[-V]
			devicename
<devicename> is required unless -d name=xxx is given.
<num> is xxx (bytes), xxxs (sectors), xxxb (fs blocks), xxxk (xxx KiB),
      xxxm (xxx MiB), xxxg (xxx GiB), xxxt (xxx TiB) or xxxp (xxx PiB).
<value> is xxx (512 byte blocks).

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 common/xfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/xfs b/common/xfs
index 210c924..f0c9b7f 100644
--- a/common/xfs
+++ b/common/xfs
@@ -16,7 +16,7 @@ _xfs_mkfs_and_mount() {
 
 	mkdir -p "${mount_dir}"
 	umount "${mount_dir}"
-	mkfs.xfs -l size=32m -f "${bdev}"
+	mkfs.xfs -f "${bdev}"
 	mount "${bdev}" "${mount_dir}"
 }
 
-- 
2.34.1

