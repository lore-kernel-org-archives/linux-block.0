Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB1AC433E1
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897BE206B2
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 17:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYLdMSTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgHFRrj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:47:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25053 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727081AbgHFRrh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 13:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596736055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=+6FzmLvlaKV/NtfInk3NuAoke2rpjP5o1HfYuy15BlY=;
        b=TYLdMSTNuk+vI5yMsahqs5YDPF+HNjUq06fsQQuA0x/6YnQov0ematY9tp3eer64/4NZbF
        mTZwiNJLU3e3HvEsLTrXtlAsJArj0wHyCe495eQ+5dMQNrLDXL6PYaMqvPT842goTvsa91
        LZquBkRrLw+UjgNJzWR93/RM7B5inBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-qUlxRwU6MZKhuMvPMbot_A-1; Thu, 06 Aug 2020 13:47:34 -0400
X-MC-Unique: qUlxRwU6MZKhuMvPMbot_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 718601902EAB
        for <linux-block@vger.kernel.org>; Thu,  6 Aug 2020 17:47:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A51F19D7E
        for <linux-block@vger.kernel.org>; Thu,  6 Aug 2020 17:47:33 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 642591809547
        for <linux-block@vger.kernel.org>; Thu,  6 Aug 2020 17:47:33 +0000 (UTC)
Date:   Thu, 6 Aug 2020 13:47:33 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     linux-block@vger.kernel.org
Message-ID: <1929570063.6965184.1596736053281.JavaMail.zimbra@redhat.com>
In-Reply-To: <94883604.6936811.1596720770623.JavaMail.zimbra@redhat.com>
Subject: [bug] mkfs.ext[23] hangs on loop device (aarch64, 5.8+)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.208.12, 10.4.195.11]
Thread-Topic: mkfs.ext[23] hangs on loop device (aarch64, 5.8+)
Thread-Index: vAzUT3U3p2m0D9LErJy2kxg88GiTfw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I'm seeing sporadic mkfs.ext[23] hangs on loop device while running various
LTP tests. It seems to hang indefinitely once in bad state:
  0 D root       29782   29761  0  80   0 -  1006 rq_qos 15:09 ?        00:00:00             mkfs.ext3 /dev/loop0

[19809.932566] mkfs.ext3       D    0 29782  29761 0x00000000 
[19809.934000] Call trace: 
[19809.934624]  __switch_to+0xfc/0x150 
[19809.935533]  __schedule+0x364/0x828 
[19809.936432]  schedule+0x58/0xe0 
[19809.937261]  io_schedule+0x24/0xc0 
[19809.938144]  rq_qos_wait+0xe4/0x150 
[19809.939044]  wbt_wait+0x98/0xd8 
[19809.939864]  __rq_qos_throttle+0x38/0x50 
[19809.940847]  blk_mq_submit_bio+0x108/0x620 
[19809.941890]  submit_bio_noacct+0x358/0x3d8 
[19809.942909]  submit_bio+0x40/0x1a8 
[19809.943770]  submit_bh_wbc+0x16c/0x1e8 
[19809.944701]  __block_write_full_page+0x238/0x5c8 
[19809.945862]  block_write_full_page+0x124/0x138 
[19809.947000]  blkdev_writepage+0x24/0x30 
[19809.948031]  __writepage+0x28/0xc8 
[19809.948905]  write_cache_pages+0x1ac/0x410 
[19809.949988]  generic_writepages+0x4c/0x88 
[19809.950947]  blkdev_writepages+0x18/0x28 
[19809.951934]  do_writepages+0x40/0xe8 
[19809.952856]  __filemap_fdatawrite_range+0xe0/0x150 
[19809.954066]  file_write_and_wait_range+0x9c/0x108 
[19809.955266]  blkdev_fsync+0x24/0x50 
[19809.956170]  vfs_fsync_range+0x3c/0x88 
[19809.957126]  do_fsync+0x44/0x90 
[19809.957925]  __arm64_sys_fsync+0x20/0x30 
[19809.958961]  el0_svc_common.constprop.0+0x7c/0x188 
[19809.960242]  do_el0_svc+0x2c/0x98 
[19809.961028]  el0_sync_handler+0x84/0x110 
[19809.962003]  el0_sync+0x15c/0x180 

It started happening in recent weeks and appears to be aarch64 exclusive so far.

Affected kernels are at least:
  v5.8-475-g382625d0d432
  v5.8-607-gcdc8fcb49905
  v5.8-rc2-87-g6b7b181b67aa
  v5.8-rc2-105-g492d76b21566

6b7b181b67aa is the oldest commit I could reproduce it with, but my current
reproducer (running LTP fgetxattr01 in loop for 30 minutes) doesn't look very
reliable for bisect. 

Does this ring any bells?

Thanks,
Jan

