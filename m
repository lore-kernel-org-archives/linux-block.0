Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C2CC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3AD2083B
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 18:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SbEI71Mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfBDS2O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:28:14 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:32850 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDS2O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 13:28:14 -0500
Received: by mail-it1-f194.google.com with SMTP id m8so12220524itk.0
        for <linux-block@vger.kernel.org>; Mon, 04 Feb 2019 10:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=haPam+GYaLSYSqglRkc3TMwbOLtEu/5RVbDNskoBkcA=;
        b=SbEI71MjW6i8XCi37/Uzs+8/NWC8IaSd+3Zq0V7uq6oC+3aby4dc8OEcG46kdbDv1k
         5mxroivVwfZjS4r3w+06tjpmi00Oe4FfCdE/9AUUzf66q1WrVXlTNGqsZLJXSP6k96ut
         09mC0RL5XQ9C8G2F3685xRl/BASyMjSl5mp0UozRV+sEAeX4JArm6qktgCwdBkfSToCs
         v/GEF6QzHkjgAlDqk2d/W0oVw8Wvj+QBti2j1KIl0yDk3vjcO2sI+oUGZqGy9zTOoP1c
         ng1CxuMLF1wC182TepizmoeaPG0i11JpsMu04zDv6hzSbSavnYPWonVmDwn/g/WAuedN
         hGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=haPam+GYaLSYSqglRkc3TMwbOLtEu/5RVbDNskoBkcA=;
        b=A0agxceQYuH3FfXbxJBvr4FC6GoF3ivDQgR2BLcg0gfDDoV5srRO3MjLrWWFPmKGmP
         M4QOKWvoia2mqu7HO/UomLnSBjH1y1RHhZML1dSp3r85x/T/kUFv29D+AizdqU4r4QAM
         5d6lgJBGHo3tD/P0RiyeNvnbG9qL710PwEroOwYXvtkHGf+wKW2iamnGNvLpGitRCdhC
         MPdALRGEQKxLR3ZfCBfpUvjrDPyFgPYORi9i5cG7orsB7Isj1+38Gk0SI31WYEfbGmOa
         BYUGDDn20HA+0Os+XZ+acP+okvg7r9EmKMC8XXBIgr7yzxNqqYx0Ncur7e2xguS0PadA
         p1vg==
X-Gm-Message-State: AHQUAuY5kiBWOkAzwIb6q1bWb7TUNijNsVqO6R/W9JpIFOXkjp7ruVZf
        uDBjQgHjsQYceCAkO/qwt9vGfQVEUyw=
X-Google-Smtp-Source: AHgI3IbbVdF4AGEe33RA5MHIzKbHjSsMK6lNkxlAseatMxO/bMNpdjo431Z58pegpf/7DOj8OsGE3Q==
X-Received: by 2002:a24:a542:: with SMTP id w2mr393231iti.64.1549304892891;
        Mon, 04 Feb 2019 10:28:12 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e141sm472705itc.40.2019.02.04.10.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 10:28:11 -0800 (PST)
Subject: Re: [GIT PULL] early nvme pull request for 5.1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190204151054.GA32678@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1bd7b844-72bb-29b6-2a92-96f0d7ae9299@kernel.dk>
Date:   Mon, 4 Feb 2019 11:28:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204151054.GA32678@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/19 8:10 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below is our current (small) queue of NVMe patches for Linux 5.1.  We
> want the re-addition of the Write Zeroes support to be in linu-next for
> a few weeks as it caused some problems last time.  The only other
> patch is a cleanup from Sagi.
> 
> The following changes since commit bb94aea1444b9859faa8d72aff3713fcd11c6696:
> 
>   blk-mq: save default hctx into ctx->hctxs for not-supported type (2019-02-01 08:33:43 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.1
> 
> for you to fetch changes up to 794a4cb3d2f7c105112f9b59525533f00ac06006:
> 
>   nvme: remove the .stop_ctrl callout (2019-02-04 15:41:25 +0100)
> 
> ----------------------------------------------------------------
> Chaitanya Kulkarni (1):
>       nvme: add support for the Write Zeroes command
> 
> Sagi Grimberg (1):
>       nvme: remove the .stop_ctrl callout
> 
>  drivers/nvme/host/core.c | 54 ++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/nvme/host/nvme.h |  1 -
>  drivers/nvme/host/rdma.c | 12 +++--------
>  drivers/nvme/host/tcp.c  | 10 +++------
>  4 files changed, 56 insertions(+), 21 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

