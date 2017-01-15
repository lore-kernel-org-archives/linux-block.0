Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54681 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750781AbdAOBEb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 20:04:31 -0500
Date: Sat, 14 Jan 2017 20:03:48 -0500
From: Josef Bacik <jbacik@fb.com>
Subject: Re: NBD: exported files over something around 1 TiB get an insane
 device size on the client side and are actually empty
To: Christoph Anton Mitterer <calestyo@scientia.net>
CC: <linux-block@vger.kernel.org>, <nbd-general@lists.sourceforge.net>
Message-ID: <1484442228.7132.0@smtp.office365.com>
In-Reply-To: <1484436698.7110.29.camel@scientia.net>
References: <1484436698.7110.29.camel@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Jan 14, 2017 at 6:31 PM, Christoph Anton Mitterer 
<calestyo@scientia.net> wrote:
> Hi.
> 
> On advice from Alex Bligh I'd like to ping linux-block and nbd-general
> about the issue described here:
> https://github.com/NetworkBlockDevice/nbd/issues/44
> 
> What basically happens is, that with a recent kernel (Linux heisenberg
> 4.9.0-1-amd64 #1 SMP Debian 4.9.2-2 (2017-01-12) x86_64 GNU/Linux),
> when a device larger than something between 1 TiB and 2 TiB is 
> exported
> via nbd-server and connected to via nbd-client (which uses the kernel
> driver, AFAIU) than the device size gets insanely large while reading
> from /dev/nbd0 gives actually nothing.
> 
> 
> The bug does not seem to happen when the kernel is not involved (we
> tried using nbd-server and qemu-img as the client).
> 
> Don't think it makes all too much sense to copy & paste everything 
> from
> what was tried already for testing here, so please have a look at the
> issue on github.

Yeah I noticed this in testing, there's a bug with NBD since it's 
inception where it uses a 32 bit number for keeping track of the size 
of the device, I fixed it with

nbd: use loff_t for blocksize and nbd_set_size args

It'll be in 4.10.  Thanks,

Josef

