Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14B8C4CEC7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 02:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB262067D
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 02:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfIPCLl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Sep 2019 22:11:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbfIPCLk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Sep 2019 22:11:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 09FD23082132;
        Mon, 16 Sep 2019 02:11:40 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9F2960923;
        Mon, 16 Sep 2019 02:11:35 +0000 (UTC)
Date:   Mon, 16 Sep 2019 10:11:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Manuel Bentele <development@manuel-bentele.de>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 0/5] block: loop: add file format subsystem and QCOW2
 file format driver
Message-ID: <20190916021129.GC5162@ming.t460p>
References: <20190823225619.15530-1-development@manuel-bentele.de>
 <20190912022359.GD2731@ming.t460p>
 <dc9e1697-ee11-622a-0f48-ebd65ff2a4e7@manuel-bentele.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc9e1697-ee11-622a-0f48-ebd65ff2a4e7@manuel-bentele.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 16 Sep 2019 02:11:40 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 13, 2019 at 01:57:33PM +0200, Manuel Bentele wrote:
> Hi Ming,
> 
> On 9/12/19 4:24 AM, Ming Lei wrote:
> > On Sat, Aug 24, 2019 at 12:56:14AM +0200, development@manuel-bentele.de wrote:
> >> From: Manuel Bentele <development@manuel-bentele.de>
> >>
> >> Hi
> >>
> >> Regarding to the following discussion [1] on the mailing list I show you 
> >> the result of my work as announced at the end of the discussion [2].
> >>
> >> The discussion was about the project topic of how to implement the 
> >> reading/writing of QCOW2 in the kernel. The project focuses on an read-only 
> >> in-kernel QCOW2 implementation to increase the read/write performance 
> >> and tries to avoid nbd. Furthermore, the project is part of a project 
> >> series to develop a in-kernel network boot infrastructure that has no need 
> > I'd suggest you to share more details about this use case first:
> >
> > 1) what is the in-kernel network boot infrastructure? which functions
> > does it provide for user?
> 
> Some time ago, I started to describe the setup a little bit in [1]. Now
> I want to extend the description:
> 
> The boot infrastructure is used in the university environment and
> quarrels with network-related limitations. Step-by-step, the network
> hardware is renewed and improved, but there are still many university
> branches which are spread all over the city and connected by poor uplink
> connections. Sometimes there exist cases where 15 until 20 desktop
> computers have to share only 1 gigabit uplink. To accelerate the network
> boot, the idea came up to use the QCOW2 file format and its compression
> feature for the image content. Tests have shown, that the usage of
> compression is already measurable at gigabit uplinks and clearly
> noticeable at 100 megabit uplinks.

Got it, looks a good use case for compression, but not has to be QCOW2.

> 
> The network boot infrastructure is based on a classical PXE network boot
> to load the Linux kernel and the initramfs. In the initramfs, the
> compressed QCOW2 image is fetched via nfs or cifs or something else. The
> fetched QCOW2 image is now decompressed and read in the kernel. Compared
> to a decompression and read in the user space, like qemu-nbd does, this
> approach does not need any user space process, is faster and avoids
> switchroot problems.

This image can be compressed via xz, and fetched via wget or what
ever. 'xz' could have better compression ratio than qcow2, I guess.

> 
> > 2) how does the in kernel QCOW2 interacts with in-kernel network boot
> > infrastructure?
> 
> The in-kernel QCOW2 implementation uses the fetched QCOW2 image and
> exposes it as block device.
> 
> Therefore, my implementation extends the loop device module by a general
> file format subsystem to implement various file format drivers including
> a driver for the QCOW2 and RAW file format. The configuration utility
> losetup is used to set up a loop device and specify the file format
> driver to use.

You still need to update losetup.  xz-utils can be installed for
decompressing the image, then you still can create loop disk over
the image.

> 
> > 3) most important thing, what are the exact steps for one user to use
> > the in-kernel network boot infrastructure and in-kernel QCOW2?
> 
> To achieve a running system one have to complete the following items:
> 
>   * Set up a PXE boot server and configure client computers to boot from
>     the network
>   * Build a Linux kernel for the network boot with built-in QCOW2
>     implementation
>   * Prepare the initramfs for the network boot. Use a network file
>     system or copy tool to fetch the compressed QCOW2 image.
>   * Create a compressed QCOW2 image that contains a complete environment
>     for the user to work with after a successful network boot
>   * Set up the reading of the fetched QCOW2 image using the in-kernel
>     QCOW2 implementation and mount the file systems located in the QCOW2
>     image.
>   * Perform a switchroot to change into the mounted environment of the
>     QCOW2 image.

As I mentioned above, seems not necessary to introduce loop-qcow2.

Thanks,
Ming
