Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ADCC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 15:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114BB61151
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 15:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFUP6M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFUP6M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 11:58:12 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3739C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 08:55:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k11so3163620ioa.5
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 08:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xoGOR6bNmxcId/Ee4H0L3QqG5xTZcJdVQzkm9X75obA=;
        b=cLyyjm85xcRaukag+4YfWF05RrRrM5THsTgk3lgojaD9eyyXlB02Y878yEtdIDexBH
         C9PMEfIV9i0GgVpmn6kvkkXhw0pXGt+Altx9T7p620NH3gaf2/+R8ymXrc5WnPbPFEdl
         yQIDceu8yNer6gLKy2Q+WZGWv9IbYztvTy9LPqzy53df3Yiwj+Wilr1OPQScNkq6mHFG
         n/E8xwAKpsjkvV/Q70gd5/TwWf4oppLGjPYzeDeqljmbME4JtiSw0x5nyNgmdUyjrGgm
         1HwWn7I3kcBILp5LbsStc8bjJ7sUildTpo6PbCJA5+6OadcY7PQ4YLv+QIqhTRFYzxy7
         NnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xoGOR6bNmxcId/Ee4H0L3QqG5xTZcJdVQzkm9X75obA=;
        b=pcEr8zpUS9pYFmE35BeXo9ugOo/3N5aipkFUWdRUIO8CNgj288qF2DIx6YBo+z1bsn
         AtVhVw4ItLCKHco4eGOwoLZQWgho2Z1ozCFcwiIUoZHFsiGe7bsd1+RoFaPqMJrJfAdB
         BG8zmdUgjlfwuNPWHucrse6y+0HQCe1ayvqA7v6QLMH+nOR6rRMwWluftBuQBtbGAJbD
         smEo+0vOt2hxudVCA8zcWWtsJVQKYylN+kDDCPvEQkT7ve/HQGPaDlZRrXdkapaRC6YB
         OTkSxKQK4w6/RvgDWs1+F/hPq548rzaOsn5MPO79AIXx5KO9fTT7Qx2XZEps0Zr4cQVn
         cXGg==
X-Gm-Message-State: AOAM5313wr5bt1suvEDrctec3Z0cSHI04OYaGwoemHL+ND/h4e8B6qyX
        n+MFQlZCbaa6qNalxZPioKp3XJbztkMycg==
X-Google-Smtp-Source: ABdhPJyjeB+QKOUeOmsHQDOPSMxVdqE8D40OUJJzhCP0YyuywJf0TJyUhYLoz9IlAS5JaNIltvUcfw==
X-Received: by 2002:a5d:9059:: with SMTP id v25mr20266419ioq.113.1624290957096;
        Mon, 21 Jun 2021 08:55:57 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x9sm10378909iol.2.2021.06.21.08.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 08:55:56 -0700 (PDT)
Subject: Re: [PATCH] block: Include mm_types.h instead of mm.h
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20210621122407.3116975-1-willy@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <490a7c73-74ce-6a17-b16d-629d433d0de1@kernel.dk>
Date:   Mon, 21 Jun 2021 09:55:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210621122407.3116975-1-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 6:24 AM, Matthew Wilcox (Oracle) wrote:
> There's no need to include all of mm.h in bvec.h.  It only needs a few
> things like the definition of struct page, PAGE_SIZE, PAGE_MASK and so
> on, all of which are provided by mm_types.h.

Applied, thanks.

-- 
Jens Axboe

