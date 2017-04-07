Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH V2 11/16] block, bfq: reduce idling only in symmetric scenarios
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1490973609.2587.3.camel@sandisk.com>
Date: Fri, 7 Apr 2017 09:47:53 +0200
Cc: "tj@kernel.org" <tj@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "samuele.zecchini92@gmail.com" <samuele.zecchini92@gmail.com>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "riccardo.pizzetti@gmail.com" <riccardo.pizzetti@gmail.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Message-Id: <2F5C851A-CE28-4159-AC60-8D42884E6EF1@linaro.org>
References: <20170331124743.3530-1-paolo.valente@linaro.org> <20170331124743.3530-12-paolo.valente@linaro.org> <1490973609.2587.3.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 31 mar 2017, alle ore 17:20, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Fri, 2017-03-31 at 14:47 +0200, Paolo Valente wrote:
>> +       entity->weight_counter =3D kzalloc(sizeof(struct =
bfq_weight_counter),
>> +                                        GFP_ATOMIC);
>> +       entity->weight_counter->weight =3D entity->weight;
>=20
> GFP_ATOMIC allocations are more likely to fail than GFP_KERNEL =
allocations.
> What will happen if kzalloc() returns NULL?
>=20

A plain crash :( I'm adding the simple handling of this forgotten =
exception. If I don't get other reviews in the next days, I'll post a V3 =
addressing this and the other issue you highlighted.

Thanks,
Paolo

> Bart.
