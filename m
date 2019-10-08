Return-Path: <SRS0=ti8e=YB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A188AC4360C
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 18:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A7521871
	for <linux-block@archiver.kernel.org>; Tue,  8 Oct 2019 18:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfJHSqr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:46:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49846 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJHSqr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Oct 2019 14:46:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 967AF28F6BB
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, kernel@collabora.com
Subject: Re: [PATCH v2 1/1] blk-mq: fill header with kernel-doc
Organization: Collabora
References: <20191008001416.12656-1-andrealmeid@collabora.com>
        <854l0j19go.fsf@collabora.com>
        <6aa48cd2-5f23-a4be-f777-d65bf755a976@acm.org>
Date:   Tue, 08 Oct 2019 14:46:31 -0400
In-Reply-To: <6aa48cd2-5f23-a4be-f777-d65bf755a976@acm.org> (Bart Van Assche's
        message of "Tue, 8 Oct 2019 10:30:58 -0700")
Message-ID: <85zhibyt14.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart Van Assche <bvanassche@acm.org> writes:

> On 10/8/19 9:35 AM, Gabriel Krisman Bertazi wrote:
>> André Almeida <andrealmeid@collabora.com> writes:
>>
>>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>>> index e0fce93ac127..8b745f229789 100644
>>> --- a/include/linux/blk-mq.h
>>> +++ b/include/linux/blk-mq.h
>>> @@ -10,74 +10,153 @@ struct blk_mq_tags;
>>>   struct blk_flush_queue;
>>>     /**
>>> - * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware block device
>>> + * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware
>>> + * block device
>>>    */
>>>   struct blk_mq_hw_ctx {
>>>   	struct {
>>> +		/** @lock: Lock for accessing dispatch queue */
>>>   		spinlock_t		lock;
>>> +		/**
>>> +		 * @dispatch: Queue of dispatched requests, waiting for
>>> +		 * workers to send them to the hardware.
>>> +		 */
>>
>> It's been a few years since I looked at the block layer, but isn't
>> this used to hold requests that were taken from the blk_mq_ctx,  but
>> couldn't be dispatched because the queue was full?
>
> I don't think so. I think that you are looking for the requeue_list
> member of struct request_queue.
>

Hmm, sorry, but I'm confused.  I'm sure I'm missing something simple,
since I haven't touched this in a while, so maybe you can quickly point
me in the right direction?

I see blk_mq_requeue_request() being used by device drivers to retry
requests that failed, but if I read the code correctly, the flushed
queue seems to be moved to hctx->dispatch when the device
driver returned BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE to
blk_mq_dispatch_rq_list(). I thought BLK_STS_RESOURCE was returned by
the driver on .queue_rq() to signal there was no more resources on the
hardware to service further requests.

-- 
Gabriel Krisman Bertazi
