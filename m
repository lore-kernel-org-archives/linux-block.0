Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29274C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB35F61394
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhDFPW0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhDFPWZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 11:22:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E55C061756
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 08:22:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nh5so5895900pjb.5
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E6z5kWwAl+1QNK1u0OVgaasZnxxYZm0UhtDBQU9NQyM=;
        b=Mv8FIUEgsM18zskQs7tY7B/k0o7lz07YKooRJA46pT3T4Fujs2+EngigMWz1SeXxk2
         408Wr1wqz8H6xFLG9imGxTklpi19vPMezpxq7NkXPUKoqZtcOp236xq6iXS6PZgoWnSY
         u9svYa3oMjpxZyz71mbTc+/G0S+PY7LxLoupiSd3xqQjmTjJNd/QITXAcJMPpdI9cmuN
         0v2+mgf65BG6o1u6vK2WY1mJSCLMXdZxysUQKoCdJcdHM3Q/Zv0GKV1ct2mwjmxokKcW
         NPW3PoCso53PC6Np4rG6b49qINu/V7X4j/Wi0lAHyHKj84Z+mD17W0DnEuxRS/v2fLyy
         mQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E6z5kWwAl+1QNK1u0OVgaasZnxxYZm0UhtDBQU9NQyM=;
        b=kspQKgp7KO7aXvPUg/bYaNpLFoytfbzzeMWw/lB1JytxOuq1gSJj/k0esQrGYCRQOb
         5hDFb0x+q2NsdhoSNgKE8Yq0JS830PizMQA8VOu6jhoLTbRlYfnabSFTcBW9BlfxtYgG
         O/3rgwFmKLdZrl+Y25A3iSQHuWbtVPel1ncPMJ5swWVuSSr/6lC3O8/b/G+iHiSe2VD2
         1EObKOg6Q6MqhmNCI3B6o1atXLYcFPEJ7nl2GdmSaQGhdJWQ8SLe4SPKOUzqX/nuGdEq
         hVNxTdukwykNee9tELenYY92sJByyeAPltptMO1n5u0iYZU0UCL7NFbXarlFOlxlH0NL
         yACA==
X-Gm-Message-State: AOAM532vjTve6E3fDOOxqkgSKedeNuAS+/uVJEngSlPNcFMofn3qql+2
        6OPLm/j1sfoI4CVDAu3LnwSsWA==
X-Google-Smtp-Source: ABdhPJwN5ZKGULvml9xEQa+VKvFePdAogoclt6woGJtjAIRk5kqlNGGROJTag2OMaBAe3myOkBprWA==
X-Received: by 2002:a17:90b:a0c:: with SMTP id gg12mr4750699pjb.184.1617722536134;
        Tue, 06 Apr 2021 08:22:16 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id q22sm17686696pfk.2.2021.04.06.08.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:22:15 -0700 (PDT)
Subject: Re: [PATCH 00/11] Rid W=1 warnings from Block
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        drbd-dev@lists.linbit.com,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20210312105530.2219008-1-lee.jones@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <33a06c9d-58b6-c9bf-a119-6d2a3e37b955@kernel.dk>
Date:   Tue, 6 Apr 2021 09:22:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210312105530.2219008-1-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/21 3:55 AM, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.

Applied 2-11, 1 is already in the my tree.

-- 
Jens Axboe

