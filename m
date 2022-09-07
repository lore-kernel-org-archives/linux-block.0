Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB25C38145
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 14:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiIGO5O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiIGO44 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 10:56:56 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A30DFCD;
        Wed,  7 Sep 2022 07:56:53 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EF85B5C013F;
        Wed,  7 Sep 2022 10:56:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 07 Sep 2022 10:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662562609; x=
        1662649009; bh=Z15hM739erLeylQSYwM0QX4Xa9iikANFqdyPOrNO3sw=; b=f
        jJ7vs1TUpa70NDwv5xto6bLLRPJwerN255KOrgcTVkW/OJ1cZdJlcblNLAK7AOs+
        a3ilFRxpzOOxj+DAGBRXw+y3+/tW/tiGx4A46CSBFkHQWdMtBN82H1Mk8bq35DfC
        Flkp1z/px+YqLJWmPI7R3m8lwz+mIa83KSRIbsluYjxgswI4dt3R9BhmlVSTHcHD
        ed3z5p870SGRMGXqQG3Jxb6klRWDgOArjcO3610LQYcsmadDzz7v8S+zeeZ8ZSPy
        BC1xUVljFtU/MEKXT/nGTKEp0lTvlWgKSydebvpnY/A6Od4qDwEsjcNTDYA9Fgfd
        l91xw6EBp0Njr20yiLNXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662562609; x=
        1662649009; bh=Z15hM739erLeylQSYwM0QX4Xa9iikANFqdyPOrNO3sw=; b=N
        bd4IXW+zRxIczsfird3YReBSnXzOZ6jZz0E6mOibqYz6MdQHdiIetYUdv2X49zir
        5niVELviqRveDltteo8RegneuQpXMKoW3ajUgGOVaTprPrX5HtPWafhrccV60mHi
        NmZudJJaqcaiDDDI14TGF4htgOaU7XR1I3xaWUi8YB38GrI5FHD6C2IK1JtX3bVr
        IWMuqXozbR3aTq3kzK7MIcMOtugZNEPm0hyFXryTa5dK34wLKNsY+MwlO8iBIIhp
        bn3mL6Bka4Y8PiLTKQh+GoNIYjurD2ajWnNS0UzcvxgbggHGk3oNYl4k/kyv5eyy
        rqHgI49ymAkkPtlwE1twg==
X-ME-Sender: <xms:MbEYY3Lm1NHexMAOKobzHQ9W1UXTR-Yyggl1wxwb_RhmTDUwugag3Q>
    <xme:MbEYY7KmvjORt1zPm4JfcF-fcwLAEudL8hSZo4u92eBpg8S8Jg3f4lLtJc7mZRn_E
    Yxb_PbRV9Hf5eHER0k>
X-ME-Received: <xmr:MbEYY_s9aVGv4xlDusrV6DwCBYD6WtEO24Jbp8lQLLZ37UZadd5zA-9USw6ayi8TRPfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeffuhhs
    thihucforggsvgcuoeguuhhsthihseguuhhsthihmhgrsggvrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeiffffuefgtdfhgfekfedtkedtteefgfevueelueefueegvdehteeulefg
    ueekkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    guuhhsthihseguuhhsthihmhgrsggvrdgtohhm
X-ME-Proxy: <xmx:MbEYYwZSxkkmF2rat-milEGk43tdryoS-mBQ2bQWWXbGKXGowR1pug>
    <xmx:MbEYY-YU7qRWmFrU3Hcad341daEDrEzRD1YZP_cLQORgX6ZaXErUmA>
    <xmx:MbEYY0AmFFkaGX_-fmSBbU2vRt0uPrXz_-WgN-8kd0rRHbKjGdrckA>
    <xmx:MbEYY9mYtL3Jj85j3jxhKw_P9ENwGQteAemCvX3pmDVVbq1evkqlKA>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 10:56:49 -0400 (EDT)
Message-ID: <ac6d972c-a4c3-d691-3dcf-2d1725e814fb@dustymabe.com>
Date:   Wed, 7 Sep 2022 10:56:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <20220907072231.GA23826@lst.de>
From:   Dusty Mabe <dusty@dustymabe.com>
In-Reply-To: <20220907072231.GA23826@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/7/22 03:22, Christoph Hellwig wrote:
> Just curious:  what is the underlying device (or more speicifically
> driver) under the md raids?

I think Ming already answered this, but yes virtio-blk:

```
Aug 23 12:50:59.764004 kernel: virtio_blk virtio1: [vda] 10485760 512-byte logical blocks (5.37 GB/5.00 GiB)

Aug 23 12:50:59.795968 kernel: virtio_blk virtio2: [vdb] 20971520 512-byte logical blocks (10.7 GB/10.0 GiB)
```

Dusty
