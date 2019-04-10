Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC4EC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 09:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49DF2083E
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 09:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYuFRgC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfDJJdv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:33:51 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:38647 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfDJJdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 05:33:51 -0400
Received: by mail-wr1-f46.google.com with SMTP id k11so2078075wro.5
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+1px/DHWI8SCzx6KfYR6VAzOZhOwhiFObq5qES6AFTc=;
        b=HYuFRgC6VzWRME+SFpFAZ4xtknixYDl81l6ABefhMTESOoafxtNQO3dwvbFylsKfPk
         Pn9qiej7xQ+tuPNMLfOt1w3Y9HFoPPnssr9cWxytPul2kXuHuFWWTvqINWLj9rPBC9Tw
         blBhAdSntCKDgWaDmV55RE4kPzNtGP6pyu4tQq22RxcY1EozdElXgEe0crvso3yVG8MV
         EmvCVaI8BWiqT3/H1S/kd61k0dl/hzLAUUPo3Ptv2TxGMMK7V01DNN70h2RqwYNxIOgD
         nLij5sv77R6kYjbEr+ud1aKaT8aRUR4q89ZVXIjeuNvEum520mp77j4sT1T/eo3NAog4
         KIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+1px/DHWI8SCzx6KfYR6VAzOZhOwhiFObq5qES6AFTc=;
        b=qqTvEI1KP2WYGEeuoUfn9Ls0s5Kou+beWxSp72tJEBYqrGUkXQQDmsOdTgDYJ+VUnt
         5OeKthcRNu7nHy+WOvDo7r75Ii/Hq5dtuLBJuybiryKiT+flq3QaThcrwAoO+SrQL8dc
         wYqcCpbrC7fJiqiwuW145/QO9Es5F00D2csOuMrEUizSfQ03KISQNMYqF1WIJxTzfy1Q
         o3NSjowKyq37plgkAAxfowxp/368nyvlBjUUuEx5IRstbzCrjK+uO0fPyDMGciiaPFTG
         p6dsbmfoSHoTEbgVCQvm7FggKoRneXji1Y+nN1cDlOrOu4vGWXrEwKD3l/3tVn5whxZk
         /xxg==
X-Gm-Message-State: APjAAAU1u82ylXgLnROssbB2EVQRAWjYGfaWvypn3m+2msAQBFLZ+vBC
        Z6P02w49lYEmbVqYLHkp3FD/CA==
X-Google-Smtp-Source: APXvYqwKw0Za71js2z9d2LuAig2tXInnm6/AEiqkVaMtZyh+M9KbP9w/slGFebTsDa893xGlABXvhQ==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr26908793wru.30.1554888829177;
        Wed, 10 Apr 2019 02:33:49 -0700 (PDT)
Received: from wifi-122_dhcprange-158.wifi.unimo.it ([155.185.122.158])
        by smtp.gmail.com with ESMTPSA id s189sm3402225wmf.45.2019.04.10.02.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 02:33:48 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Thinkpad X60: regression with 5.1-rc1 and 5.1-rc4
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190410093044.GA3776@amd>
Date:   Wed, 10 Apr 2019 11:33:43 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, rjw@rjwysocki.net,
        lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5BA70BA-D560-4C4C-BEC7-83E7D6407070@linaro.org>
References: <20190408173914.GA13260@amd>
 <678ab058-986c-9727-58d7-d3f5283e2225@kernel.dk> <20190409163304.GA23829@amd>
 <F6306562-0022-4043-BBF8-13FE4872CA31@linaro.org> <20190410093044.GA3776@amd>
To:     Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 10 apr 2019, alle ore 11:30, Pavel Machek <pavel@ucw.cz> ha =
scritto:
>=20
> Hi!
>=20
>>> I now noticed it said:
>>>=20
>>> EIP is in bfq_bfqq_expire
>>>=20
>>>> Can you try and revert:
>>>>=20
>>>> 9dee8b3b057e1
>>>>=20
>>>> and see if that helps?
>>>=20
>>> Yes, I tried and yes, it helps. What are the next steps?=20
>>>=20
>>=20
>> Try my fix:
>>=20
>> =
https://lore.kernel.org/linux-block/20190409191420.3f56d493@fire.localdoma=
in/T/#m30a14045e710b870f00f7c51cdaa7c403977b767
>>=20
>> and cross your fingers :)
>=20
> It seems to work... even without fingers crossed.
>=20

Great!  I've submitted a final version of this fix patch a few minutes
ago (not yet archived anywhere, sorry).

Thanks,
Paolo

> Tested-by: Pavel Machek <pavel@ucw.cz>
> 									=
Pavel
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) =
http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

