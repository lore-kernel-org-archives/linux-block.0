Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AE0C636CC
	for <linux-block@archiver.kernel.org>; Tue,  7 Feb 2023 12:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjBGMLn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Feb 2023 07:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjBGMLm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Feb 2023 07:11:42 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528D728234
        for <linux-block@vger.kernel.org>; Tue,  7 Feb 2023 04:11:40 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id sa10so12197369ejc.9
        for <linux-block@vger.kernel.org>; Tue, 07 Feb 2023 04:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gH1tOnAErjckbVlt/gjfTXGvMo5413TBr40k09jVMGA=;
        b=lHYxNAZGP1yVHUVdI+RAo/0Ni1gPdusvawW0btQ424Zi1+OCpQAJNgg8zP/p3/YcL8
         TWtYV6HmGjjwDJEZEWPciUfIo7P2QIPGqogPEVvc6CPCZWskH6ious4iqKLS9XkDG5XV
         34+VDYyJteHdpA1uVkmHXRnNxJYUvAFWl27314koFHzP4+aV8TBKFjfH0WbGqcsJmN7l
         r18vGN6lF20Si4tdAjZi4GUKNtGiRiL44BYWgeW4SP8oipOWgIBn0PkY4yLRe/QjWZlL
         OAfRyDmhsL7B+xoAWcDfTklt4EaQA8BTpYsXUzjZontJ4STKg3b9xcDdZMjJjPIewYCO
         yCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gH1tOnAErjckbVlt/gjfTXGvMo5413TBr40k09jVMGA=;
        b=WeQuRYvNhbVmEDyKYpJSle2f682Cu+8fNggHrqPuMYLl9xSgL1N78vWMfQwJf7qwNA
         RbWWLGgfhQyGAF1p+dD4UxFsObvFefpnzrUft8jaixNbhBQ7U+V59NU1AXg8HdY4ffZ4
         isfBb+8HhxiW7kjhbZBWEP7urAe8XfCYk7PMSauBhc3njnpDVHnTTjD5LYu2XdWan1fV
         xSG6zKgARJhMGJemLey7p2MOYeilSDgSljhvaVVtjmfVsj+YUIpVxd8BrQHtJeYK3Rt1
         QJQEBwSQ0xZzl/dc/M8cP4LLOXM6QKZYiZfVk9RQi+wzD2fTMPCD7FaGHgXPo/+ZTToJ
         2SiA==
X-Gm-Message-State: AO0yUKU/zwq5mAhr/534qmK/PZvqBR7A0hKa78HX0sFc93OeVr0LQZUY
        kN0ZknDHodEOpnEA0P9i/bJhLTXWVL3KpveIUtLFEg==
X-Google-Smtp-Source: AK7set8dCUMSuvCGvu4GFzUM2zNA9yJyudY96c35vr69Lf0NuuCdfFPbjw4+f9UyDRYQ+2zVRcJucyTDCb/EmN3NzaM=
X-Received: by 2002:a17:906:6957:b0:886:73de:3efc with SMTP id
 c23-20020a170906695700b0088673de3efcmr891776ejs.87.1675771898850; Tue, 07 Feb
 2023 04:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20230206100019.GA6704@gsv> <639ba3a3-4b6d-b540-02fd-0e68afd00ac6@acm.org>
In-Reply-To: <639ba3a3-4b6d-b540-02fd-0e68afd00ac6@acm.org>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Tue, 7 Feb 2023 13:11:27 +0100
Message-ID: <CANr-nt0QfXDd6=aNNLc-muSidCOumpx7A9sqC=7OSOJwQg7NPg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        =?UTF-8?Q?J=C3=B8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        "andreas@metaspace.dk" <andreas@metaspace.dk>,
        "javier@javigon.com" <javier@javigon.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 6, 2023 at 7:58 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/6/23 02:00, Hans Holmberg wrote:
