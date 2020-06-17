Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F351C433DF
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 23:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE91021556
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 23:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="Ixd3NNQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFQXoi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFQXoh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 19:44:37 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22970C06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 16:44:37 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id f2so796397ooo.5
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucsc.edu; s=ucsc-google-2018;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uJ2PlPgrWohgBlHx3eMj/u+O3g5rs9Qkl8fBDfrrwi0=;
        b=Ixd3NNQbfQIR/gfVrJCL3hxFisKXpgnPOTZULmTu7EJDNIiv+g+t4XQsKTIKppzCIO
         Ger3q9ns/RBw3MockjFb49XE5YvFnB8PN/AUZDSq8dKueSiRwJW/9qEjD2QIPsSB9J1c
         DuABSiLq+dgQJBsjJQzkGrxfEJuPTYKAKHL60SDe/1IMKvYOxKnqFfTFA4PmyunzLC1e
         gT9DkjZwTY3tieaeOVUzIK9opZHWkjeYW2MTgB4aEhWLVYCCnypH57lFxfSFFBIXtIGO
         wrGCH0IawU6xR4FhTf+vkahH36OvVf2yDUbxFKqAotnAKNsbTJRyuw/6W8W8bRiUEpu6
         A4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uJ2PlPgrWohgBlHx3eMj/u+O3g5rs9Qkl8fBDfrrwi0=;
        b=qks7LZpMvhtU9q3erazXZzQosLYdLEETVz/tVpj9oOcOwqZqCENk/zIFmPLNH0zfWV
         uMZKnSfpw859s4IHXG/W/005BiX2OrllDqqx0cG2o7lz/l/VrzaoJx56ShHjOZUf3Dl3
         LRQQA7WfiHklhLMK3HnSw+Dv3t2c1zcNdQLo7oqvaCzZgTwwLWxMxuAKbgjBRHaom9iH
         x8ScbGwHOC+gwf5cERK/7Sq2nR26Y/Y7Tct3nuuRGkBhIE5Atbvm6mA9SnlY3HrtQjCI
         HLi0QTwPfJhK5fJoZwfTlwvfgeVLaJH8C55kLpfDgPf3FXxhkvBPLplLjKVnSG+Ob/W0
         d6Zg==
X-Gm-Message-State: AOAM531SfrTRShPpu6jP/X+gd+ZfXabQfE/iH53j+HUdHvDQ6XoyeQOM
        2ZUb72D8Rqovg0aiSe/eL/RfF+QLiJdO0LJcbdRmTaHY
X-Google-Smtp-Source: ABdhPJysI11SS0RAgEbG/scwC9yswsmdXIzKegydVE2GkUgdw1KveEmf3oYTolOhlm6WxJvKJKtFscbq1Mvhyls9k60=
X-Received: by 2002:a4a:ca8b:: with SMTP id x11mr1702275ooq.83.1592437475055;
 Wed, 17 Jun 2020 16:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200615233424.13458-1-keith.busch@wdc.com> <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local> <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain> <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
 <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain> <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local> <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
In-Reply-To: <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
From:   Heiner Litz <hlitz@ucsc.edu>
Date:   Wed, 17 Jun 2020 16:44:23 -0700
Message-ID: <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the interesting discussion but it made me wonder about the
usefulness of 4K writes in the first place. Append seems to be a
workaround for a problem (single writer/QD) that shouldn't exist in
the first place. If writes need to be sequential, what is the purpose
of allowing 4K writes at all (it provides no placement flexibility).
Mandating zone-sized writes would address all problems with ease and
reduce request rate and overheads in the kernel. I don't see why we
would disassemble a zone-sized block into smaller writes just to
re-assemble them again on the device. A promise of ZNS is to move the
translation overhead from the device into the FS layer so why
re-introduce complexity in the bio layer? Managing zone-sized blocks
on the application/FS layer is also much more convenient than
receiving random 4K addresses from append commands.
Finally, note that splitting zone-sized bios in the kernel does not
achieve any purpose as interleaving/scheduling within a zone isn't
possible. If we want to interleave accesses to multiple open zones,
this should be done on the device layer by exposing queue(s) per zone.
For applications writing large, consecutive blocks (RocksDB), the best
implementation seems to be providing a kernel path that guarantees
non-splittable zone-sized writes.

