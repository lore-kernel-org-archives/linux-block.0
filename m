Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDBDC433E2
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 15:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D52D20719
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 15:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHaPus (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbgHaPup (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 11:50:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEE3C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 08:50:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2610:98:8005::6b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5749B295208;
        Mon, 31 Aug 2020 16:50:44 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, kernel@collabora.com,
        khazhy@google.com
Subject: Re: [PATCH] block: Fix inflight statistic for MQ submission with !elevator
Organization: Collabora
References: <20200831153127.3561733-1-krisman@collabora.com>
        <7a4669a1-7633-6acc-e06d-86992245dfee@kernel.dk>
Date:   Mon, 31 Aug 2020 11:50:41 -0400
In-Reply-To: <7a4669a1-7633-6acc-e06d-86992245dfee@kernel.dk> (Jens Axboe's
        message of "Mon, 31 Aug 2020 09:33:55 -0600")
Message-ID: <87sgc2u84u.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 8/31/20 9:31 AM, Gabriel Krisman Bertazi wrote:
>> According to Documentation/block/stat.rst, inflight should not include
>> I/O requests that are in the queue but not yet dispatched to the device,
>> but blk-mq identifies as inflight any request that has a tag allocated,
>> which, for queues without elevator, happens at request allocation time
>> and before it is queued in the ctx (default case in blk_mq_submit_bio).
>> 
>> A more precise approach would be to only consider requests with state
>> MQ_RQ_IN_FLIGHT.
>
> We've had some churn here, last change in this area was:

Hi Jens,

Thanks for the quick reply.  I wasn't aware of that patch.

I'm collecting statistics on the queue depth of a NCQ disk, and my end
goal is to have a time_in_driver clock, which is the time spent by IOs
in the driver, similarly to what is shown in diskstats, but the latter
includes the block layer time.  I stumbled this issue with inflight,
where we noticed a difference between inflight and what was actually
dispatched to the driver.  The problem is the current behavior doesn't
seem to match the documentation in Documentation/block/stat.sh.

I went back to history.git and found that this difference in behavior
from the documentation has always been there for legacy path, unless I
am misreading the documentation.  The patch I proposed consolidates
inflight in favor of documentation instead of the legacy patch.

The documentation reads:

"""
This value counts the number of I/O requests that have been issued to
the device driver but have not yet completed.  It does not include I/O
requests that are in the queue but not yet issued to the device driver.
"""

Should I patch the documentation instead?

Thinking about semantics, it seem more useful to have inflight include
only the time between dispatching and completion, but if you think there
is a concern about stable abi here, would you accept a new in_device file
tracking this metric?

-- 
Gabriel Krisman Bertazi
