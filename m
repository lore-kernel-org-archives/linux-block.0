Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6439C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95DE2146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Fj06p72T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95DE2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbeLAHmx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:42:53 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55351 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeLAHmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 02:42:53 -0500
Received: by mail-it1-f194.google.com with SMTP id o19so398503itg.5
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 12:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JxNb6RuvU+rRV2jhoJZBo6I3SoBESTfMAMJehRmiG/0=;
        b=Fj06p72Tlt35CqiG0EOksDP3bF7rWKdZRDKi3lOTY0c0GCzTqx8h4vX0RPxD/NF2je
         cf1ecYHorAA2wOCU5Q1vWlFVXxftHZQ3Cz0zuMz6CO11WkheUh2Zkwy8INQLaGbC315e
         pxINqYZGz2iQxgkBM6hopJ5gtiLUt3zuJVsr3hbRdKs+BdVBzPG3DgU1LUZBQAupHr5+
         IeBQlHdqOWSx9QzfN+7NrsG0DnnXk72Zrj/Ju1Z1NKzNuI78xYA/TugGeawMUpMGi7ZQ
         FuKenabUs7cos2fpsXOkjehK9QvS6OEVDt09tYRx+jfCloZ9K/YPCXmXVyx2lh3MyN+3
         ZeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxNb6RuvU+rRV2jhoJZBo6I3SoBESTfMAMJehRmiG/0=;
        b=R5qt7EKafc9YwKKcXpqSbYGCVQLXvAVARdKyqLpwQWmTzwmXgZWNdkWdvTqGI/4z8l
         qZzvQsEuxWjNrEdTh9ZulbcUrLOsFsi+byu5VQROw165Y+l7rQEXaMrLMHw4YYTyLfIQ
         aenI+RwI9zot3FUgDp33xfs3YhfYOwWJ64E45pyYRg8RDeC/kmOjK967zcRdWt5jv2ru
         kin3Vz0b95FREGHlPuIE+kucluxl/ZNvcQzQq02FEObfK71YZ1WVqDLQSABJeVZoXdyb
         pfp9lk2WO+hT9tghTANJ+v0R5SXsiwYs01X2fYZFPLUQ6u7xLYioaQkVI3Q5xFFG5JmB
         CF9w==
X-Gm-Message-State: AA+aEWbdLDNH5tZsw1537d9tz03hC2YQ1dq6Irw6qYIPM8OqpRwhf6hw
        9tmh8oIsbQKt9gOh/QMLhFz+0A==
X-Google-Smtp-Source: AFSGD/UwTttrJcjwX7U3pJOBhPRrWXL7Vu/FlCgT2YPBW47LXoNsijPavZ3j0cV2+PgebtPPUjZlNA==
X-Received: by 2002:a02:a906:: with SMTP id n6mr6238978jam.123.1543609943884;
        Fri, 30 Nov 2018 12:32:23 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id n4sm2207836ioj.41.2018.11.30.12.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 12:32:22 -0800 (PST)
Subject: Re: [PATCH 24/27] block: implement bio helper to add iter kvec pages
 to bio
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-25-axboe@kernel.dk>
 <20181130192102.GP2217@ZenIV.linux.org.uk>
 <6e42d763-9c94-6b84-7099-f5ef5964404c@kernel.dk>
Message-ID: <1545b364-df01-51e7-1786-56dde7c49b5d@kernel.dk>
Date:   Fri, 30 Nov 2018 13:32:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6e42d763-9c94-6b84-7099-f5ef5964404c@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 1:15 PM, Jens Axboe wrote:
> On 11/30/18 12:21 PM, Al Viro wrote:
>> On Fri, Nov 30, 2018 at 09:56:43AM -0700, Jens Axboe wrote:
>>> For an ITER_KVEC, we can just iterate the iov and add the pages
>>> to the bio directly.
>>
>>> +		page = virt_to_page(kv->iov_base);
>>> +		size = bio_add_page(bio, page, kv->iov_len,
>>> +					offset_in_page(kv->iov_base));
>>
>> Who said that you *can* do virt_to_page() on those?  E.g. vmalloc()'ed
>> addresses are fine for ITER_KVEC, etc.
> 
> Then how do you set up a kvec based iter with memory you can safely
> DMA to/from?

Would this make you happy:

if (!is_vmalloc_addr(kv->iov_base))
        page = virt_to_page(kv->iov_base);
else
        page = vmalloc_to_page(kv->iov_base);

-- 
Jens Axboe

