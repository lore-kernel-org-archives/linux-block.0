Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C3AC433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C686105A
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 16:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhDZQSk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:18:40 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:44711 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbhDZQSk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 12:18:40 -0400
Received: by mail-pl1-f177.google.com with SMTP id y1so13553569plg.11
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 09:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s9IpppjAuBICscbaBctnC573VoyQtmC1p003HYACVC0=;
        b=TndigRAikcI5QCAYbdNy8RnPDMnyya1K/bQQoN9CsJyRwHpl0Ndqt8ygO6AkvmbKu8
         HLGRSSyouTppYcM7OOGXayb8I5MiB8YJFmqvw23tssUBSzkvPYJ2EKA5eg4SxnJhrv1+
         jKbwsTheEorGbZPvGqjPdYnCsLIzm58RFS4d5RViM9TDPzeYsEUBy03KiIEzoM0wbVp7
         QJU9E5M0tlVSXhfTaGlgxXg3O6S7KZeNdYspBMFy+IifWYX5etZPAr//FLlbNIjSlExe
         KDrYfAnetLrVzz9unhANFHCCbdP5QVi2k1m+5518UcGlLzjlQXnDwJ2q1BNGYB7QtzRo
         UiFA==
X-Gm-Message-State: AOAM531UTkdqMl+aXiq26pRNVrYomAiuXima7Ni2/XqIym1K1SNAZLpm
        k9EKtKeUcr9aisGq/6ubMGo=
X-Google-Smtp-Source: ABdhPJyk+BgKgOHrI5FEebK7gVvqlpKgWMHn5Ipr1Ed/mxWdaRBWnyGQDVRUIMcvPeKwI+4nkKc/hA==
X-Received: by 2002:a17:903:2285:b029:eb:d7b:7687 with SMTP id b5-20020a1709032285b02900eb0d7b7687mr18985057plh.82.1619453878353;
        Mon, 26 Apr 2021 09:17:58 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id c23sm11811268pgj.50.2021.04.26.09.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 09:17:57 -0700 (PDT)
Subject: Re: [PATCH v2] block: Improve limiting the bio size
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     yi.zhang@redhat.com, axboe@kernel.dk, bgoncalv@redhat.com,
        hch@lst.de, jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com
References: <CAHj4cs9E+9n9M6W59LuTWQbbhTzMGgi8KBPaN+cAYC3ypC3dCg@mail.gmail.com>
 <CGME20210426085241epcas1p46ed8de18a98c40218dacd58fc4b25ff9@epcas1p4.samsung.com>
 <20210426083442.5831-1-nanich.lee@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <34286266-1c03-35bc-94e8-08bd0ac3400a@acm.org>
Date:   Mon, 26 Apr 2021 09:17:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210426083442.5831-1-nanich.lee@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 1:34 AM, Changheun Lee wrote:
> Should we check queue point in bio_max_size()?
> __device_add_disk() can be called with "register_queue=false" like as
> device_add_disk_no_queue_reg(). How about below?
> 
> unsigned int bio_max_size(struct bio *bio)
> {
> 	struct request_queue *q;
> 
> 	q = (bio->bi_bdev) ? bio->bi_bdev->bd_disk->queue : NULL;
> 	return q ? q->limits.bio_max_bytes : UINT_MAX;
> }

How could bio_max_size() get called from inside __device_add_disk() if
no request queue is registered? Did I perhaps miss something?

Thanks,

Bart.


