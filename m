Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8326BC7EE26
	for <linux-block@archiver.kernel.org>; Sat,  6 May 2023 05:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjEFFzy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 May 2023 01:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjEFFzx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 May 2023 01:55:53 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24384C00;
        Fri,  5 May 2023 22:55:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 167295C019A;
        Sat,  6 May 2023 01:55:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 06 May 2023 01:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683352552; x=1683438952; bh=Xy
        YyidwFBJooKcRwuNAyEiGZndfQ4uAFMEUJTuQOeVA=; b=qpeZCQ0K+20gwyiaU2
        2BQ5Iaiz2dmVVZVBIzYkeIiyR4y7bRtH2oCTZF+HJqQ1Rwe8gyrDrRnMziEqZZwf
        PxzomCbSBxZRIWY1ClVsCPWwSRh0wc0pqh2zxIH2Z8xoom3mU50OzN45TQX5I2q6
        XLE7OMkRuu39cYutdNBk0u7kjENsjKpWvac99Vv3bjmeFBiGyHZr7ohilrRywtwE
        KGi6+4fS27RZAu0JQc2J6MqOMFtOMkag+DOLf6olgUcTNoNjFsotbkNeLv+Fmbdt
        LWlFpB2MzLHHtt7Etv4YoTtRajkw7kgVBoP/lLZ2QghRwwZ+1kVXXptWk8W2bJ8M
        taTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683352552; x=1683438952; bh=XyYyidwFBJooK
        cRwuNAyEiGZndfQ4uAFMEUJTuQOeVA=; b=AiOnHrKn9/dVMLH1MM1HQ7LqTcBGa
        kbCEjmHOpRr6bumKb0lR8EjgFz7tHJhJvp1qyb4Pjv8tia7J26OfPMazRQnCvEqi
        gBtISk4QccDs7Ufjx8ZmT72NkD09QaWBZMAdAfoyiR2asEV1ObB6aQfX7jZi/bEu
        XwTaVbVGIbFNaGNws8RzAwxhfTCBCTCWFlbkoyCZPf98Xl+xJB9YyDHVm1ukwYTO
        /MBrNMqfa3wBSZWEg3gy9HmcDlsRk15P9iNmTkewaYtRo/LqW7N5n6Ff/kFTkIn7
        v7rgouDBkEKrMLHzhtWYEMf6y987uBbf1ccxLhXBv1XyVBUYH16x7EerQ==
X-ME-Sender: <xms:5-tVZCwQQRNkT0IiYo-C38stsreb3dVji-PtLd0NJcEBbqql4wHEjA>
    <xme:5-tVZOSGwf9SYB_XhPgPD8OJXct0mKeL8PtAXz47zfhXP4ACgD7p6A1ACoAMvXhUZ
    SyoFEpuJUBw9g>
X-ME-Received: <xmr:5-tVZEWfJ87lakacVZIe7T8GoMgZhTK2exyY4zDbepQtqUCb84nBiVe6JsDjgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:5-tVZIg6dk6uwodSRkMfmbJyGV2ywJ5Fn8amGmzf_pN5EieTNq_ClA>
    <xmx:5-tVZEDgkMJqd2X_G-0pjq7ODPYXrXqv-793dSdKv0-xUM47LTQU5w>
    <xmx:5-tVZJKXD739QDqfFHpUvv5L6lvKOcrGji71XtRnyOodbK2WXHx-BQ>
    <xmx:6OtVZH_7F25cRA_Rt99CiwMjKq0xdHtCvIQNBrieKJIuxuj_9jENpQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 May 2023 01:55:50 -0400 (EDT)
Date:   Sat, 6 May 2023 11:06:43 +0900
From:   Greg KH <greg@kroah.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     stable@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 6.1 0/7] blk-crypto fixes for 6.1
Message-ID: <2023050630-graveyard-paving-3e94@gregkh>
References: <20230504035417.61435-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504035417.61435-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 03, 2023 at 08:54:10PM -0700, Eric Biggers wrote:
> This series backports a couple blk-crypto fixes and their prerequisites
> to 6.1-stable.  All are clean cherry-picks, but I'm sending this out
> explicitly since the prerequisites might not have been obvious.

Thanks for these, that helped out a lot, all now queued up!

greg k-h
