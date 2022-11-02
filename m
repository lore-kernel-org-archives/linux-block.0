Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0EDC43217
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 02:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKBC6h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiKBC6g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 22:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E75822531
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 19:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667357854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RswB510iQnL61XzrmzYzoOFaNhqJWXGUpuiXL9j46Jc=;
        b=hxW3Dt796idJCOGfdPjyEYcCzQ7wMInXAuC6tmCUpxyo/CWzKfdjcwHQERMt75IAZrVTxe
        haS9NVLerjZB7oTA02YvJSZYGVRWjyWHBjinyimvq8es6n0szxKG7Zr+qyZATUvEPnpJgV
        tEpEcdTSnL48I+Ck4inwzrJBZzUnDU8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-ZY5VsYX6N3qs7UEWKgd6zQ-1; Tue, 01 Nov 2022 22:57:31 -0400
X-MC-Unique: ZY5VsYX6N3qs7UEWKgd6zQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F228B1C068D1;
        Wed,  2 Nov 2022 02:57:30 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62BFF422A9;
        Wed,  2 Nov 2022 02:57:29 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     shinichiro.kawasaki@wdc.com
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: [PATCH V2 blktests 1/3] common/xfs: set the minimal log size 64m during mkfs.xfs
Date:   Wed,  2 Nov 2022 10:57:00 +0800
Message-Id: <20221102025702.1664101-2-yi.zhang@redhat.com>
In-Reply-To: <20221102025702.1664101-1-yi.zhang@redhat.com>
References: <20221102025702.1664101-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update to use the new minimum xfs log size 64MB which introudced from
xfsprogs v5.19.0:

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
index 210c924..846a5ef 100644
--- a/common/xfs
+++ b/common/xfs
@@ -16,7 +16,7 @@ _xfs_mkfs_and_mount() {
 
 	mkdir -p "${mount_dir}"
 	umount "${mount_dir}"
-	mkfs.xfs -l size=32m -f "${bdev}"
+	mkfs.xfs -l size=64m -f "${bdev}"
 	mount "${bdev}" "${mount_dir}"
 }
 
-- 
2.34.1

