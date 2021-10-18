Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA6AC433FE
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97FFF60F8F
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 23:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhJRXT2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 19:19:28 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48057 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230070AbhJRXT1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 19:19:27 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D343E5C02AD;
        Mon, 18 Oct 2021 19:17:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 18 Oct 2021 19:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=x7IWaM
        g/xwqql0+MHK53bh2W0mi/Fp8zsCtvfvGPzAE=; b=jeWqtVj9NvUVir/2eQPnQV
        CrBh4hKO38qIdxZEkkDFQnT4iVkOc/3drY8GwKDCIP23gkwZKKuelpJa/XphoMIX
        m8mwDzvMTSwfoopBLeuNR02IiTjp3islumpU/1uMEH9mVS7FmtJ4+HmgbfiZ3BFR
        kENz4YV2i/BpDJnvEvrsj9yCmIuLXim5D/ztIw6YTV5QFZJ8rry7jz3nQrKG+LBZ
        guBKkJmsxRQMSlz+eMlR73oRzb86X0o37ApFHZZW0yHQzGvWzjbvs9onh9EK7j2a
        GOt+URMK3zWm4DOKRu0eX03d5tOuX7IH18RkwP9/6xsXdPCgPnlMOVMbJs+a8X0Q
        ==
X-ME-Sender: <xms:ewBuYQTLgUI70QC7OZsiC0GfGtF3oY4QPer-3p5EA7Yag9JnMCMfgQ>
    <xme:ewBuYdwkT9Wm585FWdrZ0V_lKPU6R6O42Xl12PTCg_XF4yl8MADnEipO78K3KV8wU
    HXr3QptH89T5kbJMKk>
X-ME-Received: <xmr:ewBuYd2xAKgVZXn9lM3sNR7Pb2uID4fp6QfF7T3GXD7Sztu8PbShH1ioY5vVjCwOT8qCj9CDQvAJxt4LbK7s3aWMYVP7QpxVyZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvuddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepteduueduueetuddukedvuddvhfeluedtvefhkeeludeitdetjeeihedtkeej
    vdefnecuffhomhgrihhnpehfrhgvvgdrfhhrpdgrmhhighgrshhtohhrvgdrvghupdgsih
    hgmhgvshhsohifihhrvghsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:ewBuYUC1twpCPlmTmAKHWOqdy1KlUiHtdBnGmumSxoDNtIaZoiqQ3Q>
    <xmx:ewBuYZhwU3Cv7ZIwk_dk4mqU_B0L_b2CMWyKq8nVxQNkof1yAmCBiA>
    <xmx:ewBuYQodtuck6EuzWdAFgyMHMh779h5LEPblrsbsMV0aLrAYqqouOg>
    <xmx:ewBuYetZnUhYbFdnWlkLayrB4sZ8DUM6Ai6S7ZVUneomUaj-a-Rm3w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 19:17:13 -0400 (EDT)
Date:   Tue, 19 Oct 2021 10:17:19 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq
 refactoring
In-Reply-To: <7f64bd89-e0a5-8bc9-e504-add00dc63cf6@kernel.dk>
Message-ID: <604778bc-816a-3f2e-d2ad-d39d7f7f230@linux-m68k.org>
References: <20211018222157.12238-1-schmitzmic@gmail.com> <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk> <97323ce2-4f5c-3af2-83ac-686edf672aea@linux-m68k.org> <7f64bd89-e0a5-8bc9-e504-add00dc63cf6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Oct 2021, Jens Axboe wrote:

> > It is much more difficult to report regressions than it is to use a 
> > workaround (i.e. boot a known good kernel). And I have plenty of 
> > sympathy for end-users who may assume that the people and corporations 
> > who create the breakage will take responsibility for fixing it.
> 
> We're talking about a floppy driver here, and one for ATARI no less. 
> It's not much of a leap of faith to assume that
> 
> a) those users are more savvy than the average computer user, as they
>    have to compile their own kernels anyway.
> 
> b) that there are essentially zero of them left. The number is clearly
>    different from zero, but I doubt by much.
> 

Well, that assumption is as dangerous as any. The floppy interface is 
still important even if most of the old mechanisms have been replaced.

http://hxc2001.free.fr/floppy_drive_emulator/
https://amigastore.eu/en/220-sd-floppy-emulator-rev-c.html
https://www.bigmessowires.com/floppy-emu/

> Hence it would stand to reason that if someone was indeed in the group 
> of ATARI floppy users that they would know how to report a bug. 

Yes, it would if the premise was valid. But the premise is just a flawed 
assumption.
