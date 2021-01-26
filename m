Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233E5C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74C420665
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbhAZWAe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405501AbhAZUPW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 15:15:22 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D095CC0613ED
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:14:41 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o16so2560907pgg.5
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vUWa/nqQ/A/FFzCKwNGOfLjGalA5xZDYWlP7k0RNMN4=;
        b=aNgxpXHyhquyX9+OT/S2Ivy6rHQvxdf0vWV+hC/39bhX3aBUpNlzTSFfQdDEp6im8a
         KZhIP25K3RXUXHMBHDU2+dIAvUM4Qov7IunrwNKrDe4/iii/ofIR3PHoAf6vIv+u0Sox
         8o1VIvGjcaRhwqOwJS+/5qnakNwYzfdsA9Pl+1uyHDYTU7MxgqkduHTzan9z9YVbuGcA
         WIdrk2f+1p2PLr+n/q/GH6AueR4Rccs1Cwo9IbOcka+0wNK7zwOUj2WmQibuXoQvitJB
         2pStJzimWuAv3RFiPHpupixIKybApinZr033DoaPjOEF3xMis+zpZdSLS1YPg40rrkmU
         FGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vUWa/nqQ/A/FFzCKwNGOfLjGalA5xZDYWlP7k0RNMN4=;
        b=qfbSMtKcNch9wuB0YkWaqBndaAAIDvye817iECwxGlZRR7t7T35D/q6kfnYnGxtY4W
         u6Dex9T2lKLYAFJ1dL9K8JKvbLlRFP4+E+hBn0SxN6lZDoSLDIOyon5VZ7FMJosrEzlo
         0IIuJcix8YIgC2KwPD2HuMqQGg4eZoQKTRloini8lB1G2/OyP+kNF99DLsASLyMLM+sW
         KPu0Q+u9XVLbHtRVM2PqV7/sCkmd+N3F8cF+tTr8av2kXS1asSSFuNkxSFlnIwr7x4xC
         thuEFr+HjvPqQIqG2ORQgHo5twiscJ+8j6UAm2GaFq3WJatwVUECkr6SUI7Yg94rfGI+
         8BCw==
X-Gm-Message-State: AOAM533ocddcypK9KABozSWQI+9vGsaD8OpcLrETOGRh/+te1Se/AdU8
        eHu3kvmOtHh+aQtYvvoW9epdMIFyu+4hxg==
X-Google-Smtp-Source: ABdhPJzpMN5r9lAMFHvuk1vF95rtBTPz9BzU0foNJAQXszB/nNFtuhg2wLn+q3qj7UpO6E9wwS3P6A==
X-Received: by 2002:a63:656:: with SMTP id 83mr7314185pgg.222.1611692081226;
        Tue, 26 Jan 2021 12:14:41 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id i36sm14433901pgi.81.2021.01.26.12.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:14:40 -0800 (PST)
Subject: Re: [PATCH RESEND] blkcg: delete redundant get/put operations for
 queue
To:     Chunguang Xu <brookxu.cn@gmail.com>, tj@kernel.org
Cc:     linux-block@vger.kernel.org
References: <1611551128-1238-1-git-send-email-brookxu@tencent.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fc9cc1dd-9b2f-d5e2-1575-796239742b08@kernel.dk>
Date:   Tue, 26 Jan 2021 13:14:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1611551128-1238-1-git-send-email-brookxu@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/21 10:05 PM, Chunguang Xu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> When calling blkcg_schedule_throttle(), for the same queue,
> redundant get/put operations can be removed.

Applied, thanks.

-- 
Jens Axboe

