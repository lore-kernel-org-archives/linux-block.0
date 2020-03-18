Return-Path: <SRS0=4fFE=5D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE4C5ACD6
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 08:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550FB20767
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 08:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDXNoBNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgCRIow (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:44:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33224 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCRIov (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Mar 2020 04:44:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id r7so1739663wmg.0
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2020 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O8KYGOf+95Tpf3eEPrMnhsryx85iZb2LeCTWSGRPL+s=;
        b=LDXNoBNrjSsEY5u9iH14PkyBEwl8Mj0bqzypRHX6hf18F8muu8+dj4U/7nonEhP1kJ
         hqZ4lU+cZqcD10i4yzbe3tS4jH2txG8XaBG45URJj2hOCcLHxCXuj/FikE00FHz2Vghn
         lJi2LfyoLaJH/VhzqzuVbNj9xu+iE1qeQmhb9d4HSa18RaahyQLXncbKih6KrwqnzxDa
         6xEugheBXnmKoHchr1QSjDmgoXkj/pDfrqMX3p0A3zQPbpKylYYEI4KLEvH7V0RIXsVA
         qFs1dPYEJ67+sb+No9xe18p8b/pWAfBBuSBPDmFaNJ97ajF/c/Urf7W2EwBfurtRVAfR
         I82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O8KYGOf+95Tpf3eEPrMnhsryx85iZb2LeCTWSGRPL+s=;
        b=uA0LWOUq2FyG4S+uTbRNPFYS/2H7aN2ct/VLohGtIaglL6fq1xLL3trwu/qm+HRvpu
         Lzp1J3naQdUoV+tmfAHKnUreB90QTnWVrrZQOA9Egusn3OT0BtjQuCt+5oQT0u1s/dJD
         a97ws3Ljar+WQNqQrY2HtNAnqyoQC8X3W/Lyu7wrkbJzmPyZGNPRYo+VGaGSxV4PJ9ae
         bFIHbLX2mFlY+H2vQ+c5WeETA0W48S4SK4+U/KyxF5VX1G7gawxOhb1iJMW8IvKk5phL
         KBqY0J5jFUyuldvzuEPw1PWWTOgxDuTuCTMQnKOK0e7wLgidhn2WfA8ocjbEb6GAOou1
         NTqQ==
X-Gm-Message-State: ANhLgQ2SHHQhiCXKtsB/mQnavMku3FYbNgp2vy6p6AKKhkPrEwlYM8Cx
        UY7MDtPkhtE3paw0IeEWD3pRnQ==
X-Google-Smtp-Source: ADFU+vsI8CS7Hr+U1KR7xE/D4bGBbLL3wLDbo3yu957OH3eDUSODN0KOxV68TcjQHyaLudOxumIMQQ==
X-Received: by 2002:a1c:de82:: with SMTP id v124mr3915989wmg.70.1584521088385;
        Wed, 18 Mar 2020 01:44:48 -0700 (PDT)
Received: from [192.168.0.104] (88-147-64-186.dyn.eolo.it. [88.147.64.186])
        by smtp.gmail.com with ESMTPSA id i1sm8797761wrs.18.2020.03.18.01.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 01:44:47 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] block, bfq: fix use-after-free in
 bfq_idle_slice_timer_body
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <0a6e190a-3393-53f9-b127-d57d67cdcdc8@huawei.com>
Date:   Wed, 18 Mar 2020 09:45:22 +0100
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>, renxudong <renxudong1@huawei.com>,
        Louhongxiang <louhongxiang@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4171EF13-7956-44DA-A5BF-0245E4926436@linaro.org>
References: <6c0d0b36-751b-a63a-418b-888a88ce58f4@huawei.com>
 <C69604D5-CBB7-4A5F-AD73-7A9C0B6B3360@linaro.org>
 <0a6e190a-3393-53f9-b127-d57d67cdcdc8@huawei.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 18 mar 2020, alle ore 02:35, Zhiqiang Liu =
<liuzhiqiang26@huawei.com> ha scritto:
>=20
>=20
>=20
> On 2020/3/18 1:44, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 17 mar 2020, alle ore 15:06, Zhiqiang Liu =
<liuzhiqiang26@huawei.com> ha scritto:
>>>=20
>>> In bfq_idle_slice_timer func, bfqq =3D bfqd->in_service_queue is
>>> not in bfqd-lock critical section. The bfqq, which is not
>>> equal to NULL in bfq_idle_slice_timer, may be freed after passing
>>> to bfq_idle_slice_timer_body. So we will access the freed memory.
>>>=20
>>> KASAN log is given as follows:
>>> [13058.354613] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [13058.354640] BUG: KASAN: use-after-free in =
bfq_idle_slice_timer+0xac/0x290
>>> [13058.354644] Read of size 8 at addr ffffa02cf3e63f78 by task =
fork13/19767
>>> [13058.354646]
>>> [13058.354655] CPU: 96 PID: 19767 Comm: fork13
>>> [13058.354661] Call trace:
>>> [13058.354667]  dump_backtrace+0x0/0x310
>>> [13058.354672]  show_stack+0x28/0x38
>>> [13058.354681]  dump_stack+0xd8/0x108
>>> [13058.354687]  print_address_description+0x68/0x2d0
>>> [13058.354690]  kasan_report+0x124/0x2e0
>>> [13058.354697]  __asan_load8+0x88/0xb0
>>> [13058.354702]  bfq_idle_slice_timer+0xac/0x290
>>> [13058.354707]  __hrtimer_run_queues+0x298/0x8b8
>>> [13058.354710]  hrtimer_interrupt+0x1b8/0x678
>>> [13058.354716]  arch_timer_handler_phys+0x4c/0x78
>>> [13058.354722]  handle_percpu_devid_irq+0xf0/0x558
>>> [13058.354731]  generic_handle_irq+0x50/0x70
>>> [13058.354735]  __handle_domain_irq+0x94/0x110
>>> [13058.354739]  gic_handle_irq+0x8c/0x1b0
>>> [13058.354742]  el1_irq+0xb8/0x140
>>> [13058.354748]  do_wp_page+0x260/0xe28
>>> [13058.354752]  __handle_mm_fault+0x8ec/0x9b0
>>> [13058.354756]  handle_mm_fault+0x280/0x460
>>> [13058.354762]  do_page_fault+0x3ec/0x890
>>> [13058.354765]  do_mem_abort+0xc0/0x1b0
>>> [13058.354768]  el0_da+0x24/0x28
>>> [13058.354770]
>>> [13058.354773] Allocated by task 19731:
>>> [13058.354780]  kasan_kmalloc+0xe0/0x190
>>> [13058.354784]  kasan_slab_alloc+0x14/0x20
>>> [13058.354788]  kmem_cache_alloc_node+0x130/0x440
>>> [13058.354793]  bfq_get_queue+0x138/0x858
>>> [13058.354797]  bfq_get_bfqq_handle_split+0xd4/0x328
>>> [13058.354801]  bfq_init_rq+0x1f4/0x1180
>>> [13058.354806]  bfq_insert_requests+0x264/0x1c98
>>> [13058.354811]  blk_mq_sched_insert_requests+0x1c4/0x488
>>> [13058.354818]  blk_mq_flush_plug_list+0x2d4/0x6e0
>>> [13058.354826]  blk_flush_plug_list+0x230/0x548
>>> [13058.354830]  blk_finish_plug+0x60/0x80
>>> [13058.354838]  read_pages+0xec/0x2c0
>>> [13058.354842]  __do_page_cache_readahead+0x374/0x438
>>> [13058.354846]  ondemand_readahead+0x24c/0x6b0
>>> [13058.354851]  page_cache_sync_readahead+0x17c/0x2f8
>>> [13058.354858]  generic_file_buffered_read+0x588/0xc58
>>> [13058.354862]  generic_file_read_iter+0x1b4/0x278
>>> [13058.354965]  ext4_file_read_iter+0xa8/0x1d8 [ext4]
>>> [13058.354972]  __vfs_read+0x238/0x320
>>> [13058.354976]  vfs_read+0xbc/0x1c0
>>> [13058.354980]  ksys_read+0xdc/0x1b8
>>> [13058.354984]  __arm64_sys_read+0x50/0x60
>>> [13058.354990]  el0_svc_common+0xb4/0x1d8
>>> [13058.354994]  el0_svc_handler+0x50/0xa8
>>> [13058.354998]  el0_svc+0x8/0xc
>>> [13058.354999]
>>> [13058.355001] Freed by task 19731:
>>> [13058.355007]  __kasan_slab_free+0x120/0x228
>>> [13058.355010]  kasan_slab_free+0x10/0x18
>>> [13058.355014]  kmem_cache_free+0x288/0x3f0
>>> [13058.355018]  bfq_put_queue+0x134/0x208
>>> [13058.355022]  bfq_exit_icq_bfqq+0x164/0x348
>>> [13058.355026]  bfq_exit_icq+0x28/0x40
>>> [13058.355030]  ioc_exit_icq+0xa0/0x150
>>> [13058.355035]  put_io_context_active+0x250/0x438
>>> [13058.355038]  exit_io_context+0xd0/0x138
>>> [13058.355045]  do_exit+0x734/0xc58
>>> [13058.355050]  do_group_exit+0x78/0x220
>>> [13058.355054]  __wake_up_parent+0x0/0x50
>>> [13058.355058]  el0_svc_common+0xb4/0x1d8
>>> [13058.355062]  el0_svc_handler+0x50/0xa8
>>> [13058.355066]  el0_svc+0x8/0xc
>>> [13058.355067]
>>> [13058.355071] The buggy address belongs to the object at =
ffffa02cf3e63e70#012 which belongs to the cache bfq_queue of size 464
>>> [13058.355075] The buggy address is located 264 bytes inside of#012 =
464-byte region [ffffa02cf3e63e70, ffffa02cf3e64040)
>>> [13058.355077] The buggy address belongs to the page:
>>> [13058.355083] page:ffff7e80b3cf9800 count:1 mapcount:0 =
mapping:ffff802db5c90780 index:0xffffa02cf3e606f0 compound_mapcount: 0
>>> [13058.366175] flags: 0x2ffffe0000008100(slab|head)
>>> [13058.370781] raw: 2ffffe0000008100 ffff7e80b53b1408 =
ffffa02d730c1c90 ffff802db5c90780
>>> [13058.370787] raw: ffffa02cf3e606f0 0000000000370023 =
00000001ffffffff 0000000000000000
>>> [13058.370789] page dumped because: kasan: bad access detected
>>> [13058.370791]
>>> [13058.370792] Memory state around the buggy address:
>>> [13058.370797]  ffffa02cf3e63e00: fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc fb fb
>>> [13058.370801]  ffffa02cf3e63e80: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
>>> [13058.370805] >ffffa02cf3e63f00: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
>>> [13058.370808]                                                       =
    ^
>>> [13058.370811]  ffffa02cf3e63f80: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
>>> [13058.370815]  ffffa02cf3e64000: fb fb fb fb fb fb fb fb fc fc fc =
fc fc fc fc fc
>>> [13058.370817] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> [13058.370820] Disabling lock debugging due to kernel taint
>>>=20
>>> Here, we directly pass the bfqd to bfq_idle_slice_timer_body func.
>>>=20
>>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
>>> ---
>>> block/bfq-iosched.c | 10 +++++-----
>>> 1 file changed, 5 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index 8c436abfaf14..f470b9daa98b 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -6215,20 +6215,20 @@ static struct bfq_queue *bfq_init_rq(struct =
request *rq)
>>> 	return bfqq;
>>> }
>>>=20
>>> -static void bfq_idle_slice_timer_body(struct bfq_queue *bfqq)
>>> +static void
>>> +bfq_idle_slice_timer_body(struct bfq_data *bfqd, struct bfq_queue =
*bfqq)
>>> {
>>> -	struct bfq_data *bfqd =3D bfqq->bfqd;
>>> 	enum bfqq_expiration reason;
>>> 	unsigned long flags;
>>>=20
>>> 	spin_lock_irqsave(&bfqd->lock, flags);
>>> -	bfq_clear_bfqq_wait_request(bfqq);
>>> -
>>> 	if (bfqq !=3D bfqd->in_service_queue) {
>>> 		spin_unlock_irqrestore(&bfqd->lock, flags);
>>> 		return;
>>> 	}
>>>=20
>>> +	bfq_clear_bfqq_wait_request(bfqq);
>>> +
>>=20
>> Please add a comment on why you (correctly) clear this flag only if =
bfqq is in service.
>>=20
>> For the rest, seems ok to me.
>>=20
>> Thank you very much for spotting and fixing this bug,
>> Paolo
>>=20
> Thanks for your reply.
> Considering that the bfqq may be in race, we should firstly check =
whether bfqq is in service before
> doing something on it.
>=20

The comment you propose is correct, but the correctness issue I raised
is essentially the opposite.  Sorry for not being clear.

Let me put it the other way round: why is it still correct that, if
bfqq is not the queue in service, then that flag is not cleared at all?
IOW, why is it not a problem that that flag remains untouched is bfqq
is not in service?

Thanks,
Paolo

> I will add a comment before 'if (bfqq !=3D bfqd->in_service_queue) {'
>=20
> In addition, the fix tag is missing. I will add it in v2 patch.
>=20
>>> 	if (bfq_bfqq_budget_timeout(bfqq))
>>> 		/*
>>> 		 * Also here the queue can be safely expired
>>> @@ -6273,7 +6273,7 @@ static enum hrtimer_restart =
bfq_idle_slice_timer(struct hrtimer *timer)
>>> 	 * early.
>>> 	 */
>>> 	if (bfqq)
>>> -		bfq_idle_slice_timer_body(bfqq);
>>> +		bfq_idle_slice_timer_body(bfqd, bfqq);
>>>=20
>>> 	return HRTIMER_NORESTART;
>>> }
>>> --=20
>>> 2.19.1
>>>=20
>>>=20
>>=20
>>=20
>> .

