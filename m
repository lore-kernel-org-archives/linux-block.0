Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C5EC25B0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Aug 2022 12:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiHOMGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Aug 2022 08:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbiHOMGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Aug 2022 08:06:06 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E5255AB;
        Mon, 15 Aug 2022 05:06:01 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 10D155FD05;
        Mon, 15 Aug 2022 15:05:59 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660565159;
        bh=qnpOaT6JJnvXbIjt2B0k8LM9YQ+BW665J4bNjST6xec=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=m20210HWrvqdlg2rQiwYJ/jbllRjt+JDtg2V2X0324ltsmwEwQ39Yx5+kVwpz3kGL
         /S3wme124ggfRWSF8ajYIsZS4avtxXNtocm9V0B/vvtmdkAUkIxjVDdJ5vldYVRry8
         d3JGyPRhvqiWuPVwkbfsxMCMHpw4OLfxKIeFxJiBEIYD3po5JZInC/910TUU/YVMUM
         IYLxdY40UocIOC27jOzDjqJ3UomrRP6CcL6ITQW0sR8iK/xVvRWHf7wGF7YyaybJVu
         loFUSq9Yply2iM2t29LCtumOhtr+5b7wX660mBLqi/6rdDE5SjBCfohiylN1hoRJce
         wtBxOCUHxghFA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 15 Aug 2022 15:05:58 +0300 (MSK)
From:   Aleksey Romanov <AVRomanov@sberdevices.ru>
To:     "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@chromium.org" <axboe@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mnitenko@gmail.com" <mnitenko@gmail.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
Subject: Re: [PATCH v1] zram: don't retry compress incompressible page
Thread-Topic: [PATCH v1] zram: don't retry compress incompressible page
Thread-Index: AQHYrKxf/aKxWvprs0WcIg34PQnzIq2vsxaA
Date:   Mon, 15 Aug 2022 12:05:07 +0000
Message-ID: <20220815120551.qhtk5c4gty7wurjl@CAB-WSD-0003100.sigma.sbrf.ru>
References: <20220810112857.90278-1-avromanov@sberdevices.ru>
In-Reply-To: <20220810112857.90278-1-avromanov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5EF4E9AD478C014887345254EF694CCF@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/15 08:42:00 #20120161
X-KSMG-AntiVirus-Status: Clean, skipped
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Forgot to add Andrew Morton.=
