Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB471C46467
	for <linux-block@archiver.kernel.org>; Thu, 19 Jan 2023 18:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjASSyG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjASSyF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2023 13:54:05 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15679485B6
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2023 10:54:03 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id m15so1645287ilq.2
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2023 10:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sa8Oz+7EARYAtQ0WLnCqgtp/WsCMus/3I6/+CNJ1OPw=;
        b=sPzq1KJuKnyasXRpxYhl2vyV/bYi9yVZ56Vqego/VjuHdzz/5dWCi47UX2CUDpoDNC
         CcC5wYt/hUVVEpFkHtyZ89U3S4NTWky0LrDtrtiFDdFrjZELyHOpVBHxbNELtKnQ2iw4
         nr1fs0E0gGKpdnwRST07vzvNPYUzWsF4Vi012BPK68GyqhQejq7mymG62LbNctNk1H5z
         ANiECjUYn3uY98+hJ+kIU7gfPJH2vu/HOgNnNuH23TbDVW4pbv+weD5qebAzq+j5ja3T
         n2GpBO55V9L6Il8+jeulDNzuo2GKi68Gu59deOK6KEDsKNVjB9594cAWwGeunxMF6FhC
         vCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sa8Oz+7EARYAtQ0WLnCqgtp/WsCMus/3I6/+CNJ1OPw=;
        b=n/k0MXPM82Di2oWNGYabUKMIpKbZWUB/GM8J5XZOzR3WsJz5Pw3v+rfNBd/sGeTLs+
         4/eNshq3WwShd/+Fw6bmKZ2jNyQuz5E5VCXOeAHtt0cIm2aaNRDiVR1+UujvJeT7mvqA
         We5BZ/PjRUAhg0QoHHPYx32fOgZop+KcbNsyHlmyTUVw3M+oKpF888ibZ9W8Zqrg9Uu2
         50lsSoXITHICN7/GUM5qEm4S5H9+93VaumT3qICSJ++U7y7ohTls7eZSIWAxXbuwLqmJ
         fsNitKIDrQyiyBFkvTYWWhYuYCGHwHYmAprfseqxj5odHuZbSALTTSUFw4Ccr0gAHB3c
         FhKg==
X-Gm-Message-State: AFqh2krmcfIf8fEon8usTT05rb+reC3fD5/fECdbYLac5ZmNKfVvdm8K
        lDe2tlRErCdUpf+oa3vwuodDi3j9uQ27TfiV
X-Google-Smtp-Source: AMrXdXuIIp/c0w2El/LzauKFa6i872EXwxoi+fHEVHbXfB+cDnoMsFA/jCYUDrbbR0SKLLTI269Tgg==
X-Received: by 2002:a92:cda4:0:b0:30d:bf1a:b174 with SMTP id g4-20020a92cda4000000b0030dbf1ab174mr2555528ild.1.1674154442314;
        Thu, 19 Jan 2023 10:54:02 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e36-20020a028627000000b003a7c2e97005sm763264jai.126.2023.01.19.10.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 10:54:01 -0800 (PST)
Message-ID: <bd1c347b-cbf8-3917-401a-ed85c6ccb956@kernel.dk>
Date:   Thu, 19 Jan 2023 11:54:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH -next v3 0/3] blk-cgroup: make sure pd_free_fn() is called
 in order
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org, hch@lst.de,
        josef@toxicpanda.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230119110350.2287325-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/19/23 4:03 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v3:
>  - add ack tag from Tejun for patch 1,2
>  - as suggested by Tejun, update commit message and comments in patch 3
> 
> The problem was found in iocost orignally([1]) that ioc can be freed in
> ioc_pd_free(). And later we found that there are more problem in
> iocost([2]).
> 
> After some discussion, as suggested by Tejun([3]), we decide to fix the
> problem that parent pd can be freed before child pd in cgroup layer
> first. And the problem in [1] will be fixed later if this patchset is
> applied.

Doesn't apply against for-6.3/block (or linux-next or my for-next, for
that matter). Can you resend a tested one against for-6.3/block?

-- 
Jens Axboe


