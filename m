Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B998C76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 06:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDJGGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 02:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDJGGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 02:06:13 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE673C35
        for <linux-block@vger.kernel.org>; Sun,  9 Apr 2023 23:06:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id BEEAB2B06712;
        Mon, 10 Apr 2023 02:06:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 10 Apr 2023 02:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681106770; x=1681107370; bh=+J
        iAbLrbAJgHcDzgRpzma7BrumZozZYXSiVdGgFxTPA=; b=qxsuj/m258kY/8g2JF
        hbc0h2/oqib296rMYxvESCICdfEx0hU1eTuBVAYplz3roSHPgigayrFjB32L0DDb
        afK9ZA0al8/hye74l9eermwV35BS5GVc+053psxK8XsNDqA3797KXBrwHwgLRpdg
        8j0LxlW2W5TZIISh72TALIctRUm9EPuIXQQfli11cH1rEZ7sz+8oNcj/IHA+58m+
        tmM6ZiC4xcj2bfY1acDHXlPO2vFafH8DPua6JXcF1aq/7AgeKGHYY950hZmvVS02
        /owDmXGJKgBN+hcTAgqVQAsdembd+Iiod1QDBQEIR6RPnFzM6KjniBtblCOxHsgd
        Qo6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm2; t=1681106770; x=1681107370; bh=+Ji
        AbLrbAJgHcDzgRpzma7BrumZozZYXSiVdGgFxTPA=; b=jaSD2lBqT4APe0KBzNg
        qcHDOT9pE78Pd2yXfbW3bq5cpoVk2Y7sPT6I0D3it3NHYqz5CQdFCZQ4lWcPlHGV
        Y9Htz/KoRQWyWRsuvs1SjiSuD6Lbujm1FQLyUwBMP3rFTQ4F4MP1cdT/2E6gdb2C
        Nl6qb/0uVhhLy99ZqvN+SbQRzKuL3PFABIXApV44XjmwjJRVo2a+9yZPDjVQ6kM3
        FJMhD4pP2Ea2hSxrrWFGpuyr484mBfNdB7Wx2WPtFMHE8sBKjBZCBWOf/vaAy8In
        LWVKk8YP6VSrnAcU6tTAc3bSK2RnBT8JtTl3D2VhSn6+77/TW1JULcH5A4ccjDLm
        u+A==
X-ME-Sender: <xms:UaczZA4mbnp5UH90vOiIAMcZokmX_wENW3XtpdUEeyreAV95v2aECQ>
    <xme:UaczZB7k9JcFMlbBpUPkg4cGLNe5JwCJJHuWENEKYxSlA0i4QQ8fEJW9_uPH921hL
    F6hiE01hTzuAkwddI4>
X-ME-Received: <xmr:UaczZPdsQP831zElw4Dh5eyp0bBrIH2Qcq7q3oqUkjFbI0ffU3OkWlr6O56Ly8mjew5UW0_EvQ0nYp_zOU3GDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekuddguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefuhhhi
    nhdkihgthhhirhhoucfmrgifrghsrghkihcuoehshhhinhhitghhihhrohesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedvgedtgfdvhffgkedvkedtgfefleej
    leeggfekudejieetheeghfegtefhgfehheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehshhhinhhitghhihhrohesfhgrshhtmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:UqczZFK763oUAg3BbDdZtoNIliUIPdQk_FyLG2DW6yWAe3U9uRXsoA>
    <xmx:UqczZEIyhig2DFz3nCueXjNo5wDZWI3VCSB-XY5klz97weNNRUmx2Q>
    <xmx:UqczZGxOCeSrdojQe_CV7dqbokvI5AHI9-VDK647L0GzOtJUiQzE7w>
    <xmx:UqczZM8qCRxNfmNc7MuXa5HQq0I48ULEqZ52XMJgJ0dxHF3uVztAcHYECjycWoOS>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 02:06:07 -0400 (EDT)
Date:   Mon, 10 Apr 2023 15:06:05 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v6 0/2] test queue count changes on reconnect
Message-ID: <enbhdajylbbzykqyey5d35hmqbmsqca6entvdhpwifg53lx3ue@pe4dpridsdxg>
References: <20230406083050.19246-1-dwagner@suse.de>
 <ftljvb4alzxssqjzr5ik7pvatiwh25i4ftktvgvxzqxk76afew@brp7ch4v7wik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ftljvb4alzxssqjzr5ik7pvatiwh25i4ftktvgvxzqxk76afew@brp7ch4v7wik>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 06, 2023 / 11:10, Daniel Wagner wrote:
> On Thu, Apr 06, 2023 at 10:30:48AM +0200, Daniel Wagner wrote:
> > good and the bad case (rdma started to fail today, something to fix).
> 
> After adding the missing _nvmet_setup() call, tcp and rdma works fine.

I also confirmed this. I observed test pass with tcp and rdma. Good. Still
lockdep warning is observed and fc transport causes system hang, but I think
those issues should be fixed after applying the patches to blktests master.

I walked through the patches and they look good enough to apply for me. I will
wait a few more days in case anyone has more comments. If there is no more
comments, no need to post v7. I will add the missing _setup_nvmet() and replace
the spaces in the 2nd patch.
