Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF521C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9616320863
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 17:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="chSwYG/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9616320863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbeK3EMZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:12:25 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40086 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbeK3EMZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 23:12:25 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so4747092ita.5
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 09:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bDPFOjb7hHsJptlbNEPf+M5H/qCMrdlKG0DKIpoHlf0=;
        b=chSwYG/wAJgckW63rAUAadddX4ZfVZLkuz/hZzyYFHbMl59xkb0SKm98LpIIoW0mzw
         53g7zhVbQYGxYB/tpxlrOBPQVbNz9urKtqrZjKD+u1rAHiPohnCHtM7CDcBKOTECtZj4
         oh9GoPCGfrbeXzfzUnUQCBcKk4M8WU7F9MxV2/3v13R/YPKxEoN+ZrA05iiW/yTUsGXR
         Rkgp7p/U+iPz+dsdhyV1yXaosbraMhCY2n47FM4a1RVu1bclJt5PH2q/f1JVgPXMNH/0
         KAhK/KBHpZXF5nMs0DS9CiAg7AWt0oNRCJZzxv98F4W5NYKeDzDb2M/NzRZTGhwqynyT
         PpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bDPFOjb7hHsJptlbNEPf+M5H/qCMrdlKG0DKIpoHlf0=;
        b=BfUJgrSldfy+WDp8MZX94XM18dWJs25xqPFpzBCHekuXn7jno512gO/y0MqPE+AW14
         rCGfAVoU9YJ+07qhhgrKm7lwqHFz4ApTtm1FzJuQGqKXDgS7aSvdvwxrk2PdaZuJajUq
         uIoC2ZxHaLaSJ6VJolwATC6JkVUgoKrl/sHidhlo2eQ2qxFTwMFUSGxPxs7bgcLkGVcP
         pcXUDWmDTi6Ho+e4+aGCUnb+6GqUJQth773dPsskrBZw2YN0ycnGmsZx2i0D8rYXzymS
         Pql4j4Uv2Lw+g7CG0nGLxnwIEzd32N4kvykI+DhzzkiZ95NVQFUxtj8yLHBaiNFbn7Ve
         NCWg==
X-Gm-Message-State: AA+aEWYkXW576FNm/G8DzMQHEslv6KeybcGex1tuCi67TPPTLswx/zDO
        M50/zdwQQUBB+4+X/Aulti7ZUw==
X-Google-Smtp-Source: AFSGD/WQMTQR9M7igCrVIZQW6VxaUKNfGUrJJaAjCwGLYis0sTGz1JmQ/jImm0KSoc6DUE6h1V2cOw==
X-Received: by 2002:a24:c8c2:: with SMTP id w185-v6mr2161884itf.50.1543511181807;
        Thu, 29 Nov 2018 09:06:21 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b140sm367319itc.4.2018.11.29.09.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:06:20 -0800 (PST)
Subject: Re: [PATCH 3/7] nvme: implement mq_ops->commit_rqs() hook
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-4-axboe@kernel.dk>
 <20181129154713.GC7234@infradead.org>
 <2188627d-6d45-fe8a-8d31-fa46fdb82618@kernel.dk>
 <20181129170430.GA27364@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <64106f7d-73d9-70f3-7b28-9b836994d5aa@kernel.dk>
Date:   Thu, 29 Nov 2018 10:06:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129170430.GA27364@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 10:04 AM, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018 at 10:02:25AM -0700, Jens Axboe wrote:
>> On 11/29/18 8:47 AM, Christoph Hellwig wrote:
>>>> +static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
>>>> +{
>>>> +	if (++index == nvmeq->q_depth)
>>>> +		return 0;
>>>> +
>>>> +	return index;
>>>> +}
>>>
>>> This is unused now.
>>
>> Huh, wonder how I missed that. GCC must not have complained.
> 
> gcc never warns about unused static inline functions.  Which makes a lot
> of sense at least for headers..

Not so much for non-headers :-)

>>> Also what about this little cleanup on top?
>>
>> That looks good, I like it. With that, can I add your reviewed-by? I'll
>> run a sanity check on it first.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

-- 
Jens Axboe

