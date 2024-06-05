Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9114B093
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580889; cv=none; b=MUy0Kj2z5KLtOXiWukejtTaT6N93WY7FGJc/zfb5Ulvvm8i4rMtWWTLuWIBShc9wYYl0+mcpWmzYiPfrHVgN/nWmQCxAoYPem/QI0lFi2oCp1tX1qkdmKKPftFf436wvRrP/PPFZxgHu8fVV8G3JUs+6ckykuH3v8CyfK5GNSus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580889; c=relaxed/simple;
	bh=C4iwgHy0Vtpi0Ntz+kAPqXOSt3BXAywIVancJW3S7TA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgoA8aGimVjJbxkRkZ2cSG9jWDqGsPKpvsDL68utVBcRwU6mE8XCG0xWfgizHO/xxIjZu+kyxD81XqpIAxKR9s+hx6guZQjRkBy29ytjN8VugTu54RhXKWFKzsfQusx7vZCcsXBQxx2pzzzV6FFuCg1RGwy+GND0ZmhU8PlYKh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWLWlqAi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWLWlqAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717580886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opY4p+BpYUBWLdwIooIw98BXTUX1WcY1hsxBx/R5iBM=;
	b=iWLWlqAi/eA8o7da24suwonh1ZDFp0AecEAr0mKYUvpyyHSeGbQKH0FTmFZujNHmYTvJH4
	++1urh5gaX5DrjkwqGlEbcsoAjX1r/FMs4393k+1QTKAgJQEuxy33sGFLhUwmcc8KWqh0M
	RgQbxhFdK0/Dwi0jPWgdSc6pRUz/HjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-4X7cLI-bOh-8HDmhpp1D3Q-1; Wed, 05 Jun 2024 05:48:03 -0400
X-MC-Unique: 4X7cLI-bOh-8HDmhpp1D3Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F6BF101A520;
	Wed,  5 Jun 2024 09:48:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.43])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DFE9E492BF6;
	Wed,  5 Jun 2024 09:47:57 +0000 (UTC)
Date: Wed, 5 Jun 2024 17:47:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Changhui Zhong <czhong@redhat.com>
Cc: Li Nan <linan666@huaweicloud.com>, axboe@kernel.dk,
	ZiyangZhang@linux.alibaba.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] ublk_drv: fix NULL pointer dereference in
 ublk_ctrl_start_recovery()
Message-ID: <ZmA0Se+t/LZihBKp@fedora>
References: <20240529095313.2568595-1-linan666@huaweicloud.com>
 <Zl0QpCbYVHIkKa/H@fedora>
 <225f4c8e-0e2c-8f4b-f87d-69f4677af572@huaweicloud.com>
 <CAGVVp+XD5MbYOWL4pbLMxXL0yNKO5NJ84--=KVnW6w5-GF7Drw@mail.gmail.com>
 <918f128b-f752-2d66-ca60-7d9c711ed928@huaweicloud.com>
 <CAGVVp+V6XGmE_LyOYM3z8cEOzkvQZy=2Fnr5V3G4+DchxAz3Qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGVVp+V6XGmE_LyOYM3z8cEOzkvQZy=2Fnr5V3G4+DchxAz3Qw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Wed, Jun 05, 2024 at 03:20:34PM +0800, Changhui Zhong wrote:
