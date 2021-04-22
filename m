Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E1BC433ED
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 15:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E2A61026
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 15:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhDVPvo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:51:44 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:46888 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbhDVPvn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Apr 2021 11:51:43 -0400
Received: by mail-pf1-f169.google.com with SMTP id d124so31953506pfa.13
        for <linux-block@vger.kernel.org>; Thu, 22 Apr 2021 08:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PW0nji90BIio4iDEgaGvaY58f3TfH9x+AyzDNtM2SUQ=;
        b=JEw8znZwFltAoHy0jsT8rMEBU5mvZbsWdVOlih+wYQFJPfoFC0lZZg3VB7Yg4SbW4U
         CX19Jpk3uSJpwOpoBJrWEs24umWh1TXWWR4YEkvDXYs6eeDCKyB34hfP9d5ejgdFILfC
         ZdTiytKgNHOQH73SYYPonS9Leevkxcgj04ai/hibqz628RHVqQYSlCRDI7S7eOURdxvz
         gWZKDkBIMf4sy8LzYBtmR3eoPlqQgjGS4f/2wX0lZxjoBoHlm1vIfNH9tC83tA4z27Kq
         syja8tJJhBNwPGriSQ3/8fOpyjiHIa9M3xzo4dFmjvm3AG1Pp69PthGLZl4A5MKl3rB6
         3Z3A==
X-Gm-Message-State: AOAM530CohR96xVMvJUr6yilvcvIedlz/6DU5Hb+M6zo4oURzt+VbDvc
        iJwigB4S4lgqmOhLcgEiuA+2l6BFVdY=
X-Google-Smtp-Source: ABdhPJx27UrYcqVTsFTvldobTE3xzSbye1/2Wt5dQwPBpgsXU6nBeixhSovSYwoVavNqfKv2CfrclA==
X-Received: by 2002:a62:6481:0:b029:249:ecee:a05d with SMTP id y123-20020a6264810000b0290249eceea05dmr4095198pfb.9.1619106668175;
        Thu, 22 Apr 2021 08:51:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:ca3e:c761:2ef0:61cd? ([2601:647:4000:d7:ca3e:c761:2ef0:61cd])
        by smtp.gmail.com with ESMTPSA id 123sm2427190pfx.180.2021.04.22.08.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 08:51:07 -0700 (PDT)
Subject: Re: [PATCH v7 3/5] blk-mq: Fix races between iterating over requests
 and freeing requests
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Khazhismel Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.garry@huawei.com>
References: <20210421000235.2028-1-bvanassche@acm.org>
 <20210421000235.2028-4-bvanassche@acm.org> <YIDqa6YkNoD5OiKN@T590>
 <b717ffc0-a434-738f-9c63-32901bd164b2@acm.org> <YIEiElb9wxReV/oL@T590>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <32a121b7-2444-ac19-420d-4961f2a18129@acm.org>
Date:   Thu, 22 Apr 2021 08:51:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIEiElb9wxReV/oL@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/21 12:13 AM, Ming Lei wrote:
> On Wed, Apr 21, 2021 at 08:54:30PM -0700, Bart Van Assche wrote:
>> On 4/21/21 8:15 PM, Ming Lei wrote:
>>> On Tue, Apr 20, 2021 at 05:02:33PM -0700, Bart Van Assche wrote:
>>>> +static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>>> +{
>>>> +	struct bt_tags_iter_data *iter_data = data;
>>>> +	struct blk_mq_tags *tags = iter_data->tags;
>>>> +	bool res;
>>>> +
>>>> +	if (iter_data->flags & BT_TAG_ITER_MAY_SLEEP) {
>>>> +		down_read(&tags->iter_rwsem);
>>>> +		res = __bt_tags_iter(bitmap, bitnr, data);
>>>> +		up_read(&tags->iter_rwsem);
>>>> +	} else {
>>>> +		rcu_read_lock();
>>>> +		res = __bt_tags_iter(bitmap, bitnr, data);
>>>> +		rcu_read_unlock();
>>>> +	}
>>>> +
>>>> +	return res;
>>>> +}
>>>
>>> Holding one rwsem or rcu read lock won't avoid the issue completely
>>> because request may be completed remotely in iter_data->fn(), such as
>>> nbd_clear_req(), nvme_cancel_request(), complete_all_cmds_iter(),
>>> mtip_no_dev_cleanup(), because blk_mq_complete_request() may complete
>>> request in softirq, remote IPI, even wq, and the request is still
>>> referenced in these contexts after bt_tags_iter() returns.
>>
>> The rwsem and RCU read lock are used to serialize iterating over
>> requests against blk_mq_sched_free_requests() calls. I don't think it
>> matters for this patch from which context requests are freed.
> 
> Requests still can be referred in other context after blk_mq_wait_for_tag_iter()
> returns, then follows freeing request pool. And use-after-free exists too, doesn't it?

The request pool should only be freed after it has been guaranteed that
all pending requests have finished and also that no new requests will be
started. This patch series adds two blk_mq_wait_for_tag_iter() calls.
Both calls happen while the queue is frozen so I don't think that the
issue mentioned in your email can happen.

Bart.
