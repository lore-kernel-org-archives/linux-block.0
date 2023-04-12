Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F20C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 12:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjDLMX1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 08:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDLMX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 08:23:26 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0832C2697
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 05:23:22 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 95D6E2B06D22;
        Wed, 12 Apr 2023 08:23:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 12 Apr 2023 08:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681302199; x=1681302799; bh=ht
        kyVBu1g0lw5rFigY59dspM0v7B4GY3eOilngQdGs0=; b=XtKXbxrsO5b6p1mi8Y
        BTmQBMTUpiSOno61xKgaWHheCayl8CgeiQztRYw/tkkzffFt4iDGhcnYrf0HwzsC
        zFl2DsnBWoPc2eTnwDCWuX2HcvYQq6Br2v+aI9ULNTnVx8UjtqoPLZXnGKM7aZSf
        imkdPHMiizY7sydt1FrbbK2UmwZgVulmdtv5rBB+9WRnKoyJgaQDYyr382AKcO6V
        +F3CbDwd2GJnPuXefOynZZmfxdkdO2M0Fg1RzI+6Eg0K/tFyScjJN1M+npKrscS6
        pVDTEtdVEO3fZ9BHZ6E2cjR5sJ3ZQ7zsRWT/I98m4fw0SMP4/ftRALQKEgpe2Q2W
        rcxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm3; t=1681302199; x=1681302799; bh=htk
        yVBu1g0lw5rFigY59dspM0v7B4GY3eOilngQdGs0=; b=G0nLGrbu5pNN0zrcpsr
        9+HS1L3i/Pu+irKCAnenM9vWuyhfCS2wd0Swqt3v4X2sZiIu/TTZJf5EVlDgnWSO
        Z1NiU/ZylNNmIhrSsH3A2KQJEuy15QopI3w4+KyjOgUIdSDhfpZ/UbCdLcTiyJ2i
        99P0eP8t024/6JtV6c2+Uf5RxWQ0ejYEW8qPPuwIMlEOM9wp4l8rOFNBDLF5JNa9
        biiDGDd+de6Mxd5f7TfzdlRaUD2h3AKMMiiBCv89l8hEEQA+fdGNROrbRiPkIac/
        2Sw20AAKwMrQqdAx8XMOIiDnH3CgPJYZSQ7tH9aBuiOkYX19EhhokawwWi+M8REo
        2pA==
X-ME-Sender: <xms:tqI2ZObbPv4p340w5P2Mk1pYW2JwTHAZxlx3qpXgZ4t8Lm98SbJTUg>
    <xme:tqI2ZBZhUi6vGt-V5hE6yLwRCZQBdWYjY1IPfCBt_z_xnGlGkq4jurfYLikXiUPZZ
    RsflyTxmSitoigY214>
X-ME-Received: <xmr:tqI2ZI9y9UczqNx7aNRR3M3WhXhoh1veQnI5ek3ErXs_Xa3S6TWA4FAY1ShmdObkFwgoua11gnEZOEQbHXMDZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepufhhihhn
    kdhitghhihhrohcumfgrfigrshgrkhhiuceoshhhihhnihgthhhirhhosehfrghsthhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepffehffetgfdugeffffelvdfgjefgkedv
    hfehgeefveffgfffvedtueekgeevvefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshhhi
    nhhitghhihhrohesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:tqI2ZAqtJQsvfMWOoQepV64N8C0JdVwSbQX5kra--cvoTjynlk5UVQ>
    <xmx:tqI2ZJpt_QWKL9WUy9qb5eDuG7T-0l9dIgQ7CYSUDugsY0-50ub3tA>
    <xmx:tqI2ZOSiPlRT7vqYH15vFu9ARAFvz1KHvmCy0nk20rukDvJ8IX4fMg>
    <xmx:t6I2ZKmMWWJDw100tvFvp3vLN2fcpzQbNL7rdSex5bjBU80K-VukCJOd1Y34ynS6>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 08:23:17 -0400 (EDT)
Date:   Wed, 12 Apr 2023 21:23:13 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests v3 0/4] Test different queue types
Message-ID: <7bf4oclwq3utcuwadedqiqc2l5hbasujcdfpfycdo7x6jlob7q@4t6lvsun3qvt>
References: <20230329090202.8351-1-dwagner@suse.de>
 <20230331002100.e7xmotjoprimxs5u@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331002100.e7xmotjoprimxs5u@shindev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 31, 2023 / 02:32, Shinichiro Kawasaki wrote:
> On Mar 29, 2023 / 11:01, Daniel Wagner wrote:
> > Setup different queues, e.g. read and poll queues.
> > 
> > As discussed I introduced a _require_nvme_trtype() function to limit the test to
> > tcp and rdma. I've upated the existing _require_nvme_type_is_*() checks to
> > explicit transport checks.
> > 
> > Test run against current nvme-6.4 but it still needs patch #3 from [1] to
> > survive.
> > 
> > [1] https://lore.kernel.org/linux-nvme/20230322002350.4038048-1-kbusch@meta.com/
> 
> All patches look good to me. I reconfirmed that my test system hangs without the
> kernel fix patch above [1]. I'll wait for the kernel fix patch lands on Linus
> tree, then apply your patches to blktests master.

The fix was upstreamed and I've applied this series. Thanks!
