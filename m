Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D298C04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 04:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2226320839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 04:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2226320839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeLLE2Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 23:28:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeLLE2Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 23:28:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BDCE356E7;
        Wed, 12 Dec 2018 04:28:24 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 621395C20D;
        Wed, 12 Dec 2018 04:28:14 +0000 (UTC)
Date:   Wed, 12 Dec 2018 12:28:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: for-next hangs on test srp/012
Message-ID: <20181212042809.GE541@ming.t460p>
References: <CACVXFVObwybJ1hmekS_bJ05zrOawoG33MQDVda+W1ATa+SqNCw@mail.gmail.com>
 <20181212002759.GC20445@redhat.com>
 <CACVXFVP_xGwwEr4xs64z69tkA8Wm20VVew9axcJRpqZ_-a3DNA@mail.gmail.com>
 <41d15b87-d32e-9c6d-d68e-03bd5e7b74b0@kernel.dk>
 <05be643a-46b8-c836-11bf-005dbb0df9e4@kernel.dk>
 <72a57d3c-97e0-03d5-e893-f94f441b3357@kernel.dk>
 <20181212014332.GB541@ming.t460p>
 <20181212014909.GC541@ming.t460p>
 <20181212020353.GD541@ming.t460p>
 <6ecdcb9f-90e8-9cf1-3b08-20a68cd1fad9@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ecdcb9f-90e8-9cf1-3b08-20a68cd1fad9@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 12 Dec 2018 04:28:24 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11, 2018 at 07:25:21PM -0700, Jens Axboe wrote:
