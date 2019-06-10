Return-Path: <SRS0=HnxX=UJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1531BC4321A
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 22:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DDC20859
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 22:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfFJWAm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jun 2019 18:00:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36206 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbfFJWAm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jun 2019 18:00:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so179621pfl.3
        for <linux-block@vger.kernel.org>; Mon, 10 Jun 2019 15:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ZbZOVb75C9+btON0t2eiN7veiKbZqARVe8qrDAfXGQ=;
        b=A9wMncC5kJmeXEojXgQ3wUW5Bkxgd8N07KpfaD/ygWj5TrXrH7Fy/AUNi0sAEKLasX
         MA1GvO1hpGgAL9UFV22sNCoSNZ98NxjYUkxfv+nyGjAqoEgM3JqtESlsRrscVhQ6muFZ
         u6Mw7WKYLzieS1gDIBjrT7SGxEtTIOvyYLg4d2qcW6DUqgLGK7wOMaNzlrzrh9DhiHrY
         32KC6ipWZQBsqQLZ9ryulU6Jn7hQ2VwkU87rfEXukaHyn5JqV1GuEswmSXg8yN59yDaH
         GkmTG/zhZltX64gjiEXHacZ9o3gVjzpFsimDmM6GqEsDvixkqT3JIHkfqQzAoBmtqsJJ
         QZsw==
X-Gm-Message-State: APjAAAX4GJ3q8qWkClQaKkm5JNqggNfwgpMg9cyllYSR+8rl/DWAJutP
        YylZJTBJzbRNHN9RNr0frAU=
X-Google-Smtp-Source: APXvYqz6Z0lMSUUl4YqmRkLHV0IoAxaPjvu7wy6du0WrZ6zhZwkdkpRS1EezVzC2mjHYFHJiv4tr9g==
X-Received: by 2002:a62:b609:: with SMTP id j9mr61978909pff.145.1560204041290;
        Mon, 10 Jun 2019 15:00:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id v126sm15730592pfb.81.2019.06.10.15.00.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 15:00:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: Remove blk_mq_put_ctx()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
References: <20190604181736.903-1-bvanassche@acm.org>
 <20190604181736.903-2-bvanassche@acm.org> <20190608081907.GB19573@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8b179799-5381-1b47-1793-f1fd39726d49@acm.org>
Date:   Mon, 10 Jun 2019 15:00:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190608081907.GB19573@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/19 1:19 AM, Christoph Hellwig wrote:
> On Tue, Jun 04, 2019 at 11:17:35AM -0700, Bart Van Assche wrote:
>> No code that occurs between blk_mq_get_ctx() and blk_mq_put_ctx() depends
>> on preemption being disabled for its correctness. Since removing the CPU
>> preemption calls does not measurably affect performance, simplify the
>> blk-mq code by removing the blk_mq_put_ctx() function and also by not
>> disabling preemption in blk_mq_get_ctx().
> 
> I like the idea behinds this, but I think it makes some small issues
> we have in the current code even worse.  As far as I can tell the idea
> behind this call was that we operate on the same blk_mq_ctx for the
> duration of the I/O submission.  Now it should not matter which one,
> that is we don't care if we get preempted, but it should stay the same.

Hi Christoph,

Can you clarify this? Isn't the goal of the rq->mq_ctx = data->ctx 
assignment in blk_mq_rq_ctx_init() to ensure that the same blk_mq_ctx is 
used during I/O submission? As you know blk_mq_rq_ctx_init() is called 
immediately after a tag has been allocated.

> To actually make this work properly we'll need to pass down the
> blk_mq_ctx into the I/O scheduler merge path, which dereference it.
> Note that I also have an outstanding series to pass down an additional
> parameter there (the bi_phys_segments removal) so we'll need to
> coordinate that.

I can wait until Jens has queued your patch series.

Thanks,

Bart.
