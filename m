Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD9CC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 21:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7C32082B
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 21:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dtjmjZTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7C32082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbeLFVEd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:04:33 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35618 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFVEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 16:04:33 -0500
Received: by mail-it1-f194.google.com with SMTP id p197so3821457itp.0
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 13:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7CsYVSS9Q45OTLTKSzLGm6R+TTwvvdcm/kk/m3ejtvs=;
        b=dtjmjZTLZvYmW/eZMqL7hqyY2O1c6tAdNHRWarWKs9dpgqrUmROaVVZpIUeha5nHfX
         2oK+vOcQgxEGGQtOF4b0qubbVO5qqAaeh0fko0W6KOCc+D2KbYRyu1cKNV9m+Rt8fQkX
         pJ1g+wEw8SyE4p7wngFJ/aJWEvZQ8hiLUrxeGjC9KnjibMceB41eyBdUgTmA+HAoRkCR
         bnUFpC0arIBeE6ITdEGYhjiML/bIwSpUrHzC6cCNJDRb4PWQ4B3dcsJ0QF404533T3EK
         kJlouysyjKWHoxctMzGs3PbQ0YJaPNdeCqQhIdVah4UUk381lkX6ck2ieKVxDTKgvb9V
         NwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7CsYVSS9Q45OTLTKSzLGm6R+TTwvvdcm/kk/m3ejtvs=;
        b=S57v1+6Egvvw1ollaB2BvYhsYu4yMoNhdYubpyuYBbENQGJPbk/oc81/nD9e0+VNFG
         81i+HXkKBFOdVzsqmDG62P+fUR2CJBpBb7QlBmrAggpydfMR/71BV6G12xYBWMxF6TdL
         m+aTkoidvceuPVvnoeAIOLYTxULHe55vL17Ex8pvGg9FcZMt/KekmgBEFXV6+kkOtVKY
         /iNYm1FUUaaYW+RwhP4v74AyBYbFLXaiPFnVp1pS2G5nxRsx/KeMTsNEt9y+1jhxTO+S
         kWBF4cFaLWq1U2nX79BlwO59/vC5dt/6p0DANChzMGPjqn9Iv6t8v2xLSkOHZw41Au3d
         tF6g==
X-Gm-Message-State: AA+aEWbzMd0Cp6gvccf59HHF6z1bPN3z4ziUIDG61v3kaaDvPkdg0PPu
        bWVLTvJsklxeLEDnsJQffLwy6g==
X-Google-Smtp-Source: AFSGD/VlDQxbEXUW+eMweoj+5kX8L8/iOTLi8XQtcPtENuW76jV7EJK03hxDy2pFbNoflvIMPnq32g==
X-Received: by 2002:a24:3391:: with SMTP id k139mr19832112itk.25.1544130272527;
        Thu, 06 Dec 2018 13:04:32 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m37sm837597iti.6.2018.12.06.13.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 13:04:31 -0800 (PST)
Subject: Re: for-next branch and blktests/srp
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <1544114872.185366.250.camel@acm.org>
 <1544129803.185366.287.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa8b66c5-1ae8-b21e-cbad-6c447351d545@kernel.dk>
Date:   Thu, 6 Dec 2018 14:04:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544129803.185366.287.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 1:56 PM, Bart Van Assche wrote:
> On Thu, 2018-12-06 at 08:47 -0800, Bart Van Assche wrote:
>> If I merge Jens' for-next branch with Linus' master branch, boot the
>> resulting kernel in a VM and run blktests/tests/srp/002 then that test
>> never finishes. The same test passes against Linus' master branch. I
>> think this is a regression. The following appears in the system log if
>> I run that test:
>>
>> Call Trace:
>> INFO: task kworker/0:1:12 blocked for more than 120 seconds.
>> Call Trace:
>> INFO: task ext4lazyinit:2079 blocked for more than 120 seconds.
>> Call Trace:
>> INFO: task fio:2151 blocked for more than 120 seconds.
>> Call Trace:
>> INFO: task fio:2154 blocked for more than 120 seconds.
> 
> Hi Jens,
> 
> My test results so far are as follows:
> * With kernel v4.20-rc5 test srp/002 passes.
> * With your for-next branch test srp/002 reports the symptoms reported in my e-mail.
> * With Linus' master branch from this morning test srp/002 fails in the same way as
>   your for-next branch.
> * Also with Linus' master branch, test srp/002 passes if I revert the following commit:
>   ffe81d45322c ("blk-mq: fix corruption with direct issue"). So it seems like that
>   commit fixed one regression but introduced another regression.

Yes, I'm on the same page, I've been able to reproduce. It seems to be related
to dm and bypass insert, which is somewhat odd. If I just do:

diff --git a/block/blk-core.c b/block/blk-core.c
index deb56932f8c4..4c44e6fa0d08 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2637,7 +2637,8 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 		 * bypass a potential scheduler on the bottom device for
 		 * insert.
 		 */
-		return blk_mq_request_issue_directly(rq);
+		blk_mq_request_bypass_insert(rq, true);
+		return BLK_STS_OK;
 	}
 
 	spin_lock_irqsave(q->queue_lock, flags);

it works fine. Well, at least this regression is less serious, I'll bang
out a fix for it and ensure we make -rc6. I'm guessing it's the bypassin
of non-read/write, which your top of dispatch also shows to be a
non-read/write. But there should be no new failure case here that wasn't
possible before, only it's easier to hit now.

-- 
Jens Axboe

