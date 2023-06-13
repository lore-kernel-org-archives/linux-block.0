Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EBDC88CB2
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 07:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbjFMHcp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 03:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240589AbjFMHc0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 03:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1E1173E
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 00:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686641466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0vScxj5YMa+K+40jeVOVL1oOtwkyiQd/IWuuzvGGDI=;
        b=MvNFPn6cmmvUPG+qbM+kY3JvkeRLJDCGHEJDZA5s1Sy0LsFvq473Z7K8HGBfJ9HcjLeqt9
        U+nrtwb9oeT1m3Ml6u5I4dI6Cmgw2ynMpd4wX77H6QUNsupwYaJxZjdyWY3hLZcNnq2j/t
        ZzR/JJK9XB6RPQobweM9OFNlQW98THQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-zKiz8jdmMmqV_tlzrFQYZA-1; Tue, 13 Jun 2023 03:31:03 -0400
X-MC-Unique: zKiz8jdmMmqV_tlzrFQYZA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30c5d31b567so1987635f8f.2
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 00:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686641462; x=1689233462;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0vScxj5YMa+K+40jeVOVL1oOtwkyiQd/IWuuzvGGDI=;
        b=RKpghdq7TWDDLjkZQB+crGhrV8WT9hUTrT+PibG7QQVYL12HwtHtwrXeqLq/z7WiaC
         lP1yDdqNDnKz/rjYk+XNLdnpQGoQLIfj2cZ0/d7d9E2V97x6OTN7OetfyCrOiLzoc3jt
         5l/bLM/G/1+P2khfqJdpBkOghu35hR8/FMGx1mKR01cRI3KDSpTJBZg8sxMSxbADuh9G
         e6hxelPYgjx5pV4GxEF5yod7XHGyox6qbh6207xmXAj2RDlC0HZkQ0KiuwwOJ+oksZce
         3xQvv4XqfFn41k1Y3ArRp31U4ijJ2itPMuAQTbKTJVNBkhPTeFpik/mqhZyIeDoLHyLI
         YZNQ==
X-Gm-Message-State: AC+VfDzB3n5ABYBmxfwj9TzRcvP2UO9e4LnCOaCuelV/2OUuUJlsCpk4
        ECEkk7cJhbxNQS1bvkOtRJpSjS/Hj9HaegMfpmxKrjJgWy4Euz7340ZFcF4ey3/6YqarCySp8C6
        t+YOfik+WlVwC9F52HA0dFAI=
X-Received: by 2002:adf:f042:0:b0:30f:cf6b:4982 with SMTP id t2-20020adff042000000b0030fcf6b4982mr261170wro.62.1686641462574;
        Tue, 13 Jun 2023 00:31:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5CTFZVdIdiMBJTa4yPNgw1OdLhPXmCNTDxDHv57xIkOk0hRvQBsdz1yvdn7YhXRQMeaWwtxg==
X-Received: by 2002:adf:f042:0:b0:30f:cf6b:4982 with SMTP id t2-20020adff042000000b0030fcf6b4982mr261154wro.62.1686641462242;
        Tue, 13 Jun 2023 00:31:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:ff00:1a06:80f:733a:e8c6? (p200300cbc710ff001a06080f733ae8c6.dip0.t-ipconnect.de. [2003:cb:c710:ff00:1a06:80f:733a:e8c6])
        by smtp.gmail.com with ESMTPSA id b10-20020adfe30a000000b00300aee6c9cesm14561038wrj.20.2023.06.13.00.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:31:01 -0700 (PDT)
Message-ID: <5aed54c8-45e3-e05e-ccfd-a177df41c4a9@redhat.com>
Date:   Tue, 13 Jun 2023 09:31:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] block: Fix dio_bio_alloc() to set BIO_PAGE_PINNED
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <oliver.sang@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org
References: <545463.1686601473@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <545463.1686601473@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12.06.23 22:24, David Howells wrote:
>      
> Fix dio_bio_alloc() to set BIO_PAGE_PINNED, not BIO_PAGE_REFFED, so that
> the bio code unpins the pinned pages rather than putting a ref on them.
> 
> The issue was causing:
> 
>          WARNING: CPU: 6 PID: 2220 at mm/gup.c:76 try_get_folio
> 
> This can be caused by creating a file on a loopback UDF filesystem, opening
> it O_DIRECT and making two writes to it from the same source buffer.
> 
> Fixes: 1ccf164ec866 ("block: Use iov_iter_extract_pages() and page pinning in direct-io.c")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202306120931.a9606b88-oliver.sang@intel.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: David Hildenbrand <david@redhat.com>
> cc: Andrew Morton <akpm@linux-foundation.org>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Jan Kara <jack@suse.cz>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Jason Gunthorpe <jgg@nvidia.com>
> cc: Logan Gunthorpe <logang@deltatee.com>
> cc: Hillf Danton <hdanton@sina.com>
> cc: Christian Brauner <brauner@kernel.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-kernel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
> 
> Notes:
>      ver #2)
>       - Remove comment on requiring references for all pages.
> 
>   fs/direct-io.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 14049204cac8..5d4c5be0fb41 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -414,8 +414,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
>   		bio->bi_end_io = dio_bio_end_aio;
>   	else
>   		bio->bi_end_io = dio_bio_end_io;
> -	/* for now require references for all pages */
> -	bio_set_flag(bio, BIO_PAGE_REFFED);
> +	if (dio->need_unpin)
> +		bio_set_flag(bio, BIO_PAGE_PINNED);
>   	sdio->bio = bio;
>   	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
>   }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

