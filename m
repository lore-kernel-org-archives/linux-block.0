Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2616C7618E
	for <linux-block@archiver.kernel.org>; Fri, 21 Apr 2023 09:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjDUJmc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 05:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjDUJmb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 05:42:31 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216F2A5FF
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 02:42:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id E1E55582110;
        Fri, 21 Apr 2023 05:42:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 21 Apr 2023 05:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682070146; x=1682070746; bh=I7
        vX/0YfzsfZsRGHX5jgTWrTU6BxxAyi+YLlm5BZnp0=; b=apYdKa+J4E7tHyMRm+
        5vKZ1YvQ0XQtDYxVNtLZ8tsJ3GkTCqEY8hmqV4gbCNZ2FQGm6zH/DzvqE/9UrU2m
        Huucq/WpE6/0bNdAOdMhicuvFK7HE1R5Cbq4s1HKDu4Uyktv5aKCGBLuI3YQfZbP
        fwCup2gIdBbzpowT6p5VcU08wXXRZ5qkyALHRic5h5pBeMySww2P/IKQWISKq1sc
        L6Z7dg2IOgouqOGju3nA8odRi/CnckVFmcEeydy2Ed4mzITODhv9usXjOXjIZLP8
        56IuDg0Z7lm06t7XtppViYuhRIOrATXq5ikXKgXPmhsw7xuDI22of5qw+vPDcink
        1fDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm3; t=1682070146; x=1682070746; bh=I7v
        X/0YfzsfZsRGHX5jgTWrTU6BxxAyi+YLlm5BZnp0=; b=NUc9Inp6IT4dqgv6F7E
        MEXcDJFASiJEQdWIbmXDN1WLB7KJvBOgt3q/ADeQHjUOkj2l25NkXdXhXKRzi3sh
        HjtMaBar3fMKYlIzv7RPIrh4/Y/esi+vhfAQ5wJvBPG4xcwFAwksHRM0gxW03BTn
        6YR9ROOYsSTY/IvPklDRvwMYftBL8Tp8HkgHV8huqRalq3b1xe+j7lQHjBN/oH/o
        zYkcBNLu2KsbSsTRJ2vCLlOQgkxef7fyykS6L0pOwWp5JGbH5eDvVnPs9dY+tSLN
        rccql5aB3zJmLMg+kHvXmfYKZqqPi4J4UUlVDZv68ZlSRIGkRYj5TW/nUi7WY5Nx
        7OQ==
X-ME-Sender: <xms:glpCZP2OuD0w7E6VnopfBqguvUNF2cKTkv_2ykXTbqr0Ms4Vrt-uag>
    <xme:glpCZOFLPpeKyzHdoy50HS4_jwSFgbmpLdqPHajjUocBHoKqTk8Z3WNqbNimdOGnk
    4R-raRZox_zSOquNFo>
X-ME-Received: <xmr:glpCZP7MfmZ1XrSovmdlmBA874MPNvhzpKYixuKCrvdVC64yvaIm9fmHiDDuiJz0JlSohaNTdw-no0LgPaGoJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedtgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepufhhihhn
    kdhitghhihhrohcumfgrfigrshgrkhhiuceoshhhihhnihgthhhirhhosehfrghsthhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvdegtdfgvdfhgfekvdektdfgfeeljeel
    gefgkedujeeiteehgefhgeethffgheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhhihhnihgthhhirhhosehfrghsthhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:glpCZE3oNBPAFYiiXRiHBLcWt0r9UxbhPp4Hf_YCNyrKjEA3YuTybA>
    <xmx:glpCZCHbe98-aVlSbQMphtZchvKyjz0uxLOMvNZM1IfOVEcBsExCvA>
    <xmx:glpCZF-P7o9fttxV6oe7v-29_gW28IiTBTN9nZrk0JqZwuJdhECnrw>
    <xmx:glpCZOgLZuTKWF8gJc4swNYgUzIgOEvbBe4pDRqmxgo42EUSdrg7c73zkak>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Apr 2023 05:42:24 -0400 (EDT)
Date:   Fri, 21 Apr 2023 18:42:22 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
        hch@infradead.org
Subject: Re: [PATCH v2 blktests] don't require modular null_blk for
 fault-injection
Message-ID: <fieo7bgfpmqstvycvcq6ucdsg7h5bjhpkpsucs6uk4njzimahf@gx6emcqngf4m>
References: <20230416043744.25646-1-akinobu.mita@gmail.com>
 <55byiexrqbbhiftyiwi6xg7t2av5va6jj5zyntejqniq4l2g7z@ofej27qygtqg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55byiexrqbbhiftyiwi6xg7t2av5va6jj5zyntejqniq4l2g7z@ofej27qygtqg>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 18, 2023 / 21:37, Shin'ichiro Kawasaki wrote:
> On Apr 16, 2023 / 13:37, Akinobu Mita wrote:
> > This blktests change changes null_blk fault-injection settings to be
> > configured via configfs instead of module parameters.
> > This allows null_blk fault-injection tests to run even if the null_blk is
> > built-in the kernel and not built as a module.
> > 
> > If the null_blk does not yet support configuring fault-injection via
> > configfs, fall back to set up with module parameter.
> > 
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> > * v2
> > - don't skip the tests on older kernels without fault-injection via configfs
> 
> Thanks for this v2 patch. It looks good to me. I'll wait a few more days before
> I apply it in case anyone has some more comments.
> 
> One nit in the commit title: it's the better to have the prefix
> "block/{014,015,030}: " to clarify the test cases this commit touches. I'll do
> the edit when I apply this patch.

I've applied the patch with the edit. Thanks!
