Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B709C4320A
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 03:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BAD60F23
	for <linux-block@archiver.kernel.org>; Thu, 29 Jul 2021 03:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhG2DOU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhG2DOU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 23:14:20 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1949AC0613CF
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 20:14:11 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 184so4557946qkh.1
        for <linux-block@vger.kernel.org>; Wed, 28 Jul 2021 20:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=nlsvjj4rY0Et6e/FykFDR3vhRnNtSIxPsqSGb/r9ALU=;
        b=kCFpSYAgNQ0jmV6c4v5/E971UvU9p9NMkZJGXzZDqwkFxBkfwMmDUZEjYJa7WRyTtF
         riAe3bXOmyu7Q2Z9ynCYvzPI+mcZwh48Ecl2G6sczf4zl9y2zB+oVICdglEENTshKF9e
         Hi3tZ7n4+ENgWTHPK21OI+nXbphwOEtqGicUhOxfL7K2swIWziSWF0WYKAj7zfhzejsS
         7hwQI4g2txxGDT+D8v2/Bzx8UEohJKLLDTRaHxYzMcZfLsj/OqGgGS4eI1P94eHH7S66
         x7t7MQYubYZFOZbJ9pUDBi34GT4aByDP8CYPtGRha3S2UaNBC1mgdHjzuw3DQCszlUr7
         K7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=nlsvjj4rY0Et6e/FykFDR3vhRnNtSIxPsqSGb/r9ALU=;
        b=JW8LZDEV8DXOKu8JxFBBOfFcd2irsauoIDmshn1YuQWPh4E3poFbHK/iN22ZRQciCK
         VXDo6iElSfk8rB5V6wRgJMtNLG9KU/WF8np7LUIvoyft7lwGbsqxr1zd7qhAME3rUn8o
         lwdpz6p8+OS/VJ9+Cc5uc0dditKZjbm4xrUHB3poZ46TQtfUeZn0iTBolulFf0KbFqhX
         760Q2zZXBbeiNGvJ9R+rUN5EOe/C6UZzfEM757jLU93tSsEsa2vhczY5OjEJDQiH1KxV
         kguWS9XNOnjrpOaGmlSjpDGxtFVkUZLYSa/JBfXxkZJK1Mxdg23M4J5FrJCYj85JsNwa
         kE9w==
X-Gm-Message-State: AOAM5312wzsuW1if4fOjE9bJip1JNQBJ6nBXvnjo0ts0tfMYkbvHs8CU
        tkQ9wfwK8al+i3BAVeF+kUgm+g==
X-Google-Smtp-Source: ABdhPJzuzipQ4hfP+0qmMKCAw0UZE8uHWc0F6Tdt+TS3gzApe3YsMZdvIS2ds/UEppmIEeFOr0nH+A==
X-Received: by 2002:a37:9f55:: with SMTP id i82mr3058039qke.459.1627528450226;
        Wed, 28 Jul 2021 20:14:10 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id u7sm779796qta.27.2021.07.28.20.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:14:09 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-leds@vger.kernel.org,
        axboe@kernel.dk, pavel@ucw.cz, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [RFC PATCH 2/8] block: Add block device LED trigger list
In-Reply-To: <20210729015344.3366750-3-arequipeno@gmail.com>
References: <20210729015344.3366750-1-arequipeno@gmail.com>
 <20210729015344.3366750-3-arequipeno@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1627528448_13589P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Jul 2021 23:14:08 -0400
Message-ID: <108872.1627528448@turing-police>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--==_Exmh_1627528448_13589P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Jul 2021 20:53:38 -0500, Ian Pilcher said:
> * New config option (CONFIG_BLK_LED_TRIGGERS) to enable/disable
>   block device LED triggers
>
> * New file - block/blk-ledtrig.c

Is this bisect-clean (as in "will it build properly with that config option
set after each of the succeeding patches")?  Usually, the config option
is added in the *last* patch, so that even if you have a bisect issue
it won't manifest because it's wrapped in a '#ifdef CONFIG_WHATEVER'
that can't possibly be compiled in because there's no way for Kconfig
to set that variable.




--==_Exmh_1627528448_13589P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJhAh0AAAoJEI0DS38y7CIc6cUH/3tq6hqxvKtkiQcD4HzMc2rV
VVnh4Fwe87oMVih1762MyR3eJq78lMdYCIE0uH5oCmhENt9vRazzRvqkhECq65+X
4J6vzZPa5b11Thlbq7VxcX9xekPGY5oMy4gNUIxA13FssiY155/vJHoxf5M03eHV
py/UIKV+Nt6TalNECEfo+tBwOo53jI0NuxKXVLSkrej1kTUWIgaGBhQ6a2UAVBlI
yo7OR3plIsotR1586qaQinzTvLQ8CMehGYut5xMWFNsAFryK/KrwtZ3SI30k9Fnb
mn51wpu5eei//q34mj5fSd93Ib0IK+7VmpSncpzqrWjZsRkn3z+yGMLjaCGvIuw=
=6m9i
-----END PGP SIGNATURE-----

--==_Exmh_1627528448_13589P--
