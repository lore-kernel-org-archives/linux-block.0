Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF6BC433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Dec 2021 14:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhLSO6f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Dec 2021 09:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbhLSO6f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Dec 2021 09:58:35 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFFEC061574
        for <linux-block@vger.kernel.org>; Sun, 19 Dec 2021 06:58:35 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id c3so10119297iob.6
        for <linux-block@vger.kernel.org>; Sun, 19 Dec 2021 06:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qKz+WAr6nEBLsYj+AcL5DWngB8lrLlnoDgVx0fw/U4M=;
        b=HaiOYbTqzxLag60YV9E+lZgvoytr3V9F3lFwlTgtrIhgxyyUbo0h2YaRbtkGKwsaxQ
         BQbtQL4LImkM0wbxCW1vhhA4LMbLb2IZfj5pS2f2sxwqtcLKOK3B31Xa1hNdv+oM+Gjh
         KOYXoeZ0xGNkqv3bDUOeqKVoeHwgX6hkiaFnvQ87nunUyGJ1mczjFTXSa5SbQWe1BTOD
         8RqsPgY8hzJ83fjcgpuBW8EpzdGkD0aMq6gZtbKYcb2BlMLuQ3BCHJ1pgjo5BvJGQQet
         2gqRZElkltBv767sWaUobPB+AlbnsGsEseROo8qSz2cRi3oee5eV0QaoeYQmVOuLbe6l
         PLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qKz+WAr6nEBLsYj+AcL5DWngB8lrLlnoDgVx0fw/U4M=;
        b=57O9/vDQhSfGW2a0yugM4+MYPArME7Kox78QALB1QO3t7/KUuRKGYgu3J38CflLqs1
         ag7vTnOk2OVhqcbEHJGe0yqqH76tlFpjxYqeJeHfmfEtv3SU22yj/ej65x5KhTmgpcBw
         OJHOFo7lhpefXdRsXWPXAaqmUWq73mtsQDR3re+T9fFetiHAI96HRo5xdVgA/OK1x9t/
         OHZjNqmkWI87pyXHPtEhILi1+qp4qVMZJooS2J7nEnK5B9mUfQh9ts/hDgvjZ/n2O8hg
         N7gDIwu/ighRhzmmdh6AN6V3ZyTHGsO53vA7qnHdBC0j3jYKxVIfhXc8Ky1UWctXeFaT
         m6/w==
X-Gm-Message-State: AOAM530dw0I7SBAsjrls4JVilZURjXX43d5OksgeRxKIZh1L+ZpF0ku4
        7Lx6/PRNLPo2LvqwoNldqYJzhw==
X-Google-Smtp-Source: ABdhPJwXhxG8IxWFGOqQzRmBqSTSLV4aRS0fpka63UV2gZBWhX6DelmsVshPL8ODFP5spTK0ukHfJQ==
X-Received: by 2002:a05:6638:3053:: with SMTP id u19mr7730348jak.220.1639925914462;
        Sun, 19 Dec 2021 06:58:34 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m14sm2035189iow.54.2021.12.19.06.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 06:58:34 -0800 (PST)
Subject: Re: very low IOPS due to "block: reduce kblockd_mod_delayed_work_on()
 CPU consumption"
From:   Jens Axboe <axboe@kernel.dk>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        linux-block@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        ming.lei@redhat.com, hch@lst.de, Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org
References: <1639853092.524jxfaem2.none.ref@localhost>
 <1639853092.524jxfaem2.none@localhost>
 <7d1e4bb8-1a73-9529-3191-66df4ff2d5fe@kernel.dk>
Message-ID: <12f43a71-713b-a74f-a169-b6ac3d804e50@kernel.dk>
Date:   Sun, 19 Dec 2021 07:58:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7d1e4bb8-1a73-9529-3191-66df4ff2d5fe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/21 12:02 PM, Jens Axboe wrote:
> On 12/18/21 11:57 AM, Alex Xu (Hello71) wrote:
>> Hi,
>>
>> I recently noticed that between 6441998e2e and 9eaa88c703, I/O became 
>> much slower on my machine using ext4 on dm-crypt on NVMe with bfq 
>> scheduler. Checking iostat during heavy usage (find / -xdev and fstrim 
>> -v /), maximum IOPS had fallen from ~10000 to ~100. Reverting cb2ac2912a 
>> ("block: reduce kblockd_mod_delayed_work_on() CPU consumption") resolves 
>> the issue.
> 
> Hmm interesting. I'll try and see if I can reproduce this and come up
> with a fix.

I can reproduce this. Alex, can you see if this one helps? Trying to see
if we can hit a happy medium here that avoids hammering on that timer,
but it really depends on what the mix is here of delay with pending,
or no delay with no pending.

Dexuan, can you test this for your test case too? I'm going to queue
up a revert for -rc6 just in case.

diff --git a/block/blk-core.c b/block/blk-core.c
index c1833f95cb97..a3fbf4360ee9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1481,12 +1481,15 @@ int kblockd_schedule_work(struct work_struct *work)
 }
 EXPORT_SYMBOL(kblockd_schedule_work);
 
-int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
-				unsigned long delay)
-{
-	if (!delay)
-		return queue_work_on(cpu, kblockd_workqueue, &dwork->work);
-	return mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
+void kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork,
+				 unsigned long delay)
+{
+	if (!delay) {
+		cancel_delayed_work(dwork);
+		queue_work_on(cpu, kblockd_workqueue, &dwork->work);
+	} else {
+		mod_delayed_work_on(cpu, kblockd_workqueue, dwork, delay);
+	}
 }
 EXPORT_SYMBOL(kblockd_mod_delayed_work_on);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bd4370baccca..1c7ba45e8463 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1159,7 +1159,7 @@ static inline unsigned int block_size(struct block_device *bdev)
 }
 
 int kblockd_schedule_work(struct work_struct *work);
-int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
+void kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned long delay);
 
 #define MODULE_ALIAS_BLOCKDEV(major,minor) \
 	MODULE_ALIAS("block-major-" __stringify(major) "-" __stringify(minor))


-- 
Jens Axboe

