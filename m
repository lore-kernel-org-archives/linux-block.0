Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E7C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 21:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE13206BA
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 21:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjellstrom.ca header.i=thomas@fjellstrom.ca header.b="cEmJq5KP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE13206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fjellstrom.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeKVICM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 03:02:12 -0500
Received: from sender-op-o12.zoho.com ([135.84.80.197]:17457 "EHLO
        sender-op-o12.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeKVICM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 03:02:12 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1542835561; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=AhiPzbLl77ERr56y03hDPAX99px5qKqHPE9cZP9lNkeK4NcxvbuQU+XjaMFkxzvUXIwMe9qkcWEGHHzIMxXSNMV4OxhjRR4+HuSDN4cFoa7ToDTBCif7jZUOOEYJL+0nvFc+v7Znx55Heb2t/eHQQCugRGn0ILQjRzbJVL5L66E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1542835561; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=7Po6rSrWJqvaX15Vn3q1Mz8QZytPgrtunbCe1FYvbSw=; 
        b=NK8pcTnP1oL+3BNlbJinccbw/UIGC9Qhre5LiindKPxnd1zbdGsWu7oZSKucg3WKMSw4R52lBkJvgcgML/lCJE/eU101YAj26oIsrpo6f3ZKo1eCuSt0CfQC3S71PM2k4LJXABnx89iQfkP92WHvcZ7ei1jftkctXp8KWaGjSc4=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=fjellstrom.ca;
        spf=pass  smtp.mailfrom=thomas@fjellstrom.ca;
        dmarc=pass header.from=<thomas@fjellstrom.ca> header.from=<thomas@fjellstrom.ca>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zoho; d=fjellstrom.ca; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-type; 
  b=gxnMEbdzIXwASwY10KVAzJTLfnM106NUkKVa42JYKmVMolCxrKV7Mz7ggqX5ub7DOGUxIHWeU0i0
    CgEouTo94o4Y/+Js9vBe6sgO4TL+55mEiDGjC2D5kO2Yrg22/3VxmggChnlxbf/jfwiXm1szd3ym
    4JiDPSohvuwtVYkuukM=  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1542835561;
        s=zoho; d=fjellstrom.ca; i=thomas@fjellstrom.ca;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=7170; bh=7Po6rSrWJqvaX15Vn3q1Mz8QZytPgrtunbCe1FYvbSw=;
        b=cEmJq5KPREgnvQHGg3AKUDcwIobggNfBm5eJf9ZTpB+MbsM6DCUNsqP6vauYFjg5
        X1W0fqIwQlOXIHHhOOYpJdNrADTe1IUCLphyiATFl9SjvE86NhRulxnXzTALOlE+WJS
        w3uQwaZckup9JvTuG1f6LVTWxhJeLQamYiUmQ938=
Received: from natasha.localnet (S010652540017b116.ed.shawcable.net [68.148.49.236]) by mx.zohomail.com
        with SMTPS id 1542835559019440.3525326163352; Wed, 21 Nov 2018 13:25:59 -0800 (PST)
From:   Thomas Fjellstrom <thomas@fjellstrom.ca>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: recent issues with heavy delete's causing soft lockups
Date:   Wed, 21 Nov 2018 14:25:54 -0700
Message-ID: <1876163.D0WNILC8ec@natasha>
In-Reply-To: <baa9f4e4-34e2-1112-5d01-ce86c1b51005@kernel.dk>
References: <2800911.LnhMzhikfW@natasha> <5281881.2vk5iP2XJf@natasha> <baa9f4e4-34e2-1112-5d01-ce86c1b51005@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-ZohoMailClient: External
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Friday, November 2, 2018 2:37:08 PM MST Jens Axboe wrote:
> On 11/2/18 2:32 PM, Thomas Fjellstrom wrote:
> > On Saturday, October 27, 2018 1:20:10 PM MDT Jens Axboe wrote:
> >> On Oct 27, 2018, at 12:40 PM, Thomas Fjellstrom <thomas@fjellstrom.ca>
> > 
> > [snip]
> > 
> >> Can you try 4.19? A patch went in since 4.18 that fixes a starvation
> >> issue
> >> around requeue conditions, which SATA is the one to most often hit.
> >> 
> >> Jens
> > 
> > I just had to do a clean, and I have the mq kernel options I mentioned in
> > my previous mail enabled. (mq should be disabled) and it appears to still
> > be causing issues. current io scheduler appears to be cfq, and it took
> > that "make clean" about 4 minutes, a lot of that time was spent with
> > plasma, intelij, and chrome all starved of IO.
> > 
> > I did switch to a terminal and checked iostat -d 1, and it showed very
> > little actual io for the time I was looking at it.
> > 
> > I have no idea what's going on.
> 
> If you're using cfq, then it's not using mq at all. Maybe do something ala:

Yeah, I switched off mq to test. I mentioned it in a previous mail.

> # perf record -ag -- sleep 10
> 
> while the slowdown is happening and then do perf report -g --no-children and
> see if that yields anything interesting. Sounds like time is being spent
> elsewhere and you aren't actually waiting on IO.

Ok, with the 4.19.1 kernel from linux-stable I've managed to catch the issue 
during real use, rather than just a dd command.

I should note that I have swap turned off, so I'm not sure what 
the "swapper" process in the below log is doing.

I also see the problem with swap enabled. But right now I'd rather 
certain apps die rather than slow the entire system down.

I also have a perf report -t log if that'd be helpful. It shows a lot of "use" 
in do_idle/acpi_idle_do_entry though I presume that's actual real idle time, 
not actual use.  The next most eye catching item in the -t log is chrome spending
17% of its time in glibc's free function.

(the top 100~ lines from perf report -g)

# Total Lost Samples: 0
#
# Samples: 456K of event 'cycles'
# Event count (approx.): 136347735217
#
# Overhead  Command          Shared Object                           Symbol                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
# ........  ...............  ......................................  .........................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................
#
    25.64%  swapper          [kernel.kallsyms]                       [k] acpi_idle_do_entry
            |
            ---0xffffffffa16000d4
               |          
               |--22.23%--start_secondary
               |          cpu_startup_entry
               |          do_idle
               |          cpuidle_enter_state
               |          acpi_idle_enter
               |          acpi_idle_do_entry
               |          
                --3.41%--start_kernel
                          cpu_startup_entry
                          do_idle
                          cpuidle_enter_state
                          acpi_idle_enter
                          acpi_idle_do_entry

     0.61%  swapper          [kernel.kallsyms]                       [k] apic_timer_interrupt
            |
            ---0xffffffffa16000d4
               |          
                --0.52%--start_secondary
                          cpu_startup_entry
                          do_idle
                          |          
                           --0.52%--cpuidle_enter_state

     0.54%  chrome           chrome                                  [.] _fini
     0.42%  swapper          [kernel.kallsyms]                       [k] native_sched_clock
     0.41%  swapper          [kernel.kallsyms]                       [k] menu_select
     0.40%  swapper          [kernel.kallsyms]                       [k] check_preemption_disabled
     0.35%  http.so          libQt5Core.so.5.11.2                    [.] QTranslatorPrivate::do_translate
     0.35%  swapper          [kernel.kallsyms]                       [k] x86_pmu_disable_all
     0.32%  TaskSchedulerFo  [kernel.kallsyms]                       [k] osq_lock
     0.31%  Chrome_IOThread  chrome                                  [.] _fini
     0.30%  chrome           libpthread-2.27.so                      [.] __pthread_mutex_lock
     0.29%  swapper          [kernel.kallsyms]                       [k] _raw_spin_lock_irqsave
     0.28%  swapper          [kernel.kallsyms]                       [k] read_tsc
     0.26%  chrome           libpthread-2.27.so                      [.] __pthread_mutex_unlock_usercnt
     0.26%  swapper          [kernel.kallsyms]                       [k] reschedule_interrupt
     0.24%  swapper          [kernel.kallsyms]                       [k] _raw_spin_lock
     0.24%  swapper          [kernel.kallsyms]                       [k] __sched_text_start
     0.24%  swapper          [kernel.kallsyms]                       [k] native_load_gs_index
     0.23%  swapper          [kernel.kallsyms]                       [k] __switch_to
     0.22%  swapper          [kernel.kallsyms]                       [k] do_idle
     0.21%  TaskSchedulerFo  [kernel.kallsyms]                       [k] mutex_lock
     0.21%  swapper          [kernel.kallsyms]                       [k] cpuidle_enter_state
     0.21%  TaskSchedulerFo  chrome                                  [.] 0x000000000306c000
     0.20%  chrome           [kernel.kallsyms]                       [k] native_sched_clock
     0.20%  TaskSchedulerFo  [kernel.kallsyms]                       [k] mutex_unlock
     0.18%  chrome           [kernel.kallsyms]                       [k] entry_SYSCALL_64
     0.18%  thumbnail.so     ld-2.27.so                              [.] do_lookup_x
     0.17%  Xorg             [kernel.kallsyms]                       [k] delay_tsc
     0.17%  rm               [ext4]                                  [k] ext4_mark_iloc_dirty
     0.16%  swapper          [kernel.kallsyms]                       [k] update_blocked_averages
     0.16%  chrome           [kernel.kallsyms]                       [k] check_preemption_disabled
     0.15%  swapper          [kernel.kallsyms]                       [k] update_load_avg
     0.15%  swapper          [kernel.kallsyms]                       [k] interrupt_entry
     0.15%  swapper          [kernel.kallsyms]                       [k] ktime_get
     0.15%  swapper          [kernel.kallsyms]                       [k] switch_mm_irqs_off
     0.15%  TaskSchedulerFo  [kernel.kallsyms]                       [k] __mutex_lock.isra.5
     0.14%  rm               [kernel.kallsyms]                       [k] check_preemption_disabled
     0.14%  TaskSchedulerFo  chrome                                  [.] 0x000000000306c009
     0.13%  swapper          [kernel.kallsyms]                       [k] __update_load_avg_se
     0.13%  chrome           libc-2.27.so                            [.] __memcpy_ssse3
     0.13%  swapper          [kernel.kallsyms]                       [k] __update_load_avg_cfs_rq
     0.12%  http.so          libQt5Core.so.5.11.2                    [.] QCoreApplicationPrivate::sendPostedEvents
     0.12%  rm               [kernel.kallsyms]                       [k] __find_get_block
     0.12%  swapper          [kernel.kallsyms]                       [k] timerqueue_add
     0.12%  swapper          [kernel.kallsyms]                       [k] acpi_idle_enter
     0.12%  apt-cache        libz.so.1.2.11                          [.] adler32_z
     0.12%  swapper          [kernel.kallsyms]                       [k] rcu_dynticks_eqs_exit
     0.12%  Xorg             [radeon]                                [k] cail_reg_read
     0.12%  swapper          [kernel.kallsyms]                       [k] trace_hardirqs_off
     0.11%  swapper          [kernel.kallsyms]                       [k] set_next_entity
     0.11%  swapper          [kernel.kallsyms]                       [k] _raw_spin_unlock_irqrestore
     0.11%  http.so          libQt5Core.so.5.11.2                    [.] QCoreApplication::translate
     0.11%  http.so          [kernel.kallsyms]                       [k] __switch_to
     0.11%  Chrome_ChildIOT  chrome                                  [.] _fini
     0.11%  chrome           [kernel.kallsyms]                       [k] __fget
     0.10%  swapper          [kernel.kallsyms]                       [k] __hrtimer_next_event_base
     0.10%  http.so          [kernel.kallsyms]                       [k] native_load_gs_index
     0.10%  swapper          [kernel.kallsyms]                       [k] rcu_check_callbacks
     0.10%  drkonqi          ld-2.27.so                              [.] do_lookup_x
     0.10%  TaskSchedulerFo  chrome                                  [.] 0x000000000306e42b
     0.10%  http.so          [kernel.kallsyms]                       [k] native_sched_clock
     0.10%  swapper          [kernel.kallsyms]                       [k] x86_pmu_enable_all
     0.10%  swapper          [kernel.kallsyms]                       [k] find_busiest_group
     0.10%  radeon_cs:0      [kernel.kallsyms]                       [k] refcount_sub_and_test_checked
     0.10%  http.so          [vdso]                                  [.] 0x00000000000008d9


Thanks,

-- 
Thomas Fjellstrom
thomas@fjellstrom.ca



