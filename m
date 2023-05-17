Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3860AC77B7D
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 15:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjEQPEL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 May 2023 11:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjEQPD5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 11:03:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FEFA5D1
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 08:03:37 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64388cf3263so621826b3a.3
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 08:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335696; x=1686927696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q71Ay2k2vTd9rtHHMbnW9Uc2a1BML8xqjdYGd16kh6w=;
        b=lMVu9XGHE5MWAHlnjk73ljrYQEuTPSNlgnBagV/4VKJxndi1s1oFkfaOOjKQObmbyk
         5N7fYXrrx8IObBufZE3KQUZBtepzE2rKazB1+pZ8WYAbBM1w0sDPTXXVhyumTjnNt8wk
         dKzZXOTQqqqHedPef8+CIqX9MtBt4qfqz0GKeq9RFM7wW7FoFClh8Se5OPG8ZkEPWLy7
         yQfOBP1fTag+MV5zlq/u8R2VC6+SlznsU45SbhbjESlDrGOpglBtWkfqtlYCREPHAutu
         T6rGCDgBRWGHpTFNoJIpg/XN9+l6HeMLGr2vu/b493V4cHwE0v2AShMyQzv+bThzAMNC
         KBqA==
X-Gm-Message-State: AC+VfDxsjXsrciwNA+HypsqHTkMT5Fiycla53ky6XN8AUcXSdbjDW0Rc
        KG2I4cMwJwFd4aDImo71tK8=
X-Google-Smtp-Source: ACHHUZ4ZpbUmwZyXFRd6iEMPFT2XLnVg5DDTze5FJaefh9P8W0BaplCPUO8IbRZof3Rw4Bz7LWUoTQ==
X-Received: by 2002:aa7:88d0:0:b0:646:663a:9d60 with SMTP id k16-20020aa788d0000000b00646663a9d60mr1644234pff.10.1684335696245;
        Wed, 17 May 2023 08:01:36 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id h23-20020a632117000000b00528da88275bsm15498394pgh.47.2023.05.17.08.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 08:01:35 -0700 (PDT)
Message-ID: <44be286c-37ff-cda5-6aa1-b9e8ff3e194b@acm.org>
Date:   Wed, 17 May 2023 08:01:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 05/11] block: mq-deadline: Clean up
 deadline_check_fifo()
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20230516223323.1383342-1-bvanassche@acm.org>
 <20230516223323.1383342-6-bvanassche@acm.org>
 <c46b14b0-56e3-ace9-91f7-15434ae93c2e@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c46b14b0-56e3-ace9-91f7-15434ae93c2e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/23 18:02, Damien Le Moal wrote:
> On 5/17/23 07:33, Bart Van Assche wrote:
>> -	if (time_after_eq(jiffies, (unsigned long)rq->fifo_time))
>> -		return 1;
>> -
>> -	return 0;
>> +	return time_is_before_eq_jiffies((unsigned long)rq->fifo_time);
> 
> This looks wrong: isn't this reversing the return value ?
> Shouldn't this be:
> 
> 	return time_after_eq(jiffies, (unsigned long)rq->fifo_time));
> 
> To return true if the first request in fifo list *expired* as indicated by the
> function kdoc comment.

Hi Damien,

 From include/linux/jiffies.h:

#define time_is_before_eq_jiffies(a) time_after_eq(jiffies, a)

Hence, time_is_before_eq_jiffies((unsigned long)rq->fifo_time) is 
equivalent to time_after_eq(jiffies, (unsigned long)rq->fifo_time). Both 
expressions check whether or not rq->fifo_time is in the past.

Bart.
