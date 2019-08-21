Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE0DC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 15:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9895622DA7
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 15:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfHUPvJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:51:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32920 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHUPvI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 11:51:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so1707334pfq.0
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2019 08:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kCrsK39MiFEY4PvJcNALkgLa/S1Jtal2ikj4JSkZ1Lo=;
        b=JDnWmdARVkXVlYgVcmLNCMP5PVVVy2vfO2f36f5qCWs9OtrtxQQ8REFsn14ru5ll/r
         PP83nq6zoP4Hn4NQmftnH/NdWU2CP5ME0OygPBwaUiG1mc9DbkE7drwx981WUwwt/3AW
         oIz+Gh/cJH2PAH9Uw/YB6EU9t3NyrxXaIk7R4mwcEBrgl9oS1m9t4vUPle1iQq4K7CyE
         zgJz2pi25opCGM95Rfz+Aiu8nM8o/xyOmP0dCNJ/SRgB/KDIj+Cd3onTEAvTNkdLg/N3
         5mCknuoT1uUeplQ5ah3n8AKQV+SPfhmeAQacbHg0eZJcHBEwVGZdQEKcfI2zykIqz/sO
         0Xbw==
X-Gm-Message-State: APjAAAWnl53G/lZqCyraRmCfmG9YXlQpIfTpJu57y6kKvE1fG8EPfLUf
        w4mobgvC3jzCoUF+ZDUdSK0=
X-Google-Smtp-Source: APXvYqw/Totpd9t3Nol6CzdnOVetzvM0YLz5D50yweiXbVNPhz+dprDx8M4H61CQjkXH64cuBdljWw==
X-Received: by 2002:a62:1941:: with SMTP id 62mr36473422pfz.188.1566402668105;
        Wed, 21 Aug 2019 08:51:08 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 65sm40193098pff.148.2019.08.21.08.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 08:51:07 -0700 (PDT)
Subject: Re: [PATCH V2 2/6] block: don't hold q->sysfs_lock in
 elevator_init_mq
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-3-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <aa6c97a6-dade-5996-1e61-e56c1f6fea5b@acm.org>
Date:   Wed, 21 Aug 2019 08:51:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821091506.21196-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/19 2:15 AM, Ming Lei wrote:
> The original comment says:
> 
> 	q->sysfs_lock must be held to provide mutual exclusion between
> 	elevator_switch() and here.
> 
> Which is simply wrong. elevator_init_mq() is only called from
> blk_mq_init_allocated_queue, which is always called before the request
> queue is registered via blk_register_queue(), for dm-rq or normal rq
> based driver. However, queue's kobject is just exposed added to sysfs
                                             ^^^^^^^^^^^^
                                             only?
> in blk_register_queue(). So there isn't such race between elevator_switch()
> and elevator_init_mq().
> 
> So avoid to hold q->sysfs_lock in elevator_init_mq().
[ ... ]
>   	/*
> -	 * q->sysfs_lock must be held to provide mutual exclusion between
> -	 * elevator_switch() and here.
> +	 * We are called from blk_mq_init_allocated_queue() only, at that
> +	 * time the request queue isn't registered yet, so the queue
> +	 * kobject isn't exposed to userspace. No need to worry about race
> +	 * with elevator_switch(), and no need to hold q->sysfs_lock.
>   	 */

How about replacing this comment with the following:

WARN_ON_ONCE(test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags));

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
