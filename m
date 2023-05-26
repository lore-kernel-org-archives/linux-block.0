Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A18CC77B7C
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 09:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243038AbjEZJZG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 May 2023 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbjEZJZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 05:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1037513D
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 02:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685093062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hvsOWsTxhCAtK9wZGl3ItbtOHeNAmtLYxozsBT60tM=;
        b=c9qS+AlBTCaTLwOuh+Kn0QdfuvA5F4/ZtqKDesOhp+Y++mSmgNMoan2qaQCQMuzOdU1uET
        +x76rLfFemSz8tq3mnkZ+VSBi3iSSkQtiVIYV5zICzwr2AWSqBDkZmUrTScwUF7P1Qj8ba
        DKRF4IBNwDAldeRurIAfcFvUXqGSysM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-DRrrlNIIMsupa_PQ0lUJ8w-1; Fri, 26 May 2023 05:24:21 -0400
X-MC-Unique: DRrrlNIIMsupa_PQ0lUJ8w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-307897bc279so313717f8f.3
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 02:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685093060; x=1687685060;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hvsOWsTxhCAtK9wZGl3ItbtOHeNAmtLYxozsBT60tM=;
        b=kGBqJHKZaYZkVyJ5Q97E3rVl21KCRTdzCliw0/DUytr++mV11QQISgKtYk6LzlvooR
         5+/b2qiOycF9EnQM1cGBlTYqo84pujOryhw7EWRpTwBX8OoTamcx4T3LhowxCFJtRb1r
         N3APdYsImzjXReK2rTbmWXX7qlFG5h0/hdEqGd1q+tmYi0lr1OtuFh62rDl2doCAJRuB
         doq5FAKrCwGV4s6TMimmd+T7IVoWB62Cp25viV4oXv29IXmveRC87KoJROKMwXtXlPDL
         R6yTfrG/FE8Ns85/ftwn29LbNSlto2RBiuCBhwD6Zf+XirCA8+7HxJCqLsrNmwdqJ4en
         b8UQ==
X-Gm-Message-State: AC+VfDzNnnUCTCaw3wdy53dqkhb6BQwv3GzdPAfRkPEEORW8RbCt6Iqe
        Wi7dqUg0LzSkhlURdieXJCKBUJ5ZuBkRpyXy7HQ8Aaavg8EIb3yzT88j/pcS4SUi3RK3H5JP2vA
        vzmLKTo+iyS5wzt0xQiQQngI=
X-Received: by 2002:adf:e704:0:b0:306:459b:f575 with SMTP id c4-20020adfe704000000b00306459bf575mr994702wrm.12.1685093060458;
        Fri, 26 May 2023 02:24:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/DN4isxucuKpWnb3968aE5fezzmDpKs9YwOs8B5KHM5/+Y68dG7HuVKtISlXTfNhMp11ttA==
X-Received: by 2002:adf:e704:0:b0:306:459b:f575 with SMTP id c4-20020adfe704000000b00306459bf575mr994681wrm.12.1685093060096;
        Fri, 26 May 2023 02:24:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:9700:7003:7e4d:43dd:7bfd? (p200300cbc710970070037e4d43dd7bfd.dip0.t-ipconnect.de. [2003:cb:c710:9700:7003:7e4d:43dd:7bfd])
        by smtp.gmail.com with ESMTPSA id v10-20020adfe28a000000b003063a1cdaf2sm4390604wri.48.2023.05.26.02.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 02:24:19 -0700 (PDT)
Message-ID: <950f095f-5182-6f14-cdc3-ce5eb35884ca@redhat.com>
Date:   Fri, 26 May 2023 11:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <4f479af6-2865-4bb3-98b9-78bba9d2065f@lucifer.local>
 <89c7f535-8fc5-4480-845f-de94f335d332@lucifer.local>
 <20230525223953.225496-1-dhowells@redhat.com>
 <20230525223953.225496-2-dhowells@redhat.com>
 <520730.1685090615@warthog.procyon.org.uk>
 <522654.1685092526@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <522654.1685092526@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.05.23 11:15, David Howells wrote:
> Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> 
>>> iov_iter_extract_pages(), on the other hand, is only used in two places
>>> with these patches and the pins are always released with
>>> unpin_user_page*() so it's a lot easier to audit.
>>
>> Thanks for the clarification. I guess these are the cases where you're
>> likely to see zero page usage, but since this is changing all PUP*() callers
>> don't you need to audit all of those too?
> 
> I don't think it should be necessary.  This only affects pages obtained from
> gup with FOLL_PIN - and, so far as I know, those always have to be released
> with unpin_user_page*() which is part of the gup API and thus it should be
> transparent to the users.

Right, and even code like like 873aefb376bb ("vfio/type1: Unpin zero 
pages") would handle it transparently, because they also call 
unpin_user_page().

[we can remove 873aefb376bb even without this change way because it uses 
FOLL_LONGTERM that shouldn't return the shared zeropage anymore ]

-- 
Thanks,

David / dhildenb

