Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C05C433E1
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 19:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD5B2075E
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 19:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="IQ7r/nEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHTTD7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgHTTD6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 15:03:58 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4062C061385
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2020 12:03:57 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so2458157qke.11
        for <linux-block@vger.kernel.org>; Thu, 20 Aug 2020 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IeFPzbP1/2uAC63tpGSICX90ZeHerr1PdZBO6JLKSEc=;
        b=IQ7r/nEK7QULQRgUruYtViggIk0yrhBkkQm+CAUw5a8EkOnP3Z3Obwe+AO0CkVc/+y
         ckR7dGWSlFKb29QS0VaoqtV5YPbCz6ErkAeZPa2IRaPAfSWfvMP3eicS9eJsmAbu8gne
         /7p2ywSqzlkFqVg1j+WcXM5mn+AoWMbN976tyr2/amy+IMQWGtkTs2oeWfEgjtOnZyuR
         NuMolaRSNG8pjgUGCo2/n4f2E4wCSaTOeyB0PpHm3ee4kLIBtZQSDaWXNvfaJw6vwdYL
         MOswIkvUu4TrXsqotNQwjrIdVNX6Soz9+HzRrTovFXuxLF6As6m+Yu/UMrlHE78YSkOr
         cAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IeFPzbP1/2uAC63tpGSICX90ZeHerr1PdZBO6JLKSEc=;
        b=TUd4/d7hgbEQ5MMxdTSdu9G6pDAJIuj82D2p0Lk2KxQ1DgkbpqxCFGvh+vs1Q1AuDL
         DWhhITw01pyxpLQwQdzPIi8spwTNokHHggvb9IeveCyH2Yq8iXlQZ0xlJGtRKHY4+pQi
         cU9Bom+6rmggNkVzvwde7tSsTK0dRr/PorzP1JdsT/HVFMMiGYG7PlBo5O5Mv+Nc0qM+
         LyoS3zGyUkz5cPSvej3NMJykJ1DWdnSRvMpxm18LOUklRZvBPY6iOaw86XT+vRNEqIZH
         YbzfQLfz0dLy5zE0bvW1MBSwX0sS1Xvvyr61IlJwKkqgOrOotf58z3PqkbelabZvv+ih
         S3Dg==
X-Gm-Message-State: AOAM533dWB8wjwNE0mZOZGiaiDk+uqMWIfb0gmNAZMjpmyiQuzTheJgk
        6iJqxd0vyOiXvmyjgAhUzX9eEjXuDZSHPHKG
X-Google-Smtp-Source: ABdhPJxmqy7dS0O0hH738bLfEgtU0qr9+TxisyoIN9ytnGIneRTmRoQgQqgQOxuELiy3Yqq1QNdKpw==
X-Received: by 2002:a05:620a:1436:: with SMTP id k22mr3751412qkj.308.1597950236554;
        Thu, 20 Aug 2020 12:03:56 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::113c? ([2620:10d:c091:480::1:2623])
        by smtp.gmail.com with ESMTPSA id o17sm3740176qtr.13.2020.08.20.12.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 12:03:55 -0700 (PDT)
Subject: Re: [PATCH] nbd: restore default timeout when setting it to zero
To:     Hou Pu <houpu@bytedance.com>, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org
References: <20200810120044.2152-1-houpu@bytedance.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <38b9de9e-38fe-3090-cea0-377c605c86d4@toxicpanda.com>
Date:   Thu, 20 Aug 2020 15:03:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810120044.2152-1-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/10/20 8:00 AM, Hou Pu wrote:
> If we configured io timeout of nbd0 to 100s. Later after we
> finished using it, we configured nbd0 again and set the io
> timeout to 0. We expect it would timeout after 30 seconds
> and keep retry. But in fact we could not change the timeout
> when we set it to 0. the timeout is still the original 100s.
> 
> So change the timeout to default 30s when we set it to zero.
> It also behaves same as commit 2da22da57348 ("nbd: fix zero
> cmd timeout handling v2").
> 
> It becomes more important if we were reconfigure a nbd device
> and the io timeout it set to zero. Because it could take 30s
> to detect the new socket and thus io could be completed more
> quickly compared to 100s.
> 
> Signed-off-by: Hou Pu <houpu@bytedance.com>
> ---
>   drivers/block/nbd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index ce7e9f223b20..bc9dc1f847e1 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1360,6 +1360,8 @@ static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout)
>   	nbd->tag_set.timeout = timeout * HZ;
>   	if (timeout)
>   		blk_queue_rq_timeout(nbd->disk->queue, timeout * HZ);
> +	else
> +		blk_queue_rq_timeout(nbd->disk->queue, 30 * HZ);
>   }
>   
>   /* Must be called with config_lock held */
> 

What about the tag_set.timeout?  Thanks,

Josef
