Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93413C54EAA
	for <linux-block@archiver.kernel.org>; Fri, 27 Jan 2023 12:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbjA0Mf6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Jan 2023 07:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjA0Mfu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2023 07:35:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404636ACB6
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 04:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674822897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvUZq9zhTSOpariEqdt1IfiEXwlz3ceeVpAzNf6gzS4=;
        b=i1e8461JCyHLPG98p1I1qj+oDizjt1QPO0bo/YoannoJXoFbM7LXV0H+bV6ihdtt3unrs8
        1lM4eu1lrFtHpuo7SAd0Wa/FRBxukslAw5fODSxZVFy1h66EkVjXpU1T3X9Zr6YAw5Biu2
        +shqOCK9ezU48nJEEmTtRGfCQTZsMLw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-407-w-kycFAzOr2S09Ukc6qURQ-1; Fri, 27 Jan 2023 07:34:53 -0500
X-MC-Unique: w-kycFAzOr2S09Ukc6qURQ-1
Received: by mail-wm1-f72.google.com with SMTP id 9-20020a05600c228900b003daf72fc827so2704517wmf.9
        for <linux-block@vger.kernel.org>; Fri, 27 Jan 2023 04:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvUZq9zhTSOpariEqdt1IfiEXwlz3ceeVpAzNf6gzS4=;
        b=orHSdFA/cTgtqgHaCzRWuIufQ/gNKQEoeIFDlKcjUeAZBTusIPkBhV+AY55bOBwsSt
         MjzWIt4kUCmct+9QzwoxVgr93h4W+lKtdgLbDgRVm/o0XzGkwYlObuNb99QcPFGK6Qm1
         EFqFv0KF4nrR6551w/P6F2LryxI67TCTiIRXQro6HZSCbzZReCPOKXmjD8CG2PH+kAdh
         LZ6+gG3v1QRVuzaWt9HNRn0DVB9Wf81cNAUDeA/KwP81WA7L8yqxHuL78Ne4uG7uyXG3
         uQPygFpht/3Y1M81LICjgI1kp/H8nN9HDdrMGw/uCubBeLK2cDVFDf/fVVCrXQpMtgZ/
         Gb9g==
X-Gm-Message-State: AO0yUKWI8ut12fkPKM61tPBN0RYm89pcZGz6xHXMQZub9L3LGRts8Bx0
        XnknVOReirGVa7IalD0QNhUzqeCZdPZr6mHVBnHU8u+S+HgCJ4vaTEABkLJyaRl2KpT4o0KzGh4
        RNgGTzv/3kU+IN2NCieOiGAM=
X-Received: by 2002:adf:c7c2:0:b0:2bf:d617:6aa0 with SMTP id y2-20020adfc7c2000000b002bfd6176aa0mr1251840wrg.66.1674822892431;
        Fri, 27 Jan 2023 04:34:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8KHfQ+JrxXe4wE8YfNkipOTaYkjMGsfUoE0u82WBLyCb+27hsIT6Rl48f0jOZhn5HYYgkV8g==
X-Received: by 2002:adf:c7c2:0:b0:2bf:d617:6aa0 with SMTP id y2-20020adfc7c2000000b002bfd6176aa0mr1251801wrg.66.1674822892038;
        Fri, 27 Jan 2023 04:34:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:2600:5c01:dcac:6d6:415? (p200300cbc70526005c01dcac06d60415.dip0.t-ipconnect.de. [2003:cb:c705:2600:5c01:dcac:6d6:415])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d53d1000000b0024cb961b6aesm3841439wrw.104.2023.01.27.04.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 04:34:51 -0800 (PST)
Message-ID: <cbca813e-cdaf-6938-570e-17dd26e3cd87@redhat.com>
Date:   Fri, 27 Jan 2023 13:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-3-dhowells@redhat.com> <Y9L3yA+B1rrnrGK8@ZenIV>
 <Y9MAbYt6DIRFm954@ZenIV> <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com>
 <Y9Mwt1EMm8InCHvA@ZenIV> <20230127123030.qfmgkthuzlxadpkk@quack3>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230127123030.qfmgkthuzlxadpkk@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27.01.23 13:30, Jan Kara wrote:
> On Fri 27-01-23 02:02:31, Al Viro wrote:
>> On Fri, Jan 27, 2023 at 12:44:08AM +0100, David Hildenbrand wrote:
>>> On 26.01.23 23:36, Al Viro wrote:
>>>> On Thu, Jan 26, 2023 at 09:59:36PM +0000, Al Viro wrote:
>>>>> On Thu, Jan 26, 2023 at 02:16:20PM +0000, David Howells wrote:
>>>>>
>>>>>> +/**
>>>>>> + * iov_iter_extract_will_pin - Indicate how pages from the iterator will be retained
>>>>>> + * @iter: The iterator
>>>>>> + *
>>>>>> + * Examine the iterator and indicate by returning true or false as to how, if
>>>>>> + * at all, pages extracted from the iterator will be retained by the extraction
>>>>>> + * function.
>>>>>> + *
>>>>>> + * %true indicates that the pages will have a pin placed in them that the
>>>>>> + * caller must unpin.  This is must be done for DMA/async DIO to force fork()
>>>>>> + * to forcibly copy a page for the child (the parent must retain the original
>>>>>> + * page).
>>>>>> + *
>>>>>> + * %false indicates that no measures are taken and that it's up to the caller
>>>>>> + * to retain the pages.
>>>>>> + */
>>>>>> +static inline bool iov_iter_extract_will_pin(const struct iov_iter *iter)
>>>>>> +{
>>>>>> +	return user_backed_iter(iter);
>>>>>> +}
>>>>>> +
>>>>>
>>>>> Wait a sec; why would we want a pin for pages we won't be modifying?
>>>>> A reference - sure, but...
>>>>
>>>> After having looked through the earlier iterations of the patchset -
>>>> sorry, but that won't fly for (at least) vmsplice().  There we can't
>>>> pin those suckers;
>>>
>>> We'll need a way to pass FOLL_LONGTERM to pin_user_pages_fast() to handle
>>> such long-term pinning as vmsplice() needs. But the release path (unpin)
>>> will be the same.
>>
>> Umm...  Are you saying that if the source area contains DAX mmaps, vmsplice()
>> from it will fail?
> 
> Yes, that's the plan. Because as you wrote elsewhere, it is otherwise too easy
> to lock up operations such as truncate(2) on DAX filesystems.

Right, it's then the same behavior as we already have for other 
FOLL_LONGTERM users, such as RDMA or io_uring.

... if we're afraid of breaking existing setups we could add some kind 
of fallback to copy to a buffer like ordinary pipe writes.

-- 
Thanks,

David / dhildenb

