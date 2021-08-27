Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1047C4320E
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 13:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B194960EB3
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 13:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245241AbhH0NrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbhH0NrB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 09:47:01 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE01C061757
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 06:46:10 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id g9so8517557ioq.11
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CgDUFMx8KRC46Y+yW22ovuANOUZSg/OO9Nc7Cyb9ZmY=;
        b=eb1nLtaWMThHE27TT/5nHTpK+bwqT5xh+36QUm/0/51Te8oJLTYjvb5OOeO2HAA9Fe
         XuthDkEku/mFSH5ji5bjyi2d/9++8W4hLv1zMXQaHBnrDFM9Ofnq54F+lvS356RAslVS
         Kw9eeWkzjdjG9t03zMJoSsS1sIOgls/H9TxXqYIZ4VNlrm9f2FRwoCU59x7EjWJg8Rqc
         gRZV+m9hLpU2T0pJy3+YoDgYVhIQ8f+gDkQD/aT+eSE/+HhiMmRqZP63Qhe6eCGmQMrk
         W2qNboIspApT4gywGHTjE+5ZlYahCf+7z6h6I0Xh2UeEMtMiha29unPKCSrX5oa4Sh1Q
         SzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgDUFMx8KRC46Y+yW22ovuANOUZSg/OO9Nc7Cyb9ZmY=;
        b=SxWHrcfImUzUcb8MnarXPqFsvNOZPZeD3RifDqRRvS0wVWPh6mMkuCj7bTAaHn7rbV
         qEMVqmUa+BNn4e5C66rdYjntn4nSiL/CSoqFeFY0yOScSqYSJBBoY1KPWLrgM3DkgB1J
         h22DpDxHQaOpcwwpy29uytiNMjr6fmec7y9yKVaFoFPZYvc/cRVd9ZXpm8ZdfRICNGnz
         f2HLCH2EhjNE9BTlVCQxJsXVy7BrLlUNgPupRttFtB7gSn2A1S0793G44fzXI/yIWJFm
         ycaIc7091qDuc8L92zGfDMVnIeFhZ8/XT5OlpbcLkfQyNouHLGUpKdu02sbiBicmzOJA
         +VRw==
X-Gm-Message-State: AOAM532VRElgdmwhDy+jk0rpPMO08nBbyx5ZXxd3deQG3SvKneSb+NUt
        ddZ/M6k8DF+FQXSpTkF1wTgcCQ==
X-Google-Smtp-Source: ABdhPJzKq2r8SQgfJKLLUmuVYSj8bTkd2thouYtjgPVw4Cye85HZP0A9rCF2m/3dtTW8TMWTDlMIfQ==
X-Received: by 2002:a02:90d0:: with SMTP id c16mr8145775jag.106.1630071969985;
        Fri, 27 Aug 2021 06:46:09 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a1sm3762051ila.40.2021.08.27.06.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 06:46:09 -0700 (PDT)
Subject: Re: [PATCH] pd: fix a NULL vs IS_ERR() check
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Tim Waugh <tim@cyberelk.net>, Christoph Hellwig <hch@lst.de>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20210827100023.GB9449@kili>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3d1ade3a-49aa-e779-6e38-debc50f4801f@kernel.dk>
Date:   Fri, 27 Aug 2021 07:46:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210827100023.GB9449@kili>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/21 4:00 AM, Dan Carpenter wrote:
> blk_mq_alloc_disk() returns error pointers, it doesn't return NULL
> so correct the check.

Applied, thanks.

-- 
Jens Axboe

