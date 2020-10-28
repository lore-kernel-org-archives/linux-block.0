Return-Path: <SRS0=cVCO=ED=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D00C388F7
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 23:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73012076B
	for <linux-block@archiver.kernel.org>; Wed, 28 Oct 2020 23:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PmSLCFJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389988AbgJ1XCv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390167AbgJ1XCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 19:02:50 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF1C0613CF
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2020 16:02:48 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cv1so626664qvb.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2020 16:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ghC9HLjoIKe8GXcTlT2zPn1hLazKF7pcN2u7tbbflEo=;
        b=PmSLCFJ0uoph9M7B+g+J3SSe/0c/VtZDWYJgmr6SK0mOriJHOIzoGukTlMyq5cikQT
         5u0q0XeTgrkUosfWs0x3tuTHOxyEkNRe/nRMrzlQvQ/Pr22dBDKkWmMDkalyNa+dpRFV
         jn8g27bSZmk9GbVYsIDPUJzooOtspllZY3rrxevCYzDbdJujIGdNEBL/QPeDrShGXoEd
         mqcr+yUZTDvZLbiwCJveWc8ZcGE6NI1s/eDVD+4rp5rt/XSjU/YyBndRm9psI2qNBpdb
         xHt/QOcrn60p4PbeY0ZgjUyv33+xbUbxSQqnzIfJbUYzLNYUhfOQsvg1HOr0SuPU+EIC
         SJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ghC9HLjoIKe8GXcTlT2zPn1hLazKF7pcN2u7tbbflEo=;
        b=pi6qcBlQfnhAA8y+gjrMFggXu5WQN8nXfkTXb4xDQKhg3WiNZzB3GU2IJMW9S2zGqb
         cHVVv1Pd1Txf59VqNTTmkwIrwE0ijoF9Ce13FbevpqSVIYoiCemKriY7k/GLjW+n/M95
         WddO5mrLG5Kiuo9SAG5ZHyyfqzGF24NCtrYGvSLnLryg5U7zbFwNdlYy2a932+l0J2mj
         XdyntWV3GDTjm4uUmeOt0O5E8kEF8mNFpj1D9ZSQTsi5oK0XKhis8xx88g1MC7OTasQD
         wl9UMe5ILMwno63xostV5YqUG9wsVhZ0dZDcLavH9UE4lphJG6zNX9eNTZ3iRUGFmLWu
         f8wQ==
X-Gm-Message-State: AOAM532LqALKRoGAXGgDjl9pPNGVhgnUKWUfaiEiVCmKsnWk9wJ/nMQJ
        EgfEq9mLzxwyJGc3SUq6rxdIM3KE4xz/wQ==
X-Google-Smtp-Source: ABdhPJwHQkZP9s1t2d7caQ5+ODqg8EEAmhzubK8o5zaY2clc8hxJ46xJPYIk1LePsmSqkkghUcbAOQ==
X-Received: by 2002:a17:902:e993:b029:d6:41d8:9ca3 with SMTP id f19-20020a170902e993b02900d641d89ca3mr7761807plb.57.1603893077876;
        Wed, 28 Oct 2020 06:51:17 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c8::1268? ([2620:10d:c090:400::4:c0d3])
        by smtp.gmail.com with ESMTPSA id r187sm6328664pfc.137.2020.10.28.06.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 06:51:17 -0700 (PDT)
Subject: Re: [PATCH] block: advance iov_iter on bio_add_hw_page failure
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-block@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Damien.LeMoal@wdc.com,
        stable@vger.kernel.org
References: <7e91d39fccbd06efdee40ad119833dbfeafd2fb7.1603868801.git.naohiro.aota@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90183284-3ecc-c276-a77f-f13eff2a39cd@kernel.dk>
Date:   Wed, 28 Oct 2020 07:51:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7e91d39fccbd06efdee40ad119833dbfeafd2fb7.1603868801.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/28/20 1:25 AM, Naohiro Aota wrote:
> When the bio's size reaches max_append_sectors, bio_add_hw_page returns
> 0 then __bio_iov_append_get_pages returns -EINVAL. This is an expected
> result of building a small enough bio not to be split in the IO path.
> However, iov_iter is not advanced in this case, causing the same pages
> are filled for the bio again and again.
> 
> Fix the case by properly advancing the iov_iter for already processed
> pages.

Applied, thanks.

-- 
Jens Axboe

