Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B69C636CC
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 02:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBQCVy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 21:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBQCVy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 21:21:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505842E0C6
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 18:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676600464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ngJH0anKmLZdgZFLmDQQFRZsbSCAidnB8FvWvEA1RVM=;
        b=Y50uswzMri/aHtmTSJANI4H0lXKIz8DRWOI/D+fqW6wzLXOabLk4KcnfWCqWiw4I6n3URF
        IWE5RSB8I9hEpaqmDuLf6W7JhNNz7UuShoELZ1spMGPGGjlF9bhIluTu7SjeV62nXhbQwE
        VngOPDUZwL/V07cRqwDzK0CcTGHNskU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-upTQarN1M3ePNt1KhOxDMA-1; Thu, 16 Feb 2023 21:20:58 -0500
X-MC-Unique: upTQarN1M3ePNt1KhOxDMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F2CA800B24;
        Fri, 17 Feb 2023 02:20:58 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C30A40B40C9;
        Fri, 17 Feb 2023 02:20:50 +0000 (UTC)
Date:   Fri, 17 Feb 2023 10:20:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>, ming.lei@redhat.com
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <Y+7kfZnWsmnA0V84@T590>
References: <Y+EWCwqSisu3l0Sz@T590>
 <Y+Finej8521IDwzV@fedora>
 <Y+MFAzt0Cx9aetf2@T590>
 <Y+OSxh2K0/Lf0SAk@fedora>
 <Y+my03K5MbSSRvQq@T590>
 <Y+qL9z7rtApszoBf@fedora>
 <Y+wsj2QqX+HMUJTI@T590>
 <87bkltrj9x.fsf@metaspace.dk>
 <Y+4JVgd338R0x1m4@T590>
 <877cwhrgul.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877cwhrgul.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 16, 2023 at 12:21:32PM +0100, Andreas Hindborg wrote:
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas Hindborg wrote:
> >> 
> >> Hi Ming,
> >> 
> >> Ming Lei <ming.lei@redhat.com> writes:
> >> 
> >> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrote:
> >> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> >> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
> >> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
> >> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wrote:
> >> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> >> >> > > > > > Hello,
> >> >> > > > > > 
> >> >> > > > > > So far UBLK is only used for implementing virtual block device from
> >> >> > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> >> >> > > > > 
> >> >> > > > > I won't be at LSF/MM so here are my thoughts:
> >> >> > > > 
> >> >> > > > Thanks for the thoughts, :-)
> >> >> > > > 
> >> >> > > > > 
> >> >> > > > > > 
> >> >> > > > > > It could be useful for UBLK to cover real storage hardware too:
> >> >> > > > > > 
> >> >> > > > > > - for fast prototype or performance evaluation
> >> >> > > > > > 
> >> >> > > > > > - some network storages are attached to host, such as iscsi and nvme-tcp,
> >> >> > > > > > the current UBLK interface doesn't support such devices, since it needs
> >> >> > > > > > all LUNs/Namespaces to share host resources(such as tag)
> >> >> > > > > 
> >> >> > > > > Can you explain this in more detail? It seems like an iSCSI or
> >> >> > > > > NVMe-over-TCP initiator could be implemented as a ublk server today.
> >> >> > > > > What am I missing?
> >> >> > > > 
> >> >> > > > The current ublk can't do that yet, because the interface doesn't
> >> >> > > > support multiple ublk disks sharing single host, which is exactly
> >> >> > > > the case of scsi and nvme.
> >> >> > > 
> >> >> > > Can you give an example that shows exactly where a problem is hit?
> >> >> > > 
> >> >> > > I took a quick look at the ublk source code and didn't spot a place
> >> >> > > where it prevents a single ublk server process from handling multiple
> >> >> > > devices.
> >> >> > > 
> >> >> > > Regarding "host resources(such as tag)", can the ublk server deal with
> >> >> > > that in userspace? The Linux block layer doesn't have the concept of a
> >> >> > > "host", that would come in at the SCSI/NVMe level that's implemented in
> >> >> > > userspace.
> >> >> > > 
> >> >> > > I don't understand yet...
> >> >> > 
> >> >> > blk_mq_tag_set is embedded into driver host structure, and referred by queue
> >> >> > via q->tag_set, both scsi and nvme allocates tag in host/queue wide,
> >> >> > that said all LUNs/NSs share host/queue tags, current every ublk
> >> >> > device is independent, and can't shard tags.
> >> >> 
> >> >> Does this actually prevent ublk servers with multiple ublk devices or is
> >> >> it just sub-optimal?
> >> >
> >> > It is former, ublk can't support multiple devices which share single host
> >> > because duplicated tag can be seen in host side, then io is failed.
> >> >
> >> 
> >> I have trouble following this discussion. Why can we not handle multiple
> >> block devices in a single ublk user space process?
> >> 
> >> From this conversation it seems that the limiting factor is allocation
> >> of the tag set of the virtual device in the kernel? But as far as I can
> >> tell, the tag sets are allocated per virtual block device in
> >> `ublk_ctrl_add_dev()`?
> >> 
> >> It seems to me that a single ublk user space process shuld be able to
> >> connect to multiple storage devices (for instance nvme-of) and then
> >> create a ublk device for each namespace, all from a single ublk process.
> >> 
> >> Could you elaborate on why this is not possible?
> >
> > If the multiple storages devices are independent, the current ublk can
> > handle them just fine.
> >
> > But if these storage devices(such as luns in iscsi, or NSs in nvme-tcp)
> > share single host, and use host-wide tagset, the current interface can't
> > work as expected, because tags is shared among all these devices. The
> > current ublk interface needs to be extended for covering this case.
> 
> Thanks for clarifying, that is very helpful.
> 
> Follow up question: What would the implications be if one tried to
> expose (through ublk) each nvme namespace of an nvme-of controller with
> an independent tag set?

https://lore.kernel.org/linux-block/877cwhrgul.fsf@metaspace.dk/T/#m57158db9f0108e529d8d62d1d56652c52e9e3e67

> What are the benefits of sharing a tagset across
> all namespaces of a controller?

The userspace implementation can be simplified a lot since generic
shared tag allocation isn't needed, meantime with good performance
(shared tags allocation in SMP is one hard problem)

The extension shouldn't be very hard, follows some raw ideas:

1) interface change

- add new feature flag of UBLK_F_SHARED_HOST, multiple ublk
  devices(ublkcXnY) are attached to the ublk host(ublkhX)

- dev_info.dev_id: in case of UBLK_F_SHARED_HOST, the top 16bit stores
  host id(X), and the bottom 16bit stores device id(Y)

- add two control commands: UBLK_CMD_ADD_HOST, UBLK_CMD_DEL_HOST

  Still sent to /dev/ublk-control

  ADD_HOST command will allocate one host device(char) with specified host
  id or allocated host id, tag_set is allocated as host resource. The
  host device(ublkhX) will become parent of all ublkcXn*

  Before sending DEL_HOST, all devices attached to this host have to
  be stopped & removed first, otherwise DEL_HOST won't succeed.

- keep other interfaces not changed
  in case of UBLK_F_SHARED_HOST, userspace has to set correct
  dev_info.dev_id.host_id, so ublk driver can associate device with
  specified host

2) implementation
- host device(ublkhX) becomes parent of all ublk char devices of
  ublkcXn*

- except for tagset, other per-host resource abstraction? Looks not
  necessary, anything is available in userspace

- host-wide error handling, maybe all devices attached to this host
  need to be recovered, so it should be done in userspace 

- per-host admin queue, looks not necessary, given host related
  management/control tasks are done in userspace directly

- others?


Thanks,
Ming

