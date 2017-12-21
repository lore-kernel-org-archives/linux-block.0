Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:45919 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdLULJu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Dec 2017 06:09:50 -0500
Received: by mail-wm0-f49.google.com with SMTP id 9so15178523wme.4
        for <linux-block@vger.kernel.org>; Thu, 21 Dec 2017 03:09:49 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: severe regression with random I/O from (at least) 4.14?
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <DA18383E-B4BE-4491-B49E-84D1A555B89B@linaro.org>
Date: Thu, 21 Dec 2017 12:09:47 +0100
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        DAVIDE FERRARI <162996@studenti.unimore.it>
Message-Id: <EC5420CE-8EB2-4E29-8C3E-FB961F616327@linaro.org>
References: <DA18383E-B4BE-4491-B49E-84D1A555B89B@linaro.org>
To: linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



> Il giorno 21 dic 2017, alle ore 11:57, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
> a few minutes ago I bumped into this apparent severe regression, with =
4.15-rc4 and an SSD PLEXTOR PX-256M5S. If, with none as I/O scheduler, I =
do
> fio --name=3Dglobal --rw=3Drandread --size=3D512m --name=3Djob1
>=20
> I get
> read : io=3D524288KB, bw=3D34402KB/s, iops=3D8600, runt=3D 15240msec
>=20
> This device had to reach at least 40 KIOPS. I retried with mq-deadline =
too, and then with a 4.14, same outcome in all cases. I asked some =
colleague to repeat the test with his/her device. Same outcome, so far, =
also with an SSD 850 EVO 250GB.
>=20
> I'm sorry if I'm making some colossal mistake.
>=20

Forget it, sorry. I was confused by a failed test where iodepth was =
higher than 1, and I am sleeping too little ...

Thanks,
Paolo

> Thanks,
> Paolo
>=20
>=20
>=20
