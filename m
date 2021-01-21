Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E070C433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 12:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F2323A1D
	for <linux-block@archiver.kernel.org>; Thu, 21 Jan 2021 12:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbhAUMso (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jan 2021 07:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbhAUMs0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 07:48:26 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA90C061575
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 04:47:46 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g3so1247537plp.2
        for <linux-block@vger.kernel.org>; Thu, 21 Jan 2021 04:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pchBZ7HrMs8fZphopy3YDMD9Pzv91Q8ikc/LwQCGD9A=;
        b=Qo7/tKnFyoY63WscJuG87dCR0YHTLw4CuGfhNpL027Ij1ktidD14qE1r0pPniXYlsK
         2gCnCtdtvfrEx2OCmB2KG48Pu4wjmh2X7jxjUYI1nqYqtjk0/Q0A+xjDA8ynIYzV+5PA
         gEp6wH5Xa6gzI3P7E4KOBBF+8QhSFkgqhk3UgubMDoH2F9tObgSjI4HDNjBCHkRVSb7V
         /FYzj8b5ah+97R5TGGlkxVIhPt+lcBEQppuxkeymQVlNofcjLlQLE4vzZyPaNDLBF5Gi
         q6Hh2KNuOy6alvDcQ6vVJGpg1+SlGXmJIjiKGJXMgRONl0F+EI4Bnmt4WhkTaFvquZp+
         e7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pchBZ7HrMs8fZphopy3YDMD9Pzv91Q8ikc/LwQCGD9A=;
        b=RFuSnSR7ueqiA/tDH4iLKVfUkfBMIeHPs65it6/9/rlikPZspkOmdgBTtmaLrNe6p5
         heciZBst+zuy4Oah7P88zL4z3lkj4fFXlVFEUItMLJ+ljcjAcoYgexNpInxMcuxm/i7P
         btjVK9rEv7TgDH+HWtfbx76nMOjORAxPBaJsahvvhnLc2i6Ts6uBDIpq8+FQQJNOeKO3
         4FrJQ+kLsMUUbizynYlnhtgwKKoQHXO45ksSqmZREjxClJl/a+wKn2sOMAc1L8I6neSX
         HjSEl/jbe37qxHJix8XXHgRUx5qALIiFIvoBYFwmxeMD6JdBIRu8X/XkraFZ1BdONQ8j
         +pdA==
X-Gm-Message-State: AOAM533YuCYBMpXCgQhjmix7+a3W00kf3DDdfCmzQ7gausuWknKo9BhK
        UfGhvKG76K6n91AnmTt37kfSsA==
X-Google-Smtp-Source: ABdhPJzQPMUrZphrYzYVhVNMuufMyE+goiPwMAGTU/u0GeF2CpcRzIxMclsebqO1hVr+1hVPj+HEtw==
X-Received: by 2002:a17:90b:11d4:: with SMTP id gv20mr11776619pjb.116.1611233265990;
        Thu, 21 Jan 2021 04:47:45 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id e17sm5889996pjh.39.2021.01.21.04.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 04:47:45 -0800 (PST)
Subject: Re: [PATCH] lightnvm: fix memory leak when submit fails
To:     Pan Bian <bianpan2016@163.com>, Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210121072202.120810-1-bianpan2016@163.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <55045608-01cb-d5af-682b-5a213944e33d@kernel.dk>
Date:   Thu, 21 Jan 2021 05:47:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121072202.120810-1-bianpan2016@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/21 12:22 AM, Pan Bian wrote:
> The allocated page is not released if error occurs in
> nvm_submit_io_sync_raw(). __free_page() is moved ealier to avoid
> possible memory leak issue.

Applied, thanks.

General question for Matias - is lightnvm maintained anymore at all, or
should we remove it? The project seems dead from my pov, and I don't
even remember anyone even reviewing fixes from other people.

-- 
Jens Axboe

