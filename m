Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE0AC74A5B
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 19:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjCWTCr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCWTCq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 15:02:46 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD5B32CE4
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 12:02:45 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id e13so2371827ioc.0
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679598164; x=1682190164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lr5SCRaLnnassC/wG2V2g1s24IM6Sp4Gt06w6T5TsjE=;
        b=O7wNq4xvbwJ8xOsZWh5it31XAuwYnvxpQCeGCCuyuXAckJmiPAV6oAazyjH5psvAGb
         zjpTncNoe69qWf3maFYANYtoOczFPHeCIDGBlNZ5SRJUlAd3PgibBmF9C0LAgjF9VLOD
         mdRXShuYDR5UAbwbGhsx3H8g3A1ErtUsPrgJrhz9Nk1ZwqOdUqUOmAwKRmffilUChEoJ
         PMdjnBesNEQnRYDmQhwrz2IgmZRhanWw9t5xfTIbktIrWfoxF9mDOKMJ605Mu1YnzuJ/
         62cTWeNH2dDYyijixaXb+NKrA9vPAkeibRUkO1TbJ9EdRa7XTzuVoljfH+C3DTi2c2qG
         fYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679598164; x=1682190164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr5SCRaLnnassC/wG2V2g1s24IM6Sp4Gt06w6T5TsjE=;
        b=38jfMlZZUlEWwv8wRumEZzRTC4NxOogC8Tjz3eRRw7hbZ3hW6EKkn9snrTVqh46rxd
         z1I4cTffOuCFjRAXTM14cPJ4N5Y/iD9zQVsfLVcLez6iQSmn+hrOLfqr5MxOqncipaty
         Q9Umne7AWrc5QVKfNCGQSIKpMKNOWrGUNREv3rNXXWGqi6HixIe7kPnqeFCdvMvOytaJ
         Sj5hFffFuDeE+SNVzRbixAdL19D5+OuN9mFGSv64l/JbC+F5T/A+Ek/TW8Uy5yp8LprA
         6twBNBkq7VQPOxyef62pHzhyioyzXFVzkkoKZCdgVcbksSMyot478YuFxloVwZjqvJB5
         RBYA==
X-Gm-Message-State: AO0yUKV6wvIKqeZsu40UUu1ypqs1Dlwwx33IaOXKsnHS5N+kXZ4XH9j7
        moWEFCMb/28rjyridGYqfljT1A==
X-Google-Smtp-Source: AK7set/lQt6FMHnB63T9//h60ZloE9026C9/GVrTJ/eidrJe5Nam+szzcKe1u6/WmobRkaZOP4pQYA==
X-Received: by 2002:a6b:b257:0:b0:758:8b42:ce5a with SMTP id b84-20020a6bb257000000b007588b42ce5amr142316iof.1.1679598164093;
        Thu, 23 Mar 2023 12:02:44 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i18-20020a026012000000b00406496ef3dcsm5797377jac.49.2023.03.23.12.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 12:02:43 -0700 (PDT)
Message-ID: <bb3aa601-f8e1-c883-7b36-bde0650ce355@kernel.dk>
Date:   Thu, 23 Mar 2023 13:02:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.3
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <ZBvQbMungfXYQaL8@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZBvQbMungfXYQaL8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/23 10:07 PM, Christoph Hellwig wrote:
> The following changes since commit 9d2789ac9d60c049d26ef6d3005d9c94c5a559e9:
> 
>   block/io_uring: pass in issue_flags for uring_cmd task_work handling (2023-03-20 20:01:25 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2023-03-23
> 
> for you to fetch changes up to aa01c67de5926fdb276793180564f172c55fb0d7:
> 
>   nvme-tcp: fix nvme_tcp_term_pdu to match spec (2023-03-22 09:19:56 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - send Identify with CNS 06h only to I/O controllers (Martin George)
>  - fix nvme_tcp_term_pdu to match spec (Caleb Sander)

Pulled, thanks.

-- 
Jens Axboe


