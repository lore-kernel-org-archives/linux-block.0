Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE836C67839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 01:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B582086D
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 01:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CQ3MCOPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7B582086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLLBXh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 20:23:37 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:42469 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLBXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 20:23:36 -0500
Received: by mail-pl1-f173.google.com with SMTP id y1so7766469plp.9
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 17:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WWQAABHbhXWKNoLY+ZjzGvRN9xnDaQRJ2y9jLyQY2K8=;
        b=CQ3MCOPVDaFScEaRErxL7bQF3Qda8wXX5ZpuidyLO/7zdpC3GXkW54ZjL20QpTSAbN
         DvkOpd7iM8WWQv+D9Ecy3PBBISF0asvoNLvnl8oK4X9agiq6DmCeAFs0C7UyXCJXfi/k
         Bomw5N7PJgvbEagotFh+Y0Syc8uVTxm1Z9IRoDly0TNXcLcL9eCDQZ8WuHze6T2SiV2R
         fbssh8HOVyfuHORg1YBrTi03s0ThDyl6w72TTe0IkvkwHTizwAW8wHuj3S75jLmQdEoC
         UmCltR/JuoJ45RHxXGRAUHm8axkBn7JnyaQhrA6jGg8zzptUoJmbZxBLiyNj/ae+dTZL
         ZcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WWQAABHbhXWKNoLY+ZjzGvRN9xnDaQRJ2y9jLyQY2K8=;
        b=A8DhxgSu9voa0leBcNwCsG4G2md1ruVN9wnBaufmuMJaMtCxhvYj1t3u1O9iciuGHo
         eDdCRTlFFzUCqkPinJoMxRdT00ZMlMtohOrZDny0AR5t3AzEyxcrrX96n8tXv/gLV8xz
         +FViA7+4mpQaXsoWhntEzjB0/Ty0tFH3RBpofHu4lOH1WL1pvYt0x0ldsimX1A6f24lq
         l27jz/fPT0N+qCCEEO/RY9s4njaJQ6e9qQk0nWoMuxcvP2K4r8O49GnFRQqXkb26JMoH
         BS+aZ2LX4RyMDcnrr+S8iOJIjVBYIz+NNwlOf+VGcNX2PKMAdOjxH6kjZMFq0Vqq7jqs
         E6NA==
X-Gm-Message-State: AA+aEWZv7MverX7nRV2PbhBTFUuZ87NLIof2zfPbGNevIWo90gAjQl7Y
        zyaWvoYXyG+vbHU0aTXtxdjc00dAmWd/7g==
X-Google-Smtp-Source: AFSGD/WzJ3rVqQ72xJI00c+67nHSmJhZinKnGhnjx9eU8bFUsfoP49J0bOR3XkrfDWtA6zKzgtWo8A==
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr18577371pll.54.1544577815145;
        Tue, 11 Dec 2018 17:23:35 -0800 (PST)
Received: from ?IPv6:2600:380:4a49:2b3f:8ddc:cb44:79a:38ad? ([2600:380:4a49:2b3f:8ddc:cb44:79a:38ad])
        by smtp.gmail.com with ESMTPSA id u29sm20227662pgn.23.2018.12.11.17.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 17:23:33 -0800 (PST)
Subject: Re: for-next hangs on test srp/012
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <tom.leiming@gmail.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
References: <1544569107.185366.391.camel@acm.org>
 <0688562b-7776-7efe-10dd-caf2a6a4f274@kernel.dk>
 <CACVXFVObwybJ1hmekS_bJ05zrOawoG33MQDVda+W1ATa+SqNCw@mail.gmail.com>
 <20181212002759.GC20445@redhat.com>
 <CACVXFVP_xGwwEr4xs64z69tkA8Wm20VVew9axcJRpqZ_-a3DNA@mail.gmail.com>
 <41d15b87-d32e-9c6d-d68e-03bd5e7b74b0@kernel.dk>
