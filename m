Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A52BC10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FF42077C
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 18:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j7Wuoud1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfDJSRV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:17:21 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:34091 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbfDJSRU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 14:17:20 -0400
Received: by mail-pf1-f172.google.com with SMTP id b3so1979039pfd.1
        for <linux-block@vger.kernel.org>; Wed, 10 Apr 2019 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BfbaaiXHZN6UJr+RjXOEU+oiazV3hLAf19xreHTSUe8=;
        b=j7Wuoud1m5nSUcRDLWuzK67TYk8bTttA8o1bgZG/Bf7HN0U2IQqTgDgzXCU+3bV1VJ
         93mbvAH7i2AN0fuNU4ivPeU9k2blSToQtTphs8Gxhfgs3XcAjOymSKJVlXsV/R+FFkXp
         JFWDKcdchk6nweaI9slGE70BDctyvRnCkdwe7/CxxVThxmSL5lVYlNYB/8VoxRxMPz30
         MFFTgS4quUp9Z8vUZ0XrHLY+Klc56VDQSm1LspU3Kbgwr4Vn84PDMiHJumSiCXjBMg/n
         zZYzvL71/pCsxKsQ/VaRvB0U+RwM96XLLqOaO55HnJjT0qZ3UQY/YWnb35wfux0sT1Ko
         l9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BfbaaiXHZN6UJr+RjXOEU+oiazV3hLAf19xreHTSUe8=;
        b=JqpSkrXGkz4zs6V2Jvk3KTiKp7O+sJrNkQL9MldZ+7Yjs/ivd+oc0zDgvOGti0zgvq
         XrYYbjTqmoled4N33Jrv1ARIBQGytocOgTSGGc2lUUYb5Kkj/KU56CgeUB/UwlLVsQE+
         3FULykV8wPsj6fYqaU9WQnw2VJCVIEDchyA68ytnK46OH2SmAUVHPBrnUkW9JyLm494v
         h8+Mzr54CL9j5gZB4TnVtZJLQKLzRPCl+QevGlfh7gL5aqJTsNfVvcWvWWORZpRxDdBL
         UWdqcxLKVMvpkYZsq4LRPqb8Yv1AhIPIv5X+G5x3Dfa6yjyWq3vq5iqQ0TFXt6/IQu2F
         2YVQ==
X-Gm-Message-State: APjAAAXo4gcAZu0rqVxhQikwrSMaeiQq3DHo8KZh2mnlefut8XzEr0XO
        ysxEZBSUEGR/E2/etKtE31Iepg==
X-Google-Smtp-Source: APXvYqxJkgZeqQSsr+COLbo4Mx/FUgwtHBqzUV1OBtqOeY71a480mKPTc02RzbByfV2NKZLvl35VjQ==
X-Received: by 2002:a63:4f52:: with SMTP id p18mr41972003pgl.333.1554920239816;
        Wed, 10 Apr 2019 11:17:19 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b26sm69307872pgn.4.2019.04.10.11.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:17:18 -0700 (PDT)
Subject: Re: [GIT PULL] lightnvm: pblk: fix crash in pblk_end_partial_read due
 to multipage bvecs
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20190410175643.11000-1-mb@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <09b7919d-2ae3-eded-0abb-472c7f642c4d@kernel.dk>
Date:   Wed, 10 Apr 2019 12:17:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410175643.11000-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/10/19 11:56 AM, Matias Bjørling wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> The introduction of multipage bio vectors broke pblk's partial read
> logic due to it not being prepared for multipage bio vectors.
> 
> Use bio vector iterators instead of direct bio vector indexing.

Applied, thanks.

-- 
Jens Axboe

