Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18645C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 09:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14EB2173C
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 09:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCMJjM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:39:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfCMJjM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 05:39:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2BCC301BE84;
        Wed, 13 Mar 2019 09:39:11 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C42B5D706;
        Wed, 13 Mar 2019 09:39:03 +0000 (UTC)
Date:   Wed, 13 Mar 2019 10:39:00 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, mst@redhat.com
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
Message-ID: <20190313103900.1ea7f996.cohuck@redhat.com>
In-Reply-To: <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
        <20190312183351.74764f4f.cohuck@redhat.com>
        <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 13 Mar 2019 09:39:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 13 Mar 2019 11:26:04 +0800
Dongli Zhang <dongli.zhang@oracle.com> wrote:

> On 3/13/19 1:33 AM, Cornelia Huck wrote:
> > On Tue, 12 Mar 2019 10:22:46 -0700 (PDT)
> > Dongli Zhang <dongli.zhang@oracle.com> wrote:
> >   
> >> I observed that there is one msix vector for config and one shared vector
> >> for all queues in below qemu cmdline, when the num-queues for virtio-blk
> >> is more than the number of possible cpus:
> >>
> >> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=6"
> >>
> >> # cat /proc/interrupts 
> >>            CPU0       CPU1       CPU2       CPU3
> >> ... ...
> >>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
> >>  25:          0          0          0         59   PCI-MSI 65537-edge      virtio0-virtqueues
> >> ... ...
> >>
> >>
> >> However, when num-queues is the same as number of possible cpus:
> >>
> >> qemu: "-smp 4" while "-device virtio-blk-pci,drive=drive-0,id=virtblk0,num-queues=4"
> >>
> >> # cat /proc/interrupts 
> >>            CPU0       CPU1       CPU2       CPU3
> >> ... ... 
> >>  24:          0          0          0          0   PCI-MSI 65536-edge      virtio0-config
> >>  25:          2          0          0          0   PCI-MSI 65537-edge      virtio0-req.0
> >>  26:          0         35          0          0   PCI-MSI 65538-edge      virtio0-req.1
> >>  27:          0          0         32          0   PCI-MSI 65539-edge      virtio0-req.2
> >>  28:          0          0          0          0   PCI-MSI 65540-edge      virtio0-req.3
> >> ... ...
> >>
> >> In above case, there is one msix vector per queue.  
> > 
> > Please note that this is pci-specific...
> >   
> >>
> >>
> >> This is because the max number of queues is not limited by the number of
> >> possible cpus.
> >>
> >> By default, nvme (regardless about write_queues and poll_queues) and
> >> xen-blkfront limit the number of queues with num_possible_cpus().  
> > 
> > ...and these are probably pci-specific as well.  
> 
> Not pci-specific, but per-cpu as well.

Ah, I meant that those are pci devices.

> 
> >   
> >>
> >>
> >> Is this by design on purpose, or can we fix with below?
> >>
> >>
> >> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> >> index 4bc083b..df95ce3 100644
> >> --- a/drivers/block/virtio_blk.c
> >> +++ b/drivers/block/virtio_blk.c
> >> @@ -513,6 +513,8 @@ static int init_vq(struct virtio_blk *vblk)
> >>  	if (err)
> >>  		num_vqs = 1;
> >>  
> >> +	num_vqs = min(num_possible_cpus(), num_vqs);
> >> +
> >>  	vblk->vqs = kmalloc_array(num_vqs, sizeof(*vblk->vqs), GFP_KERNEL);
> >>  	if (!vblk->vqs)
> >>  		return -ENOMEM;  
> > 
> > virtio-blk, however, is not pci-specific.
> > 
> > If we are using the ccw transport on s390, a completely different
> > interrupt mechanism is in use ('floating' interrupts, which are not
> > per-cpu). A check like that should therefore not go into the generic
> > driver.
> >   
> 
> So far there seems two options.
> 
> The 1st option is to ask the qemu user to always specify "-num-queues" with the
> same number of vcpus when running x86 guest with pci for virtio-blk or
> virtio-scsi, in order to assign a vector for each queue.

That does seem like an extra burden for the user: IIUC, things work
even if you have too many queues, it's just not optimal. It sounds like
something that can be done by a management layer (e.g. libvirt), though.

> Or, is it fine for virtio folks to add a new hook to 'struct virtio_config_ops'
> so that different platforms (e.g., pci or ccw) would use different ways to limit
> the max number of queues in guest, with something like below?

That sounds better, as both transports and drivers can opt-in here.

However, maybe it would be even better to try to come up with a better
strategy of allocating msix vectors in virtio-pci. More vectors in the
num_queues > num_cpus case, even if they still need to be shared?
Individual vectors for n-1 cpus and then a shared one for the remaining
queues?

It might even be device-specific: Have some low-traffic status queues
share a vector, and provide an individual vector for high-traffic
queues. Would need some device<->transport interface, obviously.
