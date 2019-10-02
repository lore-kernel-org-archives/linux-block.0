Return-Path: <SRS0=s2CZ=X3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5869FC4360C
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 21:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26788217D7
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 21:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfJBVGq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:06:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59720 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBVGq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Oct 2019 17:06:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id ED8DE289EE6
Subject: Re: [PATCH 1/1] blk-mq: fill header with kernel-doc
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, krisman@collabora.com
References: <20190930194846.23141-1-andrealmeid@collabora.com>
 <f1ca9de7-383b-4a84-31d0-92cfbb3759b2@kernel.dk>
 <f46014fd-b29d-aee5-d49d-d2c5f2ddfb9f@acm.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <dd54cda2-b314-3ae6-c330-363cfa7959a1@collabora.com>
Date:   Wed, 2 Oct 2019 18:05:26 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f46014fd-b29d-aee5-d49d-d2c5f2ddfb9f@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Bart,

On 10/2/19 5:27 PM, Bart Van Assche wrote:
> On 10/1/19 8:33 PM, Jens Axboe wrote:
>> On 9/30/19 1:48 PM, André Almeida wrote:
>>> -
>>> +/**
>>> + * struct blk_mq_ops - list of callback functions for blk-mq drivers
>>> + */
>>>    struct blk_mq_ops {
>>> -    /*
>>> -     * Queue request
>>> +    /**
>>> +     * @queue_rq: Queue a new request from block IO.
>>>         */
>>>        queue_rq_fn        *queue_rq;
>>>    -    /*
>>> -     * If a driver uses bd->last to judge when to submit requests to
>>> -     * hardware, it must define this function. In case of errors that
>>> -     * make us stop issuing further requests, this hook serves the
>>> +    /**
>>> +     * @commit_rqs: If a driver uses bd->last to judge when to submit
>>> +     * requests to hardware, it must define this function. In case
>>> of errors
>>> +     * that make us stop issuing further requests, this hook serves the
>>>         * purpose of kicking the hardware (which the last request
>>> otherwise
>>>         * would have done).
>>>         */
>>>        commit_rqs_fn        *commit_rqs;
>>
>> Stuff like this is MUCH better. Why isn't all of it done like this?
>
> Hi Jens,
> 
> If you prefer this style you may want to update
> Documentation/doc-guide/kernel-doc.rst. I think that document recommends
> another style for documenting struct members, maybe because that style
> requires less vertical space:

The same documentation also suggests that one can use inline comments:

In-line member documentation comments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The structure members may also be documented in-line within the definition.
There are two styles, single-line comments where both the opening
``/**`` and
closing ``*/`` are on the same line, and multi-line comments where they
are each
on a line of their own, like all other kernel-doc comments::

  /**
   * struct foo - Brief description.
   * @foo: The Foo member.
   */
  struct foo {
        int foo;
        /**
         * @bar: The Bar member.
         */
...


You can also check this here:
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#in-line-member-documentation-comments

Thanks,
	André
