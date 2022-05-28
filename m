Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3721BC433F5
	for <linux-block@archiver.kernel.org>; Sat, 28 May 2022 09:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbiE1Jlx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 May 2022 05:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiE1Jlv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 May 2022 05:41:51 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350C61C111;
        Sat, 28 May 2022 02:41:46 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 8C7BB5FD04;
        Sat, 28 May 2022 12:41:42 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653730902;
        bh=Ex77ge4+cVuN9VwweqWv0CsC0vVpo2OdRP2djs/jzgg=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=KoOHTF7M9/JlRuF2m+QKeCoDpTcLM/8r2P6SOgZVim4uUOODb0JFQ73lS6dNiRxT+
         KqPiay2xPpfJr4KmiARud8MhGikuSvnEDIRssIPiap8ExLF/0nOwp9v15zSu7QDkp9
         lRtzvIvyZOBwMZecyLCZDQLmLrqy6ukthfqZ/b9QjJ++KV/gMGa7zyDYqF864AJobI
         IUyXdRO/eCAMVIkGdwwtq7tun3B8beh1AfwUJo53FyZbfR6m8mCVV+R+QCZV6FaE5c
         CqXBwPn2oNeeg0/zJSjp75RZ8AwImWdvvsdZEJCGH2VwgDqnkK9lpLQG8dbc5XDYDU
         +4yQ+nLQUGw5w==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Sat, 28 May 2022 12:41:32 +0300 (MSK)
From:   Aleksey Romanov <AVRomanov@sberdevices.ru>
To:     "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@chromium.org" <axboe@chromium.org>
CC:     kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mnitenko@gmail.com" <mnitenko@gmail.com>
Subject: Re: [RFC PATCH v1] zram: experimental patch with entropy calculation
Thread-Topic: [RFC PATCH v1] zram: experimental patch with entropy calculation
Thread-Index: AQHYbGz3WSsk9a8KK0ibVrkSkBx6g60z4D2A
Date:   Sat, 28 May 2022 09:30:53 +0000
Message-ID: <20220528093121.zqejxapd7xxrbu5c@cab-wsm-0029881>
References: <20220520171309.26768-1-avromanov@sberdevices.ru>
In-Reply-To: <20220520171309.26768-1-avromanov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62DE108081885948A39634B3871D0FB7@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/28 05:16:00 #19603934
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I also try this for /lib and /bin direcories. See results below.

/lib folder as .tar (not compressed):
+-----+-------------+------------+--------+--------------+-------------+
| ent |  orig_size  | compr_size |  time  | instructions | branches    |
+-----+-------------+------------+--------+--------------+-------------+
|  Y  | 16527126528 | 5921855963 | 16.46s | 71366805304  | 11693084550 |
+-----+-------------+------------+--------+--------------+-------------+
|  N  | 16527126528 | 5594516871 | 21.87s | 112664002524 | 16184998761 |
+-----+-------------+------------+--------+--------------+-------------+

/bin folder as .tar (not compressed):
+-----+------------+------------+--------+--------------+------------+
| ent | orig_size  | compr_size |  time  | instructions | branches   |
+-----+------------+------------+--------+--------------+------------+
|  Y  | 5594516871 | 387226648  | 4.772s | 35688596793  | 4486177586 |
+-----+------------+------------+--------+--------------+------------+
|  N  | 5594516871 | 326629907  | 5.811s | 43886087430  | 5161907045 |
+-----+------------+------------+--------+--------------+------------+=
