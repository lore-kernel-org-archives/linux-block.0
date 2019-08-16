Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B47BC3A59C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0C5206C1
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 15:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfHPPbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:31:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42668 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbfHPPbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 11:31:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so3108121pgb.9
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 08:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xOQ4k2CvMo9pbAvK8uHRZ8OYCQz54RC9e1oMPDiG7jY=;
        b=BL5+/x9zE+W9grgJxjvtl8dAJkpBy1lnTOFTqjxwtgXrxlgi2HsqQ6B6Pm7ngNfGQE
         Nmlgj/0rnyKw3Aedl64XzOW1MVVaYyXwjr5Fg8Iy6IZpUV2nQ8qoRDxdKTTgDDavZC9L
         pZA2almds9NwxtpVPEOrXp42ma3kZBXZiJfW/51UMKfxoeRU4pUBViwrG/LRMgnSbBR2
         thf7nYwKLVxAhUuB6PKv2ezyqXvQ2yTkrsdp5qz6sq5HUe1SllaKNlSay12u9eQK8gQS
         kVza+Z2hKPQ9cTc36jXTmo3a1DDaXXCKlL/hfz7SRI0bbd5LiFiIKbS7ZCv8hGKo71iR
         IuBA==
X-Gm-Message-State: APjAAAWrleAvTL8p9U1E04ILs+qXTih+qPWGnRC31jqqqPKFQT0z1oXA
        eG4acZvQ+EqGB7O+ZLLdjMo=
X-Google-Smtp-Source: APXvYqyKQK6fzSUVq+Fgge51661p8+1YAiW2J4vS/qYX67oGWI6ebhKqR6mezJkVJG3wpVbObBJMAw==
X-Received: by 2002:a63:29c4:: with SMTP id p187mr8465112pgp.330.1565969468675;
        Fri, 16 Aug 2019 08:31:08 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 65sm5363254pgf.30.2019.08.16.08.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 08:31:07 -0700 (PDT)
Subject: Re: [PATCH] block: don't acquire .sysfs_lock before removing mq &
 iosched kobjects
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190816135506.29253-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <14a9ae85-0d65-483d-30f7-d692c4058e46@acm.org>
Date:   Fri, 16 Aug 2019 08:31:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816135506.29253-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/19 6:55 AM, Ming Lei wrote:
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 977c659dcd18..46f033b48917 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -1021,6 +1021,7 @@ EXPORT_SYMBOL_GPL(blk_register_queue);
>   void blk_unregister_queue(struct gendisk *disk)
>   {
>   	struct request_queue *q = disk->queue;
> +	bool has_elevator;
>   
>   	if (WARN_ON(!q))
>   		return;
> @@ -1035,8 +1036,9 @@ void blk_unregister_queue(struct gendisk *disk)
>   	 * concurrent elv_iosched_store() calls.
>   	 */
>   	mutex_lock(&q->sysfs_lock);
> -
>   	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
> +	has_elevator = q->elevator;
> +	mutex_unlock(&q->sysfs_lock);

blk_queue_flag_clear() modifies queue flags atomically so no need to 
hold sysfs_lock around calls of that function.

> @@ -1044,16 +1046,13 @@ void blk_unregister_queue(struct gendisk *disk)
>   	 */
>   	if (queue_is_mq(q))
>   		blk_mq_unregister_dev(disk_to_dev(disk), q);
> -	mutex_unlock(&q->sysfs_lock);
>   
>   	kobject_uevent(&q->kobj, KOBJ_REMOVE);
>   	kobject_del(&q->kobj);
>   	blk_trace_remove_sysfs(disk_to_dev(disk));
>   
> -	mutex_lock(&q->sysfs_lock);
> -	if (q->elevator)
> +	if (has_elevator)
>   		elv_unregister_queue(q);
> -	mutex_unlock(&q->sysfs_lock);

Have you considered to move the q->elevator check into 
elv_unregister_queue() such that no new 'has_elevator' variable has to 
be introduced in this function?

Thanks,

Bart.
