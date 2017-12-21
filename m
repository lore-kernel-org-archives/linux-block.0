Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:44765 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753264AbdLUK5w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Dec 2017 05:57:52 -0500
Received: by mail-wm0-f44.google.com with SMTP id t8so15094356wmc.3
        for <linux-block@vger.kernel.org>; Thu, 21 Dec 2017 02:57:52 -0800 (PST)
From: Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: severe regression with random I/O from (at least) 4.14?
Message-Id: <DA18383E-B4BE-4491-B49E-84D1A555B89B@linaro.org>
Date: Thu, 21 Dec 2017 11:57:48 +0100
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        DAVIDE FERRARI <162996@studenti.unimore.it>
To: linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,
a few minutes ago I bumped into this apparent severe regression, with =
4.15-rc4 and an SSD PLEXTOR PX-256M5S. If, with none as I/O scheduler, I =
do
fio --name=3Dglobal --rw=3Drandread --size=3D512m --name=3Djob1

I get
read : io=3D524288KB, bw=3D34402KB/s, iops=3D8600, runt=3D 15240msec

This device had to reach at least 40 KIOPS. I retried with mq-deadline =
too, and then with a 4.14, same outcome in all cases. I asked some =
colleague to repeat the test with his/her device. Same outcome, so far, =
also with an SSD 850 EVO 250GB.

I'm sorry if I'm making some colossal mistake.

Thanks,
Paolo
