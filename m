Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E9EC3A5A5
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C262339D
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 16:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfICQdq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:33:46 -0400
Received: from foss.arm.com ([217.140.110.172]:40480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731200AbfICQbt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Sep 2019 12:31:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80A9C360;
        Tue,  3 Sep 2019 09:31:48 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59C973F246;
        Tue,  3 Sep 2019 09:31:47 -0700 (PDT)
Subject: Re: [PATCH] sched: make struct task_struct::state 32-bit
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        aarcange@redhat.com
References: <20190902210558.GA23013@avx2>
 <7b94004e-4a65-462b-cd6b-5cbd23d607bf@arm.com> <20190903162303.GA2173@avx2>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <64003dcd-d954-b76d-856a-214ff11ac000@arm.com>
Date:   Tue, 3 Sep 2019 17:31:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903162303.GA2173@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 03/09/2019 17:23, Alexey Dobriyan wrote:
> On Tue, Sep 03, 2019 at 12:02:38AM +0100, Valentin Schneider wrote:
>> struct task_struct {
>> 	struct thread_info         thread_info;          /*     0    24 */
>> 	volatile int               state;                /*    24     4 */
>>
>> 	/* XXX 4 bytes hole, try to pack */
>>
>> 	void *                     stack;                /*    32     8 */
>>
>> Though seeing as this is also the boundary of the randomized layout we can't
>> really do much better without changing the boundary itself. So much for
>> cacheline use :/
> 
> Cacheline use of task_struct is pretty hopeless because of all the ifdefs.
> 

Yeah I figured, then had a minute of silence for those forsaken bytes.
