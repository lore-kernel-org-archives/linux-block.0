Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:50440 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdKJHlX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Nov 2017 02:41:23 -0500
Subject: Re: [PATCH v2] locking/lockdep: Revise
 Documentation/locking/crossrelease.txt
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, kernel-team@lge.com
References: <1510212036-22008-1-git-send-email-byungchul.park@lge.com>
 <20171110073053.qh4nhpl26i47gbiv@gmail.com>
From: Byungchul Park <byungchul.park@lge.com>
Message-ID: <2f2de6c8-ef4b-070d-a81d-eed677bcce35@lge.com>
Date: Fri, 10 Nov 2017 16:41:18 +0900
MIME-Version: 1.0
In-Reply-To: <20171110073053.qh4nhpl26i47gbiv@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/10/2017 4:30 PM, Ingo Molnar wrote:
> 
> * Byungchul Park <byungchul.park@lge.com> wrote:
> 
>>      Event C depends on event A.
>>      Event A depends on event B.
>>      Event B depends on event C.
>>   
>> -   NOTE: Precisely speaking, a dependency is one between whether a
>> -   waiter for an event can be woken up and whether another waiter for
>> -   another event can be woken up. However from now on, we will describe
>> -   a dependency as if it's one between an event and another event for
>> -   simplicity.
> 
> Why was this explanation removed?
> 
>> -Lockdep tries to detect a deadlock by checking dependencies created by
>> -lock operations, acquire and release. Waiting for a lock corresponds to
>> -waiting for an event, and releasing a lock corresponds to triggering an
>> -event in the previous section.
>> +Lockdep tries to detect a deadlock by checking circular dependencies
>> +created by lock operations, acquire and release, which are wait and
>> +event respectively.
> 
> What? You changed a readable paragraph into an unreadable one.
> 
> Sorry, this text needs to be acked by someone with good English skills, and I
> don't have the time right now to fix it all up. Please send minimal, obvious
> typo/grammar fixes only.

I will send one including minimal fixes at the next spin.

-- 
Thanks,
Byungchul
