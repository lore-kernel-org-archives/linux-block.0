Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RFC 13/14] block, bfq: boost the throughput with random I/O on NCQ-capable HDDs
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1488848033.3125.12.camel@sandisk.com>
Date: Tue, 14 Mar 2017 15:12:53 +0100
Cc: "tj@kernel.org" <tj@kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "fchecconi@gmail.com" <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>
Message-Id: <FD51F768-2781-44A0-9CE8-4C411E1D6D9F@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org> <20170304160131.57366-14-paolo.valente@linaro.org> <1488848033.3125.12.camel@sandisk.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 07 mar 2017, alle ore 01:54, Bart Van Assche =
<bart.vanassche@sandisk.com> ha scritto:
>=20
> On Sat, 2017-03-04 at 17:01 +0100, Paolo Valente wrote:
>> @@ -8301,7 +8297,7 @@ static struct blkcg_policy blkcg_policy_bfq =3D =
{
>> static int __init bfq_init(void)
>> {
>> 	int ret;
>> -	char msg[50] =3D "BFQ I/O-scheduler: v6";
>> +	char msg[50] =3D "BFQ I/O-scheduler: v7r3";
>>=20
>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>> 	ret =3D blkcg_policy_register(&blkcg_policy_bfq);
>=20
> In the Linux kernel the kernel as a whole has a version number but we
> do not assign a version number to individual core components.
>=20

I'll remove that.

Thanks,
Paolo

> Bart.
