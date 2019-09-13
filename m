Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075B1C49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AD1214D8
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 15:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dmzmIjon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403852AbfIMPM6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:12:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403851AbfIMPM6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 11:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fHKysKE+M95OhX+aj6h0urrRGkOTrQd2RAdnStNOfIo=; b=dmzmIjonPfVVCtx+S3ZAHHyjjz
        CjFcCJygFbYoE695aPO/4Q9DVqO5/zEoXkC0J550MIV1T/f9fjY15kV1ukWBBOIxvQtka0psHZpLO
        6UHCRKaQ+6/RGUmt8T3fdHWp/dG351EvMP0BCNmmdzxk2YCxyfV9AE/KHjUODub3H7M/I+e22r8+2
        RW6AcMbULnAWGkVgbOlszyPFXxw8IuqTnui1EQ208uHMUSV3gzKEY+S0+AwOHVuMpGMkquRr/3Lpu
        nu5CYWQA5uCKW3SvhJfpXGZL8r7O3520VsFNuID594lfy8/5HO+D/YRDSNEthn2Jj2eoTXcycNnDi
        7kTUAoOQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i8nFi-00021y-8O; Fri, 13 Sep 2019 15:12:50 +0000
Date:   Fri, 13 Sep 2019 08:12:50 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "m@bjorling.me" <m@bjorling.me>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "krisman@collabora.com" <krisman@collabora.com>
Subject: Re: [PATCH 3/3] null_blk: validated the number of devices
Message-ID: <20190913151249.GN29434@bombadil.infradead.org>
References: <20190911144636.226945-1-andrealmeid@collabora.com>
 <20190911144636.226945-3-andrealmeid@collabora.com>
 <20190912161937.GK29434@bombadil.infradead.org>
 <dbdb0415-8762-f9c1-a65a-3531d9cca109@collabora.com>
 <DM6PR04MB5754177B405819C802549AE686B00@DM6PR04MB5754.namprd04.prod.outlook.com>
 <d55554f5-7212-c5fc-dbb0-4269be913aaa@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d55554f5-7212-c5fc-dbb0-4269be913aaa@collabora.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 13, 2019 at 11:57:17AM -0300, André Almeida wrote:
> On 9/12/19 7:20 PM, Chaitanya Kulkarni wrote:
> > On 09/12/2019 03:09 PM, André Almeida wrote:
> >> Hello Matthew,
> >>
> >> On 9/12/19 1:19 PM, Matthew Wilcox wrote:
> >>> On Wed, Sep 11, 2019 at 11:46:36AM -0300, André Almeida wrote:
> >>>>
> >>>> -static int nr_devices = 1;
> >>>> +static unsigned int nr_devices = 1;
> >>>>   module_param(nr_devices, int, 0444);
> >>>
> >>> ^^^ you forgot to change the module_param to match
> >>>
> >>>> +	if (!nr_devices) {
> >>>> +		pr_err("null_blk: invalid number of devices\n");
> >>>> +		return -EINVAL;
> >>>> +	}
> >>>
> >>> I don't think this is necessary.
> >>>
> >>
> >> Could you explain why you don't think is necessary? As I see, the module
> >> can't be used without any /dev/nullb* device, so why we should load it?
> >>
> >> Thanks,
> >> 	André
> >>
> > 
> > I think Matthew is right here. I think module can be loaded with 
> > nr_devices=0.
> > 
> > Did you get a chance to test nr_device=0 condition ?
> > 
> 
> Yes. It says "module loaded" and lsmod shows that it is loaded indeed.
> But you don't have any /dev/nullb*, so you can't do much with the module.
> 
> With this patch, it refuses to load the module.

Why is that an improvement?  I agree it's an uninteresting thing to ask
for, but I don't see a compelling need to fail the module load because
of it.

> I did not tested with all possible conditions, but I tested with the
> following ones:
> 
> * Using a negative number of devices:
> 	- Previously, it would alloc and add a huge number of devices until the
> system gets out of memory
> 	- With module_param as uint, it will throw a "invalid for parameter
> `nr_devices'" and refuse to load
> 
> * Using a range of values (1, 10, 100, 1000):
> 	- It will works as expect, creating some /dev/nullbX accordingly with
> your parameter. Works fine with and without this patch.

If you ask it to create 4 billion devices, what happens?  Obviously we'll
run out of dev_t at some point ...

