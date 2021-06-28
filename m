Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36B1C11F64
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 19:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2CA61CA8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jun 2021 19:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbhF1Tuu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbhF1Tus (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jun 2021 15:50:48 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D7C061574
        for <linux-block@vger.kernel.org>; Mon, 28 Jun 2021 12:48:21 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id o10so13699666ils.6
        for <linux-block@vger.kernel.org>; Mon, 28 Jun 2021 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iEcRS/W+fO06k8s+hGP62/QZyadi5ooc+Yyp7QlNIxc=;
        b=YMXMrjN7NmxqWfmRpv9tLnqCuvcmOfqgFWmd1d5khd/m/IlLKskdv9o77TfaUQ46VJ
         plgpu1t6gtAJBy7B5J6OwJcL3eyL/pz0G5lPT6nhgiA315tiOI3OZNw9MdIUDCa4vmIn
         YdBskcRa8ufGqSeYm+UBC09DlXI7podWMjFmK9+hH4rkS0Qosf3DlAZ4XLkgojMkLfCU
         h4fbd9idbSr94NNlRssxvaGDR7ngCuVrlEhhkOU8YNu6oYP7ppep0Py9546sVg9eTYEM
         XfxHWawFoNfIW2AWm0wJT1ncO7NehgG9rjOrtKTdRFufHIt7+vrJJXCGkGPMX0G9D3rw
         mHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iEcRS/W+fO06k8s+hGP62/QZyadi5ooc+Yyp7QlNIxc=;
        b=lc4koOQe0Gp0UZ5gWaN2qtHJnsrd3GZGd6gThkwGCGHha5r5uzR8vfg1ZYJ8/kireF
         Y/RKw89A6KC1ZqBQvfilhRI8SuYPHH429L6t8B0O03kiUSgVO5XmyUXwyouWyI6RUVAq
         EyeCVcdH2b4IdFHQbiPxg98GtXTRWEx4ISayAP79cCYzrP7aAjt21PTpgyRE3L4lsDn/
         mSb8YGOOI7lYodx8iCBSNk8SrlrlW507K/hMynACrjk1Ly+5It4WmBz8cAKvg+2GLrKr
         wle1kjuTg7yC0VVlUZEvLzTACbHxUrdkydDDKaI5Vhxfws1dZ19J8BPRc7NDGChjty9R
         sd8A==
X-Gm-Message-State: AOAM531LLnk2uAs2FVHI7v8sOfqkU2NdEtp6l+lfrFuJWolLxs197+nO
        YjTsNDucxln9ErWTMB4adiErTfhcHDLBAA==
X-Google-Smtp-Source: ABdhPJwR10QtDiSwgqx/KgRPSifwmJZyWidlDlWWtA7p1Y+JmSLzLYyWUF+D2LRPzrXViTk6X9FvEA==
X-Received: by 2002:a05:6e02:1302:: with SMTP id g2mr10679040ilr.278.1624909701001;
        Mon, 28 Jun 2021 12:48:21 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id l26sm8540303iok.26.2021.06.28.12.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 12:48:20 -0700 (PDT)
Subject: Re: [PATCH] ubd: remove dead code in ubd_setup_common
To:     Christoph Hellwig <hch@lst.de>, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     linux-um@lists.infradead.org, linux-block@vger.kernel.org
References: <20210628093937.1325608-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <59dff238-e9aa-4de3-fa00-08d376f443a6@kernel.dk>
Date:   Mon, 28 Jun 2021 13:48:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210628093937.1325608-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/28/21 3:39 AM, Christoph Hellwig wrote:
> Remove some leftovers of the fake major number parsing that cause
> complains from some compilers.

Applied, thanks.

-- 
Jens Axboe

