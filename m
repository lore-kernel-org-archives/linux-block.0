Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B7DC74A5B
	for <linux-block@archiver.kernel.org>; Thu, 16 Mar 2023 13:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCPNCX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCPNCW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2023 09:02:22 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DF8A3B64
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 06:02:20 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id l14so1057954pfc.11
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 06:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678971739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxyb17UdI6xsq79AP29b7rtQj9x0o3CwTtWs8Uu7Zqw=;
        b=bwPoUbGImBC+LtmWBPXAWRz5EqDgzPdDG+p76bRvSoZcwV3q4ohCoPJToGYMPZv4sl
         lvYz22B13g7dTHrkIQf9jAfSfehqkPeRuwh5FHmIrgU7XRaLMfGxoCOau1eBbeEpOUph
         OvUnwoFEw1NrGZbFwMYX3XcmdvWDbjF3pG/8RaOAWyxLdMJget+zWDAoNO2CrKqu4pmy
         4GtXOmOjdWIBSz96NJnuUDxCxF7/jF1aD5ScS5x3FwBVHVxPW39NOYLpYA5gcFyF4oSH
         99lpLftfDDPy+v8mZ5n3s14pphyOTKIULf9ss+yzGxwiCH+Ls5vdf6QhcbGLMf31FL5O
         SqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678971739;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxyb17UdI6xsq79AP29b7rtQj9x0o3CwTtWs8Uu7Zqw=;
        b=hbpyl0gKkTfKd3ifPr5QzsoYlat21yDDgQ487Bw5tav1aYGuHwkMTJA10d2KBLQpdc
         ZwPDkmvHiBxmyk4YxFk4JKtoBN15Z8RqdMIiHpQvhLdEiJdqPEZUalQUoxBRERcdyF9g
         uicWSNeMaIUjwiXr3ijkjfplBrWLE+RURwUIdh+6xL9+/8kUDWq1T1pxt4zvvXSEP74H
         SyFvOnf1T1Pxfj+orcsoY6zWKcnTule54OV312SUJWK0CBpX/gjHMDXRl262fDKpyr/f
         T66vB8bkJjo6urgge8OWFaiaFcEOm425OswEaPHtwxhRiOuXtasyNqHI420/Vt8Bm6B7
         DyKw==
X-Gm-Message-State: AO0yUKVSAQ85boNrHp4QsDJ4ktBKsOo0/hMz3GFgryrOWJB4RCjTEBLU
        8pnKbUof+nAMKAPaYi5vlpsd3v3lPC7cB5Ws0Fsf1g==
X-Google-Smtp-Source: AK7set+NMNwz9a+w8f6tmXPmK22sIr9yMwz7zwUIdvgLv+67s/GQCptUlD6XApVb3j5/UQjjlJ4xhA==
X-Received: by 2002:a05:6a00:32c7:b0:5db:aa2d:9ea0 with SMTP id cl7-20020a056a0032c700b005dbaa2d9ea0mr3667693pfb.2.1678971739345;
        Thu, 16 Mar 2023 06:02:19 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c8-20020aa78e08000000b005a9bf65b591sm5433589pfr.135.2023.03.16.06.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 06:02:18 -0700 (PDT)
Message-ID: <75ddafed-cc97-1414-2d61-9fa5fb7266f1@kernel.dk>
Date:   Thu, 16 Mar 2023 07:02:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.3
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <ZBLMMaLFyRsgOvGp@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZBLMMaLFyRsgOvGp@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/23 1:58 AM, Christoph Hellwig wrote:
> The following changes since commit b6402014cab0481bdfd1ffff3e1dad714e8e1205:
> 
>   block: null_blk: cleanup null_queue_rq() (2023-03-15 06:50:24 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2022-03-16
> 
> for you to fetch changes up to 6173a77b7e9d3e202bdb9897b23f2a8afe7bf286:
> 
>   nvmet: avoid potential UAF in nvmet_req_complete() (2023-03-15 14:58:53 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - avoid potential UAF in nvmet_req_complete (Damien Le Moal)
>  - more quirks (Elmer Miroslav Mosher Golovin, Philipp Geulen)
>  - fix a memory leak in the nvme-pci probe teardown path (Irvin Cote)
>  - repair the MAINTAINERS entry (Lukas Bulwahn)
>  - fix handling single range discard request (Ming Lei)
>  - show more opcode names in trace events (Minwoo Im)
>  - fix nvme-tcp timeout reporting (Sagi Grimberg)

Pulled, thanks.

-- 
Jens Axboe


