Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8FEC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C422080A
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="URh5XK0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C422080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbeLAIpX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:45:23 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:50470 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeLAIpW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 03:45:22 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so706217iti.0
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 13:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b8wq75Pfkz+jZTNy4uaaqhCjr0ZfxIlVXroBZRbzFIg=;
        b=URh5XK0J5Sl8WJ0QZQ1W2J8ow15chuG34zCafL8K12tCdUTceH6o/T4srYfylOcNtD
         fnZCKkWf+1UF1SpSG0TFYBCDaxtOFFUMl4WvBUz3eWtVX0VjUwlZnV5wLenvUijpkbd6
         UDvRg3Oov71TJOJg5CqRB4289ts4xTF6EFeQOVq+OeNLPzn7kvG4nCop4SZEedTMua7T
         Yl6jeLu7fiturcZOFlSLr1qxa8g++24ZTwYv8kVDcNxbHbWUKRKKPuBq1mlW1dqsMoeQ
         cdape1uAnZ8OEOIaj3bynD0jr/0256oQqqNUd8DfTUq8+voRKZn0ZohSyyCOvEwePCXg
         HEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8wq75Pfkz+jZTNy4uaaqhCjr0ZfxIlVXroBZRbzFIg=;
        b=SPKxXEnKTnsD1Jr/zAKDsI9NqR/Kplaue7r4I5TK5UoKoVJaHFiU+jM4pPS6P7d9Te
         R/4HzslStcdDfqKVVWBiq2ot/VxfPaX4GurYwU400RfAGV3ZkXbi1eMmjfhgHWlJDbbF
         HUuXM/HxbbDizkC/oROuPMqv8wZjJrmGC/xu9Qfua5PHRQUdb5WIwNXpba61LZTDhwZ/
         S8xpXN7DXeatlKJPBsd9Qth54l9WvEIGE1+dNX2GPcgZFiPMeidmvPcIqnrwPl8CDOvs
         3IMIGc36Muve9dofcCvUPL8sby8mGHLSZaU47ZJzhdzfmjJ7WFAIJUDt7gHvaBplcH3o
         6WwQ==
X-Gm-Message-State: AA+aEWa0Mtl0IhMW1LHnvcBLK6Wu3lCy3/B1j7+BLcKlc+KB0GSt6vXe
        Jm7lox6wu2HvpTIOsUNdf8gPQQ==
X-Google-Smtp-Source: AFSGD/XSMHtSjORPaqETrCUXMY8TSk95AwVo1CZftTwcbWDXABg7bnrmqzUgQCNM9/vg2MOTiC97BA==
X-Received: by 2002:a24:78c7:: with SMTP id p190mr407007itc.21.1543613682873;
        Fri, 30 Nov 2018 13:34:42 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x6-v6sm154992itg.15.2018.11.30.13.34.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 13:34:41 -0800 (PST)
Subject: Re: [PATCH 24/27] block: implement bio helper to add iter kvec pages
 to bio
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-25-axboe@kernel.dk>
 <20181130192102.GP2217@ZenIV.linux.org.uk>
 <6e42d763-9c94-6b84-7099-f5ef5964404c@kernel.dk>
 <1545b364-df01-51e7-1786-56dde7c49b5d@kernel.dk>
 <20181130211117.GQ2217@ZenIV.linux.org.uk>
 <07803d69-84cc-bb39-686f-2f50874ea184@kernel.dk>
 <20181130212503.GS2217@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1de11537-56c0-a9d1-60da-68c5b3e431ce@kernel.dk>
Date:   Fri, 30 Nov 2018 14:34:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130212503.GS2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 2:25 PM, Al Viro wrote:
> On Fri, Nov 30, 2018 at 02:16:38PM -0700, Jens Axboe wrote:
>>>> Would this make you happy:
>>>>
>>>> if (!is_vmalloc_addr(kv->iov_base))
>>>>         page = virt_to_page(kv->iov_base);
>>>> else
>>>>         page = vmalloc_to_page(kv->iov_base);
>>>
>>> Free advice: don't ever let Linus see anything along those lines.  Results
>>> tend to be colourful...
>>
>> We already have those lines in the kernel, XFS for instance. Al, could you
>> please try to be helpful instead of being deliberately obtuse?
> 
> Again, the last time something like that had been suggested, Linus had replied
> with a very impressive rant.  I *did* propose pretty much that, and reaction
> was basically "hell no, not in general-purpose primitives".  Precisely about
> iov_iter stuff.  A part of that was due to touching page refcounts, but quite
> a bit wasn't.

Nobody is touching the page count here, and for the aio user mapped IO,
nobody is touching them at the end either.

As far as I can tell, the above is fine. It's either a vmalloc'ed
address and should be treated specially, or we can do virt_to_page() on
it.

Do you have a link to said rant?

-- 
Jens Axboe

