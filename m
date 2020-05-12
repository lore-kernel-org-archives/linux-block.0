Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE3FC54E8E
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 15:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A014206D6
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 15:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uHCRc/sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbgELPXS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730548AbgELPXS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 11:23:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559BEC061A0C
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 08:23:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t7so5522607plr.0
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fFn786ckclf11ZqTIBAoInIjwBQqbd8MwV+cKheEzRE=;
        b=uHCRc/sy6vAOmm/Cb+pG5sR3VtlZ262mP0Q+ByXLW+Aj7lFi5PZ7+VoJxOxhQBYjPX
         pVMmWbwvzGrg2Jfevnj0fPpTdTJb1KGY1snedEARScfJUtgUTUZhb6Ta5O1IKq/ywZCW
         NdZGbv8AlOJMB8WH55zajqudiqUnqyZdQBQAkAifKoovLldg/9Vk7T8u7oZ+H15AGWPW
         SfqPlVopLrQNvC2rvUoUHLJCo11jT8Ip1gzfQqoLjb4LF9xatAAgxnB9Zc9iDN2u7ewR
         vkQo/oqLpoQUX/ENFaMUMt4Sna9n2JP6+z3kXsvYIQ03FPpss9VMdLYsmOCmXGlicejh
         CPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fFn786ckclf11ZqTIBAoInIjwBQqbd8MwV+cKheEzRE=;
        b=DOyd1kXE2u0o1w6/BoyyE5A8jrCDaAez5d53vzQUvupJjFReafN+Mldw+NTNTDjQdo
         nYU/PeSVB17rXrw8GOS8a/A3TSIJtSZj8VMcMfyF0Ck7forhoHS2hEuUEbFAUzTG6gct
         t7EsRR+TvRX+4IHnnHvv+HJPwkHzKOfVMb6BvicTIwvayzyNKh2pFu1FQ1XpqjsRLw1J
         4TcnG9z6yYT9nlQCOEyoVcAv8h6wI2ZHGu6zeMem2oydIbQwu9OtRqUqvBLFuzXOPq4Z
         1eVXmHFz7FHEP2D7bwZbQajqEjH2SwBOJfYGt1aGLZp3WKmsDNWTxsI8d6oI8abJT0GX
         g2wg==
X-Gm-Message-State: AGi0PuZsqLGaHcm+WAqO/U9VjuPzk87R5lL7swTMqt5tQZmksdq7ba7W
        xoku4VQgX1rLw18pNWqq/d1a4g==
X-Google-Smtp-Source: APiQypLMxpN/ejpzECijxeMhwFMuwwftp7qOtM75MBg/d5B5Yj2vOUXRR8q3mkq7RcXCxsYZNrXMPg==
X-Received: by 2002:a17:90b:438b:: with SMTP id in11mr29225287pjb.139.1589296996810;
        Tue, 12 May 2020 08:23:16 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:25cc:e52:aad5:83c2? ([2605:e000:100e:8c61:25cc:e52:aad5:83c2])
        by smtp.gmail.com with ESMTPSA id mu17sm2498860pjb.53.2020.05.12.08.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 08:23:16 -0700 (PDT)
Subject: Re: [GIT PULL] Floppy cleanups for next
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8d8cb63b-e1ff-ddef-a6e9-8f7adb21be60@linux.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <51b29c15-39ea-b39e-55d8-ffb578661c44@kernel.dk>
Date:   Tue, 12 May 2020 09:23:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8d8cb63b-e1ff-ddef-a6e9-8f7adb21be60@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/20 8:28 AM, Denis Efremov wrote:
> Hi Jens,
> 
> The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:
> 
>   Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com/evdenis/linux-floppy tags/floppy-for-5.8

Denis, can you rebase on my for-5.8/drivers branch? If I pull this,
I'm going to get a lot of unrelated changes as well. Alternatively,
I can pull and spit out the patches, and apply those. Either way
works for me.

-- 
Jens Axboe

