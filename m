Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7987ECAAA1
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 00:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKAAD2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 20:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKAAD0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 20:03:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EB8F035
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 17:03:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so12121859pls.9
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 17:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4+6Toyb+eDc+4qfWmzy+YHkrPt2weyWzkOzU7k0RiE=;
        b=GPOpoBC82t5ndhjXadEKyBMTP66+OLe7jkN7Iwo9C1rWFyWYZ7a0n08BU/9A/PwfyV
         Fmm5x6BGGhmfaEWWq+Y9Kv3Zuqw1JW9UOR99RFHLN28mD8VA0cvR7YVQXORLgnNLo6r1
         uhbis3ZGnEUy6tQ3TKxIE8t/UD52mGFWkq5zk7ttevF/L80VWIkMxt/Bgj/yTW2B7WLC
         h9Vz7pq8iVw+ZLuqsQGmvUEeGdJ7AW0TLrPaXRk2snxFwUUleR3CZ5LWY8l2uz/WSbm6
         y6VwWjPwlzRWIbkUoeigW7yvQXhy4eo8o1ZpyTG/evVELdsGhVziHir+SGhGdS0M+11e
         ng0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4+6Toyb+eDc+4qfWmzy+YHkrPt2weyWzkOzU7k0RiE=;
        b=VGX9rkp4KmBPA7hCvCWiLI+bwR+qlb7xhxa+uWFNgmShEO//myGJ8ZQNMzvbbeeL1B
         XDjbCCkZHfEXVZ4nat5u9bJkYiIDnF20HGJfeaA3iI30r30vFU9KqSAmtNCwfMkxlfuq
         HqNtoH+QGPVuON3rAMNGKng7BNTzC8Rb3vaoC/JEt9zKBzXDBsR7GfDU5JHNJj/hGwoZ
         qWPPR1x7eVbpKF9XkNqS/GsdchDc6bU2O/bUly/utx2tmcWyub9+aCuJR3KMVnLLb2CJ
         TrAH42yClCQG4EhuHguP2KDfrH3BWPfv1+iRvena+azhh8QH8Ezy1yMRmcqrMPyq8KKQ
         JbXg==
X-Gm-Message-State: ACrzQf3yLCN2J91pVKB3ljLLIYm8nBbEKu5ztLC/hJzAZvrJtXMxyr0k
        y7iHiNIQ/QSiwbNZOA1AAhMLB2Qm7VetShxD
X-Google-Smtp-Source: AMsMyM4AeD4i16vKpzNCpScs4KV4jWKtLp2kwXEg5+FrfDKTDDvdrECgHtTLHLxfgcv9WGdv6/6c3g==
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id a12-20020a170903100c00b0018663a13b5dmr17239405plb.148.1667261004491;
        Mon, 31 Oct 2022 17:03:24 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b00168dadc7354sm4982625plx.78.2022.10.31.17.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 17:03:24 -0700 (PDT)
Message-ID: <8ae6352c-7880-b51c-004c-06835858a349@kernel.dk>
Date:   Mon, 31 Oct 2022 18:03:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: UAF in blk_add_rq_to_plug()?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org
References: <Y2BIad98er4QsbZY@ZenIV>
 <1a46585b-878b-a3b7-3090-36bddba86dbd@kernel.dk> <Y2BbvIdYGM/4L66H@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y2BbvIdYGM/4L66H@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/22 5:35 PM, Al Viro wrote:
> On Mon, Oct 31, 2022 at 04:42:11PM -0600, Jens Axboe wrote:
>> On 10/31/22 4:12 PM, Al Viro wrote:
>>> static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>>> {
>>>         struct request *last = rq_list_peek(&plug->mq_list);
>>>
>>> Suppose it's not NULL...
>>>
>>>         if (!plug->rq_count) {
>>>                 trace_block_plug(rq->q);
>>>         } else if (plug->rq_count >= blk_plug_max_rq_count(plug) ||
>>>                    (!blk_queue_nomerges(rq->q) &&
>>>                     blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
>>> ... and we went here:
>>>                 blk_mq_flush_plug_list(plug, false);
>>> All requests, including the one last points to, might get fed ->queue_rq()
>>> here.  At which point there seems to be nothing to prevent them getting
>>> completed and freed on another CPU, possibly before we return here.
>>>
>>>                 trace_block_plug(rq->q);
>>>         }
>>>
>>>         if (!plug->multiple_queues && last && last->q != rq->q)
>>> ... and here we dereference last.
>>>
>>> Shouldn't we reset last to NULL after the call of blk_mq_flush_plug_list()
>>> above?
>>
>> There's no UAF here as the requests aren't freed. We could clear 'last'
>> to make the code more explicit, and that would avoid any potential
>> suboptimal behavior with ->multiple_queues being wrong.
> 
> Umm...
> Suppose ->has_elevator is false and so's ->multiple_queues.
> No ->queue_rqs(), so blk_mq_flush_plug_list() grabs rcu_read_lock() and
> hit blk_mq_plug_issue_direct().
> blk_mq_plug_issue_direct() picks the first request off the list
> and passes it to blk_mq_request_issue_directly(), which passes it
> to __blk_mq_request_issue_directly().  There we grab a tag and
> proceed to __blk_mq_issue_directly(), which feeds request to ->queue_rq().
> 
> What's to stop e.g. worker on another CPU from picking that sucker,
> completing it and calling blk_mq_end_request() which completes all
> bio involved and calls blk_mq_free_request()?
> 
> If all of that manages to happen before blk_mq_flush_plug_list()
> returns to caller...  Sure, you probably won't hit in on bare
> metal, but if you are in a KVM and this virtual CPU happens to
> lose the host timeslice... I've seen considerably more narrow
> race windows getting hit on such setups.
> 
> Am I missing something subtle here?  It's been a long time since
> I've read through that area - as the matter of fact, I'm trying
> to refresh my memories of the bio_submit()-related code paths
> at the moment...

With blk-mq, which all drivers are these days, the request memory is
statically allocated when the driver is setup. I'm not denying that you
could very well have issued AND completed the request which 'last'
points to by the time we dereference it, but that won't be a UAF unless
the device has also been quiesced and removed in between. Which I guess
could indeed be a possibility since it is by definition on a different
queue (->multiple_queues would be true, however, but that's also what
would be required to reach that far into that statement).

This is different from the older days of a request being literally freed
when it completes, which is what I initially reacted to.

As mentioned in the original reply, I do think we should just clear
'last' as you suggest. But it's not something we've seen on the FB fleet
of servers, even with the majority of hosts running this code (and on
VMs).

-- 
Jens Axboe
