Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EDDC433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684C4619B8
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhCWQ23 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbhCWQ2N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 12:28:13 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33ACC061763
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 09:28:11 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id x16so18305859iob.1
        for <linux-block@vger.kernel.org>; Tue, 23 Mar 2021 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UZQuQN+Y/Ln5Rqog6y/XuFlmircqKTHpGhsY1hXDlr8=;
        b=eDO9wyI04ngUdU4BR8Y3W2FAnFEO5oflQNs09vAXNIZhoCh9dTx4aaHXdMIYBH0Oh8
         uc/UESMI/Z+g+irH6E40Htfp2p8zAswssVgTY6fSJo3mDj8fU9OdbaUBJajkHpAv1VIr
         3dGUVkhgqbtxibuLPOTmlW9L7Ec4Y9OwIWhIH5pFNXMMgxysZoai50ci/RYuIRIfNBtS
         TAgqEc0WmUE2Zmwtp3/lGCoYj2z/HFs38AGsHt5psvqvPIbAN93CiFdxwaegR+/PJtdN
         uXv4ZWjZC+PpK/0szjiZjPkQUcglOIgEo47FsdIuWcrK984a540b0CU+XIbS9e32YelC
         Ctqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UZQuQN+Y/Ln5Rqog6y/XuFlmircqKTHpGhsY1hXDlr8=;
        b=AtNv2ylENzpNwDK9ttDwHdvhOwDnvcfpb2j3/8QWFI7024CfW1+0gZswOGbZWkOduQ
         sjuLlftGgUttCGh2eIyimASIfCHFGm2lcWhi8fl+vwl1h0M/MgqXDbxyJDmTuXQ/HKws
         oML3mQLTovKWwRBKWBkAUPY3EUfbSJXjKvkramkOgEA/oyuK4ZQXrSR/Hl1l1A/Y9XSU
         6WZD/nqcshFWZuGoGCIGFkn0ypUecgO6w1PvS+BaKq+z7169d+tM/wE4MfJEF95JHOvp
         y+Qtmy9gwtcWHkCOmxUEdbdJ6Qvxuz1JN10yVxr6BHcmpBvCVkcdQZnV6lpEu3aSVLNI
         VIFw==
X-Gm-Message-State: AOAM532AHss/4hOBgzNtBRsUZoR4qDg93VAapCes3NeHsLebtcStgXYg
        U7B2slhLWsJ8+ND8B4HRNw+NgQ==
X-Google-Smtp-Source: ABdhPJxIB+FYjEsQXrnfmY1mc2AaqL+WNmFYjgoU+OScb8vpa1uJVcFAs1RmgLZMnLfU5DBGClTs4w==
X-Received: by 2002:a5d:89d9:: with SMTP id a25mr5011258iot.69.1616516891090;
        Tue, 23 Mar 2021 09:28:11 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s18sm9827634ilt.9.2021.03.23.09.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 09:28:10 -0700 (PDT)
Subject: Re: [PATCH] xsysace: Remove SYSACE driver
To:     Michal Simek <michal.simek@xilinx.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, devicetree@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <ee1fe969905f641f5f97d812ee0cac44c12fe0f6.1604919578.git.michal.simek@xilinx.com>
 <20210323000436.qm5rkiplwt5x5ttk@offworld>
 <6948510c-dc7e-d74a-62e3-e42be14cff16@kernel.dk>
 <9c4911e6-92dc-0a0f-2f81-7d23e268144f@xilinx.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <66a774e3-f068-984e-e69f-b55667a494cf@kernel.dk>
Date:   Tue, 23 Mar 2021 10:28:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9c4911e6-92dc-0a0f-2f81-7d23e268144f@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/21 10:25 AM, Michal Simek wrote:
> 
> 
> On 3/23/21 5:23 PM, Jens Axboe wrote:
>> On 3/22/21 6:04 PM, Davidlohr Bueso wrote:
>>> Hi,
>>>
>>> On Mon, 09 Nov 2020, Michal Simek wrote:
>>>
>>>> Sysace IP is no longer used on Xilinx PowerPC 405/440 and Microblaze
>>>> systems. The driver is not regularly tested and very likely not working for
>>>> quite a long time that's why remove it.
>>>
>>> Is there a reason this patch was never merged? can the driver be
>>> removed? I ran into this as a potential tasklet user that can be
>>> replaced/removed.
>>
>> I'd be happy to merge it for 5.13.
>>
> 
> Can you just take this version? Or do you want me to send it again?

Minor edits needed for fuzz, but I've applied this version.

-- 
Jens Axboe

