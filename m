Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87394C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60DC420786
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="gN2Lmfnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgFPQVa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgFPQV3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 12:21:29 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CB1C061573
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 09:21:28 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g1so14715326edv.6
        for <linux-block@vger.kernel.org>; Tue, 16 Jun 2020 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0l7S91qv3WKrYo+myExsZp09xb5yLuQTmqBdFdlqdhU=;
        b=gN2Lmfnl+2zd5dHffTtMmHjibyMhBiVRkMo3xI6kv5PiIFLURd4kemoC3uLEUiZzLL
         RDTtaRaRH4LNqOR9W6VISJhsHs+SEVHidSHsCyvxGuaVjstzoBP7+D95ZI1dJTwKn57R
         R1utFTbTCcLruaW29ncDzgAcoxiIq0LjbUAZZ9TpnNtNYGTIvQA7p8t7eVIkQjaJnrmL
         7OjFVb6XGSDIV6lhm/9QS9o9tzr/z7Rvs6EcFuprWDB3VVYgL3ymLqMME8edCJh5wUp2
         GFVc5R2U/lW1YcYaSgQSqYItfDGkgMY+T+tVdj1NqKv8Fi78EFxYZ0phACrzOmcuMQ90
         8jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0l7S91qv3WKrYo+myExsZp09xb5yLuQTmqBdFdlqdhU=;
        b=rR8x78sxz87VsN1in7I63pp0OEHaSAYWYUf9Utr7IxtJN7H1xf2F81XAJLpX5SdQXs
         oTbskaZrLePH4LGbanxwmYj8cS81LtAzkA8MjiL47z2NXZQ0zrM0lJ8V+ve0KdcJkXnO
         6hvARn3VeWZ0Yfu2F+uP9mZsqx8Vh8VjkZNMNN5RWjTQxFFBvIghhv3FMOem4QvIFiy0
         js2KyFRyVmnAT0uJjctDwISkNL8NbkryZ1v2cvX6mFc7y7whAQQM3UAsWiGaHfrZTPXH
         18foW3CLI0DOwm8/eNijJE3p43JFhL8mpG3DCPvV9+wwUdfYJQQKHkHw3D7DxANOXzgU
         9Hmw==
X-Gm-Message-State: AOAM5309DQYKXu0B7FXSjfea4XhV9UTuycznUW7fPnLqZg69V3S+rOJS
        TXXM3FNiML7JA12TdThBGYCEKw==
X-Google-Smtp-Source: ABdhPJxZqgFtJA+knQv3Ws5uE5VD1SuhEhuVxuyzzl5D+f5qMom3diYA2YsIjjtPsPTbW03kn1cg3g==
X-Received: by 2002:a05:6402:362:: with SMTP id s2mr3340912edw.337.1592324487122;
        Tue, 16 Jun 2020 09:21:27 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id z3sm11355141ejl.38.2020.06.16.09.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:21:26 -0700 (PDT)
Date:   Tue, 16 Jun 2020 18:21:25 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias Bjorling <Matias.Bjorling@wdc.com>
Cc:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <Keith.Busch@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200616162125.4zz3mjw2p37wfq5t@mpHalley.localdomain>
References: <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <506571d0-52f4-de88-9438-878618ff738d@lightnvm.io>
 <20200616160326.jxs4e37bayxpyyae@MacBook-Pro.localdomain>
 <MN2PR04MB6223BC554A2C881DD60D0E5EF19D0@MN2PR04MB6223.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR04MB6223BC554A2C881DD60D0E5EF19D0@MN2PR04MB6223.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16.06.2020 16:07, Matias Bjorling wrote:
