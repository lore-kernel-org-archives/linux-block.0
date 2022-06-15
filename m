Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8148C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 15:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243007AbiFOPjl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 11:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbiFOPjk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 11:39:40 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A424313DC6
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 08:39:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m14so336026plg.5
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=edqEgyj1aQJgqVQU6EdhYMAIpwztdCTolhlaMIVQJAA=;
        b=LMx819ruwdoW6TQqOHWhQQa7z0SFBi8W4FuE4hmY3Rsjh+8lKKoVZu7tk8/vNgKQJ4
         uWBzb9hBnhV4GZqLzzFSZX9m83AuBKCJTxGN3il6rHAq3AdT3UF0x08LeVwbm+iyr/gh
         2SM0jGjkUIc6nmnPKdsyURIyZBivqH2fbPBTJDJ2Q+/tPDmoF9afeDYnaLPcBdGw6YX1
         YiUM16bLP8Uz0vgxo92xUk0z4SvhL4V3I/doXN6WShM06cuoY1eeT/hGFtxp2uiCVtNQ
         NTCM2TMnTah6DszqGELMYls/55vaIx93z6s3IFf8i5NpS9KL3bVGTJgojkkaOxSsOAEi
         +FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=edqEgyj1aQJgqVQU6EdhYMAIpwztdCTolhlaMIVQJAA=;
        b=zZ0jq5dgZqz5FFrMs0Hl2Me9Jo/60uabj+TPbbDf1aFZZCgEpNPwmppIjKxJBSna3K
         sqzk/IoLSXx1iMOARxO4zNR5X4lksmW3Oc+g6KvB06KL71MOaauVnUn9SXSMst9XWz9M
         ipgiuReMKo2biiklBCKcUSsEMWIJW+IiiDFYnTZzU0pF0ZAMVFZNr7UwFGoxR1t/lC4/
         t9k/oYEOtoYOno3LRtG+njq4oTgV/PGx5eOO668txMdsRmZeindZ18zwpXwtfx6mt7Oj
         yOd6Jm2bNZQPUG3rYimCZ8rgi0m5NAiVYZjCk0WEZ3eDQ+1xu/LYOkeY2MrXbZzsaCro
         Jc9A==
X-Gm-Message-State: AJIora8ubS5o127calgReWvW6wFmlbD0eeSU7AtI6vH/bR2sWqNPRNj2
        uKQE/cssbZRkxmb3PkQifHTd6A==
X-Google-Smtp-Source: AGRyM1sF8ewweLMdOZ4+abu2W9yM5IN/bhLQXvRlCf8Us7XqgX83BB8sTa1LHpN/EUDyKE09tiM3HA==
X-Received: by 2002:a17:90a:be16:b0:1ea:e19f:b3a2 with SMTP id a22-20020a17090abe1600b001eae19fb3a2mr903760pjs.191.1655307579040;
        Wed, 15 Jun 2022 08:39:39 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x13-20020a63b20d000000b003faebbb772esm10346530pge.25.2022.06.15.08.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 08:39:38 -0700 (PDT)
Message-ID: <98db9274-67ef-1e8d-33d3-e9020337cb02@kernel.dk>
Date:   Wed, 15 Jun 2022 09:39:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YqngkWynuVHY+aDS@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YqngkWynuVHY+aDS@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/22 7:37 AM, Christoph Hellwig wrote:
> The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:
> 
>   Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-15

Pulled, thanks.

-- 
Jens Axboe

