Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440B4C4361B
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 08:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA6623B85
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 08:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390228AbgLKIBc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 03:01:32 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:44511 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389056AbgLKIBT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 03:01:19 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 13CCAB13;
        Fri, 11 Dec 2020 03:00:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 11 Dec 2020 03:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=0VGgba5dLIPd6RkJxqFfoEr/KPt
        raAd77lrySItpBT0=; b=vBWSmLzbLnMpdLjUfm8ZJMuGqwFpcp2CQEAOQmDi/gN
        TnD1OCZnbrnKSRAyZTmd20bwtEgYFWWqJB6g/8fJu4hgJmUv6jShEggqkBLkIQ6d
        FqZjgffkbrgZ4+BJ31lXo+quW7jw5rcLSkAUgW7WgE50hbzBPR+KTJROuGFcADJL
        wqJfCBjaAAHQy01lqnwBEgu4jj9MEHCWcoa0I+SCQN7hQqHgjmn9YJPFF33oLI7Y
        Pq44vhzsStO9NHi+uRkw2HlALBN9jC1VK2W/Qn24MUeHkDMHMfYXokfig6am2ngg
        voAHnXM7nfHdMWUEPEHbbsw47QFPXTYoFnB/FLt1LoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0VGgba
        5dLIPd6RkJxqFfoEr/KPtraAd77lrySItpBT0=; b=BxpM/Uhl7DKw8WhUKrU1tb
        T+RhLlVO7CbHqVGpJYAhrTFKMCsYJ9VOMuCcFxpiI8U8M0qXYeTVv5FTfHMln7fZ
        y2es6hds5zCYqrNWvgwaDB/nDhSS8f7EE06N+QAWkrCgAGThAFsOrVJKkDkjkbRK
        yGRn+m/9b4DmwF+3MtQDv+g7+hNbvsxu7A4W2RmcDLyGRamfhG7EwdPkWurb4aHE
        ccXK686/Grqu0CHTJeqvplvKg9OD9RdKShcGpSXuoObIfudrpFupj2BHuxoFCVRN
        IODUT2zZNQ/tjPxJ+c0LQ+KZ4ZHzl8Fhzc5ktnfBj9sfuqaLWqD/cBlbfkSd7MmA
        ==
X-ME-Sender: <xms:DCfTX-LvKIHvp2lcTTEeMdUSxnR0Q7t_WnWYVw4gKpnD3OYHyeK7Uw>
    <xme:DCfTX2JLQS4tGG04WU9vUKTAXmHv19N3GVBKS92FH46W6X6g4gV2gkbOf5VcFjyOS
    hDTDelxulBv30WyQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekuddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepkedvtdejgeeugeffveevieeftdffffdtvdeivddvtddtgeevieetfeel
    ffeuleeunecuffhomhgrihhnpehsphhinhhitghsrdhnvghtpdhlkhhmlhdrohhrghenuc
    fkphepieejrdduiedtrddvudejrddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:DCfTX-t8P81beqJcVIb3IYMTZP1-RSXGQAN7Y8bFuxKxHgnwQhe2Ng>
    <xmx:DCfTXza-yqUjqzfe0sMGq4rg1qA32SEaW_0s9lFnOr_J2zWSor1OtQ>
    <xmx:DCfTX1ZFQyjWPdR5NzhqCYm2uT5NxZ82bwLCEyczKEptgNRMrJzhPg>
    <xmx:DCfTX2AsCQ_1znRTHSpdgzpNLeHJCopuPd3EboL8ecdlmtEnbEnwTA>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 28E3B24005D;
        Fri, 11 Dec 2020 03:00:12 -0500 (EST)
Date:   Fri, 11 Dec 2020 00:00:10 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <20201211080010.zy5baxjlxslut4b6@alap3.anarazel.de>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
 <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
 <aa735173-fad1-b7d4-1c90-4fccc90c562d@gmail.com>
 <20201211011940.ouc4k3am5gg2ithp@alap3.anarazel.de>
 <de0b46d2-d053-a7a8-23e7-fc954807c70d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0b46d2-d053-a7a8-23e7-fc954807c70d@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020-12-11 01:44:38 +0000, Pavel Begunkov wrote:
> In general the current hybrid polling doesn't work well with high QD,
> that's because statistics it based on are not very resilient to all sorts
> of problems. And it might be a problem I described long ago
> 
> https://www.spinics.net/lists/linux-block/msg61479.html
> https://lkml.org/lkml/2019/4/30/120

Interesting.


> Are you interested in it just out of curiosity, or you have a good
> use case? Modern SSDs are so fast that even with QD1 the sleep overhead
> on sleeping getting considerable, all the more so for higher QD.

It's a bit more than just idle curiosity, but not a strong need (yet). I
was experimenting with using it for postgres WAL writes. The CPU cost of
"classic" polling is high enough to make it not super attractive in a
lot of cases.  Often enough the QD is just 1 for data integrity writes
on fast drives, but there's also cases (bulk load particularly, or high
concurrency OLTP) where having multiple IOs in flight is important.


> Because if there is no one who really cares, then instead of adding
> elaborated correction schemes, I'd rather put max(time, 10ms) and
> that's it.

I wonder if it's doable to just switch from hybrid polling to classic
polling if there's more than one request in flight?

Greetings,

Andres Freund
