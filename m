Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7B1C433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 09:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiCAJbm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiCAJbl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 04:31:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A4B285BED
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 01:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646127060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBY88ztZKva4Dfvhre7a4FFaoq99+j707lGLFNj1qsE=;
        b=Iv1IHO/9xYq7AvjWjVZyuiHeTYislxYXWGovJYa6ngEYYX7k1jxMaDRCcr151iGwY1BRP0
        LhTs57+PA0ANZkZmL1zWk6ZsdjrlXuza9d98quzlY5Bp66eWCWcvR7mz0ArJ6eXoxIYMfH
        yInWyj+S2L9AT80kMyH6i5t1Z3S9y20=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-NffjHZSkNuydAyiyqZw5Pw-1; Tue, 01 Mar 2022 04:30:58 -0500
X-MC-Unique: NffjHZSkNuydAyiyqZw5Pw-1
Received: by mail-wm1-f71.google.com with SMTP id i131-20020a1c3b89000000b0037bb9f6feeeso729440wma.5
        for <linux-block@vger.kernel.org>; Tue, 01 Mar 2022 01:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QBY88ztZKva4Dfvhre7a4FFaoq99+j707lGLFNj1qsE=;
        b=Xqgushung70u+SCRENxKofFQAdPl2DepmqBZCOlaZ2Lr/U3p0ntTumt90zBHSv6XuU
         /12WJWGu10JUGt5xCNorqZ/qZfjeJNt2cBExW48v7OwtCr3wfrjnqSSMAZyCaS7FxE1S
         +puZbb0O7uiaME/dYLvjN+dMUHUNQ96USZLhgf9LogC1m7LWlPF1NuDaK1nZLrS/hsAT
         +cdPsjFrMNUtFPYK2OhPpZ1FP544hcio9DZpVvnqj705f5H68a5rSxnz4/50fqaL5Nqc
         UZsaiNH83kKQaOyFTEvbmarnVsKuE1ShSVNwHDCWLNmsOUnTtAu+MwJgdIEXKWKGnhh+
         flAQ==
X-Gm-Message-State: AOAM533Z3L5Kv+bPe/z+6hbux83DDB+vgzPsGIsDldPwfFgOj9uLIphK
        85LaGRQ3Gmt4aZ7XxpjEGblszlE9OB/iPupJ1+f+f4/MYUC9A5gcxLLK6f17igMX452Jwt+NeJE
        nEIrlJCji7VNACJLCrj0g/Zg=
X-Received: by 2002:a1c:a382:0:b0:381:cfd:5564 with SMTP id m124-20020a1ca382000000b003810cfd5564mr16055521wme.103.1646127057606;
        Tue, 01 Mar 2022 01:30:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxZ01JTKa85lEAtW7rkRzMrJlA0XsQxMME6SiPZ1SwraatSqHyEOf6kIqynfEITUDTCDJILg==
X-Received: by 2002:a1c:a382:0:b0:381:cfd:5564 with SMTP id m124-20020a1ca382000000b003810cfd5564mr16055505wme.103.1646127057353;
        Tue, 01 Mar 2022 01:30:57 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id j7-20020adfd207000000b001edc209e70asm12630321wrh.71.2022.03.01.01.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 01:30:56 -0800 (PST)
Message-ID: <e0ff6c64-7ab0-6300-7427-5a3e4364661e@redhat.com>
Date:   Tue, 1 Mar 2022 10:30:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 1/7] mm/gup: introduce pin_user_page()
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
 <20220225085025.3052894-2-jhubbard@nvidia.com>
 <6ba088ae-4f84-6cd9-cbcc-bbc6b9547f04@redhat.com>
 <36300717-48b2-79ec-a97b-386e36bbd2a6@nvidia.com>
 <d3973adb-9403-5b64-23ec-d6800d67e538@redhat.com>
 <f531a5be-9698-eb08-f10d-75adc2028483@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f531a5be-9698-eb08-f10d-75adc2028483@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> That might be problematic and possibly the wrong approach, depending on
>> *what* we're actually pinning and what we're intending to do with that.
>>
>> My assumption would have been that this interface is to duplicate a pin
> 
> I see that I need to put more documentation here, so people don't have
> to assume things... :)
> 

Yes, please :)

>> on a page, which would be perfectly fine, because the page actually saw
>> a FOLL_PIN previously.
>>
>> We're taking a pin on a page that we haven't obtained via FOLL_PIN if I
>> understand correctly. Which raises the questions, how do we end up with
>> the pages here, and what are we doing to do with them (use them like we
>> obtained them via FOLL_PIN?)?
>>
>>
>> If it's converting FOLL_GET -> FOLL_PIN manually, then we're bypassing
>> FOLL_PIN special handling in GUP code:
>>
>> page = get_user_pages(FOLL_GET)
>> pin_user_page(page)
>> put_page(page)
> 
> No, that's not where this is going at all. The idea, which  I now see
> needs better documentation, is to handle file-backed pages. Only.
> 
> We're not converting from one type to another, nor are we doubling up.
> We're just keeping the pin type consistent so that the vast block-
> processing machinery can take pages in and handle them, then release
> them at the end with bio_release_pages(), which will call
> unpin_user_pages().
> 

Ah, okay, that makes sense. Glad to hear that we're intending to use
this with !anon pages only.

>>
>>
>> For anonymous pages, we'll bail out for example once we have
>>
>> https://lkml.kernel.org/r/20220224122614.94921-14-david@redhat.com
>>
>> Because the conditions for pinned anonymous pages might no longer hold.
>>
>> If we won't call pin_user_page() on anonymous pages, it would be fine.
> 
> We won't, and in fact, I should add WARN_ON_ONCE(PageAnon(page)) to
> this function.

Exactly what I would have suggested,

> 
>> But then, I still wonder how we come up the "struct page" here.
>>
> 
>  From the file system. For example, the NFS-direct and fuse conversions
> in the last patches show how that works.
> 
> Thanks for this feedback, this is very helpful.

Thanks for clarifying, John!

-- 
Thanks,

David / dhildenb

