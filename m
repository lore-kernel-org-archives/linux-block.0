Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC198C4361B
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 01:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FF0323C18
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 01:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404820AbgLKBU5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:20:57 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54749 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404771AbgLKBU2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 20:20:28 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C8C65C0208;
        Thu, 10 Dec 2020 20:19:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 10 Dec 2020 20:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=6V4/QI2igplxD2dRwrMxPdTdroo
        4zGfes9kLgjr3y8U=; b=jJtBWfQ7Bnunh7Ec5D7KUIQU/CA2Z2GudA/ri9C+f+3
        og2EJn6SWY80U5bMtbQyRtENC7iSZT+VbmK07YkIIKFx9AM53LBif+3ZWD35XlVW
        2N5OjXtHDd+D8NBkSg0q5H+8Z1P+ObW+nm4fiBkOI80KwIq31XQB+uPdxn2V2NHN
        /IWp0bP5GV7FTaZpju7HNKkunHLOmXMSEHKFNjGOQY8aknbrq/yr7qFwyKhvkCzd
        yT7ZKi7oVHbtnUmUSf0NOpVJw1fu6AraT7B260IRD/2R+Aw8L1OB8CVcaP7h3LKA
        ZlSMH5dxYmyZUnVf+k7l8tWarmFyW+eP7geh+hrbyyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6V4/QI
        2igplxD2dRwrMxPdTdroo4zGfes9kLgjr3y8U=; b=OQEKgt8KTG4KCxXlw5iS+T
        vWvV+cYdgYBw4w/b5yZdLhMB2FNVEdQUdwc8wsj8440GwPfgMSEPejxa70BDsyvH
        iBOBEruqUwbZDHpdTSFNkV3Qto5ge4YSpTwNfM6Oi6Vm2WJCCJq5kkraV+r+oIhI
        HrYiehaINegLlMLgdpvTf3yVsJJug86vR6L6b6MAYodcz30fKrjEeVMQQoaUZs4X
        K9lwZLUoCLp93AoWqNpK3ScLieFr4X9mKgLDe2Fq0xB3EjPSQKgkcSVvdeqpL87u
        FalBOOvf3zdT0tIFrkmcxargOKmshuomQsz7pnzI7Scvenm4H7hsjMoqb3fLC6Pw
        ==
X-ME-Sender: <xms:LcnSX1aW0VNDQEPBMkUzl694ETRvAYruXZPlDRJ8-7qGiv_Bi_QgiQ>
    <xme:LcnSXwsyLsatJA1jI85TDtDVnzvS14uN4CevCh9vuzffV7np49NRMA97vo0BSYXbX
    ob0Y0nHlplfmhoqaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekuddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtffrrg
    htthgvrhhnpedukefhkeelueegveetheelffffjeegleeuudelfeefuedtleffueejfffh
    ueffudenucfkphepieejrdduiedtrddvudejrddvhedtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlhdr
    uggv
X-ME-Proxy: <xmx:LcnSX3HjWWonshcFqUmfqP4CrXFFf0oSJpSh3ciTtLfE4AiwS20NOA>
    <xmx:LcnSX7xUm2ZSI_IO0Q69hFHtvnrm8hjt3-9GXOqXUVNyFYplU7yPlw>
    <xmx:LcnSX2gEEpg4lF_CFXvZFPEDU2SLwCaZHgO9kgOLVTh0YpMobVaxmA>
    <xmx:LsnSXzPcQLSWVRijT_jEj_VXULzTLMona0097irAa7CW5YpQY382lA>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id A1D1D1080057;
        Thu, 10 Dec 2020 20:19:41 -0500 (EST)
Date:   Thu, 10 Dec 2020 17:19:40 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <20201211011940.ouc4k3am5gg2ithp@alap3.anarazel.de>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
 <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
 <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020-12-10 23:15:15 +0000, Pavel Begunkov wrote:
> On 10/12/2020 23:12, Pavel Begunkov wrote:
> > On 10/12/2020 20:51, Andres Freund wrote:
> >> Hi,
> >>
> >> When using hybrid polling (i.e echo 0 >
> >> /sys/block/nvme1n1/queue/io_poll_delay) I see stalls with fio when using
> >> an iodepth > 1. Sometimes fio hangs, other times the performance is
> >> really poor. I reproduced this with SSDs from different vendors.
> > 
> > Can you get poll stats from debugfs while running with hybrid?
> > For both iodepth=1 and 32.
> 
> Even better if for 32 you would show it in dynamic, i.e. cat it several
> times while running it.

Should read all email before responding...

This is a loop of grepping for 4k writes (only type I am doing), with 1s
interval. I started it before the fio run (after one with
iodepth=1). Once the iodepth 32 run finished (--timeout 10, but took
42s0, I started a --iodepth 1 run.

write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=3002, mean=7402, min=6683, max=22498
write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
write (4096 Bytes): samples=32, mean=517838676, min=517774856, max=517901274
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=7365701186, min=7365642813, max=7365756630
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351

Shortly after this I started the iodepth=1 run:

write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=32, mean=30203322069, min=30203263000, max=30203381351
write (4096 Bytes): samples=1, mean=2216868822, min=2216868822, max=2216868822
write (4096 Bytes): samples=1, mean=2216868822, min=2216868822, max=2216868822
write (4096 Bytes): samples=1, mean=2216851683, min=2216851683, max=2216851683
write (4096 Bytes): samples=1, mean=1108526485, min=1108526485, max=1108526485
write (4096 Bytes): samples=1, mean=1108522634, min=1108522634, max=1108522634
write (4096 Bytes): samples=1, mean=277274275, min=277274275, max=277274275
write (4096 Bytes): samples=19, mean=5787160, min=5496432, max=10087444
write (4096 Bytes): samples=1185, mean=67915, min=66408, max=145100
write (4096 Bytes): samples=1185, mean=67915, min=66408, max=145100
write (4096 Bytes): samples=1185, mean=67915, min=66408, max=145100
write (4096 Bytes): samples=1703, mean=50492, min=39200, max=13155316
write (4096 Bytes): samples=9983, mean=7408, min=6648, max=29950
write (4096 Bytes): samples=9980, mean=7395, min=6574, max=23454
write (4096 Bytes): samples=10011, mean=7381, min=6620, max=25533
write (4096 Bytes): samples=9381, mean=7936, min=7270, max=47315
write (4096 Bytes): samples=9295, mean=7377, min=6665, max=23490
write (4096 Bytes): samples=9987, mean=7415, min=6629, max=23352
write (4096 Bytes): samples=9992, mean=7411, min=6651, max=23071
write (4096 Bytes): samples=9404, mean=7941, min=7234, max=24193
write (4096 Bytes): samples=9434, mean=7942, min=7240, max=62745
write (4096 Bytes): samples=5370, mean=7935, min=7268, max=24116
write (4096 Bytes): samples=5370, mean=7935, min=7268, max=24116
write (4096 Bytes): samples=5370, mean=7935, min=7268, max=24116

Greetings,

Andres Freund
