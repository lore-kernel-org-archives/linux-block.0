Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D226DC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 20:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383420AbiFQUsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383062AbiFQUsD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 16:48:03 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB513D25
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 13:48:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id g186so4984210pgc.1
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E4HU3sGB5mPpumnMyVJQV5j2OzJpJF5je3ttvMEfWHo=;
        b=l6knT6n0Ab8El8mSxtAjG6qYxUVLQiqNQxhDfaZ2qwRU1zo5ch/ogvziylUHLMCJ95
         9zC+5gVHL6YKRoci4D7bvhYaY13iKQMrN/Q2xBBCT/ZnKcMwu/vZZAjAb4fAw8djkZNb
         /begVMe1DJhm0SnRRcPu/OL8fZgKVtHTXAtRJG2cF50F5y4qe2gpZ0RxqP5+iFZZ/tVY
         ZoIrVkFpoaKGSkiVuTSy6lxecVcnA0iGgZ8IfCnxvnaolk7r8R4F79rueXVM1Y9e+va9
         yqE5G6gIzd5zzhEUkzdVn9IVAaaFDyDpiDNdS0Z2okL7JTyhNi6A46koEHhjIwh8PPth
         tTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E4HU3sGB5mPpumnMyVJQV5j2OzJpJF5je3ttvMEfWHo=;
        b=ZlDOS8FyP+7RVDysxeVu0lJuv3A+2JCBrJHtR2Mo0WHENfnPMIszKMcic2uFlWu6+4
         T1N+ilJcYXy5uwBQwEdMpUl51WY3ZXD7sTOs+80/nuz0ihsckZ+2XaZXqd8U9WDvoBqL
         jkBqS5m7fAcPH1J1r2cuSjwQEqo0EhUVEjEava3SDBkmYIPDmfhnywXoApJt09eDMtyD
         8q5J/4Ir0zQ4iau0s8HM1RyGFDX3QI1AKYqzWVZ0xq2iuMCIhNdeF9/AFTGOaCrYhKuX
         JGYUH//OebkjuIChPBHxPPQkOIXr3Z+F6w1+nt71PsixDV//ILX4awvmQWOn9b0KrMHd
         SiWw==
X-Gm-Message-State: AJIora//IOOKefGMUnctvZ+H4ca7LjaRW6uRHeqEY24ap1kCuydoAo2N
        Ap8GkuIglg8KmkEI9qoJBrl1dCpH7vUAwA==
X-Google-Smtp-Source: AGRyM1uOO0feQdDhwlnuqT8XUUbVt7PUSctF7U1YV5TtzUp7y3qyopvI+yz/93p4tuJ/kkI3yvJm7A==
X-Received: by 2002:a05:6a00:a8f:b0:524:e53b:a95b with SMTP id b15-20020a056a000a8f00b00524e53ba95bmr3162053pfl.53.1655498881674;
        Fri, 17 Jun 2022 13:48:01 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b9-20020a63a109000000b003fbfa234818sm4175977pgf.54.2022.06.17.13.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 13:48:01 -0700 (PDT)
Message-ID: <c303c3b9-ee5d-c3d6-6e99-48c5eb205f21@kernel.dk>
Date:   Fri, 17 Jun 2022 14:47:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] block: bfq: Fix kernel-doc headers
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
References: <20220617204419.101985-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220617204419.101985-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/22 2:44 PM, Bart Van Assche wrote:
> Fix the following warnings:
> 
> block/bfq-cgroup.c:721: warning: Function parameter or member 'bfqg' not described in '__bfq_bic_change_cgroup'
> block/bfq-cgroup.c:721: warning: Excess function parameter 'blkcg' description in '__bfq_bic_change_cgroup'
> block/bfq-cgroup.c:870: warning: Function parameter or member 'ioprio_class' not described in 'bfq_reparent_leaf_entity'
> block/bfq-cgroup.c:900: warning: Function parameter or member 'ioprio_class' not described in 'bfq_reparent_active_queues'
> 
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/bfq-cgroup.c | 4 +++-
>  block/bfq-wf2q.c   | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index dc0fa93219df..abc251902e28 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -709,7 +709,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>   * __bfq_bic_change_cgroup - move @bic to @cgroup.
>   * @bfqd: the queue descriptor.
>   * @bic: the bic to move.
> - * @blkcg: the blk-cgroup to move to.
> + * @bfqg: the blk-cgroup to move to.

bfqg is the bfq group, not the block cgroup.

-- 
Jens Axboe

