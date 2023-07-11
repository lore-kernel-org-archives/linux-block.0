Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E12EB64DC
	for <linux-block@archiver.kernel.org>; Tue, 11 Jul 2023 11:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGKLPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jul 2023 07:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGKLPt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2023 07:15:49 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74D5BC
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 04:15:48 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b89114266dso41691275ad.0
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 04:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689074148; x=1691666148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=em9xgVa3hdk9NBQVYgyeIMHyNqzlL7w7PxEQ9l0udqc=;
        b=byFHlSTvLjX+wwzL1uvRmsJT9gApAjyX+arz4B0WuWLIPXf9adRD8JGCC0m5rpdMe9
         Rukv7xRdLlo5TDO474aEnxzG63b/BhXJkW5O4RfRWQCvj9Uc9DxxydaeT5APXWcdTzJL
         JpEIF92j/ko0dB3fiPlUgLJukl2johew+Z+rIH8MkWU6bmh0tk/5bm3qWKllXxSkGMWI
         P/DlqxcbxQIiygAcPMKj+x2/9j4ceknrwJLjoejsMqEfoa1fNcHpBTyc2+nsxoMIPaKI
         SdQYCKoSVvk9MqAyIX8fki/wYIypjuA0H9N+hS3B9i5HW2JSajuTBsM0em2NQgZii6sO
         yN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689074148; x=1691666148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=em9xgVa3hdk9NBQVYgyeIMHyNqzlL7w7PxEQ9l0udqc=;
        b=cnXLNo3ahfhtgcd4baHxuicJiy1jz3xAOulJjHPsi3teHWi6DHXT57PC9X6edDF060
         ScdKldCRLkIjC2kpqzFjLCDT7Swqt6i10O/WxzhJvxbEIoWHBW0lzxWUJ3ccwruTqnHy
         6nhg5aNJmkb0Ln++pCcZhIilWsY5UgK5lQopHJ0FMTmSoqtFXfzh2tuPyOJAukCFpL0V
         uDsT5vyh+5+puQpaztadzsITYBNIvFPjFeFhTdfNnKQJtdLuBZNZN9Ell7d8q41ny1B2
         NqYnQPJYmEwA/P9zNVmpfmdEO374kVLseKn/WfjE59VhDsoh/weoBJ+voAFXmC/w9vx4
         vfmg==
X-Gm-Message-State: ABy/qLb5Qkc8J03jHkRQGprC03fZ63FwyIrPT7TgVPbCKgHePjcUzsyN
        8hyQHZLiqY584gTerY7CbBNh9w==
X-Google-Smtp-Source: APBJJlFbdvpSFJFyEKHvLn6aFsX3912I0T7xfw27aLE/jleSdcztYBOYpNDmwbR0v5hKNcPTbyO9/w==
X-Received: by 2002:a17:903:22c6:b0:1b8:72e2:c63 with SMTP id y6-20020a17090322c600b001b872e20c63mr18675118plg.8.1689074148225;
        Tue, 11 Jul 2023 04:15:48 -0700 (PDT)
Received: from [10.4.5.144] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id bc2-20020a170902930200b001b9f032bb3dsm1305219plb.3.2023.07.11.04.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 04:15:47 -0700 (PDT)
Message-ID: <d0e823d9-292d-932c-9849-1d4d08c9f4eb@bytedance.com>
Date:   Tue, 11 Jul 2023 19:15:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [External] Re: [PATCH 1/2] blk-flush: fix rq->flush.seq for
 post-flush requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <chengming.zhou@linux.dev>
References: <20230710064705.1847287-1-chengming.zhou@linux.dev>
 <20230710133024.GA23157@lst.de>
 <4431d779-e6e7-aff1-5cf8-4147de974d8d@linux.dev>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <4431d779-e6e7-aff1-5cf8-4147de974d8d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/7/11 19:06, Chengming Zhou wrote:
> On 2023/7/10 21:30, Christoph Hellwig wrote:
>> On Mon, Jul 10, 2023 at 02:47:04PM +0800, chengming.zhou@linux.dev wrote:
>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>
>>> If the policy == (REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH), it means that the
>>> data sequence and post-flush sequence need to be done for this request.
>>>
>>> The rq->flush.seq should record what sequences have been done (or don't
>>> need to be done). So in this case, pre-flush doesn't need to be done,
>>> we should init rq->flush.seq to REQ_FSEQ_PREFLUSH not REQ_FSEQ_POSTFLUSH.
>>>
>>> Of course, this doesn't cause any problem in fact, since pre-flush and
>>> post-flush sequence do the same thing for now.
>>
>> I wonder if it really doesn't cause any problems, but the change for
>> sure looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> It should probably go before your other flush optimizations and maybe
>> grow a fixes tag.
> 
> Ok, will add a Fixes tag and send it as a separate patch since it's a bug fix.
> 

Well, I should put it in that series before other flush optimizations instead.

