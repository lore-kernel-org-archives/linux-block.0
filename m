Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C508C4363D
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 20:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0FAB2087E
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 20:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VL2ee7xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgJFUhX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJFUhV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 16:37:21 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F28C061755
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 13:37:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 22so4733920pgv.6
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2020 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RgF+rFQeG1/Kf+Q2eDaS1K/xwgjl9EGKCnFyX8mR6mY=;
        b=VL2ee7xerQgy+z0zWkGKWGd2OX3Jr7v38iAt8UoBnZEUkOve+EcA+C3npAGcfsW7hu
         CbCrOsC3ACOpV1e9JS2bmpdd8TEu4Xgox3cbrmr6eRenr9rzgefpCQ8WdiAE4F/qZHmA
         8zJS4TttSWNdxuSjOPki1wyB+RfCN073vCRcQOdepj9snGf+2XVjuZzY1e0TZGY0KJ0l
         y1SIvXJHegww3GvuFzPag8RJQrFLMvcbJyKodMyyBC8cwXoReDokXV5DAl8Gx53QrKrf
         vIFSVUnjPlxDnlMLY1dumhv0K7e+8uo1/35KwsiP4NegN9Ca97ysl7d0a5gJ+u9jcoBp
         7j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RgF+rFQeG1/Kf+Q2eDaS1K/xwgjl9EGKCnFyX8mR6mY=;
        b=ArNVrPNGnOXXuM0ShCBBQUaHG+j7ch9E+M8Omt0uK1iz35A9u8GtwmZZDNkYP6zQep
         lFZ7hbEAwX2I0xTTDcEC6e6fWpfmLL2wh9qM6B11eZQK/qm5pZJRzvPccd8o6ixm43Of
         TFBB2JTELXKEVolatsDxJK2dsLlomG5nv4C5Tx7WFKDPIFRMHmLy/wzIW8zBGzyMUagG
         niQGEC0B5yprbelnMG2NRp2NDJvrysSCi1GvtGbfRjpoiyW7OoRdnugY3mq9RrfNFaJv
         4KMr2Ih9VmYOGe717Q3lV4nhQMta9mtf5xpo29nrI+9N4wgqkAFg4K3WGvGaFOodVWnU
         zRPw==
X-Gm-Message-State: AOAM530xg5eu2goAzvLOuzMrkzORn5EzTuIsnvokdTk6sA6i/JCHw0ew
        phfDSXIpFGL6GlG7lPNsmvHbRcS/c355/Fio
X-Google-Smtp-Source: ABdhPJz+zRzy6oMt/hcgyjuTJOHJC8uKBS+hs+i7v1IcakATwP8qSrkQxpqE5Q/yElmNIo7CdsQlBQ==
X-Received: by 2002:a63:535e:: with SMTP id t30mr4029339pgl.157.1602016640109;
        Tue, 06 Oct 2020 13:37:20 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id m5sm16556pgn.28.2020.10.06.13.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 13:37:19 -0700 (PDT)
Subject: Re: [PATCH v3] block: Consider only dispatched requests for inflight
 statistic
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        kernel@collabora.com, Omar Sandoval <osandov@fb.com>
References: <20201006194125.2493508-1-krisman@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d112d39b-63ed-1ead-b1ed-6680dcd55e74@kernel.dk>
Date:   Tue, 6 Oct 2020 14:37:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006194125.2493508-1-krisman@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/20 1:41 PM, Gabriel Krisman Bertazi wrote:
> According to Documentation/block/stat.rst, inflight should not include
> I/O requests that are in the queue but not yet dispatched to the device,
> but blk-mq identifies as inflight any request that has a tag allocated,
> which, for queues without elevator, happens at request allocation time
> and before it is queued in the ctx (default case in blk_mq_submit_bio).
> 
> In addition, current behavior is different for queues with elevator from
> queues without it, since for the former the driver tag is allocated at
> dispatch time.  A more precise approach would be to only consider
> requests with state MQ_RQ_IN_FLIGHT.
> 
> This effectively reverts commit 6131837b1de6 ("blk-mq: count allocated
> but not started requests in iostats inflight") to consolidate blk-mq
> behavior with itself (elevator case) and with original documentation,
> but it differs from the behavior used by the legacy path.
> 
> This version differs from v1 by using blk_mq_rq_state to access the
> state attribute.  Avoid using blk_mq_request_started, which was
> suggested, since we don't want to include MQ_RQ_COMPLETE.

Applied, thanks.

-- 
Jens Axboe

