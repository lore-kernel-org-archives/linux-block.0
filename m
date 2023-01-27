Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E7FC54EAA
	for <linux-block@archiver.kernel.org>; Fri, 27 Jan 2023 00:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjA0ALa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 19:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjA0AL3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 19:11:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E135143C
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 16:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674778243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFCRwwoODaZccr7NcmMarl4NMoXDR8hwKLWDxPSkIE0=;
        b=aWvjd3l5tCx0nhpqD62V9Q0dVFPMRNM18xa8Cil96g3FSa5NYNCYObKsgsoX3Mn+2Erq2f
        ydFtZGwJwLNgEdsWXLeCdxRzhuyMTmhhfUVLNh7FB+AK7kVuj2WLFdvEcq6HoiF3XODnTy
        035XFlIiql0OJqz40knIqrI5gmQLsqE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-154-KLSr1sj_OA6eQMKXJJQDJQ-1; Thu, 26 Jan 2023 19:10:42 -0500
X-MC-Unique: KLSr1sj_OA6eQMKXJJQDJQ-1
Received: by mail-wm1-f71.google.com with SMTP id az37-20020a05600c602500b003da50af44b3so1880740wmb.1
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 16:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFCRwwoODaZccr7NcmMarl4NMoXDR8hwKLWDxPSkIE0=;
        b=Sks0o1piOVGBuw6AfU6jGNYum25jfDQ4swot4CJ964/dRI+wnnY9KemPYUxt9k7733
         9iMTfA8EAzTY5wh9r1LnkF3tbfgJIASpQ18UYcOl1mcwYJWBiQ/n6XAyyGwgWxXYqvIf
         EgeKtqnEBKc8dcD+mWeVZkublCoTx4HvhoiAj07KnPT9hsxziYeDcUdTKNcofm57evTr
         MJOSxDnTOZSVQIpYVHAtfUmfVd8mILVkJTAurQafXTfTevG2Y1N3qjMYBSqSECq/dfeG
         hht4CogsLxrhvA3qOa8PCGsRAFRzM/4cP7ERrDm+GeiUEJRBo7i27cO5eIZ/LEMg8KD8
         MO+g==
X-Gm-Message-State: AFqh2kpiDk0Uxc6V9PMiKG5yIo3w2IZk8rSoFvQ5NQXU2e9sepxITHMC
        R6trfeBw5tZA/qylc3lZSU0GCODWDomWDVVzABQikTjjascas/jlDMeMfcBMX5tE5gPfWOLxiak
        +UVtTFbvS0NWOg9iMD7RHEYk=
X-Received: by 2002:a1c:4c04:0:b0:3d9:f0d8:708c with SMTP id z4-20020a1c4c04000000b003d9f0d8708cmr45243537wmf.26.1674778241431;
        Thu, 26 Jan 2023 16:10:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuIVvTV3+Y5mMoncMUvJp0bRzJpK5PiB4pT8WE56lw5xCntGDrrPKnbs5J1gjhF3vHcyTl7Ow==
X-Received: by 2002:a1c:4c04:0:b0:3d9:f0d8:708c with SMTP id z4-20020a1c4c04000000b003d9f0d8708cmr45243516wmf.26.1674778241115;
        Thu, 26 Jan 2023 16:10:41 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6387.dip0.t-ipconnect.de. [91.12.99.135])
        by smtp.gmail.com with ESMTPSA id a18-20020a05600c069200b003db305bece4sm2638720wmn.45.2023.01.26.16.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 16:10:40 -0800 (PST)
Message-ID: <3e5df0cf-d2bd-7795-617d-06a3a32fc18b@redhat.com>
Date:   Fri, 27 Jan 2023 01:10:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
References: <ba3adce1-ddea-98e0-fc3a-1cb660edae4c@redhat.com>
 <20230126141626.2809643-1-dhowells@redhat.com>
 <20230126141626.2809643-3-dhowells@redhat.com> <Y9L3yA+B1rrnrGK8@ZenIV>
 <Y9MAbYt6DIRFm954@ZenIV> <2907150.1674777410@warthog.procyon.org.uk>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v11 2/8] iov_iter: Add a function to extract a page list
 from an iterator
In-Reply-To: <2907150.1674777410@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27.01.23 00:56, David Howells wrote:
> Al says that pinning a page (ie. FOLL_PIN) could cause a deadlock if a page is
> vmspliced into a pipe with the pipe holding a pin on it because pinned pages
> are removed from all page tables.  Is this actually the case?  I can't see
> offhand where in mm/gup.c it does this.

Pinning a page is mostly taking a "special" reference on the page, 
indicating to the system that the page maybe pinned. For an ordinary 
order-0 page, this is increasing the refcount by 1024 instead of 1.

In addition, we'll do some COW-unsharing magic depending on the page 
type (e.g., anon vs. fike-backed), and FOLL_LONGTERM. So if the page is 
mapped R/O only and we want to pin it R/O (!FOLL_WRITE), we might 
replace it in the page table by a different page via a fault 
(FAULT_FLAG_UNSHARE).

Last but not least, with FOLL_LONGTERM we will make sure to migrate the 
target page off of MIGRATE_MOVABLE/CMA memory where the unmovable page 
(while pinned) could otherwise cause trouble (e.g., blocking memory 
hotunplug). So again, we'd replace it in the page tale by a different 
page via a fault.

In all cases, the page won't be unmapped from the page table.

-- 
Thanks,

David / dhildenb

