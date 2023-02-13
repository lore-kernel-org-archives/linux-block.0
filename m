Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BD7C636CC
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 09:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjBMJC2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 04:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMJC1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 04:02:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF1230C8
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 01:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676278900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXJ41y77DLzQTdnZ8caltqbUlHQTGjYtUH+qH6yTvzI=;
        b=JVIxgVVsnuOUjwPu6XQkSdEdK2ukSvvPDPuJ7XOJNgjzY7DGeNISGLcIeDO8cidyLLyzPf
        9nOqEyQZ19Afj6E7azcfpp6LxSAUG+ueXvsuxCM+mLlY/Jr/BTbfUCpl7RBgbMjC6iG4m/
        UXrzB1bK5ACuk5ZcEc4YF85z03HlJ4c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-VCx7b7YFOfOm6SSwWC7I1w-1; Mon, 13 Feb 2023 04:01:38 -0500
X-MC-Unique: VCx7b7YFOfOm6SSwWC7I1w-1
Received: by mail-wr1-f69.google.com with SMTP id p7-20020a5d48c7000000b002c53d342406so2060674wrs.2
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 01:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXJ41y77DLzQTdnZ8caltqbUlHQTGjYtUH+qH6yTvzI=;
        b=CJ5FbrzGy1CCiTncu6oDq7YKlA0pf3AHHmRGGnQBNDhJbunmX2HOUbixK/Z7TGUw6M
         3sVubpWx/KlFi2J/w8P7R6MO8174aKfbizWT2Q4+y5/YLvKin0BE8xYxBNQZDoVu/y89
         I83jEHsoFzY5Ltu9fpMysJF2Rp3maotYVw30hzCcWqG9gkXw9lazpSORJeRdK5rCXD7+
         tzgGIwDlrE3zCKdheqhv/ZmJGoELeE37OwjvZXYzWR5VBJ7ZVVoYJQ6XLrQpBg9MJwMJ
         c0SnZSfVBVoFrKa4ED5QYr2aEoQUjNBIii9af4uFuNJax1QcgFcJjXPr4h5gPoz6ZQBu
         tDwg==
X-Gm-Message-State: AO0yUKXtK5eVU2U0bfjQaKgTo6Jz7tlSkW/txSZ55YFPKz0+lXYqJcyc
        WOq44j4SyvqurDDS6peZ1aGODdsePcgUVAOrUMoQCf/3wCFMxAYghShnZDo0kr2lpQbdnZYE6z0
        JsWkMFYMmycMoiNN8tKyTtc4=
X-Received: by 2002:a5d:4392:0:b0:2c5:5e9a:57fa with SMTP id i18-20020a5d4392000000b002c55e9a57famr742929wrq.24.1676278897263;
        Mon, 13 Feb 2023 01:01:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9VtyM+sAOgTcH0wT4b+Em90/RexKPCJfzXesUugyTxY8knA758KLy3q0oLiK1S+Hc1W5aLFg==
X-Received: by 2002:a5d:4392:0:b0:2c5:5e9a:57fa with SMTP id i18-20020a5d4392000000b002c55e9a57famr742914wrq.24.1676278897013;
        Mon, 13 Feb 2023 01:01:37 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:6d00:5870:9639:1c17:8162? (p200300cbc7056d00587096391c178162.dip0.t-ipconnect.de. [2003:cb:c705:6d00:5870:9639:1c17:8162])
        by smtp.gmail.com with ESMTPSA id s11-20020adfdb0b000000b002c3e1e1dcd7sm10016563wri.104.2023.02.13.01.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:01:36 -0800 (PST)
Message-ID: <df6e150f-9d5c-6f68-f234-3e1ef419f464@redhat.com>
Date:   Mon, 13 Feb 2023 10:01:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-1-jack@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/5] mm: Do not reclaim private data from pinned page
In-Reply-To: <20230209123206.3548-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09.02.23 13:31, Jan Kara wrote:
> If the page is pinned, there's no point in trying to reclaim it.
> Furthermore if the page is from the page cache we don't want to reclaim
> fs-private data from the page because the pinning process may be writing
> to the page at any time and reclaiming fs private info on a dirty page
> can upset the filesystem (see link below).
> 
> Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   mm/vmscan.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bf3eedf0209c..ab3911a8b116 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>   			}
>   		}
>   
> +		/*
> +		 * Folio is unmapped now so it cannot be newly pinned anymore.
> +		 * No point in trying to reclaim folio if it is pinned.
> +		 * Furthermore we don't want to reclaim underlying fs metadata
> +		 * if the folio is pinned and thus potentially modified by the
> +		 * pinning process is that may upset the filesystem.
> +		 */
> +		if (folio_maybe_dma_pinned(folio))
> +			goto activate_locked;
> +
>   		mapping = folio_mapping(folio);
>   		if (folio_test_dirty(folio)) {
>   			/*

At this point, we made sure that the folio is completely unmapped. 
However, we specify "TTU_BATCH_FLUSH", so rmap code might defer a TLB 
flush and consequently defer an IPI sync.

I remember that this check here is fine regarding GUP-fast: even if 
concurrent GUP-fast pins the page after our check here, it should 
observe the changed PTE and unpin it again.


Checking after unmapping makes sense: we reduce the likelyhood of false 
positives when a file-backed page is mapped many times (>= 1024). OTOH, 
we might unmap pinned pages because we cannot really detect it early.

For anon pages, we have an early (racy) check, which turned out "ok" in 
practice, because we don't frequently have that many anon pages that are 
shared by that many processes. I assume we don't want something similar 
for pagecache pages, because having a single page mapped by many 
processes can happen easily and would prevent reclaim.

I once had a patch lying around that documented for the existing 
folio_maybe_dma_pinned() for anon pages exactly that (racy+false 
positives with many mappings).


Long story short, I assume this change is fine.

-- 
Thanks,

David / dhildenb

