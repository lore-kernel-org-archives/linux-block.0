Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: v4.16-rc1 + dm-mpath + BFQ
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <75617a7d85070b989245e26de21f708c8762c7b7.camel@wdc.com>
Date: Thu, 10 May 2018 17:22:51 +0200
Cc: "loberman@redhat.com" <loberman@redhat.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "broonie@linaro.org" <broonie@linaro.org>,
 "axboe@fb.com" <axboe@fb.com>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Message-Id: <8126028A-6DCB-4776-9FA4-00F3074B66B4@linaro.org>
References: <1518202449.2871.32.camel@wdc.com>
 <6a1695f4-de6f-a959-5242-9611e148bc11@kernel.dk>
 <13a55c03-b138-ca8c-0a0a-95c976b4909e@wdc.com>
 <bee15d7a-de1f-daee-717d-b9e314ab06a1@kernel.dk>
 <1FC84680-6482-4FE5-97D0-0F7079C45AA7@linaro.org>
 <06795609-6ec6-4ae2-f219-3bf7219c11a3@wdc.com>
 <D89FF8A1-871E-4661-AE9F-6515E6C5EF22@linaro.org>
 <1518547636.2796.15.camel@wdc.com>
 <0BF6AC73-69CE-41B5-BDAC-C5249037C83C@linaro.org>
 <60f48ff1-7c8b-2c10-4560-744d70bccea1@wdc.com>
 <6C49304C-D506-4719-9365-E7D35BEC9851@linaro.org>
 <1519868123.2777.28.camel@wdc.com>
 <10BDC305-A874-477C-9545-5617036C2E91@linaro.org>
 <2dcb12b92e50a31c55dd3ab0e464cc819432c3d3.camel@wdc.com>
 <7E372E2C-83A8-4EF4-B52E-E3AC6ED01C74@linaro.org>
 <a6e512dff10d0cff12a688bbf1b30e275a91633e.camel@wdc.com>
 <6A355080-C9A8-475D-9A35-32850D771ABB@linaro.org>
 <1525466533.9055.1.camel@redhat.com>
 <75617a7d85070b989245e26de21f708c8762c7b7.camel@wdc.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 10 mag 2018, alle ore 17:16, Bart Van Assche =
<Bart.VanAssche@wdc.com> ha scritto:
>=20
> On Fri, 2018-05-04 at 16:42 -0400, Laurence Oberman wrote:
>> I was never able to reproduce Barts original issue using his tree and
>> actual mlx5/cx4 hardware and ibsrp
>> I enabled BFQ with no other special tuning for the moath and =
subpaths.
>> I was waiting for him to come back from vacation to check with him.
>=20
> (back in the office)
>=20
> Hello Laurence,
>=20
> What I understood from off-list communication is that you tried to =
find
> a way to reproduce what I reported without using the srp-test =
software.
> My understanding is that both Paolo and I can reproduce the reported =
issue
> with the srp-test software.
>=20

Thanks for chiming in, Bart.

Above all, with my fix [1] it should be gone.

Looking forward to your feedback,
Paolo

[1] =
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1682264.html
> Bart.
>=20
>=20
>=20
