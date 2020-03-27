Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32E3C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97CD2071B
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 17:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FepuvUCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgC0Ruu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:50:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40297 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0Ruu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 13:50:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id c20so2294306pfi.7
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2020 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NbkhpIuOWJuMUESyBT70pEHnCNQNnr4hZwihXUNVzQo=;
        b=FepuvUCT4M7sYuheBzr+EeuSk+ExYWaEHm4vduyKQeyB9nbFCCeXtpNLNfBgTSIPfR
         /c9Rl3Kexj21kQH/VLxhfDhzwPu+C5Up5xqGa6BEtoS9dfkVxu6fmgAj2AL8dafjagCt
         iw4TGLi/kPe7V8juR423lWDwA6vSOGT2JoLIWnb7/qE2sVoaR3+f4d2iYWX46lbBt8hP
         9kp7xCgv7LUaqNN513KW7FhO/oxpnhJarIu33p08M4KVPitW1Oy/zt5Gu6dhQ9dR8KBI
         6dxi70liJkX8NdqU8rCp5bTK2PtksgkyrQPdwFZVGDLwVH57PjnOyfC0t4IOmYVC2lWR
         zYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NbkhpIuOWJuMUESyBT70pEHnCNQNnr4hZwihXUNVzQo=;
        b=Ow5Xj4SwjL0gxfE0L6RExuGgK4sqECZg2gsNqRbQIH2kj5wI+U79+5vBaUUFFnUyVU
         0SEqSpdQ69x33Udyj1/GyvVckDfi99k7ogywyyGSjNferOrRq8fNy5iCIOhFtRTk7bdN
         7Q6VQB1M5wsVJ7gwNBh5sbpB1jQ0OL/qht1w2cBAn4rGKSk2CYVReZam0mxFFt0598j4
         JKKi08fMGlaKRFimS2b326X8GUD+UDCM+27Fz0gd0dh8eoey9TQ8EPNjrNoFmwAloeeR
         c4slhA0OKIJd8ivxhrGw8RAz7NXqdkBWqx5Rurt4H03/AeM9clmaJJIfqNMg5/oP8kED
         ZK1Q==
X-Gm-Message-State: ANhLgQ0PzE4DqMVdjPRnuAr4jqruHo643pRU94DgjMdgQa0n34XTPG1x
        ekuHi4tn1ZKOjx+KIK3VUwufvtg2
X-Google-Smtp-Source: ADFU+vt4h9qyiuqaP6qfUepMf7qUu1HnxdDZp2MqovLbOLxQQnGCUsvBgca0Tf3MuFWzw9d7V6rivA==
X-Received: by 2002:a65:68cb:: with SMTP id k11mr460554pgt.78.1585331448562;
        Fri, 27 Mar 2020 10:50:48 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:5c8f:768a:547c:1376? ([240b:10:2720:5510:5c8f:768a:547c:1376])
        by smtp.gmail.com with ESMTPSA id t11sm4189116pjo.21.2020.03.27.10.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 10:50:48 -0700 (PDT)
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
To:     Keith Busch <kbusch@kernel.org>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
Message-ID: <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
Date:   Sat, 28 Mar 2020 02:50:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2020/03/25 1:51, Tokunori Ikegami wrote:
>
> On 2020/03/24 9:02, Keith Busch wrote:
>> On Tue, Mar 24, 2020 at 08:09:19AM +0900, Tokunori Ikegami wrote:
>>> Hi,
>>>> The change looks okay, but why do we need such a large data length ?
>>>>
>>>> Do you have a use-case or performance numbers ?
>>> We use the large data length to get log page by the NVMe admin command.
>>> In the past it was able to get with the same length but failed 
>>> currently
>>> with it.
>>>
>>> So it seems that depended on the kernel version as caused by the 
>>> version up.
>> We didn't have 32-bit max segments before, though. Why was 16-bits
>> enough in older kernels? Which kernel did this stop working?
> Now I am asking the detail information to the reporter so let me 
> update later.
> That was able to use the same command script with the large data 
> length in the past.

I have just confirmed the detail so let me update below.

The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS 
64bit).
Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 
4.15.1 (Ubuntu 64bit).
So the original 20,531,712 length failure issue seems already resolved.

I tested the data length 0x10000000 (268,435,456) and it is failed
But now confirmed it as failed on all the above kernel versions.
Also the patch fixes only this 0x10000000 length failure issue.

There was confused and sorry for that.

Regards,
Ikegami

