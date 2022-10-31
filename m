Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121BAFA3741
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 22:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJaWmR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJaWmP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2022 18:42:15 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B85FE4
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 15:42:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 78so11891924pgb.13
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRMdWiYjXBe7i8ZOrpjheUXKlMSyR1zSfE5JEFpYISY=;
        b=H/9lVnsYq0RYxDSo58MjXC6UsvgNTxwjVviKsMQCbMsOCfR4Ol3sa3nWx0wBeSWRwg
         iNG3cQDElF63yYIxJuBwLKXRg7bOyHTcJWBa/rOSWcw+7HzynLatOASAWl90Si/CNSdE
         ojcV13SOx1KU5+W7eHl8GFTAz5W5WqsBrWfZutx8Xs9s/b8Ca3tedFxO/dfghvpPjex5
         qmRIYawMRxATEF4i+c1nYWx+FQ+pezXl+wrtZ2N8dHqLrSLzOrwmiZKxGbmRvG+XBN0G
         nwhJAA1+IA4Cwy2kbKyvWiglE1gDBZ6yBpGZacLrpO0mvxwKId2pa241+/RSUvKsx2Qr
         hzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRMdWiYjXBe7i8ZOrpjheUXKlMSyR1zSfE5JEFpYISY=;
        b=77OzyQVNmGMLExa/uLt2pUUaXVKE2vIOdi8WjKAmKaqoFqktJtABm4CAGTRsYFXPNX
         UFeCerxXS9HR4igpcwjtPAu66loLbpwzjuenElFkHsKmJXq/sZ9CMnch2XUiNTSLSbso
         UKGeW23iMD0OE8NNPzSmhssiV/67T68Qs90w69XAd+jQqJRPNU3hz2gwFTn4XNUZs+IX
         eJM6DgvnPSy6o1tGcC0QxVJYCbZwK9xShuGGuuV+IPHbQCyezC1+gQgcUlOsAcPVvJ81
         2+g8bbORguSLEGi0eE/72BnIWp2q3FlD13OPS8e37YNI4Up1BevbnjtHkUvlax5/hXea
         jsrA==
X-Gm-Message-State: ACrzQf078tAbrLiLbhihlX6a4FfmjqngoVDO7k9EYo1ExsvSTt+pRc+p
        5mUfjPKsIIa4u/JLd65GClzSPstaRpxuZRxH
X-Google-Smtp-Source: AMsMyM7ODcMSf5dpatFoCSId7G3XJfU1cO8merGPJYwZ92xjpfZnBISg+edbFIHEGgxzm0ak77DdGQ==
X-Received: by 2002:a62:e40e:0:b0:56b:add7:fc22 with SMTP id r14-20020a62e40e000000b0056badd7fc22mr16552135pfh.63.1667256133170;
        Mon, 31 Oct 2022 15:42:13 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b00176ba091cd3sm4874607plb.196.2022.10.31.15.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 15:42:12 -0700 (PDT)
Message-ID: <1a46585b-878b-a3b7-3090-36bddba86dbd@kernel.dk>
Date:   Mon, 31 Oct 2022 16:42:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: UAF in blk_add_rq_to_plug()?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org
References: <Y2BIad98er4QsbZY@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y2BIad98er4QsbZY@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/22 4:12 PM, Al Viro wrote:
> static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
> {
>         struct request *last = rq_list_peek(&plug->mq_list);
> 
> Suppose it's not NULL...
> 
>         if (!plug->rq_count) {
>                 trace_block_plug(rq->q);
>         } else if (plug->rq_count >= blk_plug_max_rq_count(plug) ||
>                    (!blk_queue_nomerges(rq->q) &&
>                     blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
> ... and we went here:
>                 blk_mq_flush_plug_list(plug, false);
> All requests, including the one last points to, might get fed ->queue_rq()
> here.  At which point there seems to be nothing to prevent them getting
> completed and freed on another CPU, possibly before we return here.
> 
>                 trace_block_plug(rq->q);
>         }
> 
>         if (!plug->multiple_queues && last && last->q != rq->q)
> ... and here we dereference last.
> 
> Shouldn't we reset last to NULL after the call of blk_mq_flush_plug_list()
> above?

There's no UAF here as the requests aren't freed. We could clear 'last'
to make the code more explicit, and that would avoid any potential
suboptimal behavior with ->multiple_queues being wrong.

-- 
Jens Axboe
