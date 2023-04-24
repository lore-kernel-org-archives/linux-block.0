Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3A6C7618E
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 08:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjDXIxx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 04:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjDXIxw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 04:53:52 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8168135
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 01:53:49 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f17b5552e9so10707315e9.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 01:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682326428; x=1684918428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GiHUcSnMSP1Hvh+56AcVC729SXkx17RkcpbunNrDak=;
        b=Dedk7tB/0VRST1vwLQkf4N1YBGhth+4eMEmZ439Gz0nyx3wBw53/Iid1n3VREY+2Ww
         +rRqQgm5xvJ4aznUaqWqvr8OxB219kQo+LuFHSyRetEWaZPsVJ7UVgMJaXGs++LKDsj6
         Zcdz72OM5TtEGt/frNwVBHNAng2frTdrVhBc41Hardz72YabZ99kEssLZKTd3pfxuEqO
         TBNxrIPLm35KfO5R9ixCIzshT6KCiJfFYSthq1gLNb3/+oQyFYZvlUOvfSJ9MccxsRNe
         870ncLnXWNYmhE1ZS2TxMmS6g75bDMf9l9ExiTYQpY8Z2Fw8WUOyUd9vURQuJb8H5QUC
         Y3IA==
X-Gm-Message-State: AAQBX9dLRl5w/AJwKJ0uYhe3pYbZzUxwEbBOuksBF+YFHsNvCqaz50PE
        hvxEC/FPGe1M+6CJ1zXvz9Y=
X-Google-Smtp-Source: AKy350akP3bYDfe+vbBKt69VIsKGEZTVjxqhatKenixSFNbBXRYARwbMSEYZ1XiaqIZzjp4k27n4hA==
X-Received: by 2002:a05:600c:3baa:b0:3f1:960d:68ce with SMTP id n42-20020a05600c3baa00b003f1960d68cemr6052169wms.3.1682326428292;
        Mon, 24 Apr 2023 01:53:48 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s1-20020adff801000000b00300aee6c9cesm10329789wrp.20.2023.04.24.01.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 01:53:47 -0700 (PDT)
Message-ID: <9b3da2c2-b158-ff4a-e7e3-62e49f366ac2@grimberg.me>
Date:   Mon, 24 Apr 2023 11:53:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 0/2] Fix failover to non integrity NVMe path
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, oren@nvidia.com, oevron@nvidia.com,
        israelr@nvidia.com
References: <20230423141330.40437-1-mgurtovoy@nvidia.com>
 <20230424051144.GA9288@lst.de> <5b7ca121-2b85-ddd0-d94b-1739cc5dcbec@suse.de>
 <20230424062040.GA10281@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230424062040.GA10281@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Yeah, I'm slightly unhappy with this whole setup.
>> If we were just doing DIF I guess the setup could work, but then we have to
>> disable DIX (as we cannot support integrity data on the non-PI path).
>> But we would need an additional patch to disable DIX functionality in those
>> cases.
> 
> NVMeoF only supports inline integrity data, the remapping from out of
> line integrity data is always done by the HCA for NVMe over RDMA,
> and integrity data is not supported without that.
> 
> Because of that I can't see how we could sensibly support one path with
> integrity offload and one without.  And yes, it might make sense to
> offer a way to explicitly disable integrity support to allow forming such
> a multipath setup.

I agree. I didn't read through the change log well enough, I thought
that one path is DIF and the other is DIX.

I agree that we should not permit such a configuration.
