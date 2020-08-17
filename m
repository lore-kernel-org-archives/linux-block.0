Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7711FC433E3
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 13:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A77D2076E
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 13:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BHDFltHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgHQN6L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbgHQN6H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 09:58:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C25C061389
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 06:58:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 128so8160495pgd.5
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 06:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sxTm0MDA48C6DRBHygSypzKB0FTO7Lkdws17ZyedZ+U=;
        b=BHDFltHvg94v09FxsTFqz2QR3sNHXrHocqpMEkiW+etyjuibrQo1OabrM3GON+eMpX
         iLXyaumYoeFuSrnIe8EzsUCb5PhBPvgiqXjVLeM1cIVmrBwcDAsrXO6MTEJH1ICXDDwO
         IXolzN3FryJosKw/K8Bg0Wh750IVKq7YgW4qn//fmhcZ89ZYNkkdA+KsTl5OSHZ26qK4
         Choug68AVwp831pf12XOo6PhWx/a+M8e0LgUATHblhr2lZKhWGql87cVbV+30rzz/rjD
         zxbbHMqQBvtiH/FlyUJufUlbsNWSOT0OW1v/wT2GT09QAYpAb8r953l6QHP4LA1QKWII
         0Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sxTm0MDA48C6DRBHygSypzKB0FTO7Lkdws17ZyedZ+U=;
        b=XA+VIx5KJVzP+pUI2Tx2bAu87n1+Fj+4XKU9AUUPcjJDqFXNadL2j1SsyXN6UZsghc
         iXJpkxuIZ2B0UOZzKhZsaKSvkZ4tGlzFyQJiNUcLDbCBPIlm/Z2d5ApQja/ohrWrcjRl
         bfHMVICdaX8wyOikrB0lPpH2N88v7WIBiTYaYWI4yYnNo/MskWp7l75aZ8N+S1JUqZSh
         WKeQGmy+Te33GWuoZFo613gvnaYiqZ0G184ubtnBT5vu5zT0clOaXbx5mj1ZTwRSLBCW
         Fbaqu7hCQ32R91koyFJG+zWW7dfpV/gCwx5SDF9N5L5K8jvqAhVgi29x1pIiVuWNgAku
         cn2w==
X-Gm-Message-State: AOAM531Q+vKh7/a8lZ9Jx3HYiNqj1ONoyyo5e1NivR8ruMvDj/5cUDLO
        aADUImMq7BGj+/bNs/3xcTw1Rw==
X-Google-Smtp-Source: ABdhPJywFCYWjmMBTTneDwnmtgW5uomGEgohBR+yCAHdDu81XVMdDgMtdKX0F7cmGiHr3ToyCqjXLw==
X-Received: by 2002:a63:7251:: with SMTP id c17mr10367818pgn.101.1597672687123;
        Mon, 17 Aug 2020 06:58:07 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ff2c:a74f:a461:daa2? ([2605:e000:100e:8c61:ff2c:a74f:a461:daa2])
        by smtp.gmail.com with ESMTPSA id e23sm17268269pgb.79.2020.08.17.06.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 06:58:06 -0700 (PDT)
Subject: Re: [PATCH RESEND] blk-mq: order adding requests to hctx->dispatch
 and checking SCHED_RESTART
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        David Jeffery <djeffery@redhat.com>,
        kernel test robot <rong.a.chen@intel.com>,
        stable@vger.kernel.org
References: <20200817100115.2495988-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bc5fa941-3b7c-f28e-dd46-1a1d6e5c40a8@kernel.dk>
Date:   Mon, 17 Aug 2020 06:58:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817100115.2495988-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/17/20 3:01 AM, Ming Lei wrote:
> SCHED_RESTART code path is relied to re-run queue for dispatch requests
> in hctx->dispatch. Meantime the SCHED_RSTART flag is checked when adding
> requests to hctx->dispatch.
> 
> memory barriers have to be used for ordering the following two pair of OPs:
> 
> 1) adding requests to hctx->dispatch and checking SCHED_RESTART in
> blk_mq_dispatch_rq_list()
> 
> 2) clearing SCHED_RESTART and checking if there is request in hctx->dispatch
> in blk_mq_sched_restart().
> 
> Without the added memory barrier, either:
> 
> 1) blk_mq_sched_restart() may miss requests added to hctx->dispatch meantime
> blk_mq_dispatch_rq_list() observes SCHED_RESTART, and not run queue in
> dispatch side
> 
> or
> 
> 2) blk_mq_dispatch_rq_list still sees SCHED_RESTART, and not run queue
> in dispatch side, meantime checking if there is request in
> hctx->dispatch from blk_mq_sched_restart() is missed.
> 
> IO hang in ltp/fs_fill test is reported by kernel test robot:
> 
> 	https://lkml.org/lkml/2020/7/26/77
> 
> Turns out it is caused by the above out-of-order OPs. And the IO hang
> can't be observed any more after applying this patch.

Applied, thanks.

-- 
Jens Axboe

