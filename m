Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BUGFIX] block, bfq: update wr_busy_queues if needed on a queue split
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <201706191545.FX1Q7z4r%fengguang.wu@intel.com>
Date: Mon, 19 Jun 2017 13:42:44 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <1AE9BB5E-CF3B-4542-8FCD-91F80B32A0D1@linaro.org>
References: <201706191545.FX1Q7z4r%fengguang.wu@intel.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 19 giu 2017, alle ore 09:38, kbuild test robot =
<lkp@intel.com> ha scritto:
>=20
> Hi Paolo,
>=20
> [auto build test WARNING on v4.12-rc5]
> [also build test WARNING on next-20170616]
> [cannot apply to block/for-next]
> [if your patch is applied to the wrong git tree, please drop us a note =
to help improve the system]
>=20
> url:    =
https://github.com/0day-ci/linux/commits/Paolo-Valente/block-bfq-update-wr=
_busy_queues-if-needed-on-a-queue-split/20170619-145003
> config: i386-randconfig-x000-201725 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>        # save the attached .config to linux build tree
>        make ARCH=3Di386=20
>=20
> Note: it may well be a FALSE warning. FWIW you are at least aware of =
it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
>=20
> All warnings (new ones prefixed by >>):
>=20
>   block/bfq-iosched.c: In function 'bfq_get_rq_private':
>>> block/bfq-iosched.c:770:10: warning: 'old_wr_coeff' may be used =
uninitialized in this function [-Wmaybe-uninitialized]
>     else if (old_wr_coeff > 1 && bfqq->wr_coeff =3D=3D 1)
>             ^
>   block/bfq-iosched.c:731:15: note: 'old_wr_coeff' was declared here
>     unsigned int old_wr_coeff;
>                  ^~~~~~~~~~~~
>=20

I'm sending a V2, (probably imperceptibly) slower on average, but not
confusing the compiler.

Thanks,
Paolo

> vim +/old_wr_coeff +770 block/bfq-iosched.c
>=20
>   754		    time_is_before_jiffies(bfqq->last_wr_start_finish +
>   755					   bfqq->wr_cur_max_time))) {
>   756			bfq_log_bfqq(bfqq->bfqd, bfqq,
>   757			    "resume state: switching off wr");
>   758=09
>   759			bfqq->wr_coeff =3D 1;
>   760		}
>   761=09
>   762		/* make sure weight will be updated, however we got here =
*/
>   763		bfqq->entity.prio_changed =3D 1;
>   764=09
>   765		if (likely(!busy))
>   766			return;
>   767=09
>   768		if (old_wr_coeff =3D=3D 1 && bfqq->wr_coeff > 1)
>   769			bfqd->wr_busy_queues++;
>> 770		else if (old_wr_coeff > 1 && bfqq->wr_coeff =3D=3D 1)
>   771			bfqd->wr_busy_queues--;
>   772	}
>   773=09
>   774	static int bfqq_process_refs(struct bfq_queue *bfqq)
>   775	{
>   776		return bfqq->ref - bfqq->allocated - bfqq->entity.on_st;
>   777	}
>   778=09
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology =
Center
> https://lists.01.org/pipermail/kbuild-all                   Intel =
Corporation
> <.config.gz>
