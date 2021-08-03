Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBE5C4320A
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 13:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1165160F8F
	for <linux-block@archiver.kernel.org>; Tue,  3 Aug 2021 13:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhHCNCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhHCNCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Aug 2021 09:02:42 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D481DC061757
        for <linux-block@vger.kernel.org>; Tue,  3 Aug 2021 06:02:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k2so6081084plk.13
        for <linux-block@vger.kernel.org>; Tue, 03 Aug 2021 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xym3dK2go7OZw2DbMaNrojlI3gUoFr4D9bt44dyFm0U=;
        b=StPXrwG3eNvkzVaxPPu8GWT/n8kQszTXPfezGgCtLAC2FdB0cdWuehabG6fMf+0mPR
         ucBTziPk8ZIKP1JoMgpAqK+gPPyjwQ0Ea5xXe2AeaoBlfZi1UIyXSV2Sdc9l3G4jgu4W
         PTZUzJRQE7+rjwDVmYccHRow6N8Dg2geTMR3n9Mf8Lv9jnH3PT19aPvwOEfILautmDQ+
         bhKhfgELGauK8r0pLcsVN9zpgrXNP6033+8G7+G7iXlHhIs5vg6wMMqq4LyGqVxv+ml2
         hX8UDVCQB3MWUMmp3F+cPTd13LyU0SR4N/js+GQTKglYK4yh9WNWm9GDxPV0f150DrpU
         EA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xym3dK2go7OZw2DbMaNrojlI3gUoFr4D9bt44dyFm0U=;
        b=XttjpalcseL8Lsv/vhD5UrA7ZHzrMxEP81QyqBN+IgRlQMz6TrGFj6+N/fMLjFwrZy
         slygAxlriV0z9WsIMlm9o/P6ZCr8YEMsSXo0dRCEgoI9yDztOvA95l7Jttp+djhF6tSi
         4YpC61f6lCfxmiIzy+jYRn1buZkvxqXvx5MBghLl5Xp0KCfYyG8jpjOepMy7Wdxsux+e
         Fj8Nsr3K3ft2BfdmIVnGsDrSgrVUcBrsTvbZUm0IQ12G959zvOkKLpXAjw68uxj1N7hj
         +EkUVWbi2UYW8SGwYoETTlZKxmcbaRmpoe8VGOfqjec7MunPClUtIARUHle69uNA551i
         D5Lw==
X-Gm-Message-State: AOAM533E40GY2pGHlcwA55jLM35TtUNEj/1v5kq4sqvwH5AXpwOWx9tE
        73fmi38IzMYbxMwNHa+EMn/laA==
X-Google-Smtp-Source: ABdhPJzkjRXS7I81y7/pEFIA72WnjPj4pnJy7ZTY8GIWjQuCY3kHoXm94UxNnpBKUM7JrUyyP+bpIQ==
X-Received: by 2002:a17:90a:c094:: with SMTP id o20mr23235682pjs.207.1627995751400;
        Tue, 03 Aug 2021 06:02:31 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id fh2sm14047869pjb.12.2021.08.03.06.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 06:02:30 -0700 (PDT)
Subject: Re: [PATCH] blk-iocost: fix lockdep warning on blkcg->lock
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Bruno Goncalves <bgoncalv@redhat.com>
References: <20210803070608.1766400-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d5b57c0b-4b2a-8ab6-e446-3353f0805fac@kernel.dk>
Date:   Tue, 3 Aug 2021 07:02:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210803070608.1766400-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/21 1:06 AM, Ming Lei wrote:
> blkcg->lock depends on q->queue_lock which may depend on another driver
> lock required in irq context, one example is dm-thin:
> 
> 	Chain exists of:
> 	  &pool->lock#3 --> &q->queue_lock --> &blkcg->lock
> 
> 	 Possible interrupt unsafe locking scenario:
> 
> 	       CPU0                    CPU1
> 	       ----                    ----
> 	  lock(&blkcg->lock);
> 	                               local_irq_disable();
> 	                               lock(&pool->lock#3);
> 	                               lock(&q->queue_lock);
> 	  <Interrupt>
> 	    lock(&pool->lock#3);
> 
> Fix the issue by using spin_lock_irq(&blkcg->lock) in ioc_weight_write().

This looks fine to me for blk-iocost, but block/blk-cgroup.c:blkg_create()
also looks like it gets the IRQ state of the same lock wrong?

-- 
Jens Axboe

