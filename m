Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F84C38142
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 14:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjAXOiz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjAXOiv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 09:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A616F2799D
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 06:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674571067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F2x/J0bGGkJ5eISXSY0hav/Re/JEb7A0J6D4E1fdc+E=;
        b=IAwH7/TfR99q0Xm63K9rHesNxZstOiZpmPllDzHe92+tmPrvOcg5qYMEP2jDdKEaLn+FSP
        FRfsPtVXPkezLDxGGyI+iUaSEL+jgMAsWnuhwgbqG1dxtLwyuw+Dt8j4Q2/QmgsbVsASip
        SPX7UpIykexPAmLGPnlwIqZeecm94XE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-zAtExhBBMY-OSxT5QbZ3-Q-1; Tue, 24 Jan 2023 09:37:46 -0500
X-MC-Unique: zAtExhBBMY-OSxT5QbZ3-Q-1
Received: by mail-wm1-f71.google.com with SMTP id n16-20020a05600c3b9000b003db127e03c5so838655wms.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 06:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2x/J0bGGkJ5eISXSY0hav/Re/JEb7A0J6D4E1fdc+E=;
        b=H0NQ2csCvl2C+YSyx1i+6nyKdoSCuQTLxKT+E8MhOGF8xHTa9EklfGFWDE7Qk2XEvA
         XAWH2gdyw3D0apZ6ZEoJmQMmMztaDpKJtpOy4cc5SBy7duL1ntdpctQMVuZOJYKzgB8t
         tyO+Idu7C7pq5LyCg/xrC/XHe8vzNDaCoWpPf8vItxeJQIt8o8NTWcVAzZ7sURnYI0V+
         Z2eN6AkqHpjzlAdoLFvL5PqLS4NWqZ7RjRrnz2xOw9Jo9DeMk5bJ/PybQcrseV3spQXt
         XnXRMZ+tZ71Z4YEI1w087RJ1kGERx1zkR9VL2ZmtkN78NxlrVWVayIfWIL+HP4posWj1
         ucag==
X-Gm-Message-State: AFqh2kpcxLWv7HAI7plqujKeaQcgApOq9Sd7vCoYfGsytgRfiLe87oAT
        5f5DOlW7GpFUPe2oSQxMFbaXnQDdFaoYt5fybrJRHDjr0K76nRd3RlpySJvVPG/KkBd1WFAAtTJ
        WZw438ip+aT3ihZSLsHFVbNY=
X-Received: by 2002:a05:600c:4687:b0:3db:2e06:4091 with SMTP id p7-20020a05600c468700b003db2e064091mr17927352wmo.37.1674571065227;
        Tue, 24 Jan 2023 06:37:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsTPiQ8xro+N8cTZHPqCpvzQVYFmoI1YAEYsyNxhplELggRoT15RtOz9oihNoQhKICc6Aksgg==
X-Received: by 2002:a05:600c:4687:b0:3db:2e06:4091 with SMTP id p7-20020a05600c468700b003db2e064091mr17927322wmo.37.1674571064886;
        Tue, 24 Jan 2023 06:37:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id t24-20020adfa2d8000000b002bdc129c8f6sm2020545wra.43.2023.01.24.06.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:37:44 -0800 (PST)
Message-ID: <5bc85aff-e21e-ab83-d47a-e7b7c1081ab0@redhat.com>
Date:   Tue, 24 Jan 2023 15:37:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 02/10] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
References: <1b1eb3d8-c6b4-b264-1baa-1b3eb088173d@redhat.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-3-dhowells@redhat.com>
 <874093.1674570959@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <874093.1674570959@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24.01.23 15:35, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>>> +#define iov_iter_extract_mode(iter) (user_backed_iter(iter) ? FOLL_PIN : 0)
>>> +
>>
>> Does it make sense to move that to the patch where it is needed? (do we need
>> it at all anymore?)
> 
> Yes, we need something.  Granted, there are now only two alternatives, not
> three: either the pages are going to be pinned or they're not going to be
> pinned, but I would rather have a specific function that tells you than just
> use, say, user_backed_iter() to make it easier to adjust it later if we need
> to - and easier to find the places where we need to adjust.
> 
> But if it's preferred we could require people to use user_backed_iter()
> instead.

At least reduces the occurrences of FOLL_PIN :)

-- 
Thanks,

David / dhildenb

