Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D69C3F2CD
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 16:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA89321775
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 16:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="F2YXMoKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgCAQli (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 11:41:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34190 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCAQli (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Mar 2020 11:41:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id j7so3218286plt.1
        for <linux-block@vger.kernel.org>; Sun, 01 Mar 2020 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8bGDCa12B+o0c1dRJnWIXM2nG15xjDmQgWbNrAUXWKM=;
        b=F2YXMoKqp+dfcI5qgFGx7idxzb4afSC3sQLps2iB+OhuKHYrEU+VvQQbI15gEfAiyl
         tzqqj0hiywtdfqltaZnKlQTaqVAg6JsxgUayNY92EKJ7nqFW4H2xCQKMtQqohKx3XSuq
         gF0/xYNroePJuDseyBBMPJKImAw2jzVnDAuUC0I9cWtK1Kr0dY+y5DOuQg24a5RzGExy
         HllwklBd4D7nhRJNEWSL736PIxVQBxC2YuOOEtLqF01pMl3v0/ykKTI01bZKUfV/yn1l
         sOAYZs9WPnLPtjSgdueVKU0AVIfzsHYUo3BPvueSJElt9z23rMD+yexoUW6iiehJ8TkQ
         iEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8bGDCa12B+o0c1dRJnWIXM2nG15xjDmQgWbNrAUXWKM=;
        b=mciG5907PEamnnf7Z1b7IxLfvfsfWUgwhzzhrbm14pdnh7rOD3z5aK7laHpYpQRdrw
         Fu2O1yEq8Zr6daJJuhHLWpyYsLkRI6w+Xidt7VSI4HEmAiWqlVp9wn+6g+cTyl1HkuMx
         y8nidnUGlFFx5VWP8Q8xLRHYWOtkhxuziNs42zuzi+0uy99+0dpatrzjvemzUHZfbx3Q
         vigu6gmv+pUpFMXaST3YkubUomYdvd02CLBkmat50MbJAQe5I3jZzDpZUHKE3e/FrDRB
         Ub0EolZA+3B1Vk688LlzMQPpHih6mSN7lkGc/sx+OABQ10br1JNGjs4JWDc6IqSJ3uXd
         zAsg==
X-Gm-Message-State: APjAAAX641Xcbs9QZyT4wZIukoD5xVBgNKuKbWiFm7Bjh/3btKPx1rzo
        vZaaSn2JBtcKucUveZeg6szJGopU96N5Ww==
X-Google-Smtp-Source: APXvYqxzrFvOfu0ighlpZ66ZMsKEQVlfayZ8aWe6lOQ7F53DXQPVPanvtcbSw7bAnYgHKcgQVVo19Q==
X-Received: by 2002:a17:90a:37e7:: with SMTP id v94mr15781999pjb.37.1583080896517;
        Sun, 01 Mar 2020 08:41:36 -0800 (PST)
Received: from ?IPv6:240e:82:3:5b12:940:b7e:a31d:58eb? ([240e:82:3:5b12:940:b7e:a31d:58eb])
        by smtp.gmail.com with ESMTPSA id y18sm17408165pfe.19.2020.03.01.08.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 08:41:35 -0800 (PST)
Subject: Re: [PATCH 4/6] block: remove obsolete comments for
 _blk/blk_rq_prep_clone
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
 <20200228150518.10496-5-guoqing.jiang@cloud.ionos.com>
 <4e6fcb8b-f07b-55bb-362b-c58ed03df7c0@acm.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <1aa30dde-9f70-7b90-cd76-d58909b2e7bb@cloud.ionos.com>
Date:   Sun, 1 Mar 2020 17:41:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4e6fcb8b-f07b-55bb-362b-c58ed03df7c0@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

Thanks for your review.

On 2/29/20 3:34 AM, Bart Van Assche wrote:
> On 2020-02-28 07:05, Guoqing Jiang wrote:
>> Both cmd and sense had been moved to scsi_request, so remove
>> the related comments to avoid confusion.
>>
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
>> ---
>>   block/blk-core.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index 883ffda216e4..9094fd7d1b01 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1583,7 +1583,6 @@ EXPORT_SYMBOL_GPL(blk_rq_unprep_clone);
>>   
>>   /*
>>    * Copy attributes of the original request to the clone request.
>> - * The actual data parts (e.g. ->cmd, ->sense) are not copied.
>>    */
>>   static void __blk_rq_prep_clone(struct request *dst, struct request *src)
>>   {
> 
> Although the removed comment is outdated, the new comment is not useful.
> 
> How about inlining __blk_rq_prep_clone() into its only caller and
> removing the comment above that function entirely?It's not clear to me
> why the code inside __blk_rq_prep_clone() ever was put into a separate
> function.

Not sure about it, the original code was introduced in commit b0fd271d5fba0
("block: add request clone interface (v2)"), maybe author preferred to use
a function to copy attributes from src request to dst request.

I will make the change based on your suggestion if no one objects it.

> 
>>    *
>>    * Description:
>>    *     Clones bios in @rq_src to @rq, and copies attributes of @rq_src to @rq.
>> - *     The actual data parts of @rq_src (e.g. ->cmd, ->sense)
>> - *     are not copied, and copying such parts is the caller's responsibility.
>>    *     Also, pages which the original bios are pointing to are not copied
>>    *     and the cloned bios just point same pages.
>>    *     So cloned bios must be completed before original bios, which means
> 
> Adding a comment that explains that some but not all struct request
> members are copied and also why would be welcome.

I think we need care about the actual data parts of request, I guess all the
actual data parts had been moved into scsi_request, but my understanding could
probably be wrong.

Thanks,
Guoqing
