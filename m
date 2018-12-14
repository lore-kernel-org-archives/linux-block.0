Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E726FC67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 11:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB33021104
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 11:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB33021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeLNLJn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:09:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59783 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNLJm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 06:09:42 -0500
Received: from 201-68-129-100.dsl.telesp.net.br ([201.68.129.100] helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gXlLe-0006pU-RR; Fri, 14 Dec 2018 11:09:39 +0000
Date:   Fri, 14 Dec 2018 09:09:34 -0200
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
Message-ID: <20181214110933.GF5321@calabresa>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de>
 <20181213143218.GA8723@lst.de>
 <20181213152532.GA5321@calabresa>
 <35acb1b3-77f5-29cf-b92d-5171f4ad6450@suse.de>
 <20181214085606.GD5321@calabresa>
 <20181214090656.GE5321@calabresa>
 <aa38e54b-9506-96e9-7e55-29bcccd36334@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa38e54b-9506-96e9-7e55-29bcccd36334@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 14, 2018 at 10:54:04AM +0100, Hannes Reinecke wrote:
> On 12/14/18 10:06 AM, Thadeu Lima de Souza Cascardo wrote:
> > On Fri, Dec 14, 2018 at 06:56:06AM -0200, Thadeu Lima de Souza Cascardo wrote:
> > > On Fri, Dec 14, 2018 at 08:47:20AM +0100, Hannes Reinecke wrote:
> > > > But you haven't answered my question:
> > > > 
> > > > Why can't we patch 'lsblk' to provide the required information even with the
> > > > current sysfs layout?
> > > > 
> > > 
> > 
> > Just to be clear here. If with 'current sysfs layout' you mean without any of
> > the patches we have been talking about, lsblk is not broken. It just works with
> > nvme multipath enabled. It will show the multipath paths and simply ignore the
> > underlying/hidden ones. If we hid them, we meant for them to be hidden, right?
> > 
> > What I am trying to fix here is how to find out which PCI device/driver is
> > needed to get to the block device holding the root filesystem, which is what
> > initramfs needs. And the nvme multipath device is a virtual device, pointing to
> > no driver at all, and no relation to its underlying devices, needed for it to
> > work.
> > 
> 
> Well ...
> But this is an entirely different proposition.
> The 'slaves'/'holders' trick just allows to map the relationship between
> _block_ devices, which arguably is a bit pointless here seeing that we don't
> actually have block devices for the underlying devices.
> But even if we _were_ implementing that you would still fail to get to the
> PCI device providing the block devices as there is no link pointing from one
> to another.

Well, initramfs-tools does traverse the slaves because your root filesystem
could be on top of a device-mapped block device. I will try your other patch in
any case and I will see if that fixes the problem I have at hand.

Thanks.
Cascardo.

> 
> With the currently layout we have this hierarchy:
> 
> NVMe namespace (/dev/nvmeXn1Y) -> NVMe-subsys -> NVMe controller
> 
> and the NVMe controller is missing a link pointing to the device presenting
> the controller:
> 
> # ls -l /sys/devices/virtual/nvme-fabrics/ctl/nvme2
> total 0
> -r--r--r-- 1 root root 4096 Dec 13 13:18 address
> -r--r--r-- 1 root root 4096 Dec 13 13:18 cntlid
> --w------- 1 root root 4096 Dec 13 13:18 delete_controller
> -r--r--r-- 1 root root 4096 Dec 13 13:18 dev
> lrwxrwxrwx 1 root root    0 Dec 13 13:18 device -> ../../ctl
> -r--r--r-- 1 root root 4096 Dec 13 13:18 firmware_rev
> -r--r--r-- 1 root root 4096 Dec 13 13:18 model
> drwxr-xr-x 9 root root    0 Dec  3 13:55 nvme2c64n1
> drwxr-xr-x 2 root root    0 Dec 13 13:18 power
> --w------- 1 root root 4096 Dec 13 13:18 rescan_controller
> --w------- 1 root root 4096 Dec 13 13:18 reset_controller
> -r--r--r-- 1 root root 4096 Dec 13 13:18 serial
> -r--r--r-- 1 root root 4096 Dec 13 13:18 state
> -r--r--r-- 1 root root 4096 Dec 13 13:18 subsysnqn
> lrwxrwxrwx 1 root root    0 Dec  3 13:44 subsystem ->
> ../../../../../class/nvme
> -r--r--r-- 1 root root 4096 Dec 13 13:18 transport
> -rw-r--r-- 1 root root 4096 Dec 13 13:18 uevent
> 
> So what we need to do is to update the 'device' link to point to the PCI
> device providing the controller.
> (Actually, we would need to point the 'device' link to point to the entity
> providing the transport address, but I guess we don't have that for now.)
> 
> And _that's_ what we need to fix; the slaves/holders stuff doesn't solve the
> underlying problem, and really shouldn't be merged at all.
> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke		   Teamlead Storage & Networking
> hare@suse.de			               +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
> GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
> HRB 21284 (AG Nürnberg)
