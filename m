Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2517CC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 22:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0363060FD8
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 22:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhJRWxy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 18:53:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44681 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhJRWxy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 18:53:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E31A15C003B;
        Mon, 18 Oct 2021 18:51:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Oct 2021 18:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=E14Y4t
        zyBruQUiC1HR33o5vcNQGg8Hf7awcXypd+Eq8=; b=YDoYTJCwSnrLEzstS7Ah6U
        hgnyw7Kl7JGjGR3t9Kdrp8AhJ8XhcWwVbAU5clMAFrRizzhDf7kHB/ffRp2XwIDS
        H5004gZp6Lv8RQlZR3dB0OWYD20XrRXJTYfTAL/+TgVOj9l2rrMAXOOktkpZBjgV
        dlVLLXvYffrBwKJ4z1JY/YrHt+KoICHY+wbzepXITbAlwf1jIswB/YHPQmVfrXi0
        Xk2HgZTisQFMbXi5A9ARUgHqrsF9aO6bqQ/EmTNXNlOudISXPifdwZI6y9mQy20l
        t2ooEp0Af+L0gOdfrvn4nfSRsU+bfG1YyZVtWE0L8lhZ/aLfQ9WfkRuoxkHhOBEw
        ==
X-ME-Sender: <xms:ffptYYVfwVlEkwOe3TRBkmIpzR0Vy87Cm6gGSH4wwKlAwRJ00hlLig>
    <xme:ffptYclFuZ9cLqIJL-ZKFrE9M78zZLduOjJcpSMnBPlyhH3uD6QDHqRDhdQi5ieAu
    VeCQmTRHgsK944Gen8>
X-ME-Received: <xmr:ffptYcakQRExBTSPDcR78vGzqxDMqxc_JG2IFELzBnXGwmdcC2hAN15_CylBC54z6xgWkJQn_1Rk7_d59SRbzkxutU9UETGGL4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvuddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:ffptYXV4aDLKY38SxgYOvaUmQgcXZW9-7U39JWtgceBszrhN1YNrxg>
    <xmx:ffptYSks1BAfFiOMnXfxc6kdCHUJXwqJw6r1wbRbO5eI7Eh1iW4cEw>
    <xmx:ffptYcc_to6O-G_pjKnqmaLjJknN_-4MlQUmx3hXO9fCKDC2vlRdjQ>
    <xmx:ffptYUg3hk3IsIlvtemAE3qdoSMXVq_2HSjQIe430TI18tgowfy8aA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 18:51:39 -0400 (EDT)
Date:   Tue, 19 Oct 2021 09:51:40 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq
 refactoring
In-Reply-To: <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk>
Message-ID: <97323ce2-4f5c-3af2-83ac-686edf672aea@linux-m68k.org>
References: <20211018222157.12238-1-schmitzmic@gmail.com> <8d60483d-3cd6-5df7-8db6-7a8b9ce462e3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 18 Oct 2021, Jens Axboe wrote:

> Was going to ask if this driver was used by anyone, since it's taken 3
> years for the breakage to be spotted... 

A lack of bug reports never implied a lack of users (or potential users). 
That falacy is really getting tiresome.

It is much more difficult to report regressions than it is to use a 
workaround (i.e. boot a known good kernel). And I have plenty of sympathy 
for end-users who may assume that the people and corporations who create 
the breakage will take responsibility for fixing it.

Do maintainers really expect innocent end users to report and bisect 
regressions, and also test a series of potential fixes until one of them 
is finally found to both work and pass code review?
