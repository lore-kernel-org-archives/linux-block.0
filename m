Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D9CC433ED
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 22:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373FE613AF
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 22:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhDSWRa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 18:17:30 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:35838 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhDSWR3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 18:17:29 -0400
Received: by mail-pj1-f41.google.com with SMTP id j21-20020a17090ae615b02901505b998b45so5901097pjy.0;
        Mon, 19 Apr 2021 15:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KgvHm+BppNn8A4YRtexdxltV8Bme6nRBg7d+mgFCzqA=;
        b=cHS170fT+we6vbtouDufMoe6rjoFbEmIfOBkEwbjVLK1Sgsg9gisR0RCYvcFkjJ0J3
         M4nGed+980mmb/NfQIgMB8Vnf57FwradoDtwBcJfsc3S4E9OWJm70HUOy80X9x2q6RgZ
         67FH/VdqtGui6G4fzb9BQEyqTpwA2FqN4cqbaFvoahhy1gFzBrvy7Dcr8x2J+jok0Beg
         hCIFqZGtGam9Wd96VSM7e2QODBTP8bJPq7VgUzurz+kZPAWj7l+ztWBTNSfWsQ5THp8D
         X5GAPzD3Kopb2Do1xganWX2w6BVPzpE7/6c37DidEW8NT6AAzS1v55FJvsztzKMABPud
         LELA==
X-Gm-Message-State: AOAM532pE4AbRuewyhHiL/sNYBlDWRjizOSrQeVbhJEoz1Pzz0rFtuJw
        /9NuKnwKx8t+rKkYrYpcYt8=
X-Google-Smtp-Source: ABdhPJz4WR2Xk+bXFX/eldRezIHEh6Q5lQJ+4EVjhhLkJLi25bzV4aKal8Pqf8UXcuSE+U6r17zdbQ==
X-Received: by 2002:a17:90a:5d17:: with SMTP id s23mr1337566pji.44.1618870619245;
        Mon, 19 Apr 2021 15:16:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:3e77:56a4:910b:42a9? ([2601:647:4000:d7:3e77:56a4:910b:42a9])
        by smtp.gmail.com with ESMTPSA id e1sm14036997pgl.25.2021.04.19.15.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 15:16:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v7 1/3] bio: limit bio max size
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
References: <9ad8ef3f-905c-543e-d2af-7bf2f43ea04c@acm.org>
 <CGME20210419060745epcas1p220138a5de8e08201a6bcd9193c37fc51@epcas1p2.samsung.com>
 <20210419054951.6244-1-nanich.lee@samsung.com>
Message-ID: <918e0d57-ffbc-7dcd-6eba-87d22aceb9d6@acm.org>
Date:   Mon, 19 Apr 2021 15:16:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210419054951.6244-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/21 10:49 PM, Changheun Lee wrote:
>>> @@ -167,6 +168,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>>>  	max_sectors = round_down(max_sectors,
>>>  				 limits->logical_block_size >> SECTOR_SHIFT);
>>>  	limits->max_sectors = max_sectors;
>>> +	limits->bio_max_bytes = max_sectors << SECTOR_SHIFT;
>>>  
>>>  	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
>>>  }
>>
>> Can the new shift operation overflow? If so, how about using
>> check_shl_overflow()?
> 
> Actually, overflow might be not heppen in case of physical device.
> But I modified as below. feedback about this.
> 
> @@ -168,6 +169,9 @@ void blk_queue_max_hw_sectors(struct request_queue *q, unsigned int max_hw_secto
>  				 limits->logical_block_size >> SECTOR_SHIFT);
>  	limits->max_sectors = max_sectors;
>  
> +	limits->bio_max_bytes = check_shl_overflow(max_sectors, SECTOR_SHIFT,
> +		&limits->bio_max_bytes) ? UINT_MAX : max_sectors << SECTOR_SHIFT;
> +
>  	q->backing_dev_info->io_pages = max_sectors >> (PAGE_SHIFT - 9);
>  }
>  EXPORT_SYMBOL(blk_queue_max_hw_sectors);

If no overflow occurs, check_shl_overflow() stores the result in the
memory location the third argument points at. So the above expression
can be simplified into the following:

if (check_shl_overflow(max_sectors, SECTOR_SHIFT, &limits->bio_max_bytes)) {
	limits->bio_max_bytes = UINT_MAX;
}

>>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>>> index d0246c92a6e8..e5add63da3af 100644
>>> --- a/include/linux/bio.h
>>> +++ b/include/linux/bio.h
>>> @@ -106,6 +106,8 @@ static inline void *bio_data(struct bio *bio)
>>>  	return NULL;
>>>  }
>>>  
>>> +extern unsigned int bio_max_size(struct bio *bio);
>>
>> You may want to define bio_max_size() as an inline function in bio.h
>> such that no additional function calls are introduced in the hot path.
> 
> I tried, but it is not easy. because request_queue structure of blkdev.h
> should be referred in bio.h. I think it's not good to apply as a inline function.

Please don't worry about this. Inlining bio_max_size() is not a big
concern to me.

Thanks,

Bart.
