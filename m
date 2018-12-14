Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E129CC67839
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 09:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27BB2086D
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 09:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27BB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeLNJHF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:07:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57637 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeLNJHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 04:07:05 -0500
Received: from 201-68-129-100.dsl.telesp.net.br ([201.68.129.100] helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <cascardo@canonical.com>)
        id 1gXjR0-0006yv-99; Fri, 14 Dec 2018 09:07:02 +0000
Date:   Fri, 14 Dec 2018 07:06:57 -0200
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
Message-ID: <20181214090656.GE5321@calabresa>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de>
 <20181213143218.GA8723@lst.de>
 <20181213152532.GA5321@calabresa>
 <35acb1b3-77f5-29cf-b92d-5171f4ad6450@suse.de>
 <20181214085606.GD5321@calabresa>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181214085606.GD5321@calabresa>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 14, 2018 at 06:56:06AM -0200, Thadeu Lima de Souza Cascardo wrote:
> On Fri, Dec 14, 2018 at 08:47:20AM +0100, Hannes Reinecke wrote:
> > But you haven't answered my question:
> > 
> > Why can't we patch 'lsblk' to provide the required information even with the
> > current sysfs layout?
> > 
> 

Just to be clear here. If with 'current sysfs layout' you mean without any of
the patches we have been talking about, lsblk is not broken. It just works with
nvme multipath enabled. It will show the multipath paths and simply ignore the
underlying/hidden ones. If we hid them, we meant for them to be hidden, right?

What I am trying to fix here is how to find out which PCI device/driver is
needed to get to the block device holding the root filesystem, which is what
initramfs needs. And the nvme multipath device is a virtual device, pointing to
no driver at all, and no relation to its underlying devices, needed for it to
work.

Cascardo.

> I think we could, but with my Ubuntu hat on, after the kernel fix for
> initramfs-tools, that is, slaves/holders links, the user will get an updated
> kernel that breaks the current lsblk on Bionic (Ubuntu 18.04). That will
> require that we backport the lsblk fix, which is not only more work, but there
> may be users who only update from -security, which is where kernel updates end
> regularly, but not this lsblk fix.
> 
> And that kernel update is a regression against that old lsblk version.
> 
> Cascardo.
> 
> > Cheers,
> > 
> > Hannes
> > -- 
> > Dr. Hannes Reinecke		   Teamlead Storage & Networking
> > hare@suse.de			               +49 911 74053 688
> > SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
> > GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
> > HRB 21284 (AG Nürnberg)
