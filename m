Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27A1C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 04:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A372064D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 04:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Gu+JxVnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A372064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLGEGW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:06:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40567 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGEGW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 23:06:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so1258071pfo.7
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 20:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X+RsUpsxuCbzetcThXmC+/tKTO1O+nUZGqKTon+2pvE=;
        b=Gu+JxVnusseIBv7Tuu2Yef4fvcXVA32Ay/U5iVtifiAG1Bhob+f469c2sTeHCNfno9
         CvZiCamDsXooCvi8VTcpx2QtBRPEJkdauxJCUZvTqYor3xBh9+1zoNBhvUk4toFL7MtF
         VbKTwTHMd6RVGzQ0ZqhWylY7jbrynQlgsiKXMxikuNP2auUypGYOLCCfDHhJXVKAgJxB
         9ozialArYaVqtNTQvVMO9XLjz5ETaaxQGXOAUcBsHEbhodgzdU5w5/ZpR+c/g5T+rdm6
         YSQIiqsCor7KpAJ3gGIjeQvq+0kjDh/1IlAcHYKg0+QS9lnwQgKL1ZQ3egS85yA+VuDz
         kkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X+RsUpsxuCbzetcThXmC+/tKTO1O+nUZGqKTon+2pvE=;
        b=dpqcE/nFQKpk1Bm+VIdtj1CS/d4kVQ47Q9HMsYhd5Nc0gOa5F5rhlHuzbP00VUI1ub
         td0kuUIRX6QeLMcnrQbVkQBzEWVw8XtrN9k8Trck3Y/aPpJldTA1vJaxpwtG5MLwEkQt
         2UwDlHNv7GX5qrAku58aUC2+M3Z2nCWK9LauTMMZfYc0NlGspEYVRlXRCmu3yOF3iXQc
         di2SijDzIwCOmAOV4M5xNVDNVZ7NJ2F43ezCRXWQqPykq2ZY5BYfoiC3Sb/KrdzUiZWS
         WPULa2qU0QObUDa8nBJ4XTIT526+zfPioz3MoCbs8Z8R1qMoIMy4Dt6UAMe8sZI0+Rbp
         6bfw==
X-Gm-Message-State: AA+aEWaKK4eg7S9Ukh0urT+JtIDwtEYfoUoHj+bVw85thle0G5+OFH2d
        qpFs4+96TpRrekH5pOlf+6g6aA==
X-Google-Smtp-Source: AFSGD/UVIHghrzqO+/ENzCh/DI1DHT0JSZeUAbAINhlMLho7UcxTskvhLC4yIPb2n5T1ROwLJ7vCvQ==
X-Received: by 2002:a62:34c6:: with SMTP id b189mr723876pfa.229.1544155581795;
        Thu, 06 Dec 2018 20:06:21 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j14sm2361191pfn.175.2018.12.06.20.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 20:06:20 -0800 (PST)
Subject: Re: [PATCH v2] block/dm: fix handling of busy off direct dispatch
 path
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <e6024b99-579a-ce20-ca3a-a9983582ea36@kernel.dk>
 <20181207035449.GB17585@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5fa50933-2bd0-9ad5-ce60-4b4b130b2841@kernel.dk>
Date:   Thu, 6 Dec 2018 21:06:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207035449.GB17585@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 8:54 PM, Mike Snitzer wrote:
> On Thu, Dec 06 2018 at  9:49pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> After the direct dispatch corruption fix, we permanently disallow direct
>> dispatch of non read/write requests. This works fine off the normal IO
>> path, as they will be retried like any other failed direct dispatch
>> request. But for the blk_insert_cloned_request() that only DM uses to
>> bypass the bottom level scheduler, we always first attempt direct
>> dispatch. For some types of requests, that's now a permanent failure,
>> and no amount of retrying will make that succeed.
>>
>> Use the driver private RQF_DONTPREP to track this condition in DM. If
>> we encounter a BUSY condition from blk_insert_cloned_request(), then
>> flag the request with RQF_DONTPREP. When we next time see this request,
>> ask blk_insert_cloned_request() to bypass insert the request directly.
>> This avoids the livelock of repeatedly trying to direct dispatch a
>> request, while still retaining the BUSY feedback loop for blk-mq so
>> that we don't over-dispatch to the lower level queue and mess up
>> opportunities for merging on the DM queue.
>>
>> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
>> Reported-by: Bart Van Assche <bvanassche@acm.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> This passes my testing as well, like the previous patch. But unlike the
>> previous patch, we retain the BUSY feedback loop information for better
>> merging.
> 
> But it is kind of gross to workaround the new behaviour to "permanently
> disallow direct dispatch of non read/write requests" by always failing
> such requests back to DM for later immediate direct dispatch.  That
> bouncing of the request was acceptable when there was load-based
> justification for having to retry (and in doing so: taking the cost of
> freeing the clone request gotten via get_request() from the underlying
> request_queues).
> 
> Having to retry like this purely because the request isn't a read or
> write seems costly.. every non-read-write will have implied
> request_queue bouncing.  In multipath's case: it could select an
> entirely different underlying path the next time it is destaged (with
> RQF_DONTPREP set).  Which you'd think would negate all hope of IO
> merging based performance improvements -- but that is a tangent I'll
> need to ask Ming about (again).
> 
> I really don't like this business of bouncing requests as a workaround
> for the recent implementation of the corruption fix.
> 
> Why not just add an override flag to _really_ allow direct dispatch for
> _all_ types of requests?
> 
> (just peeked at linux-block and it is looking like you took 
> jianchao.wang's series to avoid this hack... ;)
> 
> Awesome.. my work is done for tonight!

The whole point is doing something that is palatable to 4.20 and leaving
the more experimental stuff to 4.21, where we have some weeks to verify
that there are no conditions that cause IO stalls. I don't envision there
will be, but I'm not willing to risk it this late in the 4.20 cycle.

That said, this isn't a quick and dirty and I don't think it's fair
calling this a hack. Using RQF_DONTPREP is quite common in drivers to
retain state over multiple ->queue_rq invocations. Using it to avoid
multiple direct dispatch failures (and obviously this new livelock)
seems fine to me.

I really don't want to go around and audit every driver for potential
retained state over special commands, that's why the read+write thing is
in place. It's the safe option, which is what we need right now.

-- 
Jens Axboe

