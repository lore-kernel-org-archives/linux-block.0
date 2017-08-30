Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] block, bfq: fix error handle in bfq_init
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170823152515.GA9294@localhost.didichuxing.com>
Date: Wed, 30 Aug 2017 17:04:35 +0200
Cc: axboe@kernel.dk,
 linux-block@vger.kernel.org
Message-Id: <E5F6017E-62BA-41F9-8926-8BDB75034A95@linaro.org>
References: <20170818163714.GA40576@localhost.didichuxing.com> <20170823152515.GA9294@localhost.didichuxing.com>
To: weiping zhang <zhangweiping@didichuxing.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 23 ago 2017, alle ore 17:25, weiping zhang =
<zhangweiping@didichuxing.com> ha scritto:
>=20
> On Sat, Aug 19, 2017 at 12:37:20AM +0800, weiping zhang wrote:
>> if elv_register fail, bfq_pool should be free.
>>=20
>> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
>> ---
>> block/bfq-iosched.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 436b6ca..bdb072f 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -5048,10 +5048,12 @@ static int __init bfq_init(void)
>>=20
>> 	ret =3D elv_register(&iosched_bfq_mq);
>> 	if (ret)
>> -		goto err_pol_unreg;
>> +		goto slab_kill;
>>=20
>> 	return 0;
>>=20
>> +slab_kill:
>> +	bfq_slab_kill();
>> err_pol_unreg:
>> #ifdef CONFIG_BFQ_GROUP_IOSCHED
>> 	blkcg_policy_unregister(&blkcg_policy_bfq);
>> --=20
>> 2.9.4
>>=20
> Hi Paolo, Jens,
>=20
> could you give some comments for this patch ?
>=20

Sorry for not making it in time (vacation), and thanks for fixing this
bug.

Paolo

> Thanks
