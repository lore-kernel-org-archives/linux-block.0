Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262C9C48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 15:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044B6208CB
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 15:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfFYP7p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:59:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42175 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfFYP7o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 11:59:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id k13so3003912pgq.9;
        Tue, 25 Jun 2019 08:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u0a06ygLCQoXpyrPynjO0JPrsmio1gNF+IYZpMvPsR4=;
        b=d7milHahqs74SFEjLPbyPjJI4jqsTwh4o+Dvt9JzcRF4koebY+o4DO4yD6dwt03vZl
         0WeTnxphnnBE5J3au5OHS0Go2eviadf44wJVvNjnFdm9x/Uqg0mUr90DeMk4mXj388qV
         JcPQ8evGsv9vBE1mAXZQGmFjMRW6rV4JikxwFVBP7NejugZlVbLt+wdJS0HyuGBn0k6b
         tTckk6QK6cBJy6YYxmjI1DVW8NYOJ6YWC5uGZEGJiQWnwZ2ZVxxC+j8N6earjuLcx9SO
         9acl6Og9PaBIEQ66EPGQkwmfB5juV6B8Dn9HL+yj3YLHfHH50us1wq2jcwxDajUfAla8
         JzQw==
X-Gm-Message-State: APjAAAWsQD9zamNx3pmY5rwOSFH9GaK/sRBx2N2SBAbzmWbuhdAhwcSg
        TjtKGHSTQtfHV6OhW/qOC3k=
X-Google-Smtp-Source: APXvYqzY4Lk78EVJt2hSWftp6cc9OMdvWYMsi3xUrIxhsprUln83sTBHiF6DgY2xiCmyDWmUzqOnpg==
X-Received: by 2002:a17:90a:2743:: with SMTP id o61mr32888162pje.59.1561478384093;
        Tue, 25 Jun 2019 08:59:44 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id e26sm15540375pfn.94.2019.06.25.08.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 08:59:42 -0700 (PDT)
Subject: Re: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>
References: <20190625024625.23976-1-damien.lemoal@wdc.com>
 <20190625024625.23976-2-damien.lemoal@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <135fd7f3-e37c-d3c3-7acc-8f353f0c8a76@acm.org>
Date:   Tue, 25 Jun 2019 08:59:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190625024625.23976-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/19 7:46 PM, Damien Le Moal wrote:
> To allow the SCSI subsystem scsi_execute_req() function to issue
> requests using large buffers that are better allocated with vmalloc()
> rather than kmalloc(), modify bio_map_kern() to allow passing a buffer
> allocated with the vmalloc() function. To do so, simply test the buffer
> address using is_vmalloc_addr() and use vmalloc_to_page() instead of
> virt_to_page() to obtain the pages of vmalloc-ed buffers.
> 
> Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
> Fixes: e76239a3748c ("block: add a report_zones method")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   block/bio.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index ce797d73bb43..05afcaf655f3 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1501,6 +1501,8 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>   	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
>   	unsigned long start = kaddr >> PAGE_SHIFT;
>   	const int nr_pages = end - start;
> +	bool is_vmalloc = is_vmalloc_addr(data);
> +	struct page *page;
>   	int offset, i;
>   	struct bio *bio;
>   
> @@ -1518,7 +1520,11 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
>   		if (bytes > len)
>   			bytes = len;
>   
> -		if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,
> +		if (is_vmalloc)
> +			page = vmalloc_to_page(data);
> +		else
> +			page = virt_to_page(data);
> +		if (bio_add_pc_page(q, bio, page, bytes,
>   				    offset) < bytes) {
>   			/* we don't support partial mappings */
>   			bio_put(bio);

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
