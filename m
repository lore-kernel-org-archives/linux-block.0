Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAFCC433B4
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 11:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE426124B
	for <linux-block@archiver.kernel.org>; Thu, 15 Apr 2021 11:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhDOLbp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Apr 2021 07:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbhDOLbp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Apr 2021 07:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618486281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zfS/qfYHMB8CYcbGGKv+Jz6MS4K4Z5AsaKUqAYgKRrs=;
        b=D6e+Ipsr15W8Lfic9AoV3OY5hgN201Go9/jkb1TN+qoYdU8yT2M5hbTZ56z0fcHnEoYT3Z
        7H+CcBPbv7PUPZ6DmeZP+EiY1XYRqV5xtSpWdTc3gfogj1/yWCgNcwPmXuCle524M1avCA
        RaH/hZviruzx/b8DrOgvWKEngVctcVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-DWS3DHjkM86gX3jA2nfpQg-1; Thu, 15 Apr 2021 07:31:19 -0400
X-MC-Unique: DWS3DHjkM86gX3jA2nfpQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3362B1008065;
        Thu, 15 Apr 2021 11:31:18 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CB055D71F;
        Thu, 15 Apr 2021 11:31:17 +0000 (UTC)
Date:   Thu, 15 Apr 2021 13:31:14 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: no EBUSY on BLKRRPART, regression?
Message-ID: <20210415113114.zquxo2up5vltht6u@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



 Hi,

 it seems BLKRRPART does not return EBUSY although the whole-disk
 device contains mounted partitions. It seems like regression,
 or what did I overlook?

 BLKRRPART is very old way how fdisk-like programs detect that the
 whole-disk device is not used by system, otherwise it warns users. Now
 it does not work ;-( 

 Yes, it would be probably better to use open(O_EXCL) in these days.

        # lsblk /dev/sda
        NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
        sda      8:0    0 223.6G  0 disk
        ├─sda1   8:1    0   200M  0 part /boot/efi
        ├─sda2   8:2    0     5G  0 part /boot
        ├─sda3   8:3    0 125.5G  0 part
        ├─sda4   8:4    0    50G  0 part /
        └─sda5   8:5    0  42.9G  0 part /home/archive


        # strace -e ioctl blockdev --rereadpt /dev/sda
        ioctl(3, BLKRRPART)                     = 0

        # uname -r
        5.11.10-200.fc33.x86_64

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

