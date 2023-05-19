Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4C6C77B7D
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 01:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjESBjI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 21:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjESBjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 21:39:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965EF10C9
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 18:39:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-645c4a0079dso489894b3a.1
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 18:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684460346; x=1687052346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0AstTdSss7uTC7xTDJQXdjEIFD/XVNNNA3JlwFJduD8=;
        b=2iRZPcTHcIovt72UKZz+HDO9ay3ISPX54EwtVjxAdlKxtBU84FydtTnMSwvf/sokGQ
         OxldRoZFqkFqkHup7Bvf7VEtYtqECNv28Kn3NlGWc7N94XkdHq5L8qR96olA5tvqHxrH
         Av3saKg7zmwLaD+21k/1vPPrCh9pxzKa/fkBi57XO8iZ1H94d9Z5xUk5NObrhhuiXs+F
         Gg/bQVtYxA9zcZALFmnEVOZ8uoKSlTTNseUaboLyNW5r7bjT0NjPdJNexbZaS/xLWS4u
         dIIazIGV4bkUTVNith64xclctTG077CeRoRY6tYuIgc/JGmKRqtXmzBN0rQ4EPuZjL92
         sfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684460346; x=1687052346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AstTdSss7uTC7xTDJQXdjEIFD/XVNNNA3JlwFJduD8=;
        b=S8133eJ+zLyK6VqjhygRtX0aZS94KGloC+xeMwu0M0L3IEUPaLKI+p0CiAIFHYwrNv
         YEjbEgdTuQgh3aCY9h0pe8m/eQWWQlh8ZhjsmHVaj73vH00sFDQKk6Pl5ALqTtrVs3CO
         4sHzrmixj//fLrFcI+BZjBldSIsxF0+g0vEQWj1UcllM1Z3cC+RfRTAjqcLYiR+XkdBe
         902ysRHWTUWpI+wwzBlJzMLnLw3J+9gDpG/tVUalIJMUxwgzXzhC3l1YXIw2gyr3BDp+
         1xmbUhDlRcjGhMDlvesU/nEzfEz5+AutIVVs4Zr0m96lkHJuwMVXP2Z/0MbDXgYBTHlW
         FapA==
X-Gm-Message-State: AC+VfDzBqACMAW7bw6rW3QuYjlarFZ2tPvMbGC1w3tINB7ZB6fYzArcc
        WupIpf9fsE6mm1bxf0ZYriqUQg==
X-Google-Smtp-Source: ACHHUZ6TIcp1rWuPnVXCq7AkIIrZOmUC0d120UohbM6rURTx7xEA4E/oobHrQUIbI5E02SZYXmwciA==
X-Received: by 2002:a05:6a21:339a:b0:f6:7bb8:c8d5 with SMTP id yy26-20020a056a21339a00b000f67bb8c8d5mr371116pzb.4.1684460346088;
        Thu, 18 May 2023 18:39:06 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 10-20020a63114a000000b00519c3475f21sm1848402pgr.46.2023.05.18.18.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 18:39:05 -0700 (PDT)
Message-ID: <a849d530-a975-9b63-702a-6c29c8f54bee@kernel.dk>
Date:   Thu, 18 May 2023 19:39:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] blk-mq: remove RQF_ELVPRIV
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20230518053101.760632-1-hch@lst.de>
 <20230518053101.760632-3-hch@lst.de>
 <ZGXPkFOWOuoLWglR@ovpn-8-21.pek2.redhat.com> <20230518130632.GA31791@lst.de>
 <ZGYmK/y/TXuYk3tN@ovpn-8-21.pek2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZGYmK/y/TXuYk3tN@ovpn-8-21.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 7:20 AM, Ming Lei wrote:
> On Thu, May 18, 2023 at 03:06:32PM +0200, Christoph Hellwig wrote:
>> On Thu, May 18, 2023 at 03:11:12PM +0800, Ming Lei wrote:
>>>> -		if ((rq->rq_flags & RQF_ELVPRIV) && e->type->ops.requeue_request)
>>>> +		if (e->type->ops.requeue_request)
>>>>  			e->type->ops.requeue_request(rq);
>>>
>>> The above actually changes current behavior since RQF_ELVPRIV is only set
>>> iff the following condition is true:
>>>
>>> 	(rq->rq_flags & RQF_ELV) && !op_is_flush(rq->cmd_flags) &&
>>> 		e->type->ops.prepare_request.
>>
>> It would require an I/O scheduler that implements .requeue_request but
>> not .prepare_request, which doesn't exist and also is rather pointless as
>> this .requeue_request method would never get called in the current code.
>>
>> So no, no behavior change in practice.
> 
> Fair enough, just found that all three schedulers have implemented
> e->type->ops.prepare_request.

We should probably make this requirement explicit though, seems
very fragile to depend on it just because it's the status quo.

-- 
Jens Axboe


