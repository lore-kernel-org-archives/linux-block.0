Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC37C433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 03:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE507208D5
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 03:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vP6EfkCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFRDdy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 23:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgFRDdw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 23:33:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71478C06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 20:33:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so2268619pgo.9
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 20:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YI0XDThQLjY0fVNpKgQ3MeXpOKf8gaSWnYmh99xLNBE=;
        b=vP6EfkCDhhWop/JpcOXXWWLlub2BF5emVrDXrqGw2F6Vo1agBQfH40xXxrbEy16EGA
         GGzLAN9NHFZq//ZoH9oNfbbvpgmLhZheSO6pRWIqEsMrW98v7+34NzUVI+cm5B/v5XJE
         aHTkMDjh4D0vjK+boSTFJ13R9RR36fNxEwgOs8pUH27uBz2+Hj8D6kvh7OrVpQVUqGOi
         9YiarRpMHtmA1dM+M74MrhaT04LSi/B98glYopEeJXlDvpTHLat1o4o2dEvwIdo0RpC9
         02qY1V769VjnXoZQx/7zjTTvLg531EBf4nYLEyce1WzDqHA2FK7i+KTwcLCYadelEdSP
         ktpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YI0XDThQLjY0fVNpKgQ3MeXpOKf8gaSWnYmh99xLNBE=;
        b=pTQlz/1kZZQJ0Qzpo6tsrWjCcIXN0itpOkY9QjWSA3OPpCk6iBn4ouHG13rAmr3aug
         Vn05OUCKukhMSQb/4+Z/FNVSHgtdb2aNBAMZ6i68cQ+QHrvmeWCtVwYVIk0N4gEqfe/Q
         WH2goEne9r+XTPnquAcwMEN5AB8MVRDqsqG3JxcUZ+qkj+zsPJiDTYXdVQy8LClXgXff
         cpR0zhZoRtCTwxYRTJehJbJruvPTe+tDLUhC4RZCQLXzcD7crE4gyLOw1VEG8zfWyP1R
         wEy/Mm+EsIC4tdZKMdW0amZRAnYsnliKMsZ+MeKAnP5+kkVxKNrlM3JDt3rapjYPfgaT
         jCWw==
X-Gm-Message-State: AOAM531oOQbX6KJQ5VsxQXb3Ko+/+qUaEIwMK7TQcAOmFH6SsAZLcN6J
        oMP37B1WjbMr+oqDcdsO3xW82t2lf9b66w==
X-Google-Smtp-Source: ABdhPJxdD7i83tBvhq7Gfd1jRNleuRFXOPFP682ON6f9q8TUg1Z0Iy8Us19dvoM+EYZ//ZBfsH8lpA==
X-Received: by 2002:a62:38c9:: with SMTP id f192mr1815399pfa.17.1592451230595;
        Wed, 17 Jun 2020 20:33:50 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g29sm1168811pfr.47.2020.06.17.20.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 20:33:49 -0700 (PDT)
Subject: Re: [PATCH] block: update hctx map when use multiple maps
To:     bvanassche@acm.org, tom.leiming@gmail.com,
        linux-block@vger.kernel.org
References: <20200617061830.GA15100@192.168.3.9>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ec866287-a10b-be70-9c68-fbe50444cf94@kernel.dk>
Date:   Wed, 17 Jun 2020 21:33:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617061830.GA15100@192.168.3.9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/20 12:18 AM, Weiping Zhang wrote:
> There is an issue when tune the number for read and write queues,
> if the total queue count was not changed. The hctx->type cannot
> be updated, since __blk_mq_update_nr_hw_queues will return directly
> if the total queue count has not been changed.
> 
> Reproduce:
> 
> dmesg | grep "default/read/poll"
> [    2.607459] nvme nvme0: 48/0/0 default/read/poll queues
> cat /sys/kernel/debug/block/nvme0n1/hctx*/type | sort | uniq -c
>      48 default
> 
> tune the write queues to 24:
> echo 24 > /sys/module/nvme/parameters/write_queues
> echo 1 > /sys/block/nvme0n1/device/reset_controller
> 
> dmesg | grep "default/read/poll"
> [  433.547235] nvme nvme0: 24/24/0 default/read/poll queues
> 
> cat /sys/kernel/debug/block/nvme0n1/hctx*/type | sort | uniq -c
>      48 default
> 
> The driver's hardware queue mapping is not same as block layer.

Applied, thanks.

-- 
Jens Axboe

