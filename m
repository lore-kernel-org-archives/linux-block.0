Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35075 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdHXBuU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 21:50:20 -0400
Received: by mail-pg0-f67.google.com with SMTP id b3so1610932pga.2
        for <linux-block@vger.kernel.org>; Wed, 23 Aug 2017 18:50:20 -0700 (PDT)
Content-Type: text/plain; charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] block, bfq: fix error handle in bfq_init
From: weiping zhang <zwp10758@gmail.com>
In-Reply-To: <c11e3747-27b9-75bc-9e4d-d9a665a83741@kernel.dk>
Date: Thu, 24 Aug 2017 09:50:13 +0800
Cc: paolo.valente@linaro.org, linux-block@vger.kernel.org
Message-Id: <79599821-E259-4B4C-BFB5-63F4A35C15DF@gmail.com>
References: <20170818163714.GA40576@localhost.didichuxing.com>
 <c11e3747-27b9-75bc-9e4d-d9a665a83741@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> =D4=DA 2017=C4=EA8=D4=C224=C8=D5=A3=AC05:35=A3=ACJens Axboe =
<axboe@kernel.dk> =D0=B4=B5=C0=A3=BA
>=20
> On 08/18/2017 10:37 AM, weiping zhang wrote:
>> if elv_register fail, bfq_pool should be free.
>=20
> Looks correct to me, I'll add it. Thanks.
>=20
> --=20
> Jens Axboe
>=20


Jens,

Thanks a lot=
