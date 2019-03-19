Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16892C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 04:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA08A20854
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 04:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DZjf0Z1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfCSEEl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Mar 2019 00:04:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42809 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfCSEEk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Mar 2019 00:04:40 -0400
Received: by mail-oi1-f194.google.com with SMTP id w139so6142410oie.9
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 21:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+jBfmrowfcH2J/qQqo9idvj9cqHVWDySDwGkrCAoSVs=;
        b=DZjf0Z1sfjXCx8dXXy0hZRc/m7mhxvWXkwAIjRN+oujKJIF2igYLyUHHKczVH8n97c
         ehqFFz+qyQR9BvLS191lrPoAVUbG3pr5Ru+0UbZx1n8aEkRc6P1g13b9GLJXfMlS4fIN
         foNU4yseau9mPTrXbmzQcmO0UeJMyIqq+1lrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+jBfmrowfcH2J/qQqo9idvj9cqHVWDySDwGkrCAoSVs=;
        b=C2cbmMB+kmtWY3w/J4JQhsWuZ0evORWSTgTFvNv1zsCqubXmGydJOKJH4zlsHVOjMD
         RHH7MXBgoyFn1Vlr6TAF3eNOI9sF6kPkOXYmbvqv345H8WIynw3oM7/0qhNy3XRAfw1V
         OfmBOixPytG7qqEKVl78hiKNxWTs/wXkcBv6Me3lhmlioaxmCqolionLq/wKeVkVb4pg
         iufEZewUHs2q5aYXBK7DdvZxNHO7TW9kg52gJ/j6JQ7j3JCnonhGCXY2gi56IkmhsWqy
         YT/tVWlGpUOk/qcYF85istYmrf0cdu+FC9iN4afDPBjtGyqLTyOt3Hl1/yUAFFgP0heD
         ZBMg==
X-Gm-Message-State: APjAAAXZQM8FCMIyDwNZNhyNqFj3a/wNERNDKVExJlFvKyYzCn347Czp
        n0uUY6P/z2M88TcwS09qNcf9nb2t1L4=
X-Google-Smtp-Source: APXvYqwSTg24I6O1NC1fBPbdpaF9OCOumEzVH4BiA41swoug6IRtVJLknATrkNKnhs7QyQouT3qkww==
X-Received: by 2002:aca:1e09:: with SMTP id m9mr206622oic.142.1552968279835;
        Mon, 18 Mar 2019 21:04:39 -0700 (PDT)
Received: from [192.168.1.237] (ip68-5-145-143.oc.oc.cox.net. [68.5.145.143])
        by smtp.gmail.com with ESMTPSA id e12sm4030028otl.61.2019.03.18.21.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 21:04:38 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <4563485a-02c6-0bfe-d9ec-49adbd44671c@broadcom.com>
 <20190319013142.GB22459@ming.t460p>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <cb036f6f-3dd5-cf7b-4811-6c7d97a2279e@broadcom.com>
Date:   Mon, 18 Mar 2019 21:04:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190319013142.GB22459@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/18/2019 6:31 PM, Ming Lei wrote:
> On Mon, Mar 18, 2019 at 10:37:08AM -0700, James Smart wrote:
>>
>> On 3/17/2019 8:29 PM, Ming Lei wrote:
>>> In NVMe's error handler, follows the typical steps for tearing down
>>> hardware:
>>>
>>> 1) stop blk_mq hw queues
>>> 2) stop the real hw queues
>>> 3) cancel in-flight requests via
>>> 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
>>> cancel_request():
>>> 	mark the request as abort
>>> 	blk_mq_complete_request(req);
>>> 4) destroy real hw queues
>>>
>>> However, there may be race between #3 and #4, because blk_mq_complete_request()
>>> actually completes the request asynchronously.
>>>
>>> This patch introduces blk_mq_complete_request_sync() for fixing the
>>> above race.
>>>
>> This won't help FC at all. Inherently, the "completion" has to be
>> asynchronous as line traffic may be required.
>>
>> e.g. FC doesn't use nvme_complete_request() in the iterator routine.
>>
> Looks FC has done the sync already, see nvme_fc_delete_association():
>
> 		...
>          /* wait for all io that had to be aborted */
>          spin_lock_irq(&ctrl->lock);
>          wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
>          ctrl->flags &= ~FCCTRL_TERMIO;
>          spin_unlock_irq(&ctrl->lock);

yes - but the iterator started a lot of the back end io terminating in 
parallel. So waiting on many happening in parallel is better than 
waiting 1 at a time.   Even so, I've always disliked this wait and would 
have preferred to exit the thread with something monitoring the 
completions re-queuing a work thread to finish.

-- james

