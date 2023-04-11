Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C69C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 17:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDKRNP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDKRNN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 13:13:13 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921475582
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:13:10 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id jx2-20020a17090b46c200b002469a9ff94aso6875919pjb.3
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 10:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681233190; x=1683825190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6E9T8lqcuOm+XhzPlmWoA4UJ0qT4HKFcYG96P1qOJM=;
        b=p4ODDe+FLro6Z7WDcYtzhN9GK7QDdlRGLVz69UGKhsWtH2DXs2uC8Er72qtL8ymi9N
         QafhPG8T64qeJw2vwMlBNTZeD0KlyhZIShqgpxWzJCv509hypFh4y50IItQnpLCslvLr
         MMY90jHkw2ZYWHJuRozg2Nnu0aVsi/iZfD4g1nFxvRYZ8sE/EVi+MoF7A8Bef7YJXzT/
         w0IH5cE2vG2/Tqs9/sgBU4mq4UydHPO6HDWxBRWKXNBbXUOq8078UzEYyd9GlZpKFLr8
         FHzzwCRPlrb8fLEswhjRjItQL4KyQanYAbxDREx0TVHtu9P8DE0Jef/D1vdg7tdVZSsy
         LTUQ==
X-Gm-Message-State: AAQBX9eKJ6BZ6zXLHE9KXJhU/GH94T4ngiEaIitkrOdysIpOK8Fs6BhM
        +RS0RONhHxa742F8zPsyTr4=
X-Google-Smtp-Source: AKy350Y11bPWxdCaLA+dFoePoLAi+OFMZUa/D3ScUh6dfTppgTGE/W2iGVoF99oK4GLiz/a3a0HE4g==
X-Received: by 2002:a17:90b:1d0d:b0:23d:bbcb:c97f with SMTP id on13-20020a17090b1d0d00b0023dbbcbc97fmr18330706pjb.1.1681233189575;
        Tue, 11 Apr 2023 10:13:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id g7-20020a170902740700b0019ab151eb90sm9920164pll.139.2023.04.11.10.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:13:08 -0700 (PDT)
Message-ID: <59234b97-95c8-c510-da37-13fb1729a7a0@acm.org>
Date:   Tue, 11 Apr 2023 10:13:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 02/12] block: Send flush requests to the I/O scheduler
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
References: <20230407235822.1672286-1-bvanassche@acm.org>
 <20230407235822.1672286-3-bvanassche@acm.org>
 <af4aeeea-79b2-8b0d-df8b-63f5ae6752d7@kernel.org>
 <f81541f6-2fba-3d62-bd63-6b00b5cf5f5d@acm.org>
 <20230411063812.GA19616@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411063812.GA19616@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/23 23:38, Christoph Hellwig wrote:
> On Mon, Apr 10, 2023 at 05:15:44PM -0700, Bart Van Assche wrote:
>> +		blk_mq_sched_insert_request(rq, /*at_head=*/false,
>> +					    /*run_queue=*/true, /*async=*/true);
> 
> And place drop these silly comments.  If you want to do something about
> this rather suboptimal interface convert the three booleans to a flags
> argument with properly named flags.

I will remove these comments, but it is not clear to me what is silly about
these comments. There are even tools that can check the correctness of these
comments. See also
https://clang.llvm.org/extra/clang-tidy/checks/bugprone/argument-comment.html

>> -	if ((rq->rq_flags & RQF_FLUSH_SEQ) || blk_rq_is_passthrough(rq))
>> -		return true;
>> -
>> -	return false;
>> +	return req_op(rq) == REQ_OP_FLUSH || blk_rq_is_passthrough(rq);
> 
> This just seem like an arbitrary reformatting.  While I also prefer
> your new version, I don't think it belongs into this patch.

I will move this change into a patch of its own.

Thanks,

Bart.
