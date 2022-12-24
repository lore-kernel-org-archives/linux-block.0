Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD10C4332F
	for <linux-block@archiver.kernel.org>; Sat, 24 Dec 2022 21:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiLXVqs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Dec 2022 16:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiLXVqr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Dec 2022 16:46:47 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94183BE1B
        for <linux-block@vger.kernel.org>; Sat, 24 Dec 2022 13:46:46 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 82so5313433pgc.0
        for <linux-block@vger.kernel.org>; Sat, 24 Dec 2022 13:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3UxsimBVOhEDuKfSuQBk+/BzoqRkKBz/Nr1j/ZryG8=;
        b=pvsrtHUzIjjg31V+IH/mGznvfjfwaNZDh0KiqTKR+D9Qp0tWJs97bpm4mhN5kW3pQt
         OkRylP6veOvbgsdOaq3/x/m4d4dTH9ZDPaMWkmmnK02OoF7Xzpp+wtyerfdn9ClqqG/9
         U9rpKaLAWkrv5ZFoUPjFw+3Gy91H5HOaJuwMmV7DvjkSyJ1SLqub9OaDLBSWcr18YZH5
         46p0CwJ/hDRTUUvu3BY03NQwjNEAL5uNZsg1P75CIC/cQlgdAezkZyduQXl6f75R1m8B
         WA/2IHud3doEE+gz3Okydd2VATvQEiJJ/O/Wf8Q8LGepTE0YHxR/LGVG1FqGkHEhNd7A
         42YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3UxsimBVOhEDuKfSuQBk+/BzoqRkKBz/Nr1j/ZryG8=;
        b=s7HoGr/dlSPAQY61e+3f+QcBzLAOfbmP4wiwDtDJvcXHeenNfXJ69VxlgYCVhx4diU
         pqh6vWJZDlS2W/pQgthjhDXMzXMnnci5R7yC0RfnV6puBTODZlo4iuxcQh1/10t6vFFK
         7XiKViKDrqinesiemSjuJvnsmL9vAaWaOtzuAR8hiuruplYDkn4v0/7+tWE48YuLx2lZ
         TwixgHv/tjn7a9yL+f3CWoAY0lphAGyld/aUKU9+NOXVslHB85GSTKkoDH709auySZ29
         iiA1QeAGYtRhsB0ABFFMHFy/G68T2BUn727Bek6QDcqbw/MwQ7O8gcIu90+75bJRw+Md
         UOtg==
X-Gm-Message-State: AFqh2koB2nfaB2OjMhjF4iCQN1Sr393oj7IsrfsJqIpnmLteim/ZDRle
        EBMPEQXzMImht+NjKztRFTUR6AsOfftl0psQHz4CdA==
X-Google-Smtp-Source: AMrXdXt0YkaBTrpFdunDUREJLDj9yvlHL4xI+4nHdNaNW/k6tF7R0vqMBDOeqky0agrYPB5X5UyL0/+Wjr719wDOP8c=
X-Received: by 2002:a63:5b15:0:b0:479:3bf5:df35 with SMTP id
 p21-20020a635b15000000b004793bf5df35mr586451pgb.572.1671918406048; Sat, 24
 Dec 2022 13:46:46 -0800 (PST)
MIME-Version: 1.0
References: <20221224101139.sgvhr2n3pbrs4agm@pali> <Y6bvh48kTTzbMX6M@kroah.com>
 <20221224133425.vlcxbaaynihiom4a@pali> <Y6cXRbGUsarzoJEw@zn.tnic>
 <20221224154842.o4ngrwmskduowttm@pali> <Y6chm9khdG4pmNhN@zn.tnic>
 <20221224160055.ln3dbhx7dnut7dwi@pali> <Y6cma26FKzBQD8AN@zn.tnic>
 <20221224163602.6bqr32tkf2ulx6po@pali> <Y6dsWVspi9tGNid5@kbusch-mbp.dhcp.thefacebook.com>
 <20221224213646.zyosaq7hnlsaje4b@pali>
In-Reply-To: <20221224213646.zyosaq7hnlsaje4b@pali>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Sat, 24 Dec 2022 16:46:35 -0500
Message-ID: <CA+pv=HPUgxxJjOJBki1jDjR+Abk3W9=SZ3RxSsB-YYucKBFdaQ@mail.gmail.com>
Subject: Re: [PATCH] pktcdvd: remove driver.
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 24, 2022 at 4:39 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> And based on my experience, users (including me) are using distributions
> LTS kernels in production. So do not forget that it takes lot of time
> until some distributions switch from one LTS version to another LTS
> version and so it would take lot of time until deprecation warning is
> visible to user. (Maybe deprecation information could be "backported" to
> LTS kernels?)

Yeah, my main server (which I don't use for dev work) is on an LTS
kernel, same with my primary workstation, so I'm also using LTS
kernels in prod.

Would definitely appreciate it if those deprecation warnings are
visible (and maybe even backported?) if added... would certainly help
make transitioning from one LTS to the next easier.

>
> In any case I would prefer some documented webpage with all deprecation
> information. Like there is releases webpage which says exact day when
> particular LTS version is EOL: https://kernel.org/category/releases.html

I would as well, maybe it could go somewhere in Documentation? Not
sure, that's way beyond me.

-- Slade
