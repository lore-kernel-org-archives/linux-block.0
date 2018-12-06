Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250D7C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAA82082B
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 22:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="txtCHe9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAA82082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbeLFWPt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:15:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:40215 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLFWPt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 17:15:49 -0500
Received: by mail-it1-f196.google.com with SMTP id h193so4095577ita.5
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 14:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fq7/g//dXazhMzyuOWSxq6nFitCajKSaqZtTkj0D1hU=;
        b=txtCHe9WhFtxUag3CxtxAs3R8WCr3MyM4QGVljpbiyQzVgikr7bH9QKaT3c6tvYAh5
         hvvT4Ea+8NbGSaAJUeITOkn8JIT2r75gG16RADUTCdNbiMEMRn2v1Ogke7dBmXvZ0ZUx
         aLYoWaL0Ot+ma+Y/WY5ULaP4O8Zgviu9dkATnwTL7w25LWBUdIjZuboz0SKESLYO6f8z
         00/caRBubf/fob5w6HpyQcqGQsslSCX/OSsyKqnepqHSubOrB/DDHWkXFEEBecOA9PVK
         x7+wrIAeDYu3BWOyRjaxIrYcwJeCk69aqxDpV/dVnQmyteddOJcqdlv5NBWaDOWsWXLK
         bP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fq7/g//dXazhMzyuOWSxq6nFitCajKSaqZtTkj0D1hU=;
        b=YsLiXk2hqxTZbENq+FOA12KF7AyWp/J1EGnVoYNjKRCq8/NaqCqixnhp3sa5KqZAlj
         2DgRuxRXkrmGNwpOcjMXsD8Bt7kd9OR//ZvVunnAr6iWwbohMKEym0xV8pi9x+dvjpPB
         IcZUJiDWew6YoFw/+Ye9cN81lVVURej4LHk0VuA6yY29mjqEzjYtzG7Z0nRJDQfwnLDg
         OMK2jQT+SOB/7/LINEcwf6ZyVnvUG6EzOQo80FhY/sEpbY279nftkGWgyxvYkjEmDzxj
         nhWtH3yYwEtONhbsXtnfXkBM+YYLSpJndxIbSSDEvY42s/DEcT4q6Jk7zYyemTOo85rA
         4M1g==
X-Gm-Message-State: AA+aEWZiEhKOVLKllga5LbHuZrrYk2ZYhRmvF38WGs/ZImX2qfo/Wo8V
        BUJ2w8pWQ62yx0ncWvuENjM5rw==
X-Google-Smtp-Source: AFSGD/Vt2qN4qaInbu12klon758MdiwKvH39t5gMn58V0XsZYdOFfDSGB7cxQiSOuC75GJ1v1tRUXg==
X-Received: by 2002:a24:1a90:: with SMTP id 138mr106780iti.171.1544134548184;
        Thu, 06 Dec 2018 14:15:48 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r139sm1162300ior.53.2018.12.06.14.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 14:15:47 -0800 (PST)
Subject: Re: for-next branch and blktests/srp
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <1544114872.185366.250.camel@acm.org>
 <1544129803.185366.287.camel@acm.org>
 <aa8b66c5-1ae8-b21e-cbad-6c447351d545@kernel.dk>
Message-ID: <b4f97d6a-cacd-09db-ce7b-c3c2a8bb8bde@kernel.dk>
Date:   Thu, 6 Dec 2018 15:15:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <aa8b66c5-1ae8-b21e-cbad-6c447351d545@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 2:04 PM, Jens Axboe wrote:
> On 12/6/18 1:56 PM, Bart Van Assche wrote:
>> On Thu, 2018-12-06 at 08:47 -0800, Bart Van Assche wrote:
>>> If I merge Jens' for-next branch with Linus' master branch, boot the
>>> resulting kernel in a VM and run blktests/tests/srp/002 then that test
>>> never finishes. The same test passes against Linus' master branch. I
>>> think this is a regression. The following appears in the system log if
>>> I run that test:
>>>
>>> Call Trace:
>>> INFO: task kworker/0:1:12 blocked for more than 120 seconds.
>>> Call Trace:
>>> INFO: task ext4lazyinit:2079 blocked for more than 120 seconds.
>>> Call Trace:
>>> INFO: task fio:2151 blocked for more than 120 seconds.
>>> Call Trace:
>>> INFO: task fio:2154 blocked for more than 120 seconds.
>>
>> Hi Jens,
>>
>> My test results so far are as follows:
>> * With kernel v4.20-rc5 test srp/002 passes.
>> * With your for-next branch test srp/002 reports the symptoms reported in my e-mail.
>> * With Linus' master branch from this morning test srp/002 fails in the same way as
>>   your for-next branch.
>> * Also with Linus' master branch, test srp/002 passes if I revert the following commit:
>>   ffe81d45322c ("blk-mq: fix corruption with direct issue"). So it seems like that
>>   commit fixed one regression but introduced another regression.
> 
> Yes, I'm on the same page, I've been able to reproduce. It seems to be related
> to dm and bypass insert, which is somewhat odd. If I just do:
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index deb56932f8c4..4c44e6fa0d08 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2637,7 +2637,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
>  		 * bypass a potential scheduler on the bottom device for
>  		 * insert.
>  		 */
> -		return blk_mq_request_issue_directly(rq);
> +		blk_mq_request_bypass_insert(rq, true);
> +		return BLK_STS_OK;
>  	}
>  
>  	spin_lock_irqsave(q->queue_lock, flags);
> 
> it works fine. Well, at least this regression is less serious, I'll bang
> out a fix for it and ensure we make -rc6. I'm guessing it's the bypassin
> of non-read/write, which your top of dispatch also shows to be a
> non-read/write. But there should be no new failure case here that wasn't
> possible before, only it's easier to hit now.

OK, so here's the thing. As part of the corruption fix, we disallowed
direct dispatch for anything that wasn't a read or write. This means
that your WRITE_ZEROES will always fail direct dispatch. When it does,
we return busy. But next time dm will try the exact same thing again,
blk_insert_cloned_request() -> direct dispatch -> fail. Before we'd succeed
eventually, now we will always fail for that type.

The insert clone path is unique in that regard.

So we have two options - the patch I did above which always just does
bypass insert for DM, or we need to mark the request as having failed
and just not retry direct dispatch for it. I'm still not crazy about
exploring the dispatch insert off this path.

And we'd need to do this on the original request in dm, not the clone
we are passed or it won't be persistent. Hence I lean towards the
already posted patch.

-- 
Jens Axboe