> On 12/11/18 7:03 PM, Ming Lei wrote:
> > On Wed, Dec 12, 2018 at 09:49:09AM +0800, Ming Lei wrote:
> >> On Wed, Dec 12, 2018 at 09:43:32AM +0800, Ming Lei wrote:
> >>> On Tue, Dec 11, 2018 at 06:36:21PM -0700, Jens Axboe wrote:
> >>>> On 12/11/18 6:23 PM, Jens Axboe wrote:
> >>>>> On 12/11/18 6:05 PM, Jens Axboe wrote:
> >>>>>> On 12/11/18 5:38 PM, Ming Lei wrote:
> >>>>>>> On Wed, Dec 12, 2018 at 8:28 AM Mike Snitzer <snitzer@redhat.com> wrote:
> >>>>>>>>
> >>>>>>>> On Tue, Dec 11 2018 at  7:19pm -0500,
> >>>>>>>> Ming Lei <tom.leiming@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>>> On Wed, Dec 12, 2018 at 8:04 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On 12/11/18 3:58 PM, Bart Van Assche wrote:
> >>>>>>>>>>> Hi Jens,
> >>>>>>>>>>>
> >>>>>>>>>>> If I run the following subset of blktests:
> >>>>>>>>>>>
> >>>>>>>>>>>   while :; do ./check -q srp && ./check -q nvmeof-mp; done
> >>>>>>>>>>>
> >>>>>>>>>>> against today's for-next branch (commit dd2bf2df85a7) then after some
> >>>>>>>>>>> time the following hang is reported:
> >>>>>>>>>>>
> >>>>>>>>>>> INFO: task fio:14869 blocked for more than 120 seconds.
> >>>>>>>>>>>       Not tainted 4.20.0-rc6-dbg+ #1
> >>>>>>>>>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>>>>>>>>>> fio             D25272 14869  14195 0x00000000
> >>>>>>>>>>> Call Trace:
> >>>>>>>>>>>  __schedule+0x401/0xe50
> >>>>>>>>>>>  schedule+0x4e/0xd0
> >>>>>>>>>>>  io_schedule+0x21/0x50
> >>>>>>>>>>>  blk_mq_get_tag+0x46d/0x640
> >>>>>>>>>>>  blk_mq_get_request+0x7c0/0xa00
> >>>>>>>>>>>  blk_mq_make_request+0x241/0xa70
> >>>>>>>>>>>  generic_make_request+0x411/0x950
> >>>>>>>>>>>  submit_bio+0x9b/0x250
> >>>>>>>>>>>  blkdev_direct_IO+0x7fb/0x870
> >>>>>>>>>>>  generic_file_direct_write+0x119/0x210
> >>>>>>>>>>>  __generic_file_write_iter+0x11c/0x280
> >>>>>>>>>>>  blkdev_write_iter+0x13c/0x220
> >>>>>>>>>>>  aio_write+0x204/0x310
> >>>>>>>>>>>  io_submit_one+0x9c6/0xe70
> >>>>>>>>>>>  __x64_sys_io_submit+0x115/0x340
> >>>>>>>>>>>  do_syscall_64+0x71/0x210
> >>>>>>>>>>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >>>>>>>>>>>
> >>>>>>>>>>> When that hang occurs my list-pending-block-requests script does not show
> >>>>>>>>>>> any pending requests:
> >>>>>>>>>>>
> >>>>>>>>>>> # list-pending-block-requests
> >>>>>>>>>>> dm-0
> >>>>>>>>>>> loop0
> >>>>>>>>>>> loop1
> >>>>>>>>>>> loop2
> >>>>>>>>>>> loop3
> >>>>>>>>>>> loop4
> >>>>>>>>>>> loop5
> >>>>>>>>>>> loop6
> >>>>>>>>>>> loop7
> >>>>>>>>>>> nullb0
> >>>>>>>>>>> nullb1
> >>>>>>>>>>> sda
> >>>>>>>>>>> sdb
> >>>>>>>>>>> sdc
> >>>>>>>>>>> sdd
> >>>>>>>>>>> vda
> >>>>>>>>>>> vdb
> >>>>>>>>>>>
> >>>>>>>>>>> Enabling fail_if_no_path mode did not resolve the hang so I don't think
> >>>>>>>>>>> that the root cause is in any of the dm drivers used in this test:
> >>>>>>>>>>>
> >>>>>>>>>>> # dmsetup ls | while read dm rest; do dmsetup message $dm 0 fail_if_no_path; done; dmsetup remove_all; dmsetup table
> >>>>>>>>>>> 360014056e756c6c62300000000000000: 0 65536 multipath 0 1 alua 1 1 service-time 0 1 2 8:16 1 1
> >>>>>>>>>>>
> >>>>>>>>>>> The same test passes against kernel v4.20-rc6.
> >>>>>>>>>>
> >>>>>>>>>> What device is this being run on?
> >>>>>>>>>
> >>>>>>>>> I saw this issue on usb storage too.
> >>>>>>>>>
> >>>>>>>>> Seems it is introduced by commit ea86ea2cdced ("sbitmap: ammortize cost of
> >>>>>>>>> clearing bits"). When the IO hang happens, .cleared is 2, and .busy is 0 on
> >>>>>>>>> the sched_tag's sbitmap queue.
> >>>>>>>>
> >>>>>>>> You saw this running the same tests as Bart?
> >>>>>>>
> >>>>>>> Not the srp test as done by Bart, I just run 'parted' test on usb storage disk,
> >>>>>>> see the attached test script.
> >>>>>>>
> >>>>>>> Mostly it can be triggered in one run, sometimes it needs more.
> >>>>>>
> >>>>>> I'll take a look. The ->cleared doesn't make sense for QD=1, or on
> >>>>>> one word in general. But I'd like to try and understand why it hangs.
> >>>>>>
> >>>>>> Are you using a scheduler?
> >>>>>
> >>>>> OK, I think I see what it is, the shallow is missing the deferred clear.
> >>>>> On top of this, probably worth to check at what depths deferred starts
> >>>>> to make sense. For QD == 1, definitely not. But that should be on top of
> >>>>> the fix.
> >>>>>
> >>>>> Can you try this one?
> >>>>
> >>>> This one should be complete. The former should fix the case, this one
> >>>> just adds the last two cases where we ignored ->cleared. For some of
> >>>> them we'll never hit it since deferred isn't used for that, but I
> >>>> think we're better off with full coverage.
> >>>>
> >>>>
> >>>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> >>>> index 2261136ae067..5b3e56d68dab 100644
> >>>> --- a/lib/sbitmap.c
> >>>> +++ b/lib/sbitmap.c
> >>>> @@ -20,6 +20,47 @@
> >>>>  #include <linux/sbitmap.h>
> >>>>  #include <linux/seq_file.h>
> >>>>  
> >>>> +/*
> >>>> + * See if we have deferred clears that we can batch move
> >>>> + */
> >>>> +static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
> >>>> +{
> >>>> +	unsigned long mask, val;
> >>>> +	unsigned long __maybe_unused flags;
> >>>> +	bool ret = false;
> >>>> +
> >>>> +	/* Silence bogus lockdep warning */
> >>>> +#if defined(CONFIG_LOCKDEP)
> >>>> +	local_irq_save(flags);
> >>>> +#endif
> >>>> +	spin_lock(&sb->map[index].swap_lock);
> >>>> +
> >>>> +	if (!sb->map[index].cleared)
> >>>> +		goto out_unlock;
> >>>> +
> >>>> +	/*
> >>>> +	 * First get a stable cleared mask, setting the old mask to 0.
> >>>> +	 */
> >>>> +	do {
> >>>> +		mask = sb->map[index].cleared;
> >>>> +	} while (cmpxchg(&sb->map[index].cleared, mask, 0) != mask);
> >>>> +
> >>>> +	/*
> >>>> +	 * Now clear the masked bits in our free word
> >>>> +	 */
> >>>> +	do {
> >>>> +		val = sb->map[index].word;
> >>>> +	} while (cmpxchg(&sb->map[index].word, val, val & ~mask) != val);
> >>>> +
> >>>> +	ret = true;
> >>>> +out_unlock:
> >>>> +	spin_unlock(&sb->map[index].swap_lock);
> >>>> +#if defined(CONFIG_LOCKDEP)
> >>>> +	local_irq_restore(flags);
> >>>> +#endif
> >>>> +	return ret;
> >>>> +}
> >>>> +
> >>>>  int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
> >>>>  		      gfp_t flags, int node)
> >>>>  {
> >>>> @@ -70,6 +111,9 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
> >>>>  	unsigned int bits_per_word = 1U << sb->shift;
> >>>>  	unsigned int i;
> >>>>  
> >>>> +	for (i = 0; i < sb->map_nr; i++)
> >>>> +		sbitmap_deferred_clear(sb, i);
> >>>> +
> >>>>  	sb->depth = depth;
> >>>>  	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
> >>>>  
> >>>> @@ -112,47 +156,6 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
> >>>>  	return nr;
> >>>>  }
> >>>>  
> >>>> -/*
> >>>> - * See if we have deferred clears that we can batch move
> >>>> - */
> >>>> -static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
> >>>> -{
> >>>> -	unsigned long mask, val;
> >>>> -	unsigned long __maybe_unused flags;
> >>>> -	bool ret = false;
> >>>> -
> >>>> -	/* Silence bogus lockdep warning */
> >>>> -#if defined(CONFIG_LOCKDEP)
> >>>> -	local_irq_save(flags);
> >>>> -#endif
> >>>> -	spin_lock(&sb->map[index].swap_lock);
> >>>> -
> >>>> -	if (!sb->map[index].cleared)
> >>>> -		goto out_unlock;
> >>>> -
> >>>> -	/*
> >>>> -	 * First get a stable cleared mask, setting the old mask to 0.
> >>>> -	 */
> >>>> -	do {
> >>>> -		mask = sb->map[index].cleared;
> >>>> -	} while (cmpxchg(&sb->map[index].cleared, mask, 0) != mask);
> >>>> -
> >>>> -	/*
> >>>> -	 * Now clear the masked bits in our free word
> >>>> -	 */
> >>>> -	do {
> >>>> -		val = sb->map[index].word;
> >>>> -	} while (cmpxchg(&sb->map[index].word, val, val & ~mask) != val);
> >>>> -
> >>>> -	ret = true;
> >>>> -out_unlock:
> >>>> -	spin_unlock(&sb->map[index].swap_lock);
> >>>> -#if defined(CONFIG_LOCKDEP)
> >>>> -	local_irq_restore(flags);
> >>>> -#endif
> >>>> -	return ret;
> >>>> -}
> >>>> -
> >>>>  static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
> >>>>  				     unsigned int alloc_hint, bool round_robin)
> >>>>  {
> >>>> @@ -215,6 +218,7 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
> >>>>  	index = SB_NR_TO_INDEX(sb, alloc_hint);
> >>>>  
> >>>>  	for (i = 0; i < sb->map_nr; i++) {
> >>>> +again:
> >>>>  		nr = __sbitmap_get_word(&sb->map[index].word,
> >>>>  					min(sb->map[index].depth, shallow_depth),
> >>>>  					SB_NR_TO_BIT(sb, alloc_hint), true);
> >>>> @@ -223,6 +227,9 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
> >>>>  			break;
> >>>>  		}
> >>>>  
> >>>> +		if (sbitmap_deferred_clear(sb, index))
> >>>> +			goto again;
> >>>> +
> >>>>  		/* Jump to next index. */
> >>>>  		index++;
> >>>>  		alloc_hint = index << sb->shift;
> >>>> @@ -242,7 +249,7 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb)
> >>>>  	unsigned int i;
> >>>>  
> >>>>  	for (i = 0; i < sb->map_nr; i++) {
> >>>> -		if (sb->map[i].word)
> >>>> +		if (sb->map[i].word & ~sb->map[i].cleared)
> >>>>  			return true;
> >>>>  	}
> >>>>  	return false;
> >>>> @@ -255,9 +262,10 @@ bool sbitmap_any_bit_clear(const struct sbitmap *sb)
> >>>>  
> >>>>  	for (i = 0; i < sb->map_nr; i++) {
> >>>>  		const struct sbitmap_word *word = &sb->map[i];
> >>>> +		unsigned long mask = word->word & ~word->cleared;
> >>>>  		unsigned long ret;
> >>>>  
> >>>> -		ret = find_first_zero_bit(&word->word, word->depth);
> >>>> +		ret = find_first_zero_bit(&mask, word->depth);
> >>>>  		if (ret < word->depth)
> >>>>  			return true;
> >>>>  	}
> >>>
> >>> This one works too:
> >>>
> >>> Tested-by: Ming Lei <ming.lei@redhat.com>
> >>
> >> Please hold on, just found this issue is triggered again after the 4th
> >> run,
> >>
> >> [  135.588599] ================start test sanity/004================
> >> [  136.864175] scsi host14: scsi_debug: version 0188 [20180128]
> >>                  dev_size_mb=1024, opts=0x0, submit_queues=1, statistics=0
> >> [  136.873018] scsi 14:0:0:0: Direct-Access     Linux    scsi_debug       0188 PQ: 0 ANSI: 7
> >> [  136.874282] sd 14:0:0:0: Power-on or device reset occurred
> >> [  136.877196] sd 14:0:0:0: [sde] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
> >> [  136.879284] sd 14:0:0:0: [sde] Write Protect is off
> >> [  136.879892] sd 14:0:0:0: [sde] Mode Sense: 73 00 10 08
> >> [  136.882643] sd 14:0:0:0: [sde] Write cache: enabled, read cache: enabled, supports DPO and FUA
> >> [  136.908305] sd 14:0:0:0: [sde] Attached SCSI disk
> >> [  139.465844]  sdd:
> >> [  139.754360]  sdd:
> >> [  143.650074] hpet1: lost 765 rtc interrupts
> >> [  145.078137]  sdd:
> >> [  145.699220]  sdd:
> >> [  146.693532]  sdd:
> >> [  147.557814]  sdd:
> >> [  148.742290]  sdd:
> >> [  149.429425]  sdd:
> >> [  149.944095]  sdd: sdd1
> >> [  152.631125]  sdd:
> >> [  184.209792] usb 1-1: reset high-speed USB device number 2 using ehci-pci
> >> [  184.342465] sd 13:0:0:0: [sdd] tag#0 FAILED Result: hostbyte=DID_TIME_OUT driverbyte=DRIVER_OK
> >> [  184.344021] sd 13:0:0:0: [sdd] tag#0 CDB: Read(10) 28 00 05 ff fc 20 00 00 e0 00
> >> [  184.345109] print_req_error: I/O error, dev sdd, sector 100662304 flags 84000
> >> [  184.347241] systemd-journald[366]: Sent WATCHDOG=1 notification.
> >> [  185.872632]  sdd: sdd1 sdd2
> >> [  242.446969] hpet1: lost 673 rtc interrupts
> >> [  252.701145] hpet1: lost 655 rtc interrupts
> >> [  257.814148] hpet1: lost 300 rtc interrupts
> >> [  278.315651] hpet1: lost 1311 rtc interrupts
> >> [  278.317589] systemd-journald[366]: Sent WATCHDOG=1 notification.
> >> [  336.228781] hpet1: lost 948 rtc interrupts
> >> [  342.623253] hpet1: lost 409 rtc interrupts
> >> [  344.205027] hpet1: lost 14 rtc interrupts
> >> [  344.457622] hpet1: lost 15 rtc interrupts
> >> [  344.584608] hpet1: lost 7 rtc interrupts
> >> [  344.706382] hpet1: lost 7 rtc interrupts
> >> [  345.012803] hpet1: lost 19 rtc interrupts
> >> [  345.109177] hpet1: lost 5 rtc interrupts
> >> [  345.353934] hpet1: lost 14 rtc interrupts
> >> [  345.477123] hpet1: lost 7 rtc interrupts
> >> [  345.530757] hpet1: lost 3 rtc interrupts
> >> [  348.328566] hpet_rtc_timer_reinit: 2 callbacks suppressed
> >> [  348.328567] hpet1: lost 162 rtc interrupts
> >> [  348.506049] hpet1: lost 10 rtc interrupts
> >> [  350.461310] hpet1: lost 124 rtc interrupts
> >> [  351.307411] hpet1: lost 50 rtc interrupts
> >> [  351.401932] hpet1: lost 6 rtc interrupts
> >> [  351.564204] hpet1: lost 9 rtc interrupts
> >> [  351.648124] hpet1: lost 4 rtc interrupts
> >> [  351.828972] hpet1: lost 11 rtc interrupts
> >> [  353.043051] hpet1: lost 76 rtc interrupts
> >> [  353.705926] hpet1: lost 38 rtc interrupts
> >> [  353.867703] hpet1: lost 9 rtc interrupts
> >> [  354.030183] hpet1: lost 10 rtc interrupts
> >> [  354.071030] hpet1: lost 1 rtc interrupts
> >> [  354.194600] hpet1: lost 7 rtc interrupts
> >> [  354.316562] hpet1: lost 7 rtc interrupts
> >> [  355.167894] hpet1: lost 1376 rtc interrupts
> >> [  364.089267] hpet1: lost 153 rtc interrupts
> >> [  364.342905] systemd-journald[366]: Sent WATCHDOG=1 notification.
> >> [  366.869943] hpet1: lost 177 rtc interrupts
> >> [  369.937806] INFO: task parted:3645 blocked for more than 120 seconds.
> >> [  369.938941]       Not tainted 4.20.0-rc6-00284-g906c801e5248 #498
> >> [  369.939797] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> [  369.940768] parted          D    0  3645   3239 0x00000000
> >> [  369.941500] Call Trace:
> >> [  369.941874]  ? __schedule+0x6d9/0x74c
> >> [  369.942392]  ? wbt_done+0x5e/0x5e
> >> [  369.942864]  ? wbt_cleanup_cb+0x16/0x16
> >> [  369.943404]  ? wbt_done+0x5e/0x5e
> >> [  369.943874]  schedule+0x67/0x78
> >> [  369.944298]  io_schedule+0x12/0x33
> >> [  369.944771]  rq_qos_wait+0xb5/0x119
> >> [  369.945193]  ? karma_partition+0x1c2/0x1c2
> >> [  369.945691]  ? wbt_cleanup_cb+0x16/0x16
> >> [  369.946151]  wbt_wait+0x85/0xb6
> >> [  369.946540]  __rq_qos_throttle+0x23/0x2f
> >> [  369.947014]  blk_mq_make_request+0xe6/0x40a
> >> [  369.947518]  generic_make_request+0x192/0x2fe
> >> [  369.948042]  ? submit_bio+0x103/0x11f
> >> [  369.948486]  ? __radix_tree_lookup+0x35/0xb5
> >> [  369.949011]  submit_bio+0x103/0x11f
> >> [  369.949436]  ? blkg_lookup_slowpath+0x25/0x44
> >> [  369.949962]  submit_bio_wait+0x53/0x7f
> >> [  369.950469]  blkdev_issue_flush+0x8a/0xae
> >> [  369.951032]  blkdev_fsync+0x2f/0x3a
> >> [  369.951502]  do_fsync+0x2e/0x47
> >> [  369.951887]  __x64_sys_fsync+0x10/0x13
> >> [  369.952374]  do_syscall_64+0x89/0x149
> >> [  369.952819]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >> [  369.953492] RIP: 0033:0x7f95a1e729d4
> >> [  369.953996] Code: Bad RIP value.
> >> [  369.954456] RSP: 002b:00007ffdb570dd48 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
> >> [  369.955506] RAX: ffffffffffffffda RBX: 000055c2139c6be0 RCX: 00007f95a1e729d4
> >> [  369.956389] RDX: 0000000000000001 RSI: 0000000000001261 RDI: 0000000000000004
> >> [  369.957325] RBP: 0000000000000002 R08: 0000000000000000 R09: 000055c2139c6ce0
> >> [  369.958199] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c2139c0380
> >> [  369.959143] R13: 0000000000000004 R14: 0000000000000100 R15: 0000000000000008
> >> [  375.962995] ================end test sanity/004: (HANG, -1)================
> > 
> > This one may be another one, as I just observed that the wbt queue(RWQ_BG)'s inflight
> > becomes -1 after the hang is triggered.
> 
> I think it is - can you try and revert:
> 
> commit b6c7b58f5fcc2386bddf9852011c42c1d2b83979
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Tue Dec 4 12:59:03 2018 -0500
> 
>     block: convert wbt_wait() to use rq_qos_wait()
> 
> and see if that helps?

This one is a linus tree issue, just a bit harder to reproduce,
and actually not captured by my test robot, but has been triggered
several times when I run the parted test manually.

There is such report in RH internal test too.

thanks,
Ming
