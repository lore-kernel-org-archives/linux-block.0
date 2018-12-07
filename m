Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E020C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 15:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC8D20837
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 15:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wrir2pm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC8D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLGPkr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:40:47 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:33816 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeLGPkr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 10:40:47 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so1826471itd.1
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 07:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6QRLa4BzNeHYpchBXjo/8IN4dvNoFzgp7+zOjCLzuEw=;
        b=wrir2pm4c2TyUDhGxOm/ZaDBrp0VPkYMycDX8eFp0RhlvudPgLsCZ2yUukXDjEDg9g
         rGbDOh03i7zTweq+u0pkdtxOQ/oqrTn1tEQbbp9SeYNAx3SSSYFMbV96a21ia3PnXuJf
         7RsynZFoHpzvuxzxxUETq1AV9FFKCyw/OEcbwPeEAeXGjZWRarQ4MlVeKIG1G+pUwhMP
         8UoKsnWGLpNc+/8Ky6r5+rOcgN8X15F7aaI8C5Nu8AcGiRbJV/nnpW6kQmq7vbYjC6lN
         SZhj01jU2AdeTJnb78QLlJrOUrnYsaYqvmEE82RDV/TrKiOt7kjZIZLRf6hItpnygRgG
         dSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6QRLa4BzNeHYpchBXjo/8IN4dvNoFzgp7+zOjCLzuEw=;
        b=LcJjGK133OMdMSVjIYS1L48YX2B9NtmNfhvyUaIxUFXnpZb9+bbvJTIi9SVwVForBF
         mUsABZHqXv+q5w1Ef8LxQ1XEeUv7/qL0f0UbG2sVEllkjekcQT0l8PdRD+nEOaazZ/Vb
         7hFUMC6UShdn1X6dQrDSMr2Yux1NCoNqirmZQn1KLiuopXDRtw30oA7TbHZo08Ci8NM6
         LqWetbefrJkC0NKD6nuqaXIonLr7tmJfmry+coF1CwZckGxX7D+zljSopG1M6LOAUkdI
         VfyL0scAHLVi3lgBBqXhofpJHD+lTC66fkqFWTnkn45/EWtQNFRX3/6/iVxk4Sj5Wvbg
         WXzA==
X-Gm-Message-State: AA+aEWY6lCdPkMHHGHFwOzahtICTY1fOtxcIE38kNo96/D84Kcj/imT6
        icnTEcKpgdzbDgrWfQUBuBwc3g==
X-Google-Smtp-Source: AFSGD/W5vXG5ZRR+f+NDmRhWnrGpcSa+SYBqZMLrg+HxHl6fWd2CNeAAwpyfwn/vVWx/wbd4SUfy5Q==
X-Received: by 2002:a24:fd09:: with SMTP id m9mr2490326ith.81.1544197246342;
        Fri, 07 Dec 2018 07:40:46 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id b5sm1461616ioc.21.2018.12.07.07.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 07:40:45 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 4.20
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20181207153821.GA14210@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <57947e13-0949-dff9-0a16-17ca3bb59843@kernel.dk>
Date:   Fri, 7 Dec 2018 08:40:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207153821.GA14210@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/18 8:38 AM, Christoph Hellwig wrote:
> The following changes since commit ba7aeae5539c7a7cccc4cf07a2bc61281a93c50e:
> 
>   block, bfq: fix decrement of num_active_groups (2018-12-07 07:40:07 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-4.20
> 
> for you to fetch changes up to d7dcdf9d4e15189ecfda24cc87339a3425448d5c:
> 
>   nvmet-rdma: fix response use after free (2018-12-07 07:11:11 -0800)
> 
> ----------------------------------------------------------------
> Israel Rukshin (1):
>       nvmet-rdma: fix response use after free
> 
> James Smart (1):
>       nvme: validate controller state before rescheduling keep alive
> 
>  drivers/nvme/host/core.c   | 10 +++++++++-
>  drivers/nvme/target/rdma.c |  3 ++-
>  2 files changed, 11 insertions(+), 2 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

