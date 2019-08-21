Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A3AC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 15:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AC72339E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 15:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfHUP4j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:56:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46209 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbfHUP4j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 11:56:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so1680163pfc.13
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2019 08:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZZSDIQklOww3mGHYNls/gs/JjMEvciUmc6VjEf23lQk=;
        b=n7O5MeoqCbA7TBoDKceaheW5EAVOsXT7He499huklC8TOw/sK/F5HJ9G0BnvFC+XK+
         zTUfuBtqL53o/D0JVFBOJPXWchrvN6aSEzc7a6ltVUKIDH0ydQd0Q4iXfPt2Y77OOvep
         fPoirc/FUZDt8qjxGKzMtQx18KDADs84+1jMVFNoBD7HZAXloguT0aWO0Njc24cgZr5f
         Key/M3z8eZsdycDqSF3zDHIGLvcXT9FkO/PisxhM5l37sBcRRQFG6COhtn+QUeuxiY7y
         zHs6P+usK7ul5KLl7l7pDMeS3N2dB2iYnSDxF/qtc/H0UpSsnoQJaG5nMWSTvrCBle05
         94jQ==
X-Gm-Message-State: APjAAAXRmnw0xZX5uXVWfEjKBJoYrotF2+NWiu9so4ySzPAmRpWU6AP4
        kjHREI3ZuV1i/KmqKHtRX6A=
X-Google-Smtp-Source: APXvYqzOnZGKlX5ojYsWpvsETQGs3EkWXmRpKqiX3rReF+5JAEJcHC/Q5rv/u6KuFQRz3CGwBZBzgA==
X-Received: by 2002:a17:90a:2069:: with SMTP id n96mr710975pjc.4.1566402998263;
        Wed, 21 Aug 2019 08:56:38 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id k64sm35630249pgk.74.2019.08.21.08.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 08:56:37 -0700 (PDT)
Subject: Re: [PATCH V2 4/6] blk-mq: don't hold q->sysfs_lock in
 blk_mq_realloc_hw_ctxs()
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-5-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <51cf9611-c62f-3dcf-2447-d8bde28bc238@acm.org>
Date:   Wed, 21 Aug 2019 08:56:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821091506.21196-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/19 2:15 AM, Ming Lei wrote:
> blk_mq_realloc_hw_ctxs() is called from blk_mq_init_allocated_queue()
> and blk_mq_update_nr_hw_queues(). For the former caller, the kobject
> isn't exposed to userspace yet. For the latter caller, sysfs/debugfs
> is un-registered before updating nr_hw_queues.
> 
> On the other hand, commit 2f8f1336a48b ("blk-mq: always free hctx after
> request queue is freed") moves freeing hctx into queue's release
> handler, so there won't be race with queue release path too.
> 
> So don't hold q->sysfs_lock in blk_mq_realloc_hw_ctxs().

How about mentioning that the locking at the start of 
blk_mq_update_nr_hw_queues() serializes all blk_mq_realloc_hw_ctxs() 
calls that happen after a queue has been registered in sysfs?

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
