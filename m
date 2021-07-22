Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09DAC4338F
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 20:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E8560EB1
	for <linux-block@archiver.kernel.org>; Thu, 22 Jul 2021 20:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhGVTpQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jul 2021 15:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhGVTpP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 15:45:15 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF46C061575
        for <linux-block@vger.kernel.org>; Thu, 22 Jul 2021 13:25:49 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id j1-20020a0568302701b02904d1f8b9db81so6460471otu.12
        for <linux-block@vger.kernel.org>; Thu, 22 Jul 2021 13:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=77vPTsrHg+AlqkSv0c9UpaNnxNWtgOyY/NiB3HvMNiY=;
        b=dTfDMiYbNhs8xTsw3ZFsNcKbQaY5+vXaaFPMar/OAyydu4oVshaP7NmfY/D5w4fK+E
         aO1DJHApAF3UsF0GWNF7JMDveSUGDuuCDZqEZVrLsO5YtTr0aGqbACj0C+KSPZ07dICW
         PW98MPpVgRHr96tj7WgC/Rb4G6WvJQfb9abWa6GvYvX7M2QNpiRlK6loCU0mPRnptAKB
         FTDTm85bQJtF7H+I7f7x+mJM8EXMTVNUsRIzG4X+UMAcpCX5m/mh2W9Vb48WaZi5ZDDJ
         0spLOWz/5vSuwj1PxoQ6ME4ayQ4psVCt3yEaJNTaum7VKGhSL9i55eLhHA47fFuGc3ES
         /taA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=77vPTsrHg+AlqkSv0c9UpaNnxNWtgOyY/NiB3HvMNiY=;
        b=jFCEEofJ7Uqs8hA2198rJsI1M+6I+xYfG/oj9fCQ7V/Zu4Nina/80BVLRupOEZalvy
         wIDN6auVOpk4iDnpbyZzRgeDSzqb5PBkRc7bBi6RAPC5pNs+SzwU5sUsny/i5286w9YO
         BzZW9NleXAuOy6w1AVv+dvnPflrfYpOocJ/Fol5yz9ltq1wTE5hrCmJJFrzT0YYJgbF2
         tRGqYqubYPb8vu4pHMBp8sZjKTLMtqEBPZaTtyMGi+c4fcCIfxJSgxDF5ZcXZ61FErbl
         EFw5cdJlPtDaQJ+1gBHmUWYZHiwaPcCecX8SCcDpjVHyJZFMQk+ox9Odg/2s6jVT0LUm
         zRxw==
X-Gm-Message-State: AOAM532M6RkYBQejrruRmwnZSccPPX3BDwmCe7MiJo2Q8YbPAdkcQTWS
        5EjQjmG/3F/+YDgtcI7x1lrUEA==
X-Google-Smtp-Source: ABdhPJzUPRGbTELnznbn4NmFgCdI5a80mGbRI2mILC+vNpGoMbaEaRDKz0H5Lo9dWeCbNcRwjQi1HQ==
X-Received: by 2002:a05:6830:19f6:: with SMTP id t22mr1032552ott.32.1626985548993;
        Thu, 22 Jul 2021 13:25:48 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b70sm2901338oii.24.2021.07.22.13.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 13:25:48 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.14
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YPm/cHUBGJpVOS4n@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5fdf64cb-13e4-2114-b0d1-8f4cb4ac450a@kernel.dk>
Date:   Thu, 22 Jul 2021 14:25:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YPm/cHUBGJpVOS4n@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/22/21 12:56 PM, Christoph Hellwig wrote:
> The following changes since commit ec645dc96699ea6c37b6de86c84d7288ea9a4ddf:
> 
>   block: increase BLKCG_MAX_POLS (2021-07-17 13:07:24 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.14-2021-07-22

Pulled, thanks.

-- 
Jens Axboe

