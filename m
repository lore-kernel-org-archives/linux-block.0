Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AE7C433E1
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 13:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3428E61969
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 13:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhC2Njg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhC2NjL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 09:39:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B3DC061574
        for <linux-block@vger.kernel.org>; Mon, 29 Mar 2021 06:39:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so7702094pjq.5
        for <linux-block@vger.kernel.org>; Mon, 29 Mar 2021 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PTI+L6ax+/N+yMG1MXdvXBKRXCBtboFyHdTE1wtJx+k=;
        b=pWIp11nHFW7KdnNAiA9K1BL1Od6BgMAM7GRbTXqtMPyZ7gtqHQXCOkLdSG3wcT5UJE
         aj2G6x+OC5ELOVlMUvospOx5QDhace1cy5WW2FUoRbaZaR4/HCepnU+gIuH1c2TuEhVL
         zFN+UEnXJikrfluMdBrX6+RTs8xYNzSJNUR7fTnFypB8a892d27IAYuTudTMWxB8dteU
         mkABKWFlCP8rzp1OI1TAimg+bL9zTuKU9vcLC31IYPzWTZGvXkmeacqdy1Qh7Qt/MAlL
         Y7GrMMkjCj8hIP9UtDRnsCcyXjdQ9ObiX0sZEq2PlNof1lR62WjpGp1rOGY3PC5EFnXn
         AlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PTI+L6ax+/N+yMG1MXdvXBKRXCBtboFyHdTE1wtJx+k=;
        b=FWegPXfm+o8P4BwX/ssO/OUeqIoqBt0O2+GA+j2V97NHiaGSym+Ejac5WStJ0/wSL4
         Lv5Jap3SqRjpyEdcuKhRMiDuPx/CIxoiTWggZ8TayC/Q0UhxCNvLG75eCNHmvjkDvtd3
         8P/+NADHqxv61bwc75UnEC9MPUde1n2/WwEUBEDLNaO+WoD4M/8+MSIcfqMGRUXoyhd1
         ONFs1D3QKQb+HJ8NRP/bvvveocta9Sc466XWOX/2f8zdrwHvm5z4rTkFUlhuq/Yi6ndf
         PV08YsQtbUYCxWt9dgii7tEnFEh9hPuu2akc1RuQl5Q3AcnUC2sZKjwPF0Uar5xfC+h8
         ppRg==
X-Gm-Message-State: AOAM532ceglCmbWHkJyI0iPp42W8J3K2Rnl0zYT39iFuZIsslaouBdUQ
        PPCqGeKRJOAq0SKXqVnGwmK6vA==
X-Google-Smtp-Source: ABdhPJzuj3M/DsqXiV9zd8IxnhRo608IcZgTiobsDDdPzYZif5V8Z1u24W8jhK9cloHgqxbQJPdjAQ==
X-Received: by 2002:a17:90a:9f43:: with SMTP id q3mr26582711pjv.50.1617025150517;
        Mon, 29 Mar 2021 06:39:10 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 8sm15739525pjj.53.2021.03.29.06.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:39:10 -0700 (PDT)
Subject: Re: [PATCH -next 1/2] mtip32xx: use DEFINE_SPINLOCK() for spinlock
To:     Shixin Liu <liushixin2@huawei.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210329095349.4170870-1-liushixin2@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <11e068c7-0022-8c7e-23d9-c1bd8ee90896@kernel.dk>
Date:   Mon, 29 Mar 2021 07:39:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210329095349.4170870-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/21 3:53 AM, Shixin Liu wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().

Applied both, thanks.

-- 
Jens Axboe

