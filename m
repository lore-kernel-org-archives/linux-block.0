Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7FFC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 17:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD082083E
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 17:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tkc0B32u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfBURpa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:45:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33261 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfBURpa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 12:45:30 -0500
Received: by mail-pg1-f195.google.com with SMTP id h11so11709430pgl.0
        for <linux-block@vger.kernel.org>; Thu, 21 Feb 2019 09:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FKMt4zFubzLEGfcdBwSUfD+m3s5KVYoCW8ANf6nE60s=;
        b=tkc0B32uPmQ7STl7mtE97FxWSd1JrBIM/Et9inaUtZrMIwixEHsPhOK0oU7wqk9GJN
         9/HI/oYeFcOUVy9ghyjLnZsaHt3SGJseI36tquomXx+jGXGZwYANuJVua4HCI2zuFPAh
         VCcm2pdteuS9J9FJGW97pnpwZGz0CuDom9mhh3RwNwEedB867jrJF+YUdVs9o8HnjIMO
         v2M8/yY7LcmXx+NIJYnJFeisNNLHDRKHMzFpjqE1fJ4/fxQq6rYrZa2X2C2TQT5ZCNg2
         XMmia6YvgyLpAHHwe+5E8TZ2tNCFjwBGI/3hQq2d6zPMDHOXCC4u7fG8Gr6o/3veO0hs
         Lubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FKMt4zFubzLEGfcdBwSUfD+m3s5KVYoCW8ANf6nE60s=;
        b=qTxRScWvQGVWuoFw073erO7kJFnTAVvFUo2yGrRZ5IBYgmNfZTzQ1AjNzvLBtIWnv/
         6uUKsW7frRmR/pxZVmreCmiRF30YJi60b4CmQoiBcjXBQ0TPbinFDNV/WmDzaPFhEkiA
         q3595ec1yLPLU3i1jjn9U4HJ5bn57lJrZxXT57Tk/V+as5YSdA8NGLSXgSzDW/c7o/dp
         fovY8BVmu/u0BxyXXKCsZb99rOjUnZaZLoMLnWuRkh5/SbjDc6nJfqjjTALo2ekQYGhb
         Kf2kk1mwQyWPvbqZ9uDpzvhrMHeaoX3qCvGHWLObWP920VPKml9v1qFagsm1WiMhU0Ar
         iG8w==
X-Gm-Message-State: AHQUAuZ9g24XfOAvdxSwh0aVda2rSaq86zUAcuj8mYttSW3rmvBb5kpV
        4jOMNwxIE1N1uWkPSSfrtfVagw==
X-Google-Smtp-Source: AHgI3Ib3yaM0W0f3g1+LAoCJAFVrwmuVjlZ8PAJw1BVaWdN2uc1cznuvSzjdxIsAphC/Xu1MPWpz8g==
X-Received: by 2002:a63:c042:: with SMTP id z2mr35779210pgi.307.1550771129190;
        Thu, 21 Feb 2019 09:45:29 -0800 (PST)
Received: from [172.20.1.194] (71-95-160-189.static.mtpk.ca.charter.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id s12sm28385990pfm.120.2019.02.21.09.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 09:45:28 -0800 (PST)
Subject: Re: [PATCH 11/19] block: implement bio helper to add iter bvec pages
 to bio
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, jannh@google.com, viro@ZenIV.linux.org.uk
References: <20190211190049.7888-1-axboe@kernel.dk>
 <20190211190049.7888-13-axboe@kernel.dk> <20190220225856.GB28313@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b143e8c3-33d5-5f09-c441-98b3bf326d81@kernel.dk>
Date:   Thu, 21 Feb 2019 10:45:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220225856.GB28313@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/20/19 3:58 PM, Ming Lei wrote:
> On Mon, Feb 11, 2019 at 12:00:41PM -0700, Jens Axboe wrote:
>> For an ITER_BVEC, we can just iterate the iov and add the pages
>> to the bio directly. This requires that the caller doesn't releases
>> the pages on IO completion, we add a BIO_NO_PAGE_REF flag for that.
>>
>> The current two callers of bio_iov_iter_get_pages() are updated to
>> check if they need to release pages on completion. This makes them
>> work with bvecs that contain kernel mapped pages already.
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/bio.c               | 59 ++++++++++++++++++++++++++++++++-------
>>  fs/block_dev.c            |  5 ++--
>>  fs/iomap.c                |  5 ++--
>>  include/linux/blk_types.h |  1 +
>>  4 files changed, 56 insertions(+), 14 deletions(-)
>>
>> diff --git a/block/bio.c b/block/bio.c
>> index 4db1008309ed..330df572cfb8 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -828,6 +828,23 @@ int bio_add_page(struct bio *bio, struct page *page,
>>  }
>>  EXPORT_SYMBOL(bio_add_page);
>>  
>> +static int __bio_iov_bvec_add_pages(struct bio *bio, struct iov_iter *iter)
>> +{
>> +	const struct bio_vec *bv = iter->bvec;
>> +	unsigned int len;
>> +	size_t size;
>> +
>> +	len = min_t(size_t, bv->bv_len, iter->count);
>> +	size = bio_add_page(bio, bv->bv_page, len,
>> +				bv->bv_offset + iter->iov_offset);
> 
> iter->iov_offset needs to be subtracted from 'len', looks
> the following delta change[1] is required, otherwise memory corruption
> can be observed when running xfstests over loop/dio.

Thanks, I folded this in.

-- 
Jens Axboe

