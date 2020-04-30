Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87500C4724C
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63CFD20873
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 15:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="plDtk4le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgD3Pd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726344AbgD3Pd1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 11:33:27 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDCFC035494
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 08:33:25 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i3so1889176ioo.13
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0wVlHHFG7TDcdYHqCvhhySc0fLcHG5CiyMQ4xaek7IQ=;
        b=plDtk4leUb6MAEpi5mZ+QvN0BH/ERr2y9gIXBqtHrszottbJ5Rg4lUdwDS52yXt6Nj
         V3OFLsXxpuqtNaeSthplo4H6qmb+IHNdLVXt/hksFm2Fs1M8hnWFPaGUYqKZLgNdhiiw
         TjgQunOApqK7OK9JQZzx3QhSRfdR0/bs2Alw08r+BS4zBin8AvlfoIJ5NOQM8LAZYerw
         yhYbgGRCPSm7QFchetksWtAYUewVZgvlrWDdEXlxTe1wD2JmbnbSH7qzglPKkbQO4m+3
         0hhgmP5RFdShb6AnL2CFr83QWaOT/Mg7TIyovQtFmd5AeSW+ci0Pol7qDsEKtPPYZyce
         jpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0wVlHHFG7TDcdYHqCvhhySc0fLcHG5CiyMQ4xaek7IQ=;
        b=hMN1vgC2Jzc3GFVaaI5931xONL0BXdyUL9AzmTY2s1E6EgRcoMwF4RrQxyv1aPivuH
         4eOL3+z6UcwH+4B2aS0wp4vq4FnsP50W9kZ4Tkpp2GibTmYx1Xbt5eJ0A8qVavJ21Y2I
         LxihEi0wS68KARkL06AWhXnOxUl9E6oMEha1PkqZ22/tmKrNC7bKhW6i5fS7hWQyhfqO
         LSoGHzNUPZZEN0sTNLckm3wlUSoEoNfmthLhIMDyZDLemC//lsClsyY6Voo8zzP09kP/
         Iya72Sxy+AUutnqGzP20rqJVEEuJe4Q/BWTQ/uz12n1LMsvxssNx0y0Ulh2glJz1Gaqm
         CB6A==
X-Gm-Message-State: AGi0PuZH3mjglCMs2NxsuXIJ5XAvbS0Wg/ZuuY0dX8WnDrUrPZjL5R8E
        /0CvW7+7QibuuEsZ8MScq7OKdPUWfPhrzw==
X-Google-Smtp-Source: APiQypJYTN3yOepMT7MkIbvpuo0rB8AJl2AWioLOiemFa9XI5DcPZq4jhg5bTBqhViTXrgnLbvWplw==
X-Received: by 2002:a02:c9d0:: with SMTP id c16mr2412549jap.80.1588260805259;
        Thu, 30 Apr 2020 08:33:25 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z21sm2018080iog.31.2020.04.30.08.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 08:33:24 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fix for 5.7
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20200430152832.GA2579034@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d5d8c37e-af83-2d58-2018-d59eb959b40f@kernel.dk>
Date:   Thu, 30 Apr 2020 09:33:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430152832.GA2579034@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/30/20 9:28 AM, Christoph Hellwig wrote:
> The following changes since commit d205bde78fa53e1ce256b1f7f65ede9696d73ee5:
> 
>   null_blk: Cleanup zoned device initialization (2020-04-23 09:35:09 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.7
> 
> for you to fetch changes up to 132be62387c7a72a38872676c18b0dfae264adb8:
> 
>   nvme: prevent double free in nvme_alloc_ns() error handling (2020-04-27 17:08:06 +0200)
> 
> ----------------------------------------------------------------
> Niklas Cassel (1):
>       nvme: prevent double free in nvme_alloc_ns() error handling
> 
>  drivers/nvme/host/core.c | 2 ++
>  1 file changed, 2 insertions(+)

Pulled, thanks.

-- 
Jens Axboe

