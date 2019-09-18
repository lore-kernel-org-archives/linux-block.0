Return-Path: <SRS0=kmcw=XN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0094EC4CEC9
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 11:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2211214AF
	for <linux-block@archiver.kernel.org>; Wed, 18 Sep 2019 11:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfIRLZo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:25:44 -0400
Received: from smtpi.uni-freiburg.de ([132.230.2.212]:39798 "EHLO
        smtp2.uni-freiburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfIRLZo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Sep 2019 07:25:44 -0400
X-Greylist: delayed 3575 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Sep 2019 07:25:42 EDT
Delivery-date: Wed, 18 Sep 2019 13:25:42 +0200
Received: from fe2.uni-freiburg.de ([132.230.2.222] helo=uni-freiburg.de) port 55426 
        by smtp2.uni-freiburg.de with esmtp
        ( Exim )
        id 1iAX9u-0001wr-QV; Wed, 18 Sep 2019 12:26:02 +0200
Received: from [132.230.8.113] (account simon.rettberg@rz.uni-freiburg.de HELO dellnichtsogutkiste)
  by mail.uni-freiburg.de (CommuniGate Pro SMTP 6.2.12)
  with ESMTPSA id 38824255; Wed, 18 Sep 2019 12:26:02 +0200
Date:   Wed, 18 Sep 2019 12:26:02 +0200
From:   Simon Rettberg <simon.rettberg@rz.uni-freiburg.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Manuel Bentele <development@manuel-bentele.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/5] block: loop: add file format subsystem and QCOW2
 file format driver
Message-ID: <20190918122602.4f451fb1@dellnichtsogutkiste>
In-Reply-To: <20190916021129.GC5162@ming.t460p>
References: <20190823225619.15530-1-development@manuel-bentele.de>
        <20190912022359.GD2731@ming.t460p>
        <dc9e1697-ee11-622a-0f48-ebd65ff2a4e7@manuel-bentele.de>
        <20190916021129.GC5162@ming.t460p>
Organization: Rechenzentrum Uni Freiburg
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi everyone,

chiming in for clearing this up a bit.

> Got it, looks a good use case for compression, but not has to be
> QCOW2.
> 
> > 
> > The network boot infrastructure is based on a classical PXE network
> > boot to load the Linux kernel and the initramfs. In the initramfs,
> > the compressed QCOW2 image is fetched via nfs or cifs or something
> > else. The fetched QCOW2 image is now decompressed and read in the
> > kernel. Compared to a decompression and read in the user space,
> > like qemu-nbd does, this approach does not need any user space
> > process, is faster and avoids switchroot problems.  
> 
> This image can be compressed via xz, and fetched via wget or what
> ever. 'xz' could have better compression ratio than qcow2, I guess.

"Fetch" was probably a bit ambiguous. The image isn't downloaded, but
mounted directly from the network (streamed?), so we can benefit from
the per-cluster compression of qcow2, similar to squashfs but on the
block layer. A typical image is between 3 and 10GB with qcow2
compression, so downloading it entirely on boot to be able to
decompress it is not feasible.

> As I mentioned above, seems not necessary to introduce loop-qcow2.

Yes, there are many ways to achieve this. The basic concept of network
booting the workstations has been practiced here for almost 15 years
now using very different approaches like plain old NFS mounts for the
root filesystem, squashfs containers that get downloaded, or streamed
over network. But since our requirement is a stateless system, we need
a copy-on-write layer on top of this. In the beginnings we did this
with unionfs and then aufs, but as these operate on the file-system
layer they have several drawbacks and relatively high complexity
compared to block-layer CoW. So we switched to a block-based approach
about 4 years ago. For reasons stated before, we wanted to use some
form of compression, as was possible with squashfs before, so after
some experimenting, qcow2 proved to be a good fit. However, adding in
user-space tools like qemu-nbd or xmount added too much of a
performance penalty and initially, also some problems during the
switchroot from initrd to the actual root file system.

So the current process looks as follows: kernel + initrd are
loaded via iPXE. initrd sets up network, mounts NFS share or connects
to server via NBD to access the qcow2 image. Modified losetup sets up
access to qcow2 image, either from NFS share or
directly from /dev/nbd0. Finally, mount /dev/loop0pXX and switch to new
root.

Manuel's implementation has so far proven to be very reliable and
brought noticeable performance improvements compared to having a user
space process doing the qcow2 handling.

So we would have really liked the idea of having his changes
upstreamed, I think he did a very good job by designing a plugin
infrastructure for the loop device and making the qcow2 plugin a
separate module. We knew about the concerns of adding code for handling
a file format in the kernel and were hoping that maybe an acceptable
compromise would be to have his changes added to the kernel minus the
actual qcow2 plugin, so it is mostly a refactoring of the old loop
device that's not adding too much complexity (hopefully). But if we're
really such an oddball use-case here that this won't possibly be of any
interest to anybody else we will just have to go forward maintaining
this out of tree entirely.

Thanks for your time,
Simon
