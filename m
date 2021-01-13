Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C7BC433E9
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F671233F7
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 11:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbhAMLtm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726964AbhAMLti (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 06:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610538491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IClFT8HZFNG03FqV8ORG/u8ZO82v0K22MlBeqxe2bMY=;
        b=Boi7hjxOVwlrJhZ8KP5Izxzd1SQc0DfeGzV19O2wXzon/6yBY3Hjks7bYqMSEjLiVuH4RY
        Yodq2Ew6Mkfvb3dVmC98FUMAbljVWEFsaatgiCH/AWXChxW3KQR/1bWSh/kSA+gkRGcSML
        GAUgR0rbeW+rcUqw1BxiwfLbCG7V8Ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-gIujwRqWMsKmguwkOV2RMg-1; Wed, 13 Jan 2021 06:48:07 -0500
X-MC-Unique: gIujwRqWMsKmguwkOV2RMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29BA61005D44;
        Wed, 13 Jan 2021 11:48:05 +0000 (UTC)
Received: from T590 (ovpn-12-124.pek2.redhat.com [10.72.12.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FF9360871;
        Wed, 13 Jan 2021 11:47:27 +0000 (UTC)
Date:   Wed, 13 Jan 2021 19:47:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>
Subject: Re: [PATCH] bio: limit bio max size.
Message-ID: <20210113114722.GA233746@T590>
References: <CGME20210113040146epcas1p230596c7c3760471dca442d1f7ce4dc55@epcas1p2.samsung.com>
 <CH2PR04MB65225EDDA7069CCD47A459A5E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113034637.1382-1-nanich.lee@samsung.com>
 <CACVXFVMb0eE5-yo2k3KvnJjKN+aDLzOuT9rKQ7LY5-4WTgM3jw@mail.gmail.com>
 <CH2PR04MB65228D54F66068DA125CCE47E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113102450.GA220440@T590>
 <CH2PR04MB6522CF231DAA4615DABA8457E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR04MB6522CF231DAA4615DABA8457E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 13, 2021 at 11:16:11AM +0000, Damien Le Moal wrote:
> On 2021/01/13 19:25, Ming Lei wrote:
> > On Wed, Jan 13, 2021 at 09:28:02AM +0000, Damien Le Moal wrote:
> >> On 2021/01/13 18:19, Ming Lei wrote:
> >>> On Wed, Jan 13, 2021 at 12:09 PM Changheun Lee <nanich.lee@samsung.com> wrote:
> >>>>
> >>>>> On 2021/01/12 21:14, Changheun Lee wrote:
> >>>>>>> On 2021/01/12 17:52, Changheun Lee wrote:
> >>>>>>>> From: "Changheun Lee" <nanich.lee@samsung.com>
> >>>>>>>>
> >>>>>>>> bio size can grow up to 4GB when muli-page bvec is enabled.
> >>>>>>>> but sometimes it would lead to inefficient behaviors.
> >>>>>>>> in case of large chunk direct I/O, - 64MB chunk read in user space -
> >>>>>>>> all pages for 64MB would be merged to a bio structure if memory address is
> >>>>>>>> continued phsycally. it makes some delay to submit until merge complete.
> >>>>>>>> bio max size should be limited as a proper size.
> >>>>>>>
> >>>>>>> But merging physically contiguous pages into the same bvec + later automatic bio
> >>>>>>> split on submit should give you better throughput for large IOs compared to
> >>>>>>> having to issue a bio chain of smaller BIOs that are arbitrarily sized and will
> >>>>>>> likely need splitting anyway (because of DMA boundaries etc).
> >>>>>>>
> >>>>>>> Do you have a specific case where you see higher performance with this patch
> >>>>>>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary and too small
> >>>>>>> considering that many hardware can execute larger IOs than that.
> >>>>>>>
> >>>>>>
> >>>>>> When I tested 32MB chunk read with O_DIRECT in android, all pages of 32MB
> >>>>>> is merged into a bio structure.
> >>>>>> And elapsed time to merge complete was about 2ms.
> >>>>>> It means first bio-submit is after 2ms.
> >>>>>> If bio size is limited with 1MB with this patch, first bio-submit is about
> >>>>>> 100us by bio_full operation.
> >>>>>
> >>>>> bio_submit() will split the large BIO case into multiple requests while the
> >>>>> small BIO case will likely result one or two requests only. That likely explain
> >>>>> the time difference here. However, for the large case, the 2ms will issue ALL
> >>>>> requests needed for processing the entire 32MB user IO while the 1MB bio case
> >>>>> will need 32 different bio_submit() calls. So what is the actual total latency
> >>>>> difference for the entire 32MB user IO ? That is I think what needs to be
> >>>>> compared here.
> >>>>>
> >>>>> Also, what is your device max_sectors_kb and max queue depth ?
> >>>>>
> >>>>
> >>>> 32MB total latency is about 19ms including merge time without this patch.
> >>>> But with this patch, total latency is about 17ms including merge time too.
> >>>
> >>> 19ms looks too big just for preparing one 32MB sized bio, which isn't
> >>> supposed to
> >>> take so long.  Can you investigate where the 19ms is taken just for
> >>> preparing one
> >>> 32MB sized bio?
> >>
> >> Changheun mentioned that the device side IO latency is 16.7ms out of the 19ms
> >> total. So the BIO handling, submission+completion takes about 2.3ms, and
> >> Changheun points above to 2ms for the submission part.
> > 
> > OK, looks I misunderstood the data.
> > 
> >>
> >>>
> >>> It might be iov_iter_get_pages() for handling page fault. If yes, one suggestion
> >>> is to enable THP(Transparent HugePage Support) in your application.
> >>
> >> But if that was due to page faults, the same large-ish time would be taken for
> >> the preparing the size-limited BIOs too, no ? No matter how the BIOs are diced,
> >> all 32MB of pages of the user IO are referenced...
> > 
> > If bio size is reduced to 1MB, just 256 pages need to be faulted before submitting this
> > bio, instead of 256*32 pages, that is why the following words are mentioned:
> > 
> > 	It means first bio-submit is after 2ms.
> > 	If bio size is limited with 1MB with this patch, first bio-submit is about
> > 	100us by bio_full operation.
> 
> Yes, but eventually, all pages for the 32MB IO will be faulted in, just not in
> one go. Overall number of page faults is likely the same as with the large BIO
> preparation. So I think we are back to my previous point, that is, reducing the
> device idle time by starting a BIO more quickly, even a small one, leads to
> overlap between CPU time needed for the next BIO preparation and previous BIO
> execution, reducing overall the latency for the entire 32MB user IO.

When bio size is reduced from 32M to 1M:

1MB/(P(1M) + D(1M)) may become bigger than 32MB/(P(1M) + D(1M)), so
throughput is improved.

P(x) means time for preparing 'x' sized IO
D(x) means time for device to handle 'x' sized IO 

I depend on both CPU and the UFS drive.

> I don't think that the reason is page faulting in itself.

What I meant is that page faulting might contribute most part of the
100us(preparing 1MB data) and 2ms(preparing 32MB data). It can be others,
but should be easy to figure out.

-- 
Ming