On Wed, Jun 17, 2020 at 12:40 PM Javier Gonz=C3=A1lez <javier@javigon.com> =
wrote:
>
> On 17.06.2020 21:23, Matias Bj=C3=B8rling wrote:
> >On 17/06/2020 21.09, Javier Gonz=C3=A1lez wrote:
> >>On 17.06.2020 18:55, Matias Bjorling wrote:
> >>>>-----Original Message-----
> >>>>From: Javier Gonz=C3=A1lez <javier@javigon.com>
> >>>>Sent: Wednesday, 17 June 2020 20.29
> >>>>To: Matias Bj=C3=B8rling <mb@lightnvm.io>
> >>>>Cc: Christoph Hellwig <hch@lst.de>; Keith Busch <Keith.Busch@wdc.com>=
;
> >>>>linux-nvme@lists.infradead.org; linux-block@vger.kernel.org;
> >>>>Damien Le Moal
> >>>><Damien.LeMoal@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>;
> >>>>Sagi Grimberg <sagi@grimberg.me>; Jens Axboe <axboe@kernel.dk>; Hans
> >>>>Holmberg <Hans.Holmberg@wdc.com>; Dmitry Fomichev
> >>>><Dmitry.Fomichev@wdc.com>; Ajay Joshi <Ajay.Joshi@wdc.com>; Aravind
> >>>>Ramesh <Aravind.Ramesh@wdc.com>; Niklas Cassel
> >>>><Niklas.Cassel@wdc.com>; Judy Brock <judy.brock@samsung.com>
> >>>>Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
> >>>>
> >>>>On 17.06.2020 19:57, Matias Bj=C3=B8rling wrote:
> >>>>>On 17/06/2020 16.42, Javier Gonz=C3=A1lez wrote:
> >>>>>>On 17.06.2020 09:43, Christoph Hellwig wrote:
> >>>>>>>On Tue, Jun 16, 2020 at 12:41:42PM +0200, Javier Gonz=C3=A1lez wro=
te:
> >>>>>>>>On 16.06.2020 08:34, Keith Busch wrote:
> >>>>>>>>>Add support for NVM Express Zoned Namespaces (ZNS) Command Set
> >>>>>>>>>defined in NVM Express TP4053. Zoned namespaces are discovered
> >>>>>>>>>based on their Command Set Identifier reported in the namespaces
> >>>>>>>>>Namespace Identification Descriptor list. A successfully
> >>>>discovered
> >>>>>>>>>Zoned Namespace will be registered with the block layer as a hos=
t
> >>>>>>>>>managed zoned block device with Zone Append command support. A
> >>>>>>>>>namespace that does not support append is not supported by
> >>>>the driver.
> >>>>>>>>
> >>>>>>>>Why are we enforcing the append command? Append is optional on th=
e
> >>>>>>>>current ZNS specification, so we should not make this mandatory i=
n
> >>>>>>>>the implementation. See specifics below.
> >>>>>>>
> >>>>>>>Because Append is the way to go and we've moved the Linux
> >>>>zoned block
> >>>>>>>I/O stack to required it, as should have been obvious to anyone
> >>>>>>>following linux-block in the last few months.  I also have to
> >>>>say I'm
> >>>>>>>really tired of the stupid politics tha your company started in th=
e
> >>>>>>>NVMe working group, and will say that these do not matter for Linu=
x
> >>>>>>>development at all.  If you think it is worthwhile to support
> >>>>devices
> >>>>>>>without Zone Append you can contribute support for them on top of
> >>>>>>>this series by porting the SCSI Zone Append Emulation code to NVMe=
.
> >>>>>>>
> >>>>>>>And I'm not even going to read the rest of this thread as I'm on a
> >>>>>>>vacation that I badly needed because of the Samsung TWG bullshit.
> >>>>>>
> >>>>>>My intention is to support some Samsung ZNS devices that will not
> >>>>>>enable append. I do not think this is an unreasonable thing to
> >>>>do. How
> >>>>>>/ why append ended up being an optional feature in the ZNS TP is
> >>>>>>orthogonal to this conversation. Bullshit or not, it ends up on
> >>>>>>devices that we would like to support one way or another.
> >>>>>
> >>>>>I do not believe any of us have said that it is unreasonable to
> >>>>>support. We've only asked that you make the patches for it.
> >>>>>
> >>>>>All of us have communicated why Zone Append is a great addition to t=
he
> >>>>>Linux kernel. Also, as Christoph points out, this has not been
> >>>>a secret
> >>>>>for the past couple of months, and as Martin pointed out, have been =
a
> >>>>>wanted feature for the past decade in the Linux community.
> >>>>
> >>>>>
> >>>>>I do want to politely point out, that you've got a very clear signal
> >>>>>from the key storage maintainers. Each of them is part of the planet=
's
> >>>>>best of the best and most well-respected software developers, that
> >>>>>literally have built the storage stack that most of the world depend=
s
> >>>>>on. The storage stack that recently sent manned rockets into space.
> >>>>>They each unanimously said that the Zone Append command is the right
> >>>>>approach for the Linux kernel to reduce the overhead of I/O tracking
> >>>>>for zoned block devices. It may be worth bringing this information t=
o
> >>>>>your engineering organization, and also potentially consider Zone
> >>>>>Append support for devices that you intend to used with the Linux
> >>>>>kernel storage stack.
> >>>>
> >>>>I understand and I have never said the opposite.
> >>>>
> >>>>Append is a great addition that
> >>>
> >>>One may have interpreted your SDC EMEA talk the opposite. It was not
> >>>very neutral towards Zone Append, but that is of cause one of its leas=
t
> >>>problems. But I am happy to hear that you've changed your opinion.
> >>
> >>As you are well aware, there are some cases where append introduces
> >>challenges. This is well-documented on the bibliography around nameless
> >>writes.
> >
> >The nameless writes idea is vastly different from Zone append, and
> >have little of the drawbacks of nameless writes, which makes the
> >well-documented literature not apply.
>
> You can have that conversation with your customer base.
>
> >
> >>Part of the talk was on presenting an alternative for these
> >>particular use cases.
> >>
> >>This said, I am not afraid of changing my point of view when I am prove=
n
> >>wrong.
> >>
> >>>
> >>>>we also have been working on for several months (see patches
> >>>>additions from
> >>>>today). We just have a couple of use cases where append is not
> >>>>required and I
> >>>>would like to make sure that they are supported.
> >>>>
> >>>>At the end of the day, the only thing I have disagreed on is
> >>>>that the NVMe
> >>>>driver rejects ZNS SSDs that do not support append, as opposed
> >>>>to doing this
> >>>>instead when an in-kernel user wants to utilize the drive (e.g.,
> >>>>formatting a FS
> >>>>with zoned support) This would allow _today_
> >>>>ioctl() passthru to work for normal writes.
> >>>>
> >>>>I still believe the above would be a more inclusive solution
> >>>>with the current ZNS
> >>>>specification, but I can see that the general consensus is different.
> >>>
> >>>The comment from the community, including me, is that there is a
> >>>general requirement for Zone Append command when utilizing Zoned
> >>>storage devices. This is similar to implement an API that one wants to
> >>>support. It is not a general consensus or opinion. It is hard facts an=
d
> >>>how the Linux kernel source code is implemented at this point. One mus=
t
> >>>implement support for ZNS SSDs that do not expose the Zone Append
> >>>command natively. Period.
> >>
> >>Again, I am not saying the opposite. Read the 2 lines below...
> >
> >My point with the above paragraph was to clarify that we are not
> >trying to be difficult or opinionated, but point out that the reason
> >we give you the specific feedback, is that it is the way it is in the
> >kernel as today.
>
> Again, yes, we will apply the feedback and come back with an approach
> that fits so that we can enable the raw ZNS block access that we want to
> enable.
>
> >
> >>
> >>>>
> >>>>So we will go back, apply the feedback that we got and return with an
> >>>>approach that better fits the ecosystem.
> >>>>
> >>>>>
> >>>>>Another approach, is to use SPDK, and bypass the Linux kernel. This
> >>>>>might even be an advantage, your customers does not have to
> >>>>wait on the
> >>>>>Linux distribution being released with a long term release,
> >>>>before they
> >>>>>can even get started and deploy in volume. I.e., they will
> >>>>actually get
> >>>>>faster to market, and your company will be able to sell more drives.
> >>>>
> >>>>I think I will refrain from discussing our business strategy on
> >>>>an open mailing
> >>>>list. Appreciate the feedback though. Very insightful.
> >>>
> >>>I am not asking for you to discuss your business strategy on the
> >>>mailing list. My comment was to give you genuinely advise that may
> >>>save a lot of work, and might even get better results.
> >>>
> >>>>
> >>>>Thanks,
> >>>>Javier
> >>