Message-ID: <05be643a-46b8-c836-11bf-005dbb0df9e4@kernel.dk>
Date:   Tue, 11 Dec 2018 18:23:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <41d15b87-d32e-9c6d-d68e-03bd5e7b74b0@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/18 6:05 PM, Jens Axboe wrote:
> On 12/11/18 5:38 PM, Ming Lei wrote:
>> On Wed, Dec 12, 2018 at 8:28 AM Mike Snitzer <snitzer@redhat.com> wrote:
>>>
>>> On Tue, Dec 11 2018 at  7:19pm -0500,
>>> Ming Lei <tom.leiming@gmail.com> wrote:
>>>
>>>> On Wed, Dec 12, 2018 at 8:04 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>
>>>>> On 12/11/18 3:58 PM, Bart Van Assche wrote:
>>>>>> Hi Jens,
>>>>>>
>>>>>> If I run the following subset of blktests:
>>>>>>
>>>>>>   while :; do ./check -q srp && ./check -q nvmeof-mp; done
>>>>>>
>>>>>> against today's for-next branch (commit dd2bf2df85a7) then after some
>>>>>> time the following hang is reported:
>>>>>>
>>>>>> INFO: task fio:14869 blocked for more than 120 seconds.
>>>>>>       Not tainted 4.20.0-rc6-dbg+ #1
>>>>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>> fio             D25272 14869  14195 0x00000000
>>>>>> Call Trace:
>>>>>>  __schedule+0x401/0xe50
>>>>>>  schedule+0x4e/0xd0
>>>>>>  io_schedule+0x21/0x50
>>>>>>  blk_mq_get_tag+0x46d/0x640
>>>>>>  blk_mq_get_request+0x7c0/0xa00
>>>>>>  blk_mq_make_request+0x241/0xa70
>>>>>>  generic_make_request+0x411/0x950
>>>>>>  submit_bio+0x9b/0x250
>>>>>>  blkdev_direct_IO+0x7fb/0x870
>>>>>>  generic_file_direct_write+0x119/0x210
>>>>>>  __generic_file_write_iter+0x11c/0x280
>>>>>>  blkdev_write_iter+0x13c/0x220
>>>>>>  aio_write+0x204/0x310
>>>>>>  io_submit_one+0x9c6/0xe70
>>>>>>  __x64_sys_io_submit+0x115/0x340
>>>>>>  do_syscall_64+0x71/0x210
>>>>>>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>>>
>>>>>> When that hang occurs my list-pending-block-requests script does not show
>>>>>> any pending requests:
>>>>>>
>>>>>> # list-pending-block-requests
>>>>>> dm-0
>>>>>> loop0
>>>>>> loop1
>>>>>> loop2
>>>>>> loop3
>>>>>> loop4
>>>>>> loop5
>>>>>> loop6
>>>>>> loop7
>>>>>> nullb0
>>>>>> nullb1
>>>>>> sda
>>>>>> sdb
>>>>>> sdc
>>>>>> sdd
>>>>>> vda
>>>>>> vdb
>>>>>>
>>>>>> Enabling fail_if_no_path mode did not resolve the hang so I don't think
>>>>>> that the root cause is in any of the dm drivers used in this test:
>>>>>>
>>>>>> # dmsetup ls | while read dm rest; do dmsetup message $dm 0 fail_if_no_path; done; dmsetup remove_all; dmsetup table
>>>>>> 360014056e756c6c62300000000000000: 0 65536 multipath 0 1 alua 1 1 service-time 0 1 2 8:16 1 1
>>>>>>
>>>>>> The same test passes against kernel v4.20-rc6.
>>>>>
>>>>> What device is this being run on?
>>>>
>>>> I saw this issue on usb storage too.
>>>>
>>>> Seems it is introduced by commit ea86ea2cdced ("sbitmap: ammortize cost of
>>>> clearing bits"). When the IO hang happens, .cleared is 2, and .busy is 0 on
>>>> the sched_tag's sbitmap queue.
>>>
>>> You saw this running the same tests as Bart?
>>
>> Not the srp test as done by Bart, I just run 'parted' test on usb storage disk,
>> see the attached test script.
>>
>> Mostly it can be triggered in one run, sometimes it needs more.
> 
> I'll take a look. The ->cleared doesn't make sense for QD=1, or on
> one word in general. But I'd like to try and understand why it hangs.
> 
> Are you using a scheduler?

OK, I think I see what it is, the shallow is missing the deferred clear.
On top of this, probably worth to check at what depths deferred starts
to make sense. For QD == 1, definitely not. But that should be on top of
the fix.

Can you try this one?


diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 2261136ae067..d98ba7af6bce 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -20,6 +20,47 @@
 #include <linux/sbitmap.h>
 #include <linux/seq_file.h>
 
+/*
+ * See if we have deferred clears that we can batch move
+ */
+static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
+{
+	unsigned long mask, val;
+	unsigned long __maybe_unused flags;
+	bool ret = false;
+
+	/* Silence bogus lockdep warning */
+#if defined(CONFIG_LOCKDEP)
+	local_irq_save(flags);
+#endif
+	spin_lock(&sb->map[index].swap_lock);
+
+	if (!sb->map[index].cleared)
+		goto out_unlock;
+
+	/*
+	 * First get a stable cleared mask, setting the old mask to 0.
+	 */
+	do {
+		mask = sb->map[index].cleared;
+	} while (cmpxchg(&sb->map[index].cleared, mask, 0) != mask);
+
+	/*
+	 * Now clear the masked bits in our free word
+	 */
+	do {
+		val = sb->map[index].word;
+	} while (cmpxchg(&sb->map[index].word, val, val & ~mask) != val);
+
+	ret = true;
+out_unlock:
+	spin_unlock(&sb->map[index].swap_lock);
+#if defined(CONFIG_LOCKDEP)
+	local_irq_restore(flags);
+#endif
+	return ret;
+}
+
 int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		      gfp_t flags, int node)
 {
@@ -70,6 +111,9 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 	unsigned int bits_per_word = 1U << sb->shift;
 	unsigned int i;
 
+	for (i = 0; i < sb->map_nr; i++)
+		sbitmap_deferred_clear(sb, i);
+
 	sb->depth = depth;
 	sb->map_nr = DIV_ROUND_UP(sb->depth, bits_per_word);
 
@@ -112,47 +156,6 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 	return nr;
 }
 