>
>
>> -----Original Message-----
>> From: Javier González <javier@javigon.com>
>> Sent: Tuesday, 16 June 2020 18.03
>> To: Matias Bjørling <mb@lightnvm.io>
>> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Jens Axboe
>> <axboe@kernel.dk>; Niklas Cassel <Niklas.Cassel@wdc.com>; Ajay Joshi
>> <Ajay.Joshi@wdc.com>; Sagi Grimberg <sagi@grimberg.me>; Keith Busch
>> <Keith.Busch@wdc.com>; Dmitry Fomichev <Dmitry.Fomichev@wdc.com>;
>> Aravind Ramesh <Aravind.Ramesh@wdc.com>; linux-
>> nvme@lists.infradead.org; linux-block@vger.kernel.org; Hans Holmberg
>> <Hans.Holmberg@wdc.com>; Christoph Hellwig <hch@lst.de>; Matias Bjorling
>> <Matias.Bjorling@wdc.com>
>> Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
>>
>> On 16.06.2020 17:20, Matias Bjørling wrote:
>> >On 16/06/2020 17.02, Javier González wrote:
>> >>On 16.06.2020 14:42, Damien Le Moal wrote:
>> >>>On 2020/06/16 23:16, Javier González wrote:
>> >>>>On 16.06.2020 12:35, Damien Le Moal wrote:
>> >>>>>On 2020/06/16 21:24, Javier González wrote:
>> >>>>>>On 16.06.2020 14:06, Matias Bjørling wrote:
>> >>>>>>>On 16/06/2020 14.00, Javier González wrote:
>> >>>>>>>>On 16.06.2020 13:18, Matias Bjørling wrote:
>> >>>>>>>>>On 16/06/2020 12.41, Javier González wrote:
>> >>>>>>>>>>On 16.06.2020 08:34, Keith Busch wrote:
>> >>>>>>>>>>>Add support for NVM Express Zoned Namespaces (ZNS)
>> Command
>> >>>>>>>>>>>Set defined in NVM Express TP4053. Zoned namespaces are
>> >>>>>>>>>>>discovered based on their Command Set Identifier reported in
>> >>>>>>>>>>>the namespaces Namespace Identification Descriptor list. A
>> >>>>>>>>>>>successfully discovered Zoned Namespace will be registered
>> >>>>>>>>>>>with the block layer as a host managed zoned block device
>> >>>>>>>>>>>with Zone Append command support. A namespace that does not
>> >>>>>>>>>>>support append is not supported by the driver.
>> >>>>>>>>>>
>> >>>>>>>>>>Why are we enforcing the append command? Append is optional
>> on
>> >>>>>>>>>>the current ZNS specification, so we should not make this
>> >>>>>>>>>>mandatory in the implementation. See specifics below.
>> >>>>>>>>
>> >>>>>>>>>
>> >>>>>>>>>There is already general support in the kernel for the zone
>> >>>>>>>>>append command. Feel free to submit patches to emulate the
>> >>>>>>>>>support. It is outside the scope of this patchset.
>> >>>>>>>>>
>> >>>>>>>>
>> >>>>>>>>It is fine that the kernel supports append, but the ZNS
>> >>>>>>>>specification does not impose the implementation for append, so
>> >>>>>>>>the driver should not do that either.
>> >>>>>>>>
>> >>>>>>>>ZNS SSDs that choose to leave append as a non-implemented
>> >>>>>>>>optional command should not rely on emulated SW support,
>> >>>>>>>>specially when traditional writes work very fine for a large
>> >>>>>>>>part of current ZNS use cases.
>> >>>>>>>>
>> >>>>>>>>Please, remove this virtual constraint.
>> >>>>>>>
>> >>>>>>>The Zone Append command is mandatory for zoned block devices.
>> >>>>>>>Please see https://lwn.net/Articles/818709/ for the background.
>> >>>>>>
>> >>>>>>I do not see anywhere in the block layer that append is mandatory
>> >>>>>>for zoned devices. Append is emulated on ZBC, but beyond that
>> >>>>>>there is no mandatory bits. Please explain.
>> >>>>>
>> >>>>>This is to allow a single write IO path for all types of zoned
>> >>>>>block device for higher layers, e.g file systems. The on-going
>> >>>>>re-work of btrfs zone support for instance now relies 100% on zone
>> >>>>>append being supported. That significantly simplifies the file
>> >>>>>system support and more importantly remove the need for locking
>> >>>>>around block allocation and BIO issuing, allowing to preserve a
>> >>>>>fully asynchronous write path that can include workqueues for
>> >>>>>efficient CPU usage of things like encryption and compression.
>> >>>>>Without zone append, file system would either (1) have to reject
>> >>>>>these drives that do not support zone append, or (2) implement 2
>> >>>>>different write IO path (slower regular write and zone append).
>> >>>>>None of these options are ideal, to say the least.
>> >>>>>
>> >>>>>So the approach is: mandate zone append support for ZNS devices. To
>> >>>>>allow other ZNS drives, an emulation similar to SCSI can be
>> >>>>>implemented, with that emulation ideally combined to work for both
>> >>>>>types of drives if possible.
>> >>>>
>> >>>>Enforcing QD=1 becomes a problem on devices with large zones. In a
>> >>>>ZNS device that has smaller zones this should not be a problem.
>> >>>
>> >>>Let's be precise: this is not running the drive at QD=1, it is "at
>> >>>most one write *request* per zone". If the FS is simultaneously using
>> >>>multiple block groups mapped to different zones, you will get a total
>> >>>write QD > 1, and as many reads as you want.
>> >>>
>> >>>>Would you agree that it is possible to have a write path that relies
>> >>>>on QD=1, where the FS / application has the responsibility for
>> >>>>enforcing this? Down the road this QD can be increased if the device
>> >>>>is able to buffer the writes.
>> >>>
>> >>>Doing QD=1 per zone for writes at the FS layer, that is, at the BIO
>> >>>layer does not work. This is because BIOs can be as large as the FS
>> >>>wants them to be. Such large BIO will be split into multiple requests
>> >>>in the block layer, resulting in more than one write per zone. That
>> >>>is why the zone write locking is at the scheduler level, between BIO
>> >>>split and request dispatch. That avoids the multiple requests
>> >>>fragments of a large BIO to be reordered and fail. That is mandatory
>> >>>as the block layer itself can occasionally reorder requests and lower
>> >>>levels such as AHCI HW is also notoriously good at reversing
>> >>>sequential requests. For NVMe with multi-queue, the IO issuing
>> >>>process getting rescheduled on a different CPU can result in
>> >>>sequential IOs being in different queues, with the likely result of
>> >>>an out-of-order execution. All cases are avoided with zone write
>> >>>locking and at most one write request dispatch per zone as
>> >>>recommended by the ZNS specifications (ZBC and ZAC standards for SMR
>> >>>HDDs are silent on this).
>> >>>
>> >>
>> >>I understand. I agree that the current FSs supporting ZNS follow this
>> >>approach and it makes sense that there is a common interface that
>> >>simplifies the FS implementation. See the comment below on the part I
>> >>believe we see things differently.
>> >>
>> >>
>> >>>>I would be OK with some FS implementations to rely on append and
>> >>>>impose the constraint that append has to be supported (and it would
>> >>>>be our job to change that), but I would like to avoid the driver
>> >>>>rejecting initializing the device because current FS implementations
>> >>>>have implemented this logic.
>> >>>
>> >>>What is the difference between the driver rejecting drives and the FS
>> >>>rejecting the same drives ? That has the same end result to me: an
>> >>>entire class of devices cannot be used as desired by the user.
>> >>>Implementing zone append emulation avoids the rejection entirely
>> >>>while still allowing the FS to have a single write IO path, thus
>> >>>simplifying the code.
>> >>
>> >>The difference is that users that use a raw ZNS device submitting I/O
>> >>through the kernel would still be able to use these devices. The
>> >>result would be that the ZNS SSD is recognized and initialized, but
>> >>the FS format fails.
>> >>
>> >>>
>> >>>>We can agree that a number of initial customers will use these
>> >>>>devices raw, using the in-kernel I/O path, but without a FS on top.
>> >>>>
>> >>>>Thoughts?
>> >>>>
>> >>>>>and note that
>> >>>>>this emulation would require the drive to be operated with
>> >>>>>mq-deadline to enable zone write locking for preserving write
>> >>>>>command order. While on a HDD the performance penalty is minimal,
>> >>>>>it will likely be significant on a SSD.
>> >>>>
>> >>>>Exactly my concern. I do not want ZNS SSDs to be impacted by this
>> >>>>type of design decision at the driver level.
>> >>>
>> >>>But your proposed FS level approach would end up doing the exact same
>> >>>thing with the same limitation and so the same potential performance
>> >>>impact.
>> >>>The block
>> >>>layer generic approach has the advantage that we do not bother the
>> >>>higher levels with the implementation of in-order request dispatch
>> >>>guarantees.
>> >>>File systems
>> >>>are complex enough. The less complexity is required for zone support,
>> >>>the better.
>> >>
>> >>This depends very much on how the FS / application is managing
>> >>stripping. At the moment our main use case is enabling user-space
>> >>applications submitting I/Os to raw ZNS devices through the kernel.
>> >>
>> >>Can we enable this use case to start with?
>> >
>> >It is free for everyone to load kernel modules into the kernel. Those
>> >modules may not have the appropriate checks or may rely on the zone
>> >append functionality. Having per use-case limit is a no-go and at best
>> >a game of whack-a-mole.
>>
>> Let's focus on mainline support. We are leaving append as not enabled based
>> on customer requests for some ZNS products and would like this devices to be
>> supported. This is not at all a corner use-case but a very general one.
>>
>> >
>> >You already agreed to create a set of patches to add the appropriate
>> >support for emulating zone append. As these would fix your specific
>> >issue, please go ahead and submit those.
>>
>> I agreed to solve the use case that some of our customers are enabling and this
>> is what I am doing.
>>
>> Again, to start with I would like to have a path where ZNS namespaces are
>> identified independently of append support. Then specific users can require
>> append if they please to do so. We will of course take care of sending patches
>> for this.
>
>As was previously said, there are users in the kernel that depends on
>zone append. As a result, it is not an option not to have this. Please
>go ahead and send the patches and you'll have the behavior you are
>seeking.
>

Never put in doubt that we are the ones implementing support for this,
but since you keep asking, I want to make it clear that not using append
command is a very general use case for ZNS adopters.

Thanks,
Javier


