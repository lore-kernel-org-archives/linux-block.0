Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141AAC41514
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 17:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC1521670
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 17:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfIDRsw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:48:52 -0400
Received: from foss.arm.com ([217.140.110.172]:59344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729594AbfIDRsw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 13:48:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96343337;
        Wed,  4 Sep 2019 10:48:51 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76BA03F67D;
        Wed,  4 Sep 2019 10:48:50 -0700 (PDT)
Subject: Re: [PATCH] sched: make struct task_struct::state 32-bit
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        aarcange@redhat.com
References: <20190902210558.GA23013@avx2>
 <d8ad0be1-4ed7-df74-d415-2b1c9a44bac7@arm.com> <20190903181920.GA22358@avx2>
 <92ead22e-0580-c720-1a29-7db79d76f7d7@arm.com>
 <a43fe392-bd6a-71f5-8611-c6b764ba56c3@arm.com>
Message-ID: <f0328a66-ca9f-974d-3799-e73308fb1d34@arm.com>
Date:   Wed, 4 Sep 2019 18:48:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a43fe392-bd6a-71f5-8611-c6b764ba56c3@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/09/2019 13:07, Valentin Schneider wrote:
> [...]
> Baby steps...


There's something regarding coccinelle disjunctions that just can't grasp,
and this also fails to recognize "current" as being "struct task_struct*".

Once I fix these, it's "just" a matter of finding out how to write a rule
for layered calls (e.g. __kthread_bind() -> __kthread_bind_mask() ->
wait_task_inactive()), and we should be close to having something somewhat
usable.

---
virtual patch
virtual report

@state_access@
identifier func;
struct task_struct *p;
identifier state_var;
position fpos;
position epos;
@@

func(...)@fpos
{
	<...
(
  p->state & state_var@epos
|
  p->state | state_var@epos
|
  p->state < state_var@epos
|
  p->state > state_var@epos
|
  state_var@epos = p->state
// For some reason adding this disjunction gives us more matches, but causes
// some to go away :/
// |
//   p->state == state_var@epos
|
  p->state != state_var@epos
)
	...>
}

@depends on patch@
identifier fn = state_access.func;
identifier state_var = state_access.state_var;
@@

fn(...,
- long state_var
+ int state_var
,...)
{
	...
}

// Should be merged in the above but can't get disjunction to work
@depends on patch@
identifier fn = state_access.func;
identifier state_var = state_access.state_var;
@@

fn(...,
- unsigned long state_var
+ unsigned int state_var
,...)
{
	...
}

// Is it possible to match without semicolons? :/
@depends on patch@
identifier state_var = state_access.state_var;
expression E;
@@

(
- long state_var;
+ int state_var;
|
- long state_var = E;
+ int state_var = E;
)

@script:python depends on report@
fp << state_access.fpos;
ep << state_access.epos;
@@
cocci.print_main("Func at", fp)
cocci.print_main("Expr at", ep)
