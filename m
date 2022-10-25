Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0B9FA373E
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 18:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJYSLq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJYSLp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 14:11:45 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B098983050
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 11:11:41 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id g13so7320972ile.0
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 11:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5n6c2CbsfFvTIF5f5Nr1n+MOOiDbqRcJ5kDbT7Gyebg=;
        b=PhNYwqa4350GNU7w/RQHZjfqgljm2DtvGwka7LtEaVaRGxGV7CwU4q2MtMzDrB3ZKf
         zYnk+DwOzk0KDcC00sV3UqYW9L7zr4rFBfQRPIukX2yXfTJtUAttimK61Vj4yQ+O5zfP
         +Vgs33sUB5Gia0l/B1nOxu8/a9M6LaBML41/jvUbC2ASihOy18RsjS0JcHYf5jGcmay4
         WUEZ7Tq1qWbiQBGyRHed8Sr14+E2mzMzyfg2WQs8ZF08IZMfWs3SexVJmxMiP1jdewIc
         n6S6g6+o/NK29g2ECoR4a2ol7SJJZ+Bw6eI2iS2qxTTa0FBg4s4T/fdCpOYgJGQMNPyZ
         dq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5n6c2CbsfFvTIF5f5Nr1n+MOOiDbqRcJ5kDbT7Gyebg=;
        b=XEoiKMe1esvWTzcpRRQniNd1+YvdB0k3lTlWX3GSL8+FikaVsopHi+bu5623A5eOk0
         CVGH/RnzmtWRJ/IMTyEn7PmODoVkZkoa6MI5dIr+Du1g5H1eYrU/YRMRwrKftgnlFCMw
         btkI+Joxd4zcadOov8yCU36o0aSfdgOut+PpMolunqRG5w7MqT6o5JU1wZ37am25ttsj
         89t77oqBvFFfA+nQjJvEO77HV3Q+MfjLBfSgkO+awzQLLJCyeTy0aNq+qUaXleMVYcgs
         nscavreirvPFWnjOxwC0/6JcErDnfI64eQGmmtqS3GCTWZutYo1xrnv5NgaQk98vfn/J
         1C1Q==
X-Gm-Message-State: ACrzQf2LcsSS5slScRz+t7hNVqN676GGgN6MI+8u8L7oxK75oOAZ9W/j
        z/S8f0yE/Pf2XAc1jtFY52aOcw==
X-Google-Smtp-Source: AMsMyM6iQvEkBnwDvjOLmRsECOfUrlA8ckX7bc/+yUy/pp2OhtUfxF+2FZAi3DhyPFiBVT+lAXhGYg==
X-Received: by 2002:a05:6e02:1bc3:b0:2fa:c3f4:30d6 with SMTP id x3-20020a056e021bc300b002fac3f430d6mr23611222ilv.43.1666721500991;
        Tue, 25 Oct 2022 11:11:40 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g17-20020a056e02131100b002dd0bfd2467sm1260796ilr.11.2022.10.25.11.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 11:11:40 -0700 (PDT)
Message-ID: <bf375891-667f-1bcc-bd63-b90e757f5322@kernel.dk>
Date:   Tue, 25 Oct 2022 12:11:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] blk-mq: avoid double ->queue_rq() because of early
 timeout
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        virtualization@lists.linux-foundation.org
References: <20221025005501.281460-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221025005501.281460-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/22 6:55 PM, Ming Lei wrote:
> @@ -1593,10 +1598,18 @@ static void blk_mq_timeout_work(struct work_struct *work)
>  	if (!percpu_ref_tryget(&q->q_usage_counter))
>  		return;
>  
> -	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
> +	/*
> +	 * Before walking tags, we must ensure any submit started before
> +	 * the current time has finished. Since the submit uses srcu or rcu,
> +	 * wait for a synchronization point to ensure all running submits
> +	 * have finished
> +	 */
> +	blk_mq_wait_quiesce_done(q);

I'm a little worried about this bit - so we'll basically do a sync RCU
every time the timeout timer runs... Depending on machine load, that
can take a long time.

-- 
Jens Axboe
