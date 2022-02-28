Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3620BC433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 13:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbiB1N2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 08:28:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiB1N2B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 08:28:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93E7A2AE20
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 05:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646054840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TgHmDz0GNu5q6ZWTFzBjKZo8h99OvSwyTIwCakMfNVM=;
        b=S0Xzhn+OggOfA2chvChpwZRLe2xLny5D5NWNsNIFfryMLs+sHDQITmoJxMAco8HcC7wE+D
        PqSc7LVXsjrR9MeypReTJcbyU0GgD00UMFGDsR/8LHdoYJExUjaossq4Siyxf2d/GG1RZ1
        Y/gt1v/jgKhF0kGIdWIcydjwthjoxzI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-8rjhDA__PPGpPUFQKs6CgA-1; Mon, 28 Feb 2022 08:27:19 -0500
X-MC-Unique: 8rjhDA__PPGpPUFQKs6CgA-1
Received: by mail-wr1-f71.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so2067938wrg.19
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 05:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=TgHmDz0GNu5q6ZWTFzBjKZo8h99OvSwyTIwCakMfNVM=;
        b=7o+OhPq0YNE9KOz2dar0CJpXfWF66AUnjujY0tlEssomUvKGT4tLtCxUIvRPUosBCh
         P669OvHRfbEtRxUQb8rqjM20jDMbCgvVtm4BAVCBxpvjAzWnv/dj/fMGVHEyMklQ9Ogt
         NICBjE7csr3rj8prRK5IWvsi8tTm/HDQOWmjQ0t/1/jnCgO3Sj4qT+Zypq4YeddJlXlL
         XKeJuxBACfPqqi9A9dePIgUn/qlSALF3hjQ7JuB5LwJQZQ/drmALuP6IEmotjbLaSE46
         Jh4C7/qgIj/8gpeZGVHnYVfTD2On4bYcXL31UtMvBZfaIU0ux7P4ikGZVLKWLoXMQ/bO
         Sn8A==
X-Gm-Message-State: AOAM5339BK01QqjaLWHFKH/uFcw7i8M2eGwdH02UNsEfDBMDmxIRhhkK
        +bdkpEBySNGzXSau+gX+yA0vfFoWZNyfGgQQWHnLfpzIndMki3x2g6GdZiW2sG46+50sV1/Q5CO
        zpqH++JnFtmSqUsGkdZpfurw=
X-Received: by 2002:a05:6000:1e17:b0:1ef:d2b0:5624 with SMTP id bj23-20020a0560001e1700b001efd2b05624mr3754144wrb.598.1646054838218;
        Mon, 28 Feb 2022 05:27:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmK1pJZGR3uKPCb7TGF3ndIQ5PsuRUhLehyQHwqXjPcwtXh67wuuMvDm/QW/jlR2K/Qpovjg==
X-Received: by 2002:a05:6000:1e17:b0:1ef:d2b0:5624 with SMTP id bj23-20020a0560001e1700b001efd2b05624mr3754116wrb.598.1646054837932;
        Mon, 28 Feb 2022 05:27:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9700:f1d:e242:33b4:67f? (p200300cbc70297000f1de24233b4067f.dip0.t-ipconnect.de. [2003:cb:c702:9700:f1d:e242:33b4:67f])
        by smtp.gmail.com with ESMTPSA id y7-20020adff147000000b001dbd1b9812fsm15058303wro.45.2022.02.28.05.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 05:27:17 -0800 (PST)
Message-ID: <6ba088ae-4f84-6cd9-cbcc-bbc6b9547f04@redhat.com>
Date:   Mon, 28 Feb 2022 14:27:16 +0100
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220225085025.3052894-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 25.02.22 09:50, John Hubbard wrote:
> pin_user_page() is an externally-usable version of try_grab_page(), but
> with semantics that match get_page(), so that it can act as a drop-in
> replacement for get_page(). Specifically, pin_user_page() has a void
> return type.
> 
> pin_user_page() elevates a page's refcount is using FOLL_PIN rules. This
> means that the caller must release the page via unpin_user_page().
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h |  1 +
>  mm/gup.c           | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 929488a47181..bb51f5487aef 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1914,6 +1914,7 @@ long pin_user_pages_remote(struct mm_struct *mm,
>  long get_user_pages(unsigned long start, unsigned long nr_pages,
>  			    unsigned int gup_flags, struct page **pages,
>  			    struct vm_area_struct **vmas);
> +void pin_user_page(struct page *page);
>  long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  		    unsigned int gup_flags, struct page **pages,
>  		    struct vm_area_struct **vmas);
> diff --git a/mm/gup.c b/mm/gup.c
> index 5c3f6ede17eb..44446241c3a9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3034,6 +3034,40 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  }
>  EXPORT_SYMBOL(pin_user_pages);
>  
> +/**
> + * pin_user_page() - apply a FOLL_PIN reference to a page ()
> + *
> + * @page: the page to be pinned.
> + *
> + * Similar to get_user_pages(), in that the page's refcount is elevated using
> + * FOLL_PIN rules.
> + *
> + * IMPORTANT: That means that the caller must release the page via
> + * unpin_user_page().
> + *
> + */
> +void pin_user_page(struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +
> +	WARN_ON_ONCE(folio_ref_count(folio) <= 0);
> +
> +	/*
> +	 * Similar to try_grab_page(): be sure to *also*
> +	 * increment the normal page refcount field at least once,
> +	 * so that the page really is pinned.
> +	 */
> +	if (folio_test_large(folio)) {
> +		folio_ref_add(folio, 1);
> +		atomic_add(1, folio_pincount_ptr(folio));
> +	} else {
> +		folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
> +	}
> +
> +	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
> +}
> +EXPORT_SYMBOL(pin_user_page);
> +
>  /*
>   * pin_user_pages_unlocked() is the FOLL_PIN variant of
>   * get_user_pages_unlocked(). Behavior is the same, except that this one sets

I assume that function will only get called on a page that has been
obtained by a previous pin_user_pages_fast(), correct?

-- 
Thanks,

David / dhildenb

