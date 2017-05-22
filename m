Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BUGFIX] block, bfq: access and cache blkg data only when safe
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <a2b424cb-202a-5a0d-8850-dd5e3332dd8b@kernel.dk>
Date: Mon, 22 May 2017 22:20:01 +0200
Cc: Tejun Heo <tj@kernel.org>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 linus.walleij@linaro.org,
 broonie@kernel.org
Message-Id: <0DDEC9E2-43EC-4559-B178-BE9F38EA676B@linaro.org>
References: <20170519083908.2588-1-paolo.valente@linaro.org> <a2b424cb-202a-5a0d-8850-dd5e3332dd8b@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 19 mag 2017, alle ore 16:37, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 05/19/2017 02:39 AM, Paolo Valente wrote:
>> @@ -692,8 +725,7 @@ void bfq_pd_offline(struct blkg_policy_data *pd)
>> 		/*
>> 		 * The idle tree may still contain bfq_queues belonging
>> 		 * to exited task because they never migrated to a =
different
>> -		 * cgroup from the one being destroyed now.  No one else
>> -		 * can access them so it's safe to act without any lock.
>> ++                * cgroup from the one being destroyed now.
>> 		 */
>> 		bfq_flush_idle_tree(st);
>>=20
>=20
> Looks like an extra '+' snuck into that hunk.
>=20

Yes, sorry.  Before possibly submitting a fixed version, I'll wait for
a reply on my previous email in this thread, as the issue now seems
more serious to me, and affecting CFQ too.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20