> > I think we're missing a flexible way of routing random-ish
> > write workloads on to zoned storage devices. Implementing a UBLK
> > target for this would be a great way to provide zoned storage
> > benefits to a range of use cases. Creating UBLK target would
> > enable us experiment and move fast, and when we arrive
> > at a common, reasonably stable, solution we could move this into
> > the kernel.
> >
> > We do have dm-zoned [3]in the kernel, but it requires a bounce
> > on conventional zones for non-sequential writes, resulting in a write
> > amplification of 2x (which is not optimal for flash).
> >
> > Fully random workloads make little sense to store on ZBDs as a
> > host FTL could not be expected to do better than what conventional block
> > devices do today. Fully sequential writes are also well taken care of
> > by conventional block devices.
> >
> > The interesting stuff is what lies in between those extremes.
> >
> > I would like to discuss how we could use UBLK to implement a
> > common FTL with the right knobs to cater for a wide range of workloads
> > that utilize raw block devices. We had some knobs in  the now-dead pblk,
> > a FTL for open channel devices, but I think we could do way better than that.
> >
> > Pblk did not require bouncing writes and had knobs for over-provisioning and
> > workload isolation which could be implemented. We could also add options
> > for different garbage collection policies. In userspace it would also
> > be easy to support default block indirection sizes, reducing logical-physical
> > translation table memory overhead.
> >
> > Use cases for such an FTL includes SSD caching stores such as Apache
> > traffic server [1] and CacheLib[2]. CacheLib's block cache and the apache
> > traffic server storage workloads are *almost* zone block device compatible
> > and would need little translation overhead to perform very well on e.g.
> > ZNS SSDs.
> >
> > There are probably more use cases that would benefit.
> >
> > It would also be a great research vehicle for academia. We've used dm-zap
> > for this [4] purpose the last couple of years, but that is not production-ready
> > and cumbersome to improve and maintain as it is implemented as a out-of-tree
> > device mapper.
> >
> > ublk adds a bit of latency overhead, but I think this is acceptable at least
> > until we have a great, proven solution, which could be turned into
> > an in-kernel FTL.
> >
> > If there is interest in the community for a project like this, let's talk!
> >
> > cc:ing the folks who participated in the discussions at ALPSS 2021 and last
> > years' plumbers on this subject.
> >
> > Thanks,
> > Hans
> >
> > [1] https://trafficserver.apache.org/
> > [2] https://cachelib.org/
> > [3] https://docs.kernel.org/admin-guide/device-mapper/dm-zoned.html
> > [4] https://github.com/westerndigitalcorporation/dm-zap
>
> Hi Hans,
>
> Which functionality would such a user space target provide that is not
> yet provided by BTRFS, F2FS or any other log-structured filesystem that
> supports zoned block devices?
>

Hi Bart,

The use cases I'm primarily thinking of are applications and services that work
on top of raw block interfaces, like Apache Traffic server and Cachelib
mentioned in my proposal.

These workloads benefit from not using a file system. The file system overhead
is just too big for storing millions of (> 2kiB) sized objects and
billions of < 2kiB
tiny objects.

For the larger objects, the write pattern is log structured and almost
fully sequential.
Zoned storage would provide a benefit if multiple instances of these
caches would
be co-located on the same media, resulting in mixing of these streams,
or if a large object cache would be mixed with other, random workloads,
like the cache lib store for small objects.

Cache workloads have relaxed persistence requirements. It's not the
end of the world
if an object disappears.

I can recommend [1] and [2] as an introduction to these workloads.

In my plumbers talk [3] from last year I sketched out how zoned storage
could benefit object caching on flash.

[1] https://www.usenix.org/conference/osdi20/presentation/berg
[2] https://engineering.fb.com/2021/10/26/core-data/kangaroo/
[3] https://lpc.events/event/16/contributions/1232/attachments/1066/2095/LPC%202022%20Zoned%20MC%20Improving%20object%20caches%20using%20ZNS%20V2.pdf


Cheers,
Hans
