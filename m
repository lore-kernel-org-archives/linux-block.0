Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6FCC3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 21:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9AD2087E
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 21:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfICVvk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:51:40 -0400
Received: from foss.arm.com ([217.140.110.172]:44452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfICVvk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Sep 2019 17:51:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6401D337;
        Tue,  3 Sep 2019 14:51:39 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A7FE3F718;
        Tue,  3 Sep 2019 14:51:37 -0700 (PDT)
Subject: Re: [PATCH] sched: make struct task_struct::state 32-bit
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        aarcange@redhat.com
References: <20190902210558.GA23013@avx2>
 <d8ad0be1-4ed7-df74-d415-2b1c9a44bac7@arm.com> <20190903181920.GA22358@avx2>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <92ead22e-0580-c720-1a29-7db79d76f7d7@arm.com>
Date:   Tue, 3 Sep 2019 22:51:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903181920.GA22358@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/09/2019 19:19, Alexey Dobriyan wrote:
> On Tue, Sep 03, 2019 at 06:29:06PM +0100, Valentin Schneider wrote:
>> On 02/09/2019 22:05, Alexey Dobriyan wrote:
>>> 32-bit accesses are shorter than 64-bit accesses on x86_64.
>>> Nothing uses 64-bitness of ->state.
> 
>> It looks like you missed a few places. There's a long prev_state in
>> sched/core.c::finish_task_switch() for instance.
>>
>> I suppose that's where coccinelle oughta help but I'm really not fluent
>> in that. Is there a way to make it match p.state accesses with p task_struct?
>> And if so, can we make it change the type of the variable being read from
>> / written to?
> 
> Coccinelle is interesting: basic
> 
> 	- foo
> 	+ bar
> 
> doesn't find "foo" in function arguments.
> 
> I'm scared of coccinelle.> 

So am I, but I'm even more scared of having no other way of verifying this
than doing it "by hand". It's nothing critical here - just some variables
that will remain long instead of being int, but I'd like to have some way to
verify the change. A coccinelle script would be great, even if it misses
some places, I can at least have some trust in it.

If I have to verify the whole tree by hand, even with grep/ag, I don't trust
I'll do it right.


I gave Coccinelle a try, I think I got something for in-function variables:

---
@state_var@
struct task_struct *p;
identifier prev_state;
@@
prev_state = p->state

@@
identifier state_var.prev_state;
@@
- long prev_state;
+ int prev_state;
---

I tried something for function parameters, which seems to be feasible
according to [1], but couldn't get it to work (yet). Here's what I have
so far:

---
@func_param@
identifier func;
identifier p;
identifier state;
identifier mask;
@@

func(struct task_struct *p, const struct cpumask *mask, long state)
{
...
}

@@
identifier func_param.func;
identifier func_param.state;
expression E1;
expression E2;
@@

func(E1,
- long state,
+ int state,
E2)
---

(it should match against kernel/kthread.c::__kthread_bind_mask() but it
complains about me not knowing how to write coccinelle patches).

With a mix of these we might get somewhere...

[1]: http://coccinelle.lip6.fr/docs/main_grammar016.html

>> How did you come up with this changeset, did you pickaxe for some regexp?
> 
> No, manually, backtracking up to the call chain.
> Maybe I missed a few places.
> 
