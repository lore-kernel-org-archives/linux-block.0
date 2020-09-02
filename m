Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F089C433E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 17:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CF020758
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 17:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QZwigp9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIBRzT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIBRzS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 13:55:18 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB42C061244
        for <linux-block@vger.kernel.org>; Wed,  2 Sep 2020 10:55:18 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d190so6748917iof.3
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lF4pWhsByTOqyLOv5Bpsnjv77SPv18a7OvunkXhgK6g=;
        b=QZwigp9rDr7WwPU/I1qts5FEAk31WkqDNDl8N+DvmtO2nQx96vJeTzuFumkhiOBQkd
         WKdGpg1Q/loZr6Kd20KwOSbKfa09huVjkEz+HjFtFxdkd7vP/XhEY3mAMCT+4hgEaMNU
         fQ05n1cD9A/6dqL5TCY4CIWdCXrKB33hP9ys1eguvw5U4QzsPatrjXO+hRQ+/IKI6wnC
         xbRTWOuga0s9JGaGms7n7S+GRWQKjvWmasMgqRlBSg9iP47FORwWJJKUTdRkvs6hjap7
         jIhKiR2GVHEGY9YvGhgDJ7nNADwhMV1IUdI1oRNMcU1NUTBpL92rqpJIegcI1c91483A
         WzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lF4pWhsByTOqyLOv5Bpsnjv77SPv18a7OvunkXhgK6g=;
        b=gM2igndPNod21eHVADeOEwepRMGcqjm3x6JSsOFnZWhKIuE8dV/4YjFcGnuA3/bHru
         DoaXIXfr+ybe57j3Ul1QpvWmkXmiV/zGEGzpuA+/cLmqvaXYG0HQpj6J8vlilxAxchDv
         Zgn83zqqgtvdzIRw0pyEbpCw7N/WXROAbWzvSIxec4wl3zDlayoiJE5/6efx4cr5IVzB
         BkZW5GOkEcAw/nZgijP0hEq2lctlxB6Yq2DlNelTa0zfU8Xf/e3bBxur4jwCh+FNWeyS
         biWvPxtUxn34ZWQRiFwtPdmmBgx3IkdxzvwtnREG57sGVMX54vaWK2Nc/Sl7x1aZXhaK
         sz4w==
X-Gm-Message-State: AOAM531FjMtheiDGNx+b/ChSsIxGlxdhZjHc3Y8O1fEizfvXWYfw5IvM
        wOF4d7z60gDVd5JKQZYVZ/KPdg==
X-Google-Smtp-Source: ABdhPJypzj6dCXiSRVbMCqcI0gl9vjF/pJGbjYaoT1JJlIicw1aUuWkEtaw2iUzf3mJ52pOGevMZTA==
X-Received: by 2002:a05:6638:69d:: with SMTP id i29mr4340471jab.138.1599069317884;
        Wed, 02 Sep 2020 10:55:17 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p124sm126225iof.19.2020.09.02.10.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 10:55:17 -0700 (PDT)
Subject: Re: [PATCH V2] block: allow for_each_bvec to support zero len bvec
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        syzbot <syzbot+61acc40a49a3e46e25ea@syzkaller.appspotmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20200817100055.2495905-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fd90b22f-dd5f-15ef-2a9b-648a3260cea7@kernel.dk>
Date:   Wed, 2 Sep 2020 11:55:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817100055.2495905-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/17/20 4:00 AM, Ming Lei wrote:
> Block layer usually doesn't support or allow zero-length bvec. Since
> commit 1bdc76aea115 ("iov_iter: use bvec iterator to implement
> iterate_bvec()"), iterate_bvec() switches to bvec iterator. However,
> Al mentioned that 'Zero-length segments are not disallowed' in iov_iter.
> 
> Fixes for_each_bvec() so that it can move on after seeing one zero
> length bvec.

Applied, thanks.

-- 
Jens Axboe

