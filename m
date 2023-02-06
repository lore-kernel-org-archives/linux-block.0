Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23A9C61DA4
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 15:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBFPBX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFPBW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 10:01:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425319028
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 07:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675695642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=qK3PL2eMHXfoJF4n/7DCM00nVZATvdF8jVGVH/IRTY8=;
        b=SRSWKUmttmoUZ/2Y2Bv6L2ybNDMykHzFkUieSWQbvVerNrijRVVrsMwqzHX+4mtJ8W78GU
        7FSTK/plMqEQICezdrii2DrHpoz2hGlB8ZwYqT0vH1WoJKjDakyZ2R71PhCm+1gfpdAldE
        x7Ua3KqeUSEiibSnTqb3zaMI8DGtZrM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-0Cvi_m73MSyaWH1f80IG2A-1; Mon, 06 Feb 2023 10:00:40 -0500
X-MC-Unique: 0Cvi_m73MSyaWH1f80IG2A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E16EE857A8E;
        Mon,  6 Feb 2023 15:00:39 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE53E40B42D4;
        Mon,  6 Feb 2023 15:00:33 +0000 (UTC)
Date:   Mon, 6 Feb 2023 23:00:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Cc:     ming.lei@redhat.com, Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>, Stefan Hajnoczi <stefanha@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <Y+EWCwqSisu3l0Sz@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

So far UBLK is only used for implementing virtual block device from
userspace, such as loop, nbd, qcow2, ...[1].

It could be useful for UBLK to cover real storage hardware too:

- for fast prototype or performance evaluation

- some network storages are attached to host, such as iscsi and nvme-tcp,
the current UBLK interface doesn't support such devices, since it needs
all LUNs/Namespaces to share host resources(such as tag)

- SPDK has supported user space driver for real hardware

So propose to extend UBLK for supporting real hardware device:

1) extend UBLK ABI interface to support disks attached to host, such
as SCSI Luns/NVME Namespaces

2) the followings are related with operating hardware from userspace,
so userspace driver has to be trusted, and root is required, and
can't support unprivileged UBLK device

3) how to operating hardware memory space
- unbind kernel driver and rebind with uio/vfio
- map PCI BAR into userspace[2], then userspace can operate hardware
with mapped user address via MMIO

4) DMA
- DMA requires physical memory address, UBLK driver actually has
block request pages, so can we export request SG list(each segment
physical address, offset, len) into userspace? If the max_segments
limit is not too big(<=64), the needed buffer for holding SG list
can be small enough.

- small amount of physical memory for using as DMA descriptor can be
pre-allocated from userspace, and ask kernel to pin pages, then still
return physical address to userspace for programming DMA

- this way is still zero copy

5) notification from hardware: interrupt or polling
- SPDK applies userspace polling, this way is doable, but
eat CPU, so it is only one choice

- io_uring command has been proved as very efficient, if io_uring
command is applied(similar way with UBLK for forwarding blk io
command from kernel to userspace) to uio/vfio for delivering interrupt,
which should be efficient too, given batching processes are done after
the io_uring command is completed

- or it could be flexible by hybrid interrupt & polling, given
userspace single pthread/queue implementation can retrieve all
kinds of inflight IO info in very cheap way, and maybe it is likely
to apply some ML model to learn & predict when IO will be completed

6) others?



[1] https://github.com/ming1/ubdsrv
[2] https://spdk.io/doc/userspace.html
 

Thanks, 
Ming

