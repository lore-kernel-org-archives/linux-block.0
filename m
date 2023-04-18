Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55561C77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 12:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjDRMiH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 08:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjDRMiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 08:38:03 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492C113842
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 05:37:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id B186A2B0671E;
        Tue, 18 Apr 2023 08:37:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 18 Apr 2023 08:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681821477; x=1681822077; bh=J3
        VbPEwN3rqi4dOinK9dIl9bhyZN19WIqCTWpea9RiI=; b=JaXRK675OvwH+jkYNp
        fnthYDXNx7cdKJ8+M9qU8Z3vljw96JyuChvkVuorvGiWgAAwILOXOUYWUmDJUYI7
        gA+5D1529ENEDzcvktG8sQ1i79E30g8iM/hL2OQBh5Mdu8NFmASvXxn+7qJY1gdp
        qTY54URKjRzESh+A33UuPuTD7zldRab61zxGuFAqVrdguQncQ/9VnBtcmLeVmXRt
        N7Zz59mZ5X/Ru7OKV5jaIenDxA47aJCz+XsW/qCMAv/VcgfOO3X7Xd406uEDh4Zo
        6wcpQPANOH2+hJY7QntPFksh7eM+fDCoQ/kE5gXvMyj8Rc7uQQxhWUqqCmHqxVw9
        bnpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm3; t=1681821477; x=1681822077; bh=J3V
        bPEwN3rqi4dOinK9dIl9bhyZN19WIqCTWpea9RiI=; b=KTmhh+UR1xNgqTl6NOO
        yu1CI6P5YnNvkKfKd3mJ1ApeXIXZKsZMeiOcmDqjgLwVJMuBWGZjzv7095y/iiqb
        QBFMbgjoKiiyP2C3EtzDzyergtou+B6JykBsyHVLsTWQaarXDxh68YdfgCQPexRx
        4y63deEFIghK9XM9/Y8GeJxvCmT+EkOHuR7XWCzx16C27f5sOT0uILvGpswqFPts
        +szOdfuuDuTX+BcrTjUS+hTpWFBCF1n4yoBGMQoX+pvhO4qdl/+73m394fzO81PH
        UjA1l7OHKJ3X6jdyXLWlJJtzSow034NrmiSwY2Mpm+wmJ+62r+wEFm2D6NRW+I33
        9Tg==
X-ME-Sender: <xms:JI8-ZPsJAn0gNtlHT6xj9SiF_7XXPAm5MR53VrXXLdMHUHkbTPOVww>
    <xme:JI8-ZAfeLzRmlkZTjr8A6dQ8FEw4evwCCJCXywkOkQJzHTr_rki59ZnWxQ6lc-w6u
    h-gXMl2fDJlnTavsJo>
X-ME-Received: <xmr:JI8-ZCwrsPHuzLHIL4sq8cJjs6QkGwwkLNFrWJDLCRQ2ze8ryiR1xXRijmcpX1t7N3gnjIpgR9DqtA_9TsCEdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdelkedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepufhhihhn
    kdhitghhihhrohcumfgrfigrshgrkhhiuceoshhhihhnihgthhhirhhosehfrghsthhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvdegtdfgvdfhgfekvdektdfgfeeljeel
    gefgkedujeeiteehgefhgeethffgheehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshhhihhnihgthhhirhhosehfrghsthhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:JI8-ZONVP2goSPI30CRIeJNtb67fPlnhT-P4BEnsVc_kXXxhoAjmfw>
    <xmx:JI8-ZP9HqY2PfwO9wVw-Uo_aTniTyzYzs6ZqokbbG7FJ3F2NjWDXfA>
    <xmx:JI8-ZOVdvWn3_mCtAyV0eqanR4BUsy3N33rW3UymRXmMvCwDgn6z4A>
    <xmx:JY8-ZLZybk9OFS0dALkqzRauOFkG0AnJhgCxaKheDfr0nZ4WVsrEHfHVRgn87V66>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Apr 2023 08:37:55 -0400 (EDT)
Date:   Tue, 18 Apr 2023 21:37:52 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
        hch@infradead.org
Subject: Re: [PATCH v2 blktests] don't require modular null_blk for
 fault-injection
Message-ID: <55byiexrqbbhiftyiwi6xg7t2av5va6jj5zyntejqniq4l2g7z@ofej27qygtqg>
References: <20230416043744.25646-1-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416043744.25646-1-akinobu.mita@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 16, 2023 / 13:37, Akinobu Mita wrote:
> This blktests change changes null_blk fault-injection settings to be
> configured via configfs instead of module parameters.
> This allows null_blk fault-injection tests to run even if the null_blk is
> built-in the kernel and not built as a module.
> 
> If the null_blk does not yet support configuring fault-injection via
> configfs, fall back to set up with module parameter.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> * v2
> - don't skip the tests on older kernels without fault-injection via configfs

Thanks for this v2 patch. It looks good to me. I'll wait a few more days before
I apply it in case anyone has some more comments.

One nit in the commit title: it's the better to have the prefix
"block/{014,015,030}: " to clarify the test cases this commit touches. I'll do
the edit when I apply this patch.
