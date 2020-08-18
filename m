Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A286C433E1
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 02:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450942078B
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 02:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjVZuD/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgHRC3Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 22:29:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57073 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726324AbgHRC3X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 22:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597717761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1zgWuvQqdcUbsJnWydp0WNWMmDDjtw4d0mf4wUENIZY=;
        b=MjVZuD/7IL6rVdaOn4n4+jVDjwSizRrLZ2MSs/nsKEMOAB45QzpD3O9XZSbPcxiLOfLVhO
        eDdTgWONWUgl/Yct6g6+gMM5pk1KDqDKSao5hDwhdJJUNX0rxj7GqThyJbGOb7foues6l5
        JqkydTki/+j94JU9vQbVJCs+4R5ofX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-AkHReQR0Nv6j8iObJz6NHw-1; Mon, 17 Aug 2020 22:29:15 -0400
X-MC-Unique: AkHReQR0Nv6j8iObJz6NHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 075C4801AC9
        for <linux-block@vger.kernel.org>; Tue, 18 Aug 2020 02:29:15 +0000 (UTC)
Received: from T590 (ovpn-13-119.pek2.redhat.com [10.72.13.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EF57916597;
        Tue, 18 Aug 2020 02:29:09 +0000 (UTC)
Date:   Tue, 18 Aug 2020 10:29:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [bug] mkfs.ext[23] hangs on loop device (aarch64, 5.8+)
Message-ID: <20200818022905.GB2507595@T590>
References: <94883604.6936811.1596720770623.JavaMail.zimbra@redhat.com>
 <1929570063.6965184.1596736053281.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1929570063.6965184.1596736053281.JavaMail.zimbra@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 06, 2020 at 01:47:33PM -0400, Jan Stancek wrote:
> Hi,
> 
> I'm seeing sporadic mkfs.ext[23] hangs on loop device while running various
> LTP tests. It seems to hang indefinitely once in bad state:
>   0 D root       29782   29761  0  80   0 -  1006 rq_qos 15:09 ?        00:00:00             mkfs.ext3 /dev/loop0
> 
> [19809.932566] mkfs.ext3       D    0 29782  29761 0x00000000 
> [19809.934000] Call trace: 
> [19809.934624]  __switch_to+0xfc/0x150 
> [19809.935533]  __schedule+0x364/0x828 
> [19809.936432]  schedule+0x58/0xe0 
> [19809.937261]  io_schedule+0x24/0xc0 
> [19809.938144]  rq_qos_wait+0xe4/0x150 
> [19809.939044]  wbt_wait+0x98/0xd8 
> [19809.939864]  __rq_qos_throttle+0x38/0x50 
> [19809.940847]  blk_mq_submit_bio+0x108/0x620 
> [19809.941890]  submit_bio_noacct+0x358/0x3d8 
> [19809.942909]  submit_bio+0x40/0x1a8 
> [19809.943770]  submit_bh_wbc+0x16c/0x1e8 
> [19809.944701]  __block_write_full_page+0x238/0x5c8 
> [19809.945862]  block_write_full_page+0x124/0x138 
> [19809.947000]  blkdev_writepage+0x24/0x30 
> [19809.948031]  __writepage+0x28/0xc8 
> [19809.948905]  write_cache_pages+0x1ac/0x410 
> [19809.949988]  generic_writepages+0x4c/0x88 
> [19809.950947]  blkdev_writepages+0x18/0x28 
> [19809.951934]  do_writepages+0x40/0xe8 
> [19809.952856]  __filemap_fdatawrite_range+0xe0/0x150 
> [19809.954066]  file_write_and_wait_range+0x9c/0x108 
> [19809.955266]  blkdev_fsync+0x24/0x50 
> [19809.956170]  vfs_fsync_range+0x3c/0x88 
> [19809.957126]  do_fsync+0x44/0x90 
> [19809.957925]  __arm64_sys_fsync+0x20/0x30 
> [19809.958961]  el0_svc_common.constprop.0+0x7c/0x188 
> [19809.960242]  do_el0_svc+0x2c/0x98 
> [19809.961028]  el0_sync_handler+0x84/0x110 
> [19809.962003]  el0_sync+0x15c/0x180 
> 
> It started happening in recent weeks and appears to be aarch64 exclusive so far.
> 
> Affected kernels are at least:
>   v5.8-475-g382625d0d432
>   v5.8-607-gcdc8fcb49905
>   v5.8-rc2-87-g6b7b181b67aa
>   v5.8-rc2-105-g492d76b21566
> 
> 6b7b181b67aa is the oldest commit I could reproduce it with, but my current
> reproducer (running LTP fgetxattr01 in loop for 30 minutes) doesn't look very
> reliable for bisect. 
> 
> Does this ring any bells?

I saw this kind io hang in ltp/fs_fill test reliably and the loop is
over image in tmpfs:

https://lkml.org/lkml/2020/7/26/77

And I have verified that the following patch can fix the issue:

https://lore.kernel.org/linux-block/bc5fa941-3b7c-f28e-dd46-1a1d6e5c40a8@kernel.dk/T/#t


Thanks,
Ming

