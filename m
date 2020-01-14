Return-Path: <SRS0=JLuE=3D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A1C33CB1
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A04C2187F
	for <linux-block@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgANNpE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:45:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43576 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgANNpE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jan 2020 08:45:04 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irMVB-0006cA-B3; Tue, 14 Jan 2020 14:45:01 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7615A101DEE; Tue, 14 Jan 2020 14:45:00 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Ming Lei <minlei@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: Kernel-managed IRQ affinity (cont)
In-Reply-To: <20200111024835.GA24575@ming.t460p>
References: <20191216195712.GA161272@xz-x1> <20191219082819.GB15731@ming.t460p> <20191219143214.GA50561@xz-x1> <20191219161115.GA18672@ming.t460p> <87eew8l7oz.fsf@nanos.tec.linutronix.de> <20200110012802.GA4501@ming.t460p> <87v9pjrtbh.fsf@nanos.tec.linutronix.de> <20200111024835.GA24575@ming.t460p>
Date:   Tue, 14 Jan 2020 14:45:00 +0100
Message-ID: <87r202b19f.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming,

Ming Lei <ming.lei@redhat.com> writes:
> On Fri, Jan 10, 2020 at 08:43:14PM +0100, Thomas Gleixner wrote:
>> Ming Lei <ming.lei@redhat.com> writes:
>> > That is why I try to exclude isolated CPUs from interrupt effective affinity,
>> > turns out the approach is simple and doable.
>> 
>> Yes, it's doable. But it still is inconsistent behaviour. Assume the
>> following configuration:
>> 
>>   8 CPUs CPU0,1 assigned for housekeeping
>> 
>> With 8 queues the proposed change does nothing because each queue is
>> mapped to exactly one CPU.
>
> That is expected behavior for this RT case, given userspace won't submit
> IO from isolated CPUs.

What is _this_ RT case? We really don't implement policy for a specific
use case. If the kernel implements a policy then it has to be generally
useful and practical.

>> With 4 queues you get the following:
>> 
>>  CPU0,1       queue 0
>>  CPU2,3       queue 1
>>  CPU4,5       queue 2
>>  CPU6,7       queue 3
>> 
>> No effect on the isolated CPUs either.
>> 
>> With 2 queues you get the following:
>> 
>>  CPU0,1,2,3   queue 0
>>  CPU4,5,6,7   queue 1
>> 
>> So here the isolated CPUs 2 and 3 get the isolation, but 4-7
>> not. That's perhaps intended, but definitely not documented.
>
> That is intentional change, given no IO will be submitted from 4-7
> most of times in RT case, so it is fine to select effective CPU from
> isolated CPUs in this case. As peter mentioned, IO may just be submitted
> from isolated CPUs during booting. Once the system is setup, no IO
> comes from isolated CPUs, then no interrupt is delivered to isolated
> CPUs, then meet RT's requirement.

Again. This is a specific usecase. Is this generally applicable?

> We can document this change somewhere.

Yes, this needs to be documented very clearly with that command line
parameter.

>> So you really need to make your mind up and describe what the intended
>> effect of this is and why you think that the result is correct.
>
> In short, if there is at least one housekeeping available in the
> interrupt's affinity, we choose effective CPU from housekeeping CPUs.
> Otherwise, keep the current behavior wrt. selecting effective CPU.
>
> With this approach, no interrupts can be delivered to isolated CPUs
> if no IOs are submitted from these CPUs.
>
> Please let us know if it addresses your concerns.

Mostly. See above.

Thanks,

        tglx


