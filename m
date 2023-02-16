Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883F5C636D6
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 10:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjBPKrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 05:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBPKr3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 05:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17537552A9
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 02:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676544361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wr4/HX7z4Y6TZab5S2odNISKCndMHgV0QLZoaqmpfyc=;
        b=DvS+O7O1G22yEc6GpEtlWQAOVQoM4dK6QC29bRlibMlu8QNgTPuQ/+dsOZ7gv2Y5PI7htn
        GCpfrZ0/TlwWE5Z+QuJjIJRH7OcAHBxK/mFhFYqkTBqCAh++jVImsemqe0i8dDVxGmAeQW
        /CL4ZbU1j8JoLFRDn9c8t9TOi0T8ZUY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-qEbaev0UOCarT84j4WcZYQ-1; Thu, 16 Feb 2023 05:45:58 -0500
X-MC-Unique: qEbaev0UOCarT84j4WcZYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85ACC280AA25;
        Thu, 16 Feb 2023 10:45:57 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FA762166B30;
        Thu, 16 Feb 2023 10:45:48 +0000 (UTC)
Date:   Thu, 16 Feb 2023 18:45:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Andreas Hindborg <a.hindborg@samsung.com>, ming.lei@redhat.com
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Message-ID: <Y+4JVgd338R0x1m4@T590>
References: <Y+EWCwqSisu3l0Sz@T590>
 <Y+Finej8521IDwzV@fedora>
 <Y+MFAzt0Cx9aetf2@T590>
 <Y+OSxh2K0/Lf0SAk@fedora>
 <Y+my03K5MbSSRvQq@T590>
 <Y+qL9z7rtApszoBf@fedora>
 <Y+wsj2QqX+HMUJTI@T590>
 <87bkltrj9x.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkltrj9x.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 16, 2023 at 10:44:02AM +0100, Andreas Hindborg wrote:
> 
> Hi Ming,
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Mon, Feb 13, 2023 at 02:13:59PM -0500, Stefan Hajnoczi wrote:
> >> On Mon, Feb 13, 2023 at 11:47:31AM +0800, Ming Lei wrote:
> >> > On Wed, Feb 08, 2023 at 07:17:10AM -0500, Stefan Hajnoczi wrote:
> >> > > On Wed, Feb 08, 2023 at 10:12:19AM +0800, Ming Lei wrote:
> >> > > > On Mon, Feb 06, 2023 at 03:27:09PM -0500, Stefan Hajnoczi wrote:
> >> > > > > On Mon, Feb 06, 2023 at 11:00:27PM +0800, Ming Lei wrote:
> >> > > > > > Hello,
> >> > > > > > 
> >> > > > > > So far UBLK is only used for implementing virtual block device from
> >> > > > > > userspace, such as loop, nbd, qcow2, ...[1].
> >> > > > > 
> >> > > > > I won't be at LSF/MM so here are my thoughts:
> >> > > > 
> >> > > > Thanks for the thoughts, :-)
> >> > > > 
> >> > > > > 
> >> > > > > > 
> >> > > > > > It could be useful for UBLK to cover real storage hardware too:
> >> > > > > > 
> >> > > > > > - for fast prototype or performance evaluation
> >> > > > > > 
> >> > > > > > - some network storages are attached to host, such as iscsi and nvme-tcp,
> >> > > > > > the current UBLK interface doesn't support such devices, since it needs
> >> > > > > > all LUNs/Namespaces to share host resources(such as tag)
> >> > > > > 
> >> > > > > Can you explain this in more detail? It seems like an iSCSI or
> >> > > > > NVMe-over-TCP initiator could be implemented as a ublk server today.
> >> > > > > What am I missing?
> >> > > > 
> >> > > > The current ublk can't do that yet, because the interface doesn't
> >> > > > support multiple ublk disks sharing single host, which is exactly
> >> > > > the case of scsi and nvme.
> >> > > 
> >> > > Can you give an example that shows exactly where a problem is hit?
> >> > > 
> >> > > I took a quick look at the ublk source code and didn't spot a place
> >> > > where it prevents a single ublk server process from handling multiple
> >> > > devices.
> >> > > 
> >> > > Regarding "host resources(such as tag)", can the ublk server deal with
> >> > > that in userspace? The Linux block layer doesn't have the concept of a
> >> > > "host", that would come in at the SCSI/NVMe level that's implemented in
> >> > > userspace.
> >> > > 
> >> > > I don't understand yet...
> >> > 
> >> > blk_mq_tag_set is embedded into driver host structure, and referred by queue
> >> > via q->tag_set, both scsi and nvme allocates tag in host/queue wide,
> >> > that said all LUNs/NSs share host/queue tags, current every ublk
> >> > device is independent, and can't shard tags.
> >> 
> >> Does this actually prevent ublk servers with multiple ublk devices or is
> >> it just sub-optimal?
> >
> > It is former, ublk can't support multiple devices which share single host
> > because duplicated tag can be seen in host side, then io is failed.
> >
> 
> I have trouble following this discussion. Why can we not handle multiple
> block devices in a single ublk user space process?
> 
> From this conversation it seems that the limiting factor is allocation
> of the tag set of the virtual device in the kernel? But as far as I can
> tell, the tag sets are allocated per virtual block device in
> `ublk_ctrl_add_dev()`?
> 
> It seems to me that a single ublk user space process shuld be able to
> connect to multiple storage devices (for instance nvme-of) and then
> create a ublk device for each namespace, all from a single ublk process.
> 
> Could you elaborate on why this is not possible?

If the multiple storages devices are independent, the current ublk can
handle them just fine.

But if these storage devices(such as luns in iscsi, or NSs in nvme-tcp)
share single host, and use host-wide tagset, the current interface can't
work as expected, because tags is shared among all these devices. The
current ublk interface needs to be extended for covering this case.


Thanks,
Ming

