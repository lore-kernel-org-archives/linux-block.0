Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E982C433E0
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 22:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5951C2065C
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 22:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731843AbgEMWsj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 18:48:39 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:34596 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731649AbgEMWsh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 18:48:37 -0400
Received: by mail-wm1-f52.google.com with SMTP id g14so12915605wme.1
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 15:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=TXYMSfec3D5KB8tXCBWmFLPT4UghDbqXKlVycRr22I5g73MkLZTk9T2XanJ0rgDZPB
         jJUSQIL8UZJC4XveY00val2rh+Bu4Uqkdjg6976VDD0JbG3gw2tMT+tTDVSVGRH8Shyu
         khTyt4V/p8sHJ4TCr6jSqxhGXqHt6x275LYKDn4gXz3d8Zrh0+mkjD6a9tHwzxND/1CF
         iuK3uFv+u27Y4+njuvuhfWwscW3tmby4+B1N7sbBU3DEwFiDR5ZIYV3x8EyQ6W4cmPnh
         /pbSKtPIsVYYFCVV15uDfXaI8loHiuSBbsXYZozOTpy32mQEzuSdGJZSWCYyRTIff9TL
         esCQ==
X-Gm-Message-State: AGi0PuZEUxG7MJVqrQB+1LHFY9lnJHuUaoV8xZH7nDyW2sTstS6FhRBc
        VPazUnC9CmUxpibpZLgwgsw=
X-Google-Smtp-Source: APiQypLRI4Gsb/q/fdvMJCgYtZsRAs41VDFP/wjHdZpI3u58nT7Qcam6wGgviib6WT7uLfrfjSPfLg==
X-Received: by 2002:a1c:df83:: with SMTP id w125mr35593243wmg.140.1589410114519;
        Wed, 13 May 2020 15:48:34 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:59e0:deac:a73c:5d11? ([2601:647:4802:9070:59e0:deac:a73c:5d11])
        by smtp.gmail.com with ESMTPSA id y185sm8331372wmy.11.2020.05.13.15.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 15:48:33 -0700 (PDT)
Subject: Re: [PATCH 1/9] blk-mq: pass request queue into get/put budget
 callback
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-2-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eedc9d08-ba6d-4821-4eb6-cd7d429d6e80@grimberg.me>
Date:   Wed, 13 May 2020 15:48:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513095443.2038859-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
