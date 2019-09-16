Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35915C4CECD
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 15:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098AD20665
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 15:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzU2VkkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfIPPHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:07:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37621 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbfIPPHe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 11:07:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id i1so38707227wro.4
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2019 08:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YZ7GwPwdP1QaRAGCDi3zfIX/FY2fDnM1sr/RMCpFxxc=;
        b=uzU2VkkDYVjQ1pTRUBOHpiQDlJuYycViFdnM2TZTPwRbR0+hs72PASEsad5ldWEHha
         6YwaULFVAh7vUXhyKLVU4sJUP6XgqbItTQN7+FQTGReXDU2nwmRrbDpsB33iZTaXfZGk
         /hyPUmC/1qHE/rSCxaVCgMuXBV/n0z9PuGGdu+OT8RtWn9xp9ARUADYcSUaN5+uA2Qz4
         70Ayj4BJshAmRS0FoLOw089B9rb8FHgGNjnB/B8f2J+ETsc3GQ67QTYCeTwtx0jElo+A
         qPMiqIBOdgda4xvjbBXhUbZHs1l/yrfqqUa7pD7EzbcMiUBo6s4KET/EDASXzqS0G1S5
         ceyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YZ7GwPwdP1QaRAGCDi3zfIX/FY2fDnM1sr/RMCpFxxc=;
        b=gQFt4rTjOAt0TOFZzl6TmEsi2mQG0I8xBIhtfjJbzzf5oiQIK8TyHOvxwGFV6q2yul
         QnHnnFuYIuizohEBahyfWaldYF3JZvbMPWMltBcEShGYQa4YkHKqr2cFzeT3OhvjRv2h
         bn9fDvwnuXkbiQ+Jek7FiQTWPrpqXnTDIvy7He4ls34PmiIHz4ZoSM++pKkXHJsQ9TCD
         yi/fjFWiV2IsGZjEDxm0QlwQbpqwoAiReDcfxTYYpZVJtSQqe0LRxSsVNw5cWOfzspA3
         2q+3q1etK44QHX0J0RlCpWO20PDLlqTuwlFgnWi33Ly+qdK96P+P9ePGhFv1+AMbWqzw
         sYhw==
X-Gm-Message-State: APjAAAX2xt0flEgPjF/DNtlIXRS3hWUlWm1bzqwUhVsdvGX95/gw8D08
        utrO8K0EkvOdt8I+I/TydF6sUQ==
X-Google-Smtp-Source: APXvYqwA6CN0baTI+QTv0trp9VIfjDxVv1LIVPFLl9Of0S+VCIenW7uhYJSYtsse4eqn443IXckKPQ==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr226479wrq.78.1568646451810;
        Mon, 16 Sep 2019 08:07:31 -0700 (PDT)
Received: from [192.168.0.101] (146-241-102-115.dyn.eolo.it. [146.241.102.115])
        by smtp.gmail.com with ESMTPSA id 26sm113150wmf.20.2019.09.16.08.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:07:31 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/1] block, bfq: remove bfq prefix from cgroups filenames
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <c67c4d4b-ee56-85c1-5b94-7ae1704918b6@kernel.dk>
Date:   Mon, 16 Sep 2019 17:07:29 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        cgroups@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F3898DA-C61F-4FA7-B586-F0FA0CAF5069@linaro.org>
References: <20190909073117.20625-1-paolo.valente@linaro.org>
 <80C56C11-DA21-4036-9006-2F459ACE9A8C@linaro.org>
 <c67c4d4b-ee56-85c1-5b94-7ae1704918b6@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 16 set 2019, alle ore 17:01, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 9/16/19 8:56 AM, Paolo Valente wrote:
>> News of this change?  Can we have it (or the solution with the
>> symlinks if you prefer it) for 5.4?
>=20
> Coordinate with Tejun and bundle the stuff we need into a series,

Ok.

Tejun, could you put your switch-off-io-cost code into a standalone
patch, so that I can put it together with this one in a complete
series?

Thanks,
Paolo


> we
> can definitely put that in 5.4. I did send out the initial pull =
request
> for block, but I've got a few things lined up for a secondary pull
> later this week.
>=20
> --=20
> Jens Axboe
>=20

