Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181BCC7619A
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 07:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjDKHCM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjDKHCK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 03:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5372722
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 00:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35A28621F3
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 07:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8958EC433EF;
        Tue, 11 Apr 2023 07:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681196528;
        bh=CFGPd2XqhK2A0Cl0ukmyxvea/BtvuwKr69c69crn2PA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jq1nJFunYcRKMLwBUm5zhc/kC+0YbEW8VBbxvN64g3jmz26Jk/wWZgFOvbapM3Bph
         zPe7bqcNanGC2StZEJs5e4UDswBQ2fiyj2X6gySqyW5MG0s/tjF2LMBDa4kJPKMmkU
         NOly6Lrqcz+RZikkfaqoj4L+EPTZgk76Hm9CEiq2prRcYSMFzl8beenweo5IK32X9B
         pgBjD/g5kTd8S+hYFxp6TCB4AcKHgq9bD8p8wxLq1xgppQr1Sfa/OFIQFbzKDldekD
         9dTo6kzXFWSYeeYiZa/rp6TmMnsEEp/4b84PlsHL9V3uDYgdfmLSPdp3+rx7rU07qD
         nJwrOzrGuqhkg==
Message-ID: <1b23f539-1528-cd73-3575-f73c196cb661@kernel.org>
Date:   Tue, 11 Apr 2023 16:02:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 1/1] null_blk: add moddule parameter check
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "vincent.fu@samsung.com" <vincent.fu@samsung.com>
References: <20230410051352.36856-1-kch@nvidia.com>
 <20230410051352.36856-2-kch@nvidia.com>
 <CGME20230410174800epcas5p3177f199ec973ba5e8e44a0a688a072e8@epcas5p3.samsung.com>
 <20230410174708.pv6xm4pwaszyabte@green5>
 <92bce410-8a0f-5580-94d9-8952ebbab2d7@kernel.org>
 <03029381-bd62-d26b-3520-862185c4570a@nvidia.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <03029381-bd62-d26b-3520-862185c4570a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 15:40, Chaitanya Kulkarni wrote:
> On 4/10/23 22:29, Damien Le Moal wrote:
>> On 4/11/23 02:47, Nitesh Shetty wrote:
>>>> static int g_gb = 250;
>>>> -module_param_named(gb, g_gb, int, 0444);
>>>> +NULL_PARAM(gb, 1, INT_MAX);
>>> This value gets converted to mb, for dev->size calculation in
>>> null_alloc_dev. I think either there should be a type conversion or
>>> this module parameter max value can be reduced to smaller value.
>> Yeah, good catch. it is multiplied by 1024, and assigned to dev->size which is
>> an unsigned long. So that could overflow on 32-bits arch. So this needs some fixing.
>>
>> I would still allow a very large value as possible though, to allow testing for
>> overflows.
> 
> will change the type in next version, but still keep the large value
> possible for that type.
> 
>>>> +device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
>>>> MODULE_PARM_DESC(gb, "Size in GB");
>> Chaitanya,
>>
>> Another thing: did you check if setting all these arguments through configfs
>> also gets the same min/max value treatment ? Ideally, we want both configuration
>> interfaces (module args and configfs) to be equivalent.
> 
> I'm trying to avoid that in the same patch,
> are you okay to add that in the same patch or a separate one ?

Separate patch is fine.

> 
>> (Note: please use dlemoal@kernel.org. wdc.com addresses do not work right now)
> 
> noticed that from bounced mails from hgst server, will fix it next 
> git-send...
> 
> -ck
> 
> 

