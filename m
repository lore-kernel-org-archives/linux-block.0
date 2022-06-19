Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D477C433EF
	for <linux-block@archiver.kernel.org>; Sun, 19 Jun 2022 14:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiFSOHZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Jun 2022 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiFSOHZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Jun 2022 10:07:25 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1817DB494
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 07:07:23 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso8015150pja.2
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 07:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4OxnMy+a+9T8XcrE+7DVf3rFB7jRjzz0wtiO4wPYzno=;
        b=LnC2KihlBYo1J5tVskGDCp4LEDORB6460ocXyuYUhqbdo/CXyHlYnZM1bpLkq3Smse
         w+/7N8LWGv4Zl63wCSRPdGeMQgY5oSAq/y+sO8jsNDnB2CVaLU+MB5wueHuCP0rQw3oL
         50gfVBIQ9QfwYg2q1Afebe8S/cB0ktNHy9m+ueSYbKpiinPpRpx79S3bLESll/o7uqFT
         e/FQm0pOyWbDSgniod/YEjvtmkRy/NdADz8PKPRt5vuK0rQOZKuON88pf0CV1Vg9Ufzy
         ZAkshK1vdVj+Cce9WLpM65FNgfDJh14mTgtx5PYBw4DUs3lEVCi9I1v0vy8xMFXOxjh7
         k38g==
X-Gm-Message-State: AJIora/dgc6jkaDALi5SIqhuuPNKj2cWLF8xK25fykAm21hehGoDsIRL
        lbQXhTOH/e0uDP4LjSg5GFTWV+WHzsI=
X-Google-Smtp-Source: AGRyM1teGP5BjgRrqhhkafIf5prXwNce3+KHvGt/xiZjHfI1ItWci/+oD/F1YjDxLVN24hsj5El9RQ==
X-Received: by 2002:a17:902:9348:b0:167:8e92:272f with SMTP id g8-20020a170902934800b001678e92272fmr19553262plp.77.1655647642358;
        Sun, 19 Jun 2022 07:07:22 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id c10-20020aa7952a000000b0050dc762819esm1981316pfp.120.2022.06.19.07.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 07:07:21 -0700 (PDT)
Message-ID: <463adfd1-45fb-0f9f-2f25-34408b76e75c@acm.org>
Date:   Sun, 19 Jun 2022 07:07:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/6] block: remove QUEUE_FLAG_DEAD
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <20220619060552.1850436-4-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220619060552.1850436-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/18/22 23:05, Christoph Hellwig wrote:
> @@ -151,11 +150,10 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
>   	char opbuf[16] = { }, *op;
>   
>   	/*
> -	 * The "state" attribute is removed after blk_cleanup_queue() has called
> -	 * blk_mq_free_queue(). Return if QUEUE_FLAG_DEAD has been set to avoid
> -	 * triggering a use-after-free.
> +	 * The "state" attribute is removed when the queue is removed.  Don't
> +	 * allow setting the state on a dying queue to avoid a use-after-free.
>   	 */
> -	if (blk_queue_dead(q))
> +	if (blk_queue_dying(q))
>   		return -ENOENT;

I'm missing an explanation of why this patch forbids triggering a queue 
run in the dying state. "dying" means that allocation of new requests 
will fail. Unless if something fundamentally has changed in the block 
layer it should still be safe to trigger a queue run in the "dying" state.

Thanks,

Bart.