> On Wed, Jun 5, 2024 at 9:41 AM Li Nan <linan666@huaweicloud.com> wrote:
> >
> >
> >
> > 在 2024/6/4 9:32, Changhui Zhong 写道:
> > > On Mon, Jun 3, 2024 at 10:20 AM Li Nan <linan666@huaweicloud.com> wrote:
> > >>
> > >>
> > >>
> > >> 在 2024/6/3 8:39, Ming Lei 写道:
> > >>
> > >> [...]
> > >>
> > >>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > >>>> index 4e159948c912..99b621b2d40f 100644
> > >>>> --- a/drivers/block/ublk_drv.c
> > >>>> +++ b/drivers/block/ublk_drv.c
> > >>>> @@ -2630,7 +2630,8 @@ static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
> > >>>>    {
> > >>>>       int i;
> > >>>>
> > >>>> -    WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
> > >>>> +    if (WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq))))
> > >>>> +            return;
> > >>>
> > >>> Yeah, it is one bug. However, it could be addressed by adding the check in
> > >>> ublk_ctrl_start_recovery() and return immediately in case of NULL ubq->ubq_daemon,
> > >>> what do you think about this way?
> > >>>
> > >>
> > >> Check ub->nr_queues_ready seems better. How about:
> > >>
> > >> @@ -2662,6 +2662,8 @@ static int ublk_ctrl_start_recovery(struct
> > >> ublk_device *ub,
> > >>           mutex_lock(&ub->mutex);
> > >>           if (!ublk_can_use_recovery(ub))
> > >>                   goto out_unlock;
> > >> +       if (!ub->nr_queues_ready)
> > >> +               goto out_unlock;
> > >>           /*
> > >>            * START_RECOVERY is only allowd after:
> > >>            *
> > >>
> > >>>
> > >>> Thanks,
> > >>> Ming
> > >>
> > >> --
> > >> Thanks,
> > >> Nan
> > >>
> > >
> > >
> > > Hi,Nan
> > >
> > > After applying your new patch, I did not trigger "NULL pointer
> > > dereference" and "Warning",
> > > but hit task hung "Call Trace" info, please check
> > >
> > > [13617.812306] running generic/004
> > > [13622.293674] blk_print_req_error: 91 callbacks suppressed
> > > [13622.293681] I/O error, dev ublkb4, sector 233256 op 0x1:(WRITE)
> > > flags 0x8800 phys_seg 1 prio class 0
> > > [13622.308145] I/O error, dev ublkb4, sector 233256 op 0x0:(READ)
> > > flags 0x0 phys_seg 2 prio class 0
> > > [13622.316923] I/O error, dev ublkb4, sector 233264 op 0x1:(WRITE)
> > > flags 0x8800 phys_seg 1 prio class 0
> > > [13622.326048] I/O error, dev ublkb4, sector 233272 op 0x0:(READ)
> > > flags 0x0 phys_seg 1 prio class 0
> > > [13622.334828] I/O error, dev ublkb4, sector 233272 op 0x1:(WRITE)
> > > flags 0x8800 phys_seg 1 prio class 0
> > > [13622.343954] I/O error, dev ublkb4, sector 233312 op 0x0:(READ)
> > > flags 0x0 phys_seg 1 prio class 0
> > > [13622.352733] I/O error, dev ublkb4, sector 233008 op 0x0:(READ)
> > > flags 0x0 phys_seg 1 prio class 0
> > > [13622.361514] I/O error, dev ublkb4, sector 233112 op 0x0:(READ)
> > > flags 0x0 phys_seg 1 prio class 0
> > > [13622.370292] I/O error, dev ublkb4, sector 233192 op 0x1:(WRITE)
> > > flags 0x8800 phys_seg 1 prio class 0
> > > [13622.379419] I/O error, dev ublkb4, sector 233120 op 0x0:(READ)
> > > flags 0x0 phys_seg 1 prio class 0
> > > [13641.069695] INFO: task fio:174413 blocked for more than 122 seconds.
> > > [13641.076061]       Not tainted 6.10.0-rc1+ #1
> > > [13641.080338] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [13641.088164] task:fio             state:D stack:0     pid:174413
> > > tgid:174413 ppid:174386 flags:0x00004002
> > > [13641.088168] Call Trace:
> > > [13641.088170]  <TASK>
> > > [13641.088171]  __schedule+0x221/0x670
> > > [13641.088177]  schedule+0x23/0xa0
> > > [13641.088179]  io_schedule+0x42/0x70
> > > [13641.088181]  blk_mq_get_tag+0x118/0x2b0
> > > [13641.088185]  ? gup_fast_pgd_range+0x280/0x370
> > > [13641.088188]  ? __pfx_autoremove_wake_function+0x10/0x10
> > > [13641.088192]  __blk_mq_alloc_requests+0x194/0x3a0
> > > [13641.088194]  blk_mq_submit_bio+0x241/0x6c0
> > > [13641.088196]  __submit_bio+0x8a/0x1f0
> > > [13641.088199]  submit_bio_noacct_nocheck+0x168/0x250
> > > [13641.088201]  ? submit_bio_noacct+0x45/0x560
> > > [13641.088203]  __blkdev_direct_IO_async+0x167/0x1a0
> > > [13641.088206]  blkdev_write_iter+0x1c8/0x270
> > > [13641.088208]  aio_write+0x11c/0x240
> > > [13641.088212]  ? __rq_qos_issue+0x21/0x40
> > > [13641.088214]  ? blk_mq_start_request+0x34/0x1a0
> > > [13641.088216]  ? io_submit_one+0x68/0x380
> > > [13641.088218]  ? kmem_cache_alloc_noprof+0x4e/0x320
> > > [13641.088221]  ? fget+0x7c/0xc0
> > > [13641.088224]  ? io_submit_one+0xde/0x380
> > > [13641.088226]  io_submit_one+0xde/0x380
> > > [13641.088228]  __x64_sys_io_submit+0x80/0x160
> > > [13641.088229]  do_syscall_64+0x79/0x150
> > > [13641.088233]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > > [13641.088237]  ? do_io_getevents+0x8b/0xe0
> > > [13641.088238]  ? syscall_exit_work+0xf3/0x120
> > > [13641.088241]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > > [13641.088243]  ? do_syscall_64+0x85/0x150
> > > [13641.088245]  ? do_syscall_64+0x85/0x150
> > > [13641.088247]  ? blk_mq_flush_plug_list.part.0+0x108/0x160
> > > [13641.088249]  ? rseq_get_rseq_cs+0x1d/0x220
> > > [13641.088252]  ? rseq_ip_fixup+0x6d/0x1d0
> > > [13641.088254]  ? blk_finish_plug+0x24/0x40
> > > [13641.088256]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > > [13641.088258]  ? do_syscall_64+0x85/0x150
> > > [13641.088260]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > > [13641.088262]  ? do_syscall_64+0x85/0x150
> > > [13641.088264]  ? syscall_exit_to_user_mode+0x6c/0x1f0
> > > [13641.088266]  ? do_syscall_64+0x85/0x150
> > > [13641.088268]  ? do_syscall_64+0x85/0x150
> > > [13641.088270]  ? do_syscall_64+0x85/0x150
> > > [13641.088272]  ? clear_bhb_loop+0x45/0xa0
> > > [13641.088275]  ? clear_bhb_loop+0x45/0xa0
> > > [13641.088277]  ? clear_bhb_loop+0x45/0xa0
> > > [13641.088279]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > [13641.088281] RIP: 0033:0x7ff92150713d
> > > [13641.088283] RSP: 002b:00007ffca1ef81f8 EFLAGS: 00000246 ORIG_RAX:
> > > 00000000000000d1
> > > [13641.088285] RAX: ffffffffffffffda RBX: 00007ff9217e2f70 RCX: 00007ff92150713d
> > > [13641.088286] RDX: 000055863b694fe0 RSI: 0000000000000010 RDI: 00007ff92164d000
> > > [13641.088287] RBP: 00007ff92164d000 R08: 00007ff91936d000 R09: 0000000000000180
> > > [13641.088288] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000010
> > > [13641.088289] R13: 0000000000000000 R14: 000055863b694fe0 R15: 000055863b6970c0
> > > [13641.088291]  </TASK>
> > >
> > > Thanks，
> > > Changhui
> > >
> >
> > After applying the previous patch, will the test environment continue to
> > execute test cases after WARN?
> 
> a few days ago，test with the previous patch, the test environment
> continued to execute test cases after WARN,
> and I terminated the test when I observed a WARN，so I did not observe
> the subsequent situation.
> 
> > I am not sure whether this issue has always
> > existed but was not tested becasue of WARN, or whether the new patch
> > introduced it.
> 
> today， I re-test previous patch， and let it run for a long time，I
> observed WARN and task hung，
> looks this issue already existed and not introduced by new patch.

Hi Changhui,

The hang is actually expected because recovery fails.

Please pull the latest ublksrv and check if the issue can still be
reproduced:

https://github.com/ublk-org/ublksrv

BTW, one ublksrv segfault and two test cleanup issues are fixed.

Thanks,
Ming

