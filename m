Return-Path: <axboe@kernel.dk>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] don't forget to call pd_online_fn when activate policy
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <58C3731B.1050200@huawei.com>
Date: Fri, 10 Mar 2017 20:59:42 -0700
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 miaoxie@huawei.com
Message-Id: <F94C24D1-0904-4A42-B8BC-366C95CB9803@kernel.dk>
References: <1489026008-161611-1-git-send-email-zhouchengming1@huawei.com> <54047101-8ad6-a4fd-dda6-25c2551a3a3c@kernel.dk> <58C3731B.1050200@huawei.com>
To: zhouchengming <zhouchengming1@huawei.com>
List-ID: <linux-block@vger.kernel.org>


> On Mar 10, 2017, at 8:46 PM, zhouchengming <zhouchengming1@huawei.com> wro=
te:
>=20
>> On 2017/3/10 23:12, Jens Axboe wrote:
>>> On 03/08/2017 07:20 PM, Zhou Chengming wrote:
>>> When we activate policy on the request_queue, we will create policy_date=

>>> for all the existing blkgs of the request_queue, so we should call
>>> pd_init_fn() and pd_online_fn() on these newly created policy_data.
>>>=20
>>> Signed-off-by: Zhou Chengming<zhouchengming1@huawei.com>
>>> ---
>>>  block/blk-cgroup.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>=20
>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>> index 8ba0af7..0dd9e76 100644
>>> --- a/block/blk-cgroup.c
>>> +++ b/block/blk-cgroup.c
>>> @@ -1254,6 +1254,12 @@ int blkcg_activate_policy(struct request_queue *q=
,
>>>          pd->plid =3D pol->plid;
>>>          if (pol->pd_init_fn)
>>>              pol->pd_init_fn(pd);
>>> +
>>> +        if (pol->pd_online_fn) {
>>> +            spin_lock(blkg->blkcg->lock);
>>> +            pol->pd_online_fn(pd);
>>> +            spin_unlock(blkg->blkcg->lock);
>>> +        }
>>=20
>> You didn't even compile this, did you?
>>=20
>=20
> Sorry for my carelessness. It's a very minor change, so I didn't compile..=
.
> I will send a patch-v3 that I have compiled. Sorry again..

I don't care how trivial it seems. You always ALWAYS compile and test. Alway=
s. Don't ever send untested patches again, and not even compiling is unforgi=
vable.=20
