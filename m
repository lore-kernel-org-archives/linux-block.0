Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AEFC4332F
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 10:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiLHKtB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 05:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiLHKsW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 05:48:22 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3BB89AFC
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 02:43:37 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id x22so2832727ejs.11
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDOEuiDEB7Li4oZAHPN7SJ+nSHTURoPl6KCogSzGlew=;
        b=fT5kmKTsZ3pKIjr8WMNiUOQESNCk/KrBSYsFmJixtcEZpJwBsYHonx/AvHJcJK0EPX
         rXgPZQ4Z/HlEWNCloEgV0WxvFQwlxFmbI3IBK39uPW3qPxK3xuRF8CXwGNuEXv8Xv9cO
         Und1mkah+0nDzmwToyoVU6nsZgfQagWzsZ9BlOmQxJMKxu8J0ry/IfQTa5S0KXE8j7Pz
         77iO0T3UqWoIx1leuZUUg0lPY8PPd6qawlTAAqp5clE5a+mRiz2VKwifO98eMKXEsq7O
         NOr5WzL1rdIjZDwogoJiRCk/8zX8elaQ9rGdOtZwPBdVlcSIEk4NjzyeoTbGTQCSznb+
         olTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDOEuiDEB7Li4oZAHPN7SJ+nSHTURoPl6KCogSzGlew=;
        b=3fG12f6uZYcEFl3PTuJikGQ345YnpGTO+h//+WKfCYUaY9z0ZZfglN6YEGjO8QD61T
         2rBK/Dpux3KkFo+mt1Tjn2BbJA8Zx+QRi9iiS6WUBz8kCRHtb9XYs4QWbuPdgNVrfPDH
         mVdWUMYg+JENtXrBgUNpU7isA/o/VuWWWkqCEQdXH1Aokgqcwjwr/dUnLTXrQDH4xF8V
         LfeFM8r5laoSoqRkOOPfyxz26C5mK+sCTHhfTJHyyK//wAZlYZCNVu/kiicbsDJb5vw+
         FNruMURyCcyeay881+cwtj3tVAmOul/uk5/IcRb6Bh8FEiInd9+0UG0LQF/VtqxBkVTc
         lQqg==
X-Gm-Message-State: ANoB5pnhmF79X5eVjcwVP/aktihxGC5FnkK5DjcBPPM5rw9spVetbBld
        kL8779LYeelehkfmMa3FUWTdKA==
X-Google-Smtp-Source: AA0mqf761CdGepVoMb96PmWL/KVR7qh7NCA3gG1AKFlXOaEEW5glEiv4ZpQonX1fH94HkmjFlwrUmQ==
X-Received: by 2002:a17:907:a710:b0:7ba:fd1f:524 with SMTP id vw16-20020a170907a71000b007bafd1f0524mr18812158ejc.361.1670496216049;
        Thu, 08 Dec 2022 02:43:36 -0800 (PST)
Received: from mbp-di-paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id i3-20020a05640200c300b00461cdda400esm3260511edu.4.2022.12.08.02.43.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2022 02:43:35 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V6 6/8] block, bfq: retrieve independent access ranges
 from request queue
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <9eba7529-8879-fbba-4e17-f174ef401513@opensource.wdc.com>
Date:   Thu, 8 Dec 2022 11:43:34 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Federico Gavioli <f.gavioli97@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <41604669-2D56-4524-8FA1-527FEAD06B29@linaro.org>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-7-paolo.valente@linaro.org>
 <5d062001-2fff-35e5-d951-a61b510727d9@opensource.wdc.com>
 <4C45BCC6-D9AB-4C70-92E2-1B54AB4A2090@linaro.org>
 <d27ca14b-e228-49b7-28a8-00ea67e8ea06@opensource.wdc.com>
 <76ADE275-1862-44F7-B9C4-4A08179A72E3@linaro.org>
 <6983f8b3-a320-ce32-ef0d-273d11dd8648@opensource.wdc.com>
 <518C279B-8896-470A-9D8C-974F3BB886DB@linaro.org>
 <9eba7529-8879-fbba-4e17-f174ef401513@opensource.wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 7 dic 2022, alle ore 00:34, Damien Le Moal =
<damien.lemoal@opensource.wdc.com> ha scritto:
>=20
>=20

[...]

>> Just, let me avoid setting the fields bfqd->sector and
>> bfqd->nr_sectors for a case where we don't use them.
>=20
> Sure. But if you do not use them thanks to "if (num_actuators =3D=3D =
1)"
> optimizations, it would still not hurt to set these fields. That =
actually
> could be helpful for debugging.
>=20

Got it. I'm about to send a V9 that applies this last suggestion of =
yours.

Thanks,
Paolo

