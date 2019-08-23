Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82707C3A5A3
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 16:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6527C21848
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 16:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbfHWQqu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Aug 2019 12:46:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37797 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfHWQqu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 12:46:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so6072134pgp.4
        for <linux-block@vger.kernel.org>; Fri, 23 Aug 2019 09:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qM187xz+2+a1f+AI7u/OAtVFglgdVMWQOLdPSnLHvIY=;
        b=fLGJoSDiJMUmutHqhfaLBTU6hwcrQKyigi1RoAAbhSWzAIPtWlJxwvE/e7rSArMkPe
         GJ9msMnRWXJNy5fMiNU772Np6tnGPvcUDviLBeFmD3FeY4cvDPT6EbKGVKw91u5J2950
         aipVq2DZU4N+HAghac3ZlTdoGiNHf+0Uq5o81YguX2bnI/zQTwJwWoVAzbVzYXMEQK7t
         6o/d/KdvwGT6ZVnGh+HNzfTYs++esQRrkaWpEQej46FnpyiZAM7nJzo6tja5NKm1tvtM
         AJxZch1ZPo7BSxr3bP2dcsHXeGQlm0ncamXhmIQMy+gd09ddI4sekzedq7tOJwyNIfRd
         5sIQ==
X-Gm-Message-State: APjAAAXRKiTZAiCXJqurIRC69heGCx3YPIwakyntpFOmjygNgHkzXTRx
        777Bi3cvVv9CYt0kpiUub+8=
X-Google-Smtp-Source: APXvYqw8jgNMK4CZQs+No2nYxfTbHZwdVS0SUF7pU7e0DFOy0yykxLtcl9JLPl8EeRci7qOd9DlGmg==
X-Received: by 2002:a63:6f41:: with SMTP id k62mr4845251pgc.32.1566578809756;
        Fri, 23 Aug 2019 09:46:49 -0700 (PDT)
Received: from asus.site ([2601:647:4000:1349:56c2:95e9:3c7:9c11])
        by smtp.gmail.com with ESMTPSA id z28sm3876936pfj.74.2019.08.23.09.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2019 09:46:49 -0700 (PDT)
Subject: Re: [PATCH V2 6/6] block: split .sysfs_lock into two locks
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-7-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <bf9762f7-1f1f-860e-cf98-b1838289e408@acm.org>
Date:   Fri, 23 Aug 2019 09:46:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821091506.21196-7-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/19 2:15 AM, Ming Lei wrote:
> @@ -966,7 +966,7 @@ int blk_register_queue(struct gendisk *disk)
>   		return ret;
>   
>   	/* Prevent changes through sysfs until registration is completed. */
> -	mutex_lock(&q->sysfs_lock);
> +	mutex_lock(&q->sysfs_dir_lock);
>   
>   	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
>   	if (ret < 0) {
> @@ -987,26 +987,37 @@ int blk_register_queue(struct gendisk *disk)
>   		blk_mq_debugfs_register(q);
>   	}
>   
> -	kobject_uevent(&q->kobj, KOBJ_ADD);
> -
> -	wbt_enable_default(q);
> -
> -	blk_throtl_register_queue(q);
> -
> +	/*
> +	 * The queue's kobject ADD uevent isn't sent out, also the
> +	 * flag of QUEUE_FLAG_REGISTERED isn't set yet, so elevator
> +	 * switch won't happen at all.
> +	 */
>   	if (q->elevator) {
> -		ret = elv_register_queue(q);
> +		ret = elv_register_queue(q, false);
>   		if (ret) {

The above changes seems risky to me. In contrast with what the comment 
suggests, user space code is not required to wait for KOBJ_ADD event to 
start using sysfs attributes. I think user space code *can* write into 
the request queue I/O scheduler sysfs attribute after the kobject_add() 
call has finished and before kobject_uevent(&q->kobj, KOBJ_ADD) is called.

Bart.