-/*
- * See if we have deferred clears that we can batch move
- */
-static inline bool sbitmap_deferred_clear(struct sbitmap *sb, int index)
-{
-	unsigned long mask, val;
-	unsigned long __maybe_unused flags;
-	bool ret = false;
-
-	/* Silence bogus lockdep warning */
-#if defined(CONFIG_LOCKDEP)
-	local_irq_save(flags);
-#endif
-	spin_lock(&sb->map[index].swap_lock);
-
-	if (!sb->map[index].cleared)
-		goto out_unlock;
-
-	/*
-	 * First get a stable cleared mask, setting the old mask to 0.
-	 */
-	do {
-		mask = sb->map[index].cleared;
-	} while (cmpxchg(&sb->map[index].cleared, mask, 0) != mask);
-
-	/*
-	 * Now clear the masked bits in our free word
-	 */
-	do {
-		val = sb->map[index].word;
-	} while (cmpxchg(&sb->map[index].word, val, val & ~mask) != val);
-
-	ret = true;
-out_unlock:
-	spin_unlock(&sb->map[index].swap_lock);
-#if defined(CONFIG_LOCKDEP)
-	local_irq_restore(flags);
-#endif
-	return ret;
-}
-
 static int sbitmap_find_bit_in_index(struct sbitmap *sb, int index,
 				     unsigned int alloc_hint, bool round_robin)
 {
@@ -215,6 +218,7 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
 	index = SB_NR_TO_INDEX(sb, alloc_hint);
 
 	for (i = 0; i < sb->map_nr; i++) {
+again:
 		nr = __sbitmap_get_word(&sb->map[index].word,
 					min(sb->map[index].depth, shallow_depth),
 					SB_NR_TO_BIT(sb, alloc_hint), true);
@@ -223,6 +227,9 @@ int sbitmap_get_shallow(struct sbitmap *sb, unsigned int alloc_hint,
 			break;
 		}
 
+		if (sbitmap_deferred_clear(sb, index))
+			goto again;
+
 		/* Jump to next index. */
 		index++;
 		alloc_hint = index << sb->shift;

-- 
Jens Axboe

