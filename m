Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CD2C4167B
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 01:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 514A423380
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 01:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394529AbgLKBN3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 20:13:29 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41273 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394530AbgLKBNO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 20:13:14 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9D8AF5C012E;
        Thu, 10 Dec 2020 20:12:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 10 Dec 2020 20:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=64jwOZgsbJLE0Dj1pADyTpbiBqO
        jr6qt2BcmJcl3n1o=; b=ML4LIv2rO2AE18JLhNYtmZqv5kEtT+vzVvDs2JolR3L
        bHtXAz6WKgp7iUsxhkjo4gDaWwwbn4WtBiRk2hA4Ccmzsa8K6b8iaK10U0lcaJjA
        CdZ4wHNHn3YmDmEsMbPZ6BvthDcGA6sH5KyoZKZq73SVtxX5WFVAGS8vc5qro1iB
        XDV9COAvMC3FUrPZ14FJj806iAPGF2dHLMqrFOfSeMa2/aOETbsA6Z6Oi6vRDx6H
        MUmniagMc9t0UHjgWkqSNEqpzJrER1wroAcJoE+ogKyN8LATy0uxdVW8RbJrSVrU
        a1SfFwGL9gGzSnMMj3ZKlnOcltPomzLpmvg3g0trcJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=64jwOZ
        gsbJLE0Dj1pADyTpbiBqOjr6qt2BcmJcl3n1o=; b=Pzyic3zjCaVzm5xga/b6Ci
        pq1xYCoin9prRR4bv5RE5ZofhzrEZZW10M6Uro9WCoUvkevIpgo1NYYFey189WTT
        bSMdM2jAWXLPAkxPqOiIIHqRWVylzrbQeB7XoMfYbBfrZ5WDDg+iG689+TCvfY0a
        Jrzt/xiwaz/mKzEAmHc/5eCk2FS9LvZaP1v7NnLdGeuy0FdoTUzTuhOUy2ZezI6/
        bqxAEMk0BUthWi8hBLU3RkjIs/bSl/1vec2UQG1jbAGiNKPQcOMHfbyOqkDPm22v
        ldOHq7xbJhCvgqYSnjU1eB9p6QABm7A2ZF6LWpFYNVlsP4fObTlxhB8hBmLVxyEQ
        ==
X-ME-Sender: <xms:esfSX-qjDcPMPepgR5BLf96agUIHDNAkr1ZnPT-2X798bHqihBD4OQ>
    <xme:esfSX8oiwZ0o8uHmoT6wWwjjkviiA-Tw-zB2t-YI_PsCuEyV0szkod75ok2_lDjtn
    sLGxh6AcBtFnO1TCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekuddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtffrrg
    htthgvrhhnpedukefhkeelueegveetheelffffjeegleeuudelfeefuedtleffueejfffh
    ueffudenucfkphepieejrdduiedtrddvudejrddvhedtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlhdr
    uggv
X-ME-Proxy: <xmx:esfSXzOkFea0CySNmCfz7itPhUmgYZC_BylzwTEEPUeULIo5RoFIbw>
    <xmx:esfSX94npEbgQbYUQ2-LSFdJrdFG2x86wiDglcfhge1S-0Aqnxu6zA>
    <xmx:esfSX94xohC95y5VqxFrXtcLxUDsl5qVav-HjJEMcvvu3li6oyO4Iw>
    <xmx:e8fSX6j0carlKEst5RuIOhqZkHOvGnPSlNX8rouSikH4EecybR8Erw>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 946951080063;
        Thu, 10 Dec 2020 20:12:26 -0500 (EST)
Date:   Thu, 10 Dec 2020 17:12:25 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: hybrid polling on an nvme doesn't seem to work with iodepth > 1
 on 5.10.0-rc5
Message-ID: <20201211011225.f7ds6utq6wes2hu3@alap3.anarazel.de>
References: <20201210205141.px7suygfrl2lhdkr@alap3.anarazel.de>
 <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c43682-10f2-0bc9-5aa5-e433abd4f3c3@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 2020-12-10 23:12:15 +0000, Pavel Begunkov wrote:
> Can you get poll stats from debugfs while running with hybrid?
> For both iodepth=1 and 32.
> 
> cat <debugfs>/block/nvme1n1/poll_stat

Sure.

QD1:
read  (512 Bytes): samples=2, mean=6673855, min=68005, max=13279705
write (512 Bytes): samples=1, mean=13232585, min=13232585, max=13232585
read  (1024 Bytes): samples=0
write (1024 Bytes): samples=4, mean=4968280, min=4815727, max=5121434
read  (2048 Bytes): samples=0
write (2048 Bytes): samples=2, mean=2090473, min=2089735, max=2091212
read  (4096 Bytes): samples=3, mean=75684, min=68069, max=88749
write (4096 Bytes): samples=9901, mean=7424, min=6636, max=27371
read  (8192 Bytes): samples=12, mean=1178627, min=59709, max=13310383
write (8192 Bytes): samples=1, mean=13231993, min=13231993, max=13231993
read  (16384 Bytes): samples=1, mean=13376610, min=13376610, max=13376610
write (16384 Bytes): samples=1, mean=13230532, min=13230532, max=13230532
read  (32768 Bytes): samples=12, mean=128980, min=81628, max=173096
write (32768 Bytes): samples=1, mean=13240766, min=13240766, max=13240766
read  (65536 Bytes): samples=1, mean=234465, min=234465, max=234465
write (65536 Bytes): samples=3, mean=4224941, min=66043, max=12534481

QD32:
read  (512 Bytes): samples=2, mean=6673855, min=68005, max=13279705
write (512 Bytes): samples=1, mean=13232585, min=13232585, max=13232585
read  (1024 Bytes): samples=0
write (1024 Bytes): samples=4, mean=4614410, min=4576806, max=4652813
read  (2048 Bytes): samples=0
write (2048 Bytes): samples=2, mean=2090473, min=2089735, max=2091212
read  (4096 Bytes): samples=3, mean=75684, min=68069, max=88749
write (4096 Bytes): samples=32, mean=6155072604, min=6155008198, max=6155132851
read  (8192 Bytes): samples=12, mean=1178627, min=59709, max=13310383
write (8192 Bytes): samples=1, mean=13231993, min=13231993, max=13231993
read  (16384 Bytes): samples=1, mean=13376610, min=13376610, max=13376610
write (16384 Bytes): samples=1, mean=13230532, min=13230532, max=13230532
read  (32768 Bytes): samples=12, mean=128980, min=81628, max=173096
write (32768 Bytes): samples=1, mean=13240766, min=13240766, max=13240766
read  (65536 Bytes): samples=1, mean=234465, min=234465, max=234465
write (65536 Bytes): samples=3, mean=4224941, min=66043, max=12534481


I also saw
[1036471.387012] nvme nvme1: I/O 576 QID 32 timeout, aborting
[1036471.387123] nvme nvme1: Abort status: 0x0
during one of the QD32 runs just now. But not in all.


- Andres
