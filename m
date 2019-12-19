Return-Path: <SRS0=q1Dd=2J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E10C43603
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89202467E
	for <linux-block@archiver.kernel.org>; Thu, 19 Dec 2019 22:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLSWER (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Dec 2019 17:04:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44569 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSWER (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 17:04:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id 195so3180873pfw.11
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2019 14:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q13SX/+uPfDo8J7iLxbCLubGr0/EE4Ds3pixQI9a9GA=;
        b=ShfpYmHNB92IuHChJD1u6tgLRYdHLV3i3ghAo5gvOSiYVuRXcsiyR4+ZSz1pO1/U+3
         OUwjouUZyAgETu+enm0cL79bBXUece7fIBiIZKEzFkWWEdETD+YpfAgTyLsvdaMgsY39
         7L90Ph6tdBa35+5N+O/YdJzXcBmtWoR+j0cEOcWuGuthcq3EejUcMyNZ0wfcRBS3PAkV
         ePaDVjy6fp+hWiq0C4RFLC3PsbFaZJzjGeiAxQz7P96OVWwlTvjH9qLp2YoqXErFRzGi
         /1u2NIbUShogHmmn04R0bAUElSZBtKHqttv+HqIhjLVb/OI1UmMOAUIftXM+UuD3usjV
         z7PQ==
X-Gm-Message-State: APjAAAVM3r3uwgivmnmsCpKN+S3onl+5IAU83YGWy6fXV0zNoa3wbocD
        2ZrewXJ/OCRrCCcsMu4s1+FPXvwj
X-Google-Smtp-Source: APXvYqxm3pTCLMzTYWO4nRLPEDZdOFRojGW97LKM6/xyjz+tKOTZA0oNFm4lkCIx5gDGb0Xun1+mxg==
X-Received: by 2002:a62:ac08:: with SMTP id v8mr12438787pfe.83.1576793055666;
        Thu, 19 Dec 2019 14:04:15 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id k1sm7947378pgq.70.2019.12.19.14.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 14:04:14 -0800 (PST)
Subject: Re: [PATCH v2 0/4] Add an SRP test for the SoftiWARP driver
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
References: <20191213143232.29899-1-bvanassche@acm.org>
 <20191219214735.GA830111@vader>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <de0feeff-debb-8c14-2f17-6d17c5c27c9a@acm.org>
Date:   Thu, 19 Dec 2019 14:04:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219214735.GA830111@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/19/19 1:47 PM, Omar Sandoval wrote:
> On Fri, Dec 13, 2019 at 09:32:28AM -0500, Bart Van Assche wrote:
>> Recently a new low-level RDMA driver went upstream, namely the SoftiWARP
>> driver. That driver implements RDMA over TCP. Support has been added in the
>> SRP initiator and target drivers for iWARP. This patch series adds a test
>> for SRP over SoftiWARP. Please consider integration of this patch series in
>> the official blktests repository.
>>
>> Changes compared to v1:
>> - Only run the new test if the kernel version is at least 5.5 (the version in
>>    which iWARP support was added to the SRP drivers) and if "rdma link" is
>>    supported.
> 
> Is there no way to detect this feature other than checking the kernel
> version?

Hi Omar,

The only other way I can think of to verify whether the SRP initiator 
and target drivers support iWARP is by loading the SRP drivers, loading 
the iWARP driver, by configuring LIO + ib_srpt and by attempting to set 
up a connection. However, I assume that's way more than what a _have() 
test should do?

Bart.
