Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18B9C2BA83
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 17:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C504B21734
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 17:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBMRs2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:48:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44709 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMRs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 12:48:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id y5so3417396pfb.11;
        Thu, 13 Feb 2020 09:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pP7X7VpagPTi9HZ9HZW3ysdxWbV8k6DVY1p7fIv5A/k=;
        b=IInrfIcIKHFsDny/NWUMVQKT2mybp1GVL2SNOOKp85PttcVtDllDnAXUPYUEzuqEDR
         qULoXy/FXoOS4EHT/gyTWhONOKX7WTvNoD6hn9C5/MpnSCUwDkadUy5EPCDf9k5Uz7Tc
         eHWASSkjCv3ObZfISxOEQZ6E9PC7p9PQmpyg4dQjvQ58fP3Zf49sUxeZhBPmReK+JCGK
         Z3UL0hcEsk7srSzuSUYkFUDbVARxRll5/1oOVq4QmXlomvN1ke3zGf1wSCfD9s80zJFY
         jYwTFiIrBWvKIIRPbJZ0JYUBw1bFCH98Gtm8ZDtcoeJf/o+AN5BbSkpG9JWHctP6qmfh
         KbOw==
X-Gm-Message-State: APjAAAX1omz9DIFGAduhiwvl4aMp8W6Mtm4oywtK/ED9bkXBSwJ/QCBi
        TER5dXI/P0d8r0WjFT510VM=
X-Google-Smtp-Source: APXvYqyzsjzexwiaODhvRT6yFDzwhtHjJYHobpHzY7pHXzRJtlZl2uIq8ioeW/8eC/ual6BztKyAWg==
X-Received: by 2002:a63:64c5:: with SMTP id y188mr18858960pgb.10.1581616107449;
        Thu, 13 Feb 2020 09:48:27 -0800 (PST)
Received: from ?IPv6:2620:15c:2c0:5:2d74:bb8d:dd9b:a53e? ([2620:15c:2c0:5:2d74:bb8d:dd9b:a53e])
        by smtp.gmail.com with ESMTPSA id g72sm4119754pfb.11.2020.02.13.09.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 09:48:26 -0800 (PST)
Subject: Re: BLKSECDISCARD ioctl and hung tasks
To:     Ming Lei <ming.lei@redhat.com>, Salman Qazi <sqazi@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200213082643.GB9144@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
Date:   Thu, 13 Feb 2020 09:48:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200213082643.GB9144@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/13/20 12:26 AM, Ming Lei wrote:
> The approach used in blk_execute_rq() can be borrowed for workaround the
> issue, such as:
> 
> diff --git a/block/bio.c b/block/bio.c
> index 94d697217887..c9ce19a86de7 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -17,6 +17,7 @@
>   #include <linux/cgroup.h>
>   #include <linux/blk-cgroup.h>
>   #include <linux/highmem.h>
> +#include <linux/sched/sysctl.h>
>   
>   #include <trace/events/block.h>
>   #include "blk.h"
> @@ -1019,12 +1020,19 @@ static void submit_bio_wait_endio(struct bio *bio)
>   int submit_bio_wait(struct bio *bio)
>   {
>   	DECLARE_COMPLETION_ONSTACK_MAP(done, bio->bi_disk->lockdep_map);
> +	unsigned long hang_check;
>   
>   	bio->bi_private = &done;
>   	bio->bi_end_io = submit_bio_wait_endio;
>   	bio->bi_opf |= REQ_SYNC;
>   	submit_bio(bio);
> -	wait_for_completion_io(&done);
> +
> +	/* Prevent hang_check timer from firing at us during very long I/O */
> +	hang_check = sysctl_hung_task_timeout_secs;
> +	if (hang_check)
> +		while (!wait_for_completion_io_timeout(&done, hang_check * (HZ/2)));
> +	else
> +		wait_for_completion_io(&done);
>   
>   	return blk_status_to_errno(bio->bi_status);
>   }

Instead of suppressing the hung task complaints, has it been considered 
to use the bio splitting mechanism to make discard bios smaller? Block 
drivers may set a limit by calling blk_queue_max_discard_segments(). 
 From block/blk-settings.c:

/**
  * blk_queue_max_discard_segments - set max segments for discard
  * requests
  * @q:  the request queue for the device
  * @max_segments:  max number of segments
  *
  * Description:
  *    Enables a low level driver to set an upper limit on the number of
  *    segments in a discard request.
  **/
void blk_queue_max_discard_segments(struct request_queue *q,
		unsigned short max_segments)
{
	q->limits.max_discard_segments = max_segments;
}
EXPORT_SYMBOL_GPL(blk_queue_max_discard_segments);

Thanks,

Bart.
