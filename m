Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15B1C4332F
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 18:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiL2ScT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 13:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiL2ScR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 13:32:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC859E00
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 10:32:15 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fy4so20044387pjb.0
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 10:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOtZo3cRckA5ert9S3WU3eYhNXvQg14EN+002Snt29k=;
        b=mM/aGzUK2kNINF/aB272yG+USJf/zMKQmlzlkFNiBXa88iHjxQu30PR90FTIG+CAuC
         tJ4WOe/MsoraoJeNAa7NZPFFL8ZTEyJzT+6+eGMdQMtl9YndKaffp6hdg4kXfU82JMLX
         5JRQx+xOJMMTCIoHQSuNr4KB0uSQTgEF5muBvh+kTdF+cxYUb0P1BSC44Hw4i0gOFYze
         xZ/e6Q4vBE+fSLa0p45SJQnLBjuMTk+MZ2YQaYs//SWqFrG/rjXHNwW3RtUvuVMYk7Gn
         EZRp799GIVuTBdIUtkzRVWDra81ywcXBLfYz5GeGzZ+mfZRTkliW/Ynr/qohG9wvnfCj
         Te6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOtZo3cRckA5ert9S3WU3eYhNXvQg14EN+002Snt29k=;
        b=eCwdXkmdHKdgqsSmPjAMxrqUyKxiggCG/x/Q3vAWx8cno4Ie/SrAdXjlzORpoOJWEK
         mJQscPE3BFOzg13NFUoT6LuO+x0t7zRut5j6M7atvvh8i/UKqhdn5CHQdf7E1nY7yprY
         eAcOpDHQsFcBaZIt1dIiMmjMKANiqsSxWjY/mt6dh9cbW24j3icleQIhoirEjoEC/tIj
         qDeOewdC2ip/f5F/w7cHZmXdSdMfWVmXAvoGD5bo80XeKvDsxmcGvnxm2yr1cyF43YJ1
         EJ7/dLVSaBTpfe90+lPrmoWjUJgn6p8ltWsASY0UNJyFAgVaP+i69+Rc7RAwTTOkHMon
         WecQ==
X-Gm-Message-State: AFqh2kpfoN7T1jbN2oKkSUCySyHLzhgYbVO+wS4NlKLJvCFwzyLVjyuA
        H9UZIEuEMvl2a6jEEFsI+c2tRt6AN5csHbQm
X-Google-Smtp-Source: AMrXdXsoHhmT0sjvBoNt7ieYjwYjsnxvgOpg1USM8tNdxy1z0QVtj2tCka45C/h0B8NxmV5lKokvLQ==
X-Received: by 2002:a05:6a20:a587:b0:a7:c027:f84a with SMTP id bc7-20020a056a20a58700b000a7c027f84amr9599886pzb.1.1672338735083;
        Thu, 29 Dec 2022 10:32:15 -0800 (PST)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id e21-20020a63ee15000000b00478c48cf73csm11136937pgi.82.2022.12.29.10.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 10:32:14 -0800 (PST)
Message-ID: <e6f210dd-3a67-698c-6f56-b127ca1ea0ec@kernel.dk>
Date:   Thu, 29 Dec 2022 11:32:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y63DQSUSW4aQlVJ+@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y63DQSUSW4aQlVJ+@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/29/22 9:41 AM, Christoph Hellwig wrote:
> The following changes since commit 88d356ca41ba1c3effc2d4208dfbd4392f58cd6d:
> 
>   nvme-pci: update sqsize when adjusting the queue depth (2022-12-26 12:10:51 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2022-12-29
> 
> for you to fetch changes up to 76807fcd73b818eb9f245ef1035aed34ecdd9813:
> 
>   nvme-auth: fix smatch warning complaints (2022-12-28 06:26:35 -1000)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - fix various problems in handling the Command Supported and Effects log
>    (Christoph Hellwig)
>  - don't allow unprivileged passthrough of commands that don't transfer
>    data but modify logical block content (Christoph Hellwig)
>  - add a features and quirks policy document (Christoph Hellwig)
>  - fix some really nasty code that was correct but made smatch complain
>    (Sagi Grimberg)

Pulled, thanks.

-- 
Jens Axboe


