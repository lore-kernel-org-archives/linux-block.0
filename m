Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C791C6783B
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 01:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9AE2081B
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 01:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SbL3AFA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9AE2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLLBok (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:44:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34162 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLBoj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 20:44:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so7533613pgg.1
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 17:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/vcQBZzrOn2KL8P6+nIxJGi1Z8ciCsNEnjlFfJOW0ms=;
        b=SbL3AFA56xFJ28uZ7SgfpWaowdo2y2/fH8Uxg1si7ceOnTa3AKDjZwz0a5FKKazLpL
         PHW9WxBAZZGlmKD1CMyFEQWvIbpcQnpToxCrftl7/G1mA9EA147HOSHWiLQqbLN/nA+H
         ACYC7a+WFwJ9L0rWaFaSrChmfznd0RME3pyQMTXVxNKA7/Aa9+Cm2zQom1jPWuJaNTna
         /eX0wPIj/8o8i8YBYe4BvLZjFFjl/j7yKimrczsmcKkqoAvFiEpVESD4UFt2qmWrb3LO
         GYFKctagiQigDEpgdp51Kuj4JMxmhDjeQAytY0hThnpglTSYiBjh8L8dl0+DzDyCmjh1
         v1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/vcQBZzrOn2KL8P6+nIxJGi1Z8ciCsNEnjlFfJOW0ms=;
        b=AV5BM5fc9zkbXqcV/1huhMvLOYqQE+Qf294EBL4IhcFYFtq+czUDchYXCEPfPvQx/Q
         yw7QoP8JnFZUxhzjbZ17NzTwO5XnWoVlV2ROs3EYDs6Os+aFmFWsYKWgEzej0IH3lKOs
         fhvIsj87cfNJ/5P8DloEEbVpBUX+LtQNKaRtW4fX+ZzOMuc3Ou7F4kC5CLz0VTIiTe35
         UYvnhDfHqx05Eql8ifPJv3uUQzdBfITN5tXid9byRHyM+soeV9wH6anOi7GCP77f0HgV
         fbIJwlSSIa9a60m5Z3h48xSa4PgvX8PNgAu4wwXdjCtio8Akfe9n0WnWwDPr7OizRtT0
         t3jg==
X-Gm-Message-State: AA+aEWa91oatUn9ReidCy4wJAqS1mjfKf789alf2/h5HZBQTr0xFJoPe
        QLPE3eeT6TwBw2oTp4wpNJWZH8jTr/OlDQ==
X-Google-Smtp-Source: AFSGD/W3j7eHXTeh03/i+c/HJpcRnvAQLStbtWTW55UKKfn8P/Ugnipc0n4Iayxt2nIXGfzwXYgtUw==
X-Received: by 2002:a65:6148:: with SMTP id o8mr16559577pgv.451.1544579078065;
        Tue, 11 Dec 2018 17:44:38 -0800 (PST)
Received: from ?IPv6:2600:380:4a49:2b3f:8ddc:cb44:79a:38ad? ([2600:380:4a49:2b3f:8ddc:cb44:79a:38ad])
        by smtp.gmail.com with ESMTPSA id i184sm22201382pfc.41.2018.12.11.17.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 17:44:37 -0800 (PST)
Subject: Re: for-next hangs on test srp/012
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
References: <1544569107.185366.391.camel@acm.org>
 <0688562b-7776-7efe-10dd-caf2a6a4f274@kernel.dk>
 <CACVXFVObwybJ1hmekS_bJ05zrOawoG33MQDVda+W1ATa+SqNCw@mail.gmail.com>
 <20181212002759.GC20445@redhat.com>
 <CACVXFVP_xGwwEr4xs64z69tkA8Wm20VVew9axcJRpqZ_-a3DNA@mail.gmail.com>
 <41d15b87-d32e-9c6d-d68e-03bd5e7b74b0@kernel.dk>
 <05be643a-46b8-c836-11bf-005dbb0df9e4@kernel.dk>
 <72a57d3c-97e0-03d5-e893-f94f441b3357@kernel.dk>
 <20181212014332.GB541@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <12b9306f-3a58-aa8c-18b1-169898ba23be@kernel.dk>
Date:   Tue, 11 Dec 2018 18:44:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212014332.GB541@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/18 6:43 PM, Ming Lei wrote:
> On Tue, Dec 11, 2018 at 06:36:21PM -0700, Jens Axboe wrote:
>> On 12/11/18 6:23 PM, Jens Axboe wrote:
>>> On 12/11/18 6:05 PM, Jens Axboe wrote:
>>>> On 12/11/18 5:38 PM, Ming Lei wrote:
>>>>> On Wed, Dec 12, 2018 at 8:28 AM Mike Snitzer <snitzer@redhat.com> wrote:
>>>>>>
>>>>>> On Tue, Dec 11 2018 at  7:19pm -0500,
>>>>>> Ming Lei <tom.leiming@gmail.com> wrote:
>>>>>>
>>>>>>> On Wed, Dec 12, 2018 at 8:04 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>>>
>>>>>>>> On 12/11/18 3:58 PM, Bart Van Assche wrote:
>>>>>>>>> Hi Jens,
>>>>>>>>>
>>>>>>>>> If I run the following subset of blktests:
>>>>>>>>>
>>>>>>>>>   while :; do ./check -q srp && ./check -q nvmeof-mp; done
>>>>>>>>>
>>>>>>>>> against today's for-next branch (commit dd2bf2df85a7) then after some
>>>>>>>>> time the following hang is reported:
>>>>>>>>>
>>>>>>>>> INFO: task fio:14869 blocked for more than 120 seconds.
>>>>>>>>>       Not tainted 4.20.0-rc6-dbg+ #1
>>>>>>>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>>>> fio             D25272 14869  14195 0x00000000
>>>>>>>>> Call Trace:
>>>>>>>>>  __schedule+0x401/0xe50
>>>>>>>>>  schedule+0x4e/0xd0
>>>>>>>>>  io_schedule+0x21/0x50
>>>>>>>>>  blk_mq_get_tag+0x46d/0x640
>>>>>>>>>  blk_mq_get_request+0x7c0/0xa00
>>>>>>>>>  blk_mq_make_request+0x241/0xa70
>>>>>>>>>  generic_make_request+0x411/0x950
>>>>>>>>>  submit_bio+0x9b/0x250
>>>>>>>>>  blkdev_direct_IO+0x7fb/0x870
>>>>>>>>>  generic_file_direct_write+0x119/0x210
>>>>>>>>>  __generic_file_write_iter+0x11c/0x280
>>>>>>>>>  blkdev_write_iter+0x13c/0x220
>>>>>>>>>  aio_write+0x204/0x310
>>>>>>>>>  io_submit_one+0x9c6/0xe70
>>>>>>>>>  __x64_sys_io_submit+0x115/0x340
>>>>>>>>>  do_syscall_64+0x71/0x210
>>>>>>>>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>>>>>>
>>>>>>>>> When that hang occurs my list-pending-block-requests script does not show
>>>>>>>>> any pending requests:
>>>>>>>>>
>>>>>>>>> # list-pending-block-requests
>>>>>>>>> dm-0
>>>>>>>>> loop0
>>>>>>>>> loop1
>>>>>>>>> loop2
>>>>>>>>> loop3
>>>>>>>>> loop4
>>>>>>>>> loop5
>>>>>>>>> loop6
>>>>>>>>> loop7
>>>>>>>>> nullb0
>>>>>>>>> nullb1
>>>>>>>>> sda
>>>>>>>>> sdb
>>>>>>>>> sdc
>>>>>>>>> sdd
>>>>>>>>> vda
>>>>>>>>> vdb
>>>>>>>>>
>>>>>>>>> Enabling fail_if_no_path mode did not resolve the hang so I don't think
>>>>>>>>> that the root cause is in any of the dm drivers used in this test:
>>>>>>>>>
>>>>>>>>> # dmsetup ls | while read dm rest; do dmsetup message $dm 0 fail_if_no_path; done; dmsetup remove_all; dmsetup table
>>>>>>>>> 360014056e756c6c62300000000000000: 0 65536 multipath 0 1 alua 1 1 service-time 0 1 2 8:16 1 1
>>>>>>>>>
>>>>>>>>> The same test passes against kernel v4.20-rc6.
>>>>>>>>
>>>>>>>> What device is this being run on?
>>>>>>>
>>>>>>> I saw this issue on usb storage too.
>>>>>>>
>>>>>>> Seems it is introduced by commit ea86ea2cdced ("sbitmap: ammortize cost of
>>>>>>> clearing bits"). When the IO hang happens, .cleared is 2, and .busy is 0 on
>>>>>>> the sched_tag's sbitmap queue.
>>>>>>
>>>>>> You saw this running the same tests as Bart?
>>>>>
>>>>> Not the srp test as done by Bart, I just run 'parted' test on usb storage disk,
>>>>> see the attached test script.
>>>>>
>>>>> Mostly it can be triggered in one run, sometimes it needs more.
>>>>
>>>> I'll take a look. The ->cleared doesn't make sense for QD=1, or on
>>>> one word in general. But I'd like to try and understand why it hangs.
>>>>
>>>> Are you using a scheduler?
>>>
>>> OK, I think I see what it is, the shallow is missing the deferred clear.
>>> On top of this, probably worth to check at what depths deferred starts
>>> to make sense. For QD == 1, definitely not. But that should be on top of
>>> the fix.
>>>
>>> Can you try this one?
>>
>> This one should be complete. The former should fix the case, this one
>> just adds the last two cases where we ignored ->cleared. For some of
>> them we'll never hit it since deferred isn't used for that, but I
>> think we're better off with full coverage.
>>
>>
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 2261136ae067..5b3e56d68dab 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -20,6 +20,47 @@
>>  #include <linux/sbitmap.h>
>>  #include <linux/seq_file.h>
>>  
>> +/*
>> + * See if we have deferred clears that we can batch move
>> + */
>> +static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
>> +{
>> +	unsigned long mask, val;
>> +	unsigned long __maybe_unused flags;
>> +	bool ret = false;
>> +
>> +	/* Silence bogus lockdep warning */
>> +#if defined(CONFIG_LOCKDEP)
>> +	local_irq_save(flags);
>> +#endif
>> +	spin_lock(&sb->map[index].swap_lock);
>> +
>> +	if (!sb->map[index].cleared)
>> +		goto out_unlock;
>> +
>> +	/*
>> +	 * First get a stable cleared mask, setting the old mask to 0.
>> +	 */
>> +	do {
>> +		mask = sb->map[index].cleared;
>> +	} while (cmpxchg(&sb->map[index].cleared, mask, 0) != mask);
>> +
>> +	/*
>> +	 * Now clear the masked bits in our free word
>> +	 */
>> +	do {
>> +		val = sb->map[index].word;
>> +	} while (cmpxchg(&sb->map[index].word, val, val & ~mask) != val);
>> +
>> +	ret = true;
>> +out_unlock:
>> +	spin_unlock(&sb->map[index].swap_lock);
>> +#if defined(CONFIG_LOCKDEP)
>> +	local_irq_restore(flags);
>> +#endif
>> +	return ret;
>> +}
>> +
>>  int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>>  		      gfp_t flags, int node)
>>  {
>> @@ -70,6 +111,9 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
>>  	unsigned int bits_per_word = 1U << sb->shift;
>>  	unsigned int i;
>>  
>> +	for (i = 0; i < sb->map_nr; i++)
>> +		sbitmap_deferred_clear(sb, i);
>> +
>>  	sb->depth = depth;
>>  	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
>>  
>> @@ -112,47 +156,6 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
>>  	return nr;
>>  }
>>  
>> -/*
>> - * See if we have deferred clears that we can batch move
>> - */
>> -static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
>> -{
>> -	unsigned long mask, val;
>> -	unsigned long __maybe_unused flags;
>> -	bool ret = false;
>> -
>> -	/* Silence bogus lockdep warning */
>> -#if defined(CONFIG_LOCKDEP)
>> -	local_irq_save(flags);
>> -#endif
>> -	spin_lock(&sb->map[index].swap_lock);
>> -
>> -	if (!sb->map[index].cleared)
>> -		goto out_unlock;
>> -
>> -	/*
>> -	 * First get a stable cleared mask, setting the old mask to 0.
>> -	 */
>> -	do {
>> -		mask = sb->map[index].cleared;
>> -	} while (cmpxchg(&sb->map[index].cleared, mask, 0) != mask);
>> -
>> -	/*
>> -	 * Now clear the masked bits in our free word
>> -	 */
>> -	do {
>> -		val = sb->map[index].word;
>> -	} while (cmpxchg(&sb->map[index].word, val, val & ~mask) != val);
>> -
>> -	ret = true;
>> -out_unlock:
>> -	spin_unlock(&sb->map[index].swap_lock);
>> -#if defined(CONFIG_LOCKDEP)
>> -	local_irq_restore(flags);
>> -#endif
>> -	return ret;
>> -}
>> -
>>  static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
>>  				     unsigned int alloc_hint, bool round_robin)
>>  {
>> @@ -215,6 +218,7 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
>>  	index = SB_NR_TO_INDEX(sb, alloc_hint);
>>  
>>  	for (i = 0; i < sb->map_nr; i++) {
>> +again:
>>  		nr = __sbitmap_get_word(&sb->map[index].word,
>>  					min(sb->map[index].depth, shallow_depth),
>>  					SB_NR_TO_BIT(sb, alloc_hint), true);
>> @@ -223,6 +227,9 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
>>  			break;
>>  		}
>>  
>> +		if (sbitmap_deferred_clear(sb, index))
>> +			goto again;
>> +
>>  		/* Jump to next index. */
>>  		index++;
>>  		alloc_hint = index << sb->shift;
>> @@ -242,7 +249,7 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb)
>>  	unsigned int i;
>>  
>>  	for (i = 0; i < sb->map_nr; i++) {
>> -		if (sb->map[i].word)
>> +		if (sb->map[i].word & ~sb->map[i].cleared)
>>  			return true;
>>  	}
>>  	return false;
>> @@ -255,9 +262,10 @@ bool sbitmap_any_bit_clear(const struct sbitmap *sb)
>>  
>>  	for (i = 0; i < sb->map_nr; i++) {
>>  		const struct sbitmap_word *word = &sb->map[i];
>> +		unsigned long mask = word->word & ~word->cleared;
>>  		unsigned long ret;
>>  
>> -		ret = find_first_zero_bit(&word->word, word->depth);
>> +		ret = find_first_zero_bit(&mask, word->depth);
>>  		if (ret < word->depth)
>>  			return true;
>>  	}
> 
> This one works too:
> 
> Tested-by: Ming Lei <ming.lei@redhat.com>

Awesome, thanks Ming!

-- 
Jens Axboe

