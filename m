Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CC7C433FE
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 15:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiI2PKq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 11:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbiI2PKp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 11:10:45 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8943C8894
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:10:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so6244304pjh.2
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=w50MylxXfZ4vHg0qzFBvUsz2PdC4z5idp77wnharSgw=;
        b=HDvQ0YaKEum0HowdgHXRtOqLXApElq2HtUWAJ/3MVCXC4neQYXCGqe2K/ziKBpWCjF
         pjACCucLlqWu573u5O11n+0NBhF6ZvgnUy3OKppOVEkJqChMLzl0Y30f0LlWdxH2bXCr
         S5M6OuNNdRooH3feqjQtd/IDK2PsL7c2M9qz673p99Mhrl6FtjE3PbXdgtDsv7zZ7NQg
         dCLWzbiXJInhbF8NrwoCxY4Q6IQOaaEOHlnz3KSUUKWZ2LrCWBt1MMmHtS6xwLcDoISK
         zGeJbZnwb9SDnq1tSRKN1D9torv656jcDMQ7nf6s+B9dQxpTQ0viC5tLc1tu9LdptDfw
         uzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=w50MylxXfZ4vHg0qzFBvUsz2PdC4z5idp77wnharSgw=;
        b=Ub+ucWph7C98aixpQujiFeXMHU449+Fapbp7/Q4N3HQ5x6SRzGWtZEKYyrQE0cvwl1
         yAJF2GGiopwja4wjC8RerXZUzgDgE3j0trX0kw896Yd4PvAjJ3MgAe+zn9VUtLKFOlQx
         KIeAOlmDZjE7fX8IobDp2JMzHvxMtOTTUOl/Nj5NAzHjEOsm1uXzQwpoHSl+zYZ1R5u8
         pDuFFGAZRnEenyXdsaLZySLYXyPs8vwmQf5haOtnnJFZj76JdjMPYavXZc6WYOT+ALyz
         8QK3CL7OH0mfhgyv5LAGwWVXXb8TBOgUOAXStBAgwxorMr6HAttcX4g0rEv5f/Hds+Rl
         TOJQ==
X-Gm-Message-State: ACrzQf2fUYnMhZzeAgrZBEesISAqHMa2r6HLBCaIBl8pa2hoSUw/GRSB
        Tx93bDWs4UzprBrePNnfuUdOSQ==
X-Google-Smtp-Source: AMsMyM6ryP/KZf4Ql4/N5W72UfQpkoC2AwI6/M/ao4IXAK709OOvglJRoFV+mkbDxcPec1Xs6k5I+Q==
X-Received: by 2002:a17:90b:2644:b0:1fa:e0be:4dcb with SMTP id pa4-20020a17090b264400b001fae0be4dcbmr4168983pjb.85.1664464241240;
        Thu, 29 Sep 2022 08:10:41 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902ea0300b001782977fbcdsm6105629plg.206.2022.09.29.08.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:10:40 -0700 (PDT)
Message-ID: <9fa7658b-0bb3-7828-f0d9-3b9f645defa8@kernel.dk>
Date:   Thu, 29 Sep 2022 09:10:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <YzWzhIAX+vtSmo39@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YzWzhIAX+vtSmo39@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/29/22 9:02 AM, Christoph Hellwig wrote:
> The following changes since commit 4c66a326b5ab784cddd72de07ac5b6210e9e1b06:
> 
>   Revert "block: freeze the queue earlier in del_gendisk" (2022-09-20 08:15:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-29

Pulled, thanks.

-- 
Jens Axboe


