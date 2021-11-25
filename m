Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28379C433FE
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 14:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbhKYPCW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 10:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352958AbhKYPAV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 10:00:21 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2716BC0613F3
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 06:55:41 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 14so7808235ioe.2
        for <linux-block@vger.kernel.org>; Thu, 25 Nov 2021 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s6i5uE6A5Zlvkv7XdG8O/0f5q21B/jG/q2vmpQr/6x4=;
        b=XjQJQph9gjOiocBWA8oarogiZo1zQaHaFayjIPR25YouaRc7GIGfePuIYBLZGY1hVC
         JKyXldqpoy+RrnM9xaFWSPi5wnZjPmD/pkXxjoKhsW7KBA+Lg1Y+HDliT2qzcd3eSF32
         CoVcV+CTIom0XQSC/+kmtXDQPNGipw9t/NHD0G7mFKmUWlDwAkpQKukApTqhk2OLwWf4
         Cz8OdQCMymvCO+DeiQ/SajmvPqzejSISGrVd54B+gWmNYY2rwM8TpwD67jDpa4GAIqeF
         dRG+kQEob1f96SQDKC68FCTg1//fdyyuUVTPRfxr1xRckuUFTIcS0HsWbV1Xbr7bn1c2
         0LYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s6i5uE6A5Zlvkv7XdG8O/0f5q21B/jG/q2vmpQr/6x4=;
        b=DK4q8ZtnhiiO/7OcmofS2ECpjhvErkJL6w6xoprkzgmEwZaIxfvIJveGzLzJ27Lq9m
         XoY1MrSvWJaVOhzmr+kR7puLDbFsxhyYzipl44sS7gsN9pVO75lsBfrZLhZX4/N8xyVT
         VPElzmkP7NkbyWkgqKgTwDXpCE4dk5CQY/LugPTbfEC9jq+6o/03GjbOMgtUycFaEsXA
         3Jmbiex4aIS5SGiplnqXpR/LLutDdqkQgfmfGbbOT7dJmZ+ZsG8tttPBQndfF+aG6OGM
         Epsi0xlYCl/obwMXcKlLn+GWamOpbHpNXaZegBFL9wTwHv2Avhl1RxAe9JYSWIUKleLb
         s4IQ==
X-Gm-Message-State: AOAM531uGHDnaXPFV+SFy3o+PMX8rC150Vhh3jxBaIJJ9t+IpiODtovC
        /tc0GlLouDa3COUDm5mPzlVw4Q==
X-Google-Smtp-Source: ABdhPJz3B/lUaWW5cnX5/KkRg/D6TToXlvT5+9PMMEJtf+RK+xiJnm8tv2NGAcpxcb1ZL3qkVwjEww==
X-Received: by 2002:a05:6602:14d3:: with SMTP id b19mr26406594iow.17.1637852140455;
        Thu, 25 Nov 2021 06:55:40 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f2sm1889908ilu.2.2021.11.25.06.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Nov 2021 06:55:40 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.16
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YZ+X/qGC6/w3bp2c@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c55bc6b0-b98e-07f5-b808-83814ad8981a@kernel.dk>
Date:   Thu, 25 Nov 2021 07:55:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZ+X/qGC6/w3bp2c@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/25/21 7:04 AM, Christoph Hellwig wrote:
>  drivers/nvme/host/core.c          | 29 +++++++++++++++++--
>  drivers/nvme/host/fabrics.c       |  3 ++
>  drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++--------------------
>  drivers/nvme/target/io-cmd-file.c |  2 ++
>  drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++--------
>  5 files changed, 93 insertions(+), 46 deletions(-)

This doesn't match what I get:

 drivers/nvme/host/core.c          | 29 +++++++++++++++++++---
 drivers/nvme/host/fabrics.c       |  3 +++
 drivers/nvme/host/tcp.c           | 61 +++++++++++++++++++++++-----------------------
 drivers/nvme/target/io-cmd-file.c |  4 ++-
 drivers/nvme/target/tcp.c         | 44 ++++++++++++++++++++++++---------
 5 files changed, 94 insertions(+), 47 deletions(-)

Hmm?

-- 
Jens Axboe

