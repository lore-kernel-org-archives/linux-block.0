Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CAAC001B2
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 16:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiLVQXQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 11:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLVQXQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 11:23:16 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08254220C9
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 08:23:15 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 36so1629854pgp.10
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 08:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXlbX1VyAp1OUkMGBpH9EiNGKAxy9fO5IsYvI0ywITo=;
        b=3GhP48iDsw7f3PN/e0bFTcv0wTw99koJKRq7qbRwENHRRKiyLXG4lVTjrlwLgrDMfK
         m45LccLNE8dr7UUTsyzS3klT75UkUXzdYCBIHBBO51foNhFQTaS6Ph2diBUX8v8T30Wz
         y/z3CU++6aFCJ7nU1mgRzOsD5NlKHG1+ArdJd77AdbWCCG2TNdYW6xwtBMXQAKKYxMwl
         niR8b1PcoiGawFC2t7R6ADFbPAK++sOTnxPe5r2NveIM+HWRTdKVMioCEXDCU02ViOBW
         vFrWlAH0QHZMHivIhLCx9VJEvZK26CktVAi0guj63kaKwWAT4cZoulHpczOf5JD3nt5j
         nwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXlbX1VyAp1OUkMGBpH9EiNGKAxy9fO5IsYvI0ywITo=;
        b=gtFYtcNJAYHx4uX/gwGlOJrxBAp9fg9ADvVmAyML9ANOolNJbBL68PbTjogLroGMeC
         pUX4eXyDlMHC39aCV1VmNz3VLbTVFNSyIf2VLA49ER0jLXJeB0VkXnaXezxFsB4H9cfb
         lJ2QF72hTNaLAKrR03Q+Gdu/drc5G4yAP2HQeBFfzTn2zobP7cGitvvJJ8TSDKNfZFkU
         nBA7w5JdOtcALIVelycWA8Y8/atpUkHQpq9wAnMAswGr+hMKTNn434fqLWO3vRMz6arO
         fX/cXcXNiJek0T930tI2/DEzjXMKB7mI3sjOzQ54BDb7rqxj7eLItE4/czPHjQ/AB3r/
         swmg==
X-Gm-Message-State: AFqh2kpOqkBngZ3w6i6BscO/Y74FzX1h1P/z8X8fHIxqnj3fkiE0xzKY
        DvS/ktZvaRwgj/ZrwGTjNLR1Kw==
X-Google-Smtp-Source: AMrXdXtgaBwVjVuK9ElEkuRLLaMFoufiteDPKp8RMN9JoNyAuUkFKncyt6MbxWyHiFtw/GNAQhz5dg==
X-Received: by 2002:a62:3894:0:b0:56b:a661:5a5a with SMTP id f142-20020a623894000000b0056ba6615a5amr1672622pfa.2.1671726194457;
        Thu, 22 Dec 2022 08:23:14 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z7-20020a623307000000b00576d4d69909sm952358pfz.8.2022.12.22.08.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 08:23:13 -0800 (PST)
Message-ID: <7c253b8a-7535-51f0-5325-fb3866f7634e@kernel.dk>
Date:   Thu, 22 Dec 2022 09:23:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y6R7MBrn2xzmwT1J@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y6R7MBrn2xzmwT1J@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/22/22 8:43 AM, Christoph Hellwig wrote:
> The following changes since commit 53eab8e76667b124615a943a033cdf97c80c242a:
> 
>   block: don't clear REQ_ALLOC_CACHE for non-polled requests (2022-12-16 09:18:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2022-12-22

Pulled, thanks.

-- 
Jens Axboe


