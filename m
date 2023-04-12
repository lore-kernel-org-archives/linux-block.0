Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2107C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 12:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjDLMY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 08:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjDLMYw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 08:24:52 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F1A6195
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 05:24:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id F0A5D2B06D22;
        Wed, 12 Apr 2023 08:24:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 12 Apr 2023 08:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681302276; x=1681302876; bh=rJ
        IhgBsBw/NJzAOWuM05Xblw+tLr4BH3K0I+r2a8DRw=; b=n6yJ16aPNKNgV2uJ2P
        jP/fKuqY4ukTnUbUU9caqzYMZECRW8KwHRaUXkIc2iaAlSrgzZ0IMFKBh51m7Bj5
        8pf+OMAfkFUoJ6TLWItWTyY/fxWx6cOTwE77uMQlTkV+/yU9bKtMrbjkA9UYoB9k
        D1IKyph6IlG6yoXSqmKFqko0gclk7c9DOTFBfEwwulauCn4aWBhbg2bitTxzuRdg
        3Kl801CfB54xPPq0rKrW4RnMFc94kn7AKh/CoNyJiTcrp60bZK3CQtRivAcFelW7
        Xy4T+auuiyf/c/10h+o49g4uOHHS7Ud70EVjBGdJiGVaGEoAf9YTrVhWuRee7Dea
        pBLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm3; t=1681302276; x=1681302876; bh=rJI
        hgBsBw/NJzAOWuM05Xblw+tLr4BH3K0I+r2a8DRw=; b=M/Z+jV/FELvTqZP6KZJ
        MYwdylntqWygSZxNStJNhDer60LAUXGjAVHH/1IXivVaTx5XUo0saF2vaHoFObWK
        uQXEJ07oCcNvyiiNAIT8wWQpxDKrxYaqCmcZOyg+zC4YFsYDVxwa1FCstVOlzANg
        PaW7FMj+5maTktuCaWArx0+N+o5J5ulGG1/Uk4kJHR1KLMH/BDIeO26BymDIqXcq
        3rxve5SU/EvXmSaempUwbBWHDRDXBs8lTeTY+mjvHuzutj63NRuUamscsbsDJnzl
        g5HXdw2+PWZB38/EWMEU9473QMOHGyaKsV1JwkQpCODkMgTNg3ZgOw+DpUuEkLBG
        tqw==
X-ME-Sender: <xms:BKM2ZM-TJP6i9H9Mdrq75lMqLaOBpLpEqT61J4iHs4_W2lDrzrjGSg>
    <xme:BKM2ZEsFKR_WWL4fFzZ2WF2FTAXoUC2ovgeqi_KZExEA2mKSfoQt3c16OQhIjzw5S
    3-EJMp7SvVJbKY4Ioc>
X-ME-Received: <xmr:BKM2ZCD7vAHpyFvbkzWTSA-bweLneoClaTH5_s0UPBD3DU_K42do3pNQ4fK3unrJRHhkrcxQuaqUWI8RafFwWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepufhhihhn
    kdhitghhihhrohcumfgrfigrshgrkhhiuceoshhhihhnihgthhhirhhosehfrghsthhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvdegtdfgvdfhgfekvdektdfgfeeljeel
    gefgkedujeeiteehgefhgeethffgheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhhihhnihgthhhirhhosehfrghsthhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:BKM2ZMcYeQ1AXr07B3yNXQc6A2b0GTClMsQgD06QQmnxvEh7trADwQ>
    <xmx:BKM2ZBMbii5Bz22-NjPTivMz1O65n7lG4Ms8xE7BoTXLW-Z-BYKYLA>
    <xmx:BKM2ZGk1i9Vm8Wn5xzLrOBjwpaxskxazQTVyc9HKzb66UM41ylWN4A>
    <xmx:BKM2ZNCKqhUjVt36vQFyIkCfP-2Kmg0GamypH7NbPGUOMp_VVj5bkZddqCmkODKB>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 08:24:33 -0400 (EDT)
Date:   Wed, 12 Apr 2023 21:24:31 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v6 0/2] test queue count changes on reconnect
Message-ID: <oazlhd7d6lblsozvaymwiz3kug4grwyyukzmptya7kdybxhpid@q7ofosisefcr>
References: <20230406083050.19246-1-dwagner@suse.de>
 <ftljvb4alzxssqjzr5ik7pvatiwh25i4ftktvgvxzqxk76afew@brp7ch4v7wik>
 <enbhdajylbbzykqyey5d35hmqbmsqca6entvdhpwifg53lx3ue@pe4dpridsdxg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <enbhdajylbbzykqyey5d35hmqbmsqca6entvdhpwifg53lx3ue@pe4dpridsdxg>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 10, 2023 / 15:06, Shin'ichiro Kawasaki wrote:
> On Apr 06, 2023 / 11:10, Daniel Wagner wrote:
> > On Thu, Apr 06, 2023 at 10:30:48AM +0200, Daniel Wagner wrote:
> > > good and the bad case (rdma started to fail today, something to fix).
> > 
> > After adding the missing _nvmet_setup() call, tcp and rdma works fine.
> 
> I also confirmed this. I observed test pass with tcp and rdma. Good. Still
> lockdep warning is observed and fc transport causes system hang, but I think
> those issues should be fixed after applying the patches to blktests master.
> 
> I walked through the patches and they look good enough to apply for me. I will
> wait a few more days in case anyone has more comments. If there is no more
> comments, no need to post v7. I will add the missing _setup_nvmet() and replace
> the spaces in the 2nd patch.

I've applied this series with the edits. Thanks!
