Return-Path: <SRS0=yU/V=BP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC889C433DF
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 19:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BE422B42
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 19:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BZyj8tQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgHETOm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgHETMl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Aug 2020 15:12:41 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ADAC061290
        for <linux-block@vger.kernel.org>; Wed,  5 Aug 2020 12:10:56 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so1224885pjb.2
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2020 12:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/BPxTQP7JYvXtVQk0ki81teqlb2JaRXEp1ARBXZnsKo=;
        b=BZyj8tQZ0jh5Oos+bACAQdHzM8BctEVB1nm/RUpKxUQ6Pi6G9SvTFeD7fBZ/X6lfVI
         FkEJ/WjkqHZlKv6fs1JF+djzVBcU9No5gkz3vxU0yeAYZg6d4i9kwLBmPh3V4BN9RclB
         zTSxsjl5UmQZ3wGmv+ar3sNRei7z2zx0aTBPLAJrM8lq2oHQ27xaltidycvB+G9bYUaR
         iPPkoe5114KZNWhvTOaH3rhFgeMCltmUtlYFwAd/c5ctZi1gdsQ0E0v/X7k+i7g+xyTm
         JUxqfiNWjVM174YYeHWS7YFZ5kytejVTaFOyGZHdu4NYhmfkoZnYnf3xaO34Fv5Opblj
         Nqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/BPxTQP7JYvXtVQk0ki81teqlb2JaRXEp1ARBXZnsKo=;
        b=JNm2u5ET1xamdcyer6PWv7KtBp7UMktUvzEzvuUGe4RSTyYUMRweYjTF0PZzlGFD0s
         zQ/NdflUTuQbxApmm9zNWgs2w3d+hfRMp4YZxKWl7KU5AkV9B6A6OvV8mG0hfHFNOgnT
         0TiQX740H9es+B1OeER6yldAPVNdH8r3eGkLDhmRw7mN9mpqc2k66XgJR7mag0X3mIw4
         i6JHnAtHR2LOhOxGjD+9a4rTIzxysNHAewKcSSHI/qNdY61hh2ln5ZbwnJdH9QZoG/zU
         /O6sC1acnG18Qd2Hy35IW2gnd/hVI1VC7D49m7cd+WtZFNX59L0qALwVZaK+uce8zycW
         UXiQ==
X-Gm-Message-State: AOAM532GVxfcco45kuJ+kIc+Bm8Id/VJ6jph6/lCiWEuZhj7lNjUnz/C
        y2EX+hmmJ4Ak9qA+A4MiJ1ClGQ==
X-Google-Smtp-Source: ABdhPJxBxqd+46Ue4ysKapAHTBKv3UWlsAyzGfbE/liq0Ut6moG79tcjnHZxH6I+Zn1xfkVM57hEQA==
X-Received: by 2002:a17:90a:77ca:: with SMTP id e10mr4434931pjs.150.1596654655824;
        Wed, 05 Aug 2020 12:10:55 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s125sm5061242pfc.63.2020.08.05.12.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 12:10:55 -0700 (PDT)
Subject: Re: [PATCH] io_uring: Fix use-after-free in io_sq_wq_submit_work()
To:     Guoyu Huang <hgy5945@gmail.com>, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200805034042.GA29805@ubuntu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4e1b9ee-1b13-9862-8df8-cdad62821715@kernel.dk>
Date:   Wed, 5 Aug 2020 13:10:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805034042.GA29805@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/20 9:40 PM, Guoyu Huang wrote:
> when ctx->sqo_mm is zero, io_sq_wq_submit_work() frees 'req'
> without deleting it from 'task_list'. After that, 'req' is
> accessed in io_ring_ctx_wait_and_kill() which lead to
> a use-after-free.

This looks like an old one, that affects 5.4 only. I've massaged
it to apply on top of another fix, will ask to get it queued up for
stable. Thanks!

-- 
Jens Axboe

