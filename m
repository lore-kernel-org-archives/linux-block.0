Return-Path: <SRS0=3Les=W5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF6AC3A5A7
	for <linux-block@archiver.kernel.org>; Mon,  2 Sep 2019 23:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D284216C8
	for <linux-block@archiver.kernel.org>; Mon,  2 Sep 2019 23:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfIBXCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Sep 2019 19:02:50 -0400
Received: from foss.arm.com ([217.140.110.172]:58592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfIBXCu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Sep 2019 19:02:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82626344;
        Mon,  2 Sep 2019 16:02:49 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D2563F59C;
        Mon,  2 Sep 2019 16:02:48 -0700 (PDT)
Subject: Re: [PATCH] sched: make struct task_struct::state 32-bit
To:     Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        aarcange@redhat.com
References: <20190902210558.GA23013@avx2>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <7b94004e-4a65-462b-cd6b-5cbd23d607bf@arm.com>
Date:   Tue, 3 Sep 2019 00:02:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902210558.GA23013@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 02/09/2019 22:05, Alexey Dobriyan wrote:
> 32-bit accesses are shorter than 64-bit accesses on x86_64.
> Nothing uses 64-bitness of ->state.
> 
> Space savings are ~2KB on F30 kernel config.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---

Interestingly this has been volatile long since forever (or 2002, which is
my take on "forever" given the history tree), although the task states
seem to have never gone above 0x1000 (the current TASK_STATE_MAX).

[...]

> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -643,7 +643,7 @@ struct task_struct {
>  	struct thread_info		thread_info;
>  #endif
>  	/* -1 unrunnable, 0 runnable, >0 stopped: */
> -	volatile long			state;
> +	volatile int			state;

This leads to having some padding after this field (w/o randomization):

struct task_struct {
	struct thread_info         thread_info;          /*     0    24 */
	volatile int               state;                /*    24     4 */

	/* XXX 4 bytes hole, try to pack */

	void *                     stack;                /*    32     8 */

Though seeing as this is also the boundary of the randomized layout we can't
really do much better without changing the boundary itself. So much for
cacheline use :/

Anyway, task_struct doesn't shrink but we can cut some corners in the asm,
I guess that's fine?

[...]
