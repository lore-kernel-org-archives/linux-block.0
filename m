Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586C8C77B61
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 01:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDKBgC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 21:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjDKBgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 21:36:01 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27112D50
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 18:35:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 142CF2B066BB;
        Mon, 10 Apr 2023 21:35:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 10 Apr 2023 21:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681176947; x=1681177547; bh=N3
        vWz+VeN1lE7R+NrNAweI4FiV73pPcdRXaUR4ZBTtU=; b=eWPSrv+0bn8vduSHX4
        dPTTLNsosfR/mpmxII94OSOz+ZCABuYZRZ/8MYzOIGJJg2rKzE+vXx7MhSnGIIIn
        dXwsyE8YWExRqWDiJi+j/jGA8Bjqe4GHYUlPl9wASN4GRxl0ZB/+hag9cyqsvxVV
        pAZZXSNta1dvL86XVSring7liDx8dFUsR6H19yks0lBToP1vAg2AR1RTa75mAYGy
        chkOzU1MHFxSyxg3f4IW6Pl1lGVbjqpq4Hf+Bs2AfYUMVrqMtv0oIvl4aP11QfSU
        bSaYxNRRooFQinR0QBR9jLNFiVFBkyy/TPR13cRY7+PyJcpHo9GRCa88MecFTN58
        3eSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=ie1e949a3.fm2; t=1681176947; x=1681177547; bh=N3v
        Wz+VeN1lE7R+NrNAweI4FiV73pPcdRXaUR4ZBTtU=; b=Q9wUJugRyew3RQpXs7q
        bcMfbW5g3w3mVIYPjoK0bwLgNPfCa+2NcY4kWqkGxPDm5cEt8anloJza2Tg/P69a
        FAx6E8FFztb/syMULmTlkbx+CJohF1nBUGSSrWaIxeWVkBy28ZTqe22Dre7Xvzxd
        wYHBrpnSNuf11F/SUfSJwzVnfXzkqmoffGPaTfPcWJc5Y19lVFpkKGJ5TOuoeoXu
        1iX/1pGjBktmWk9F+nlrNUVrKRc4jgphPUYtGeBz7dceGZsj+wF/yX5DAcg0IalT
        ZAvTp7yNV+KK2Sl1zkKfLDsy0WZPGsGEMZvEZJ62ok9MIoRmbbMZSeayQ8QfuZ5F
        22Q==
X-ME-Sender: <xms:c7k0ZNAsFww3s9oelJ_AkJI7TDoITjqo9EE8pJQHT6BGY346gFQwog>
    <xme:c7k0ZLgQ1-_qQdGREGurVD-ntcmDd3NbN2V7Bv-MXp0M92nbU6nVMweod01CHUbZT
    UidYbuMeD2XmQKyuis>
X-ME-Received: <xmr:c7k0ZInGl0j6R33iQYm385ptnAAEDjW779ea6sEqo4ui-3UBJIgreL7JLxfHavQITENEds8K7HwJ6N-Ekz9AWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekfedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepufhhihhn
    kdhitghhihhrohcumfgrfigrshgrkhhiuceoshhhihhnihgthhhirhhosehfrghsthhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepffehffetgfdugeffffelvdfgjefgkedv
    hfehgeefveffgfffvedtueekgeevvefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshhhi
    nhhitghhihhrohesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:c7k0ZHwKLl5Q7xLchCSwGkPSg3dXF-iYm5McaxSHrqqkGSzoXOVBog>
    <xmx:c7k0ZCSjmeV2nMITxbVBhrkGB16G92U_6-c0gq6cFcxSX-WcdRab5Q>
    <xmx:c7k0ZKZqE-newFORneeCIqbgMbNlJej50WeE7D0Jf8hgZSCpJs-sqw>
    <xmx:c7k0ZAc_ZITgQPeciOE3LyDwXRsmKVOQWEj7X1pkvIomPELr8NF98XO-AeXs9Geo>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Apr 2023 21:35:45 -0400 (EDT)
Date:   Tue, 11 Apr 2023 10:35:43 +0900
From:   Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH blktests 2/2] nvme/047: add test for uring-passthrough
Message-ID: <dopldttgovohurv7fovj4sxoux7aelkhd6zzrmxvxevoue6e54@wopt7tlh3dzg>
References: <20230331034414.42024-1-joshi.k@samsung.com>
 <CGME20230331034533epcas5p2834dad2bc54ad1a6348895f522400e8c@epcas5p2.samsung.com>
 <20230331034414.42024-3-joshi.k@samsung.com>
 <20230407080746.tx4sgperc6pvjsbu@shinhome>
 <20230410124333.GC16047@green5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410124333.GC16047@green5>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 10, 2023 / 18:13, Kanchan Joshi wrote:
> On Fri, Apr 07, 2023 at 05:07:46PM +0900, Shin'ichiro Kawasaki wrote:
[...]
> > > +requires() {
> > > +	_nvme_requires
> > > +	_have_kver 6 1
> > 
> > In general, it's the better not to depend on version number to check dependency.
> > Is kernel version the only way to check the kernel dependency?
> 
> The tests checks for iopoll and fixed-buffer paths which are present
> from 6.1 onwards, therefore this check. Hope that is ok?

Okay, thanks for the clarification. The changes are not visible from userland,
then we need the kernel version check.

> 
> > Also, I think this test case assumes that the kernel is built with
> > CONFIG_IO_URING. I suggest to add "_have_kernel_option IO_URING" to ensure it.
> 
> Sure, will add.
> 
> > > +	_have_fio_ver 3 33
> > 
> > Is io_uring_cmd engine the reason to check this fio version? If so, I suggest to
> > check "fio --enghelp" output. We can add a new helper function with name like
> > _have_fio_io_uring_cmd_engine. _have_fio_zbd_zonemode in common/fio can be a
> > reference.
> 
> fixed-buffer support[1] went into this fio relese, therefore check for
> the specific version.
> 
> [1]https://lore.kernel.org/fio/20221003033152.314763-1-anuj20.g@samsung.com/

Thanks again. This can not be checked with fio commands. Let's do with
_have_fio_ver as you suggested.

On top of this, could you renumber the test case to nvme/049? Other new test
cases will consume nvme/047 and nvme/048 soon.

