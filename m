Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C026EB64D9
	for <linux-block@archiver.kernel.org>; Tue, 27 Jun 2023 21:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjF0VVO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 17:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF0VVN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 17:21:13 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6677F198E
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 14:21:12 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3facc7a4e8aso6242005e9.0
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 14:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687900871; x=1690492871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7q5GBtuXaNyU+uOoX34ux3w5E9Nu9wE8cDGL5AcPmEk=;
        b=ZdK3Yt/m8u6d27H7A7jOKGbSX+nGy0h/nYVTDA4UuwYWrH3n2YMjb3YCcvtAbREAY2
         wgIK4X2M8WWsoFb7Qv2cGg1O0W4VVsHzKX+kgE1ok1ez1fdmsfz6yQUDkDsyZ1nXsJjD
         JslHj7SaiwtD7w6B/17RkMUplAXdyb/+4huSYdHWeD4hmTQgnhhqNy/k07cAO0sMe034
         qGHCn2VJZUt9S4miynvSg/+bzeSYhR9p2j9o7pbxmgYFccdA/cvTemZxyk/Cawtw+zlo
         5iwOOajiL/iOpXUrnPExgfFZ6aFKwfou6wjr9QzG+ysrzQk8pCU4GCMM8LC8ffFrKbuy
         IrNg==
X-Gm-Message-State: AC+VfDwbbosi2VKCDLyp3mX+vF55brYZnVv9k72ahGqgX4FN6tdslMbC
        5Im5mMN4XLoUe9dzeZvJODE=
X-Google-Smtp-Source: ACHHUZ5RghmTPJFm2Gbp40AKuHZrK+hsjI2iaUF9s8mBLWhAcUQHvDe6h2lJouwNooN3FPkuCHepow==
X-Received: by 2002:a1c:ed05:0:b0:3f6:8a3:8e59 with SMTP id l5-20020a1ced05000000b003f608a38e59mr29420979wmh.1.1687900870644;
        Tue, 27 Jun 2023 14:21:10 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id v14-20020a1cf70e000000b003f9b2c602c0sm14887146wmh.37.2023.06.27.14.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 14:21:10 -0700 (PDT)
Message-ID: <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
Date:   Wed, 28 Jun 2023 00:21:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc:     Chaitanya Kulkarni <kch@nvidia.com>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Hello
> 
> I found this failure on the latest linux tree, and it cannot be
> reproduced on v6.4,
> it should be one regression recently merged to linux tree after v6.4.
> I check the commit recently merged after v6.4, and found below commit
> touched the related code, not sure if it was introduced by this
> commit.
> 
> commit 959ffef13bac792e4e2e3321d6e2bd2b00c0f5f9
> Author: Chaitanya Kulkarni <kch@nvidia.com>
> Date:   Thu Jun 1 23:47:42 2023 -0700
> 
>      nvme-fabrics: open code __nvmf_host_find()

That just moved code, no functional change,
most likely the below was the offender:
ae8bd606e09b ("nvme-fabrics: prevent overriding of existing host")
