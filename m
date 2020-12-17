Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F70C4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 19:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE138239EB
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 19:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgLQTQM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 14:16:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:34748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgLQTQM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 14:16:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7E050AD57;
        Thu, 17 Dec 2020 19:15:30 +0000 (UTC)
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208131319.GB22219@infradead.org>
 <20201217164308.ueki3scv3oxt4uta@linutronix.de>
 <e3ca3c82-cddc-ea06-39ae-48605abc77eb@kernel.dk>
 <20201217181639.byvly7dvpbdxmeu5@beryllium.lan>
 <1c11b5eb-4e3f-120e-2228-89f63c26bf29@kernel.dk>
 <20201217184154.hn5pjiaasti3m7e7@beryllium.lan>
 <277c5421-d6ac-63a5-9dd2-c72e0a77fb8d@kernel.dk>
 <119d2c73-05cd-7c90-f2be-8ed83ce95e3d@suse.de>
 <039d7e61-215c-2e10-19ea-f6018a0f9031@kernel.dk>
From:   Daniel Wagner <dwagner@suse.de>
Message-ID: <0c3e53c0-c425-4e5a-c751-396e10ef2964@suse.de>
Date:   Thu, 17 Dec 2020 20:15:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <039d7e61-215c-2e10-19ea-f6018a0f9031@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Well, had to update #3 anyway, so done.

Thanks!
