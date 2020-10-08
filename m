Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05918C4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E3F21924
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZP7L2UYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbgJHO5a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbgJHO53 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 10:57:29 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519F7C061755
        for <linux-block@vger.kernel.org>; Thu,  8 Oct 2020 07:57:28 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t18so5933378ilo.12
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2020 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WlXN8GZZvwGGopMxWEZM0u0z3USDzyayHMITdJDCfGk=;
        b=ZP7L2UYXtx7aixSt3DiKikqsTNSzMo3zbeosCxtEudHK8rqiwh8QWkbZaSy5dcBFhj
         w27F9MohU14oH0VCtsBgIlUTQ/uQdz7+WcYwxci7+r/uf7BrwkSCy06a/KPyxd8ffRPZ
         dIlwfOlM499CDNRpD/KQEB4Lib0tg/VTIbjjlWKM+O1/hOP2Hb/ezUPFtsea75GlAbdh
         t6HOYUUAM2jXPcS9U9F9eYnj5rK7Lv5CaTulOLx0UTTEpsvsH+P2qyxUFmqPIePALdZW
         9MPrAE3eCzYpsnJftuu20QCBJdJGjS9QR8UpUYRJHAXQK73w/vXsQoo575airyFnzJ17
         LJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WlXN8GZZvwGGopMxWEZM0u0z3USDzyayHMITdJDCfGk=;
        b=KcnkFBpPNvzjzapsByUH9oXS0ti62UJrvhekLW+KSYuhmtupv/IzJabZyTL0Y1/uhq
         uIIsLqRLW1wNeI6EWv+mBuUpo2vgd8ePb6jsY9chCwYc50BNpx2/1p58WtO2BUoKclLr
         CxrsGw4YMR1lFQGCbS5kB1UZBPkJJvZ/WkGR4gEDDtm3MokHbDpoEsMoNncmDEnMGuJQ
         +tD8dPg2c6gGuKxDv/OyyEoX+/YCEKI+OOFWaO5zb3DNQM6KW473ndndbOZzBYSu2mnn
         F8sJ+UhN5pwcY82CFc+689oWERchifEtRX8yqP2JTSzRkiJtYtZmUPqf8cpXwJaL1lYY
         lNUw==
X-Gm-Message-State: AOAM533C9x3HEiy5ah0caW+z2WESzitYvo5TjKuwt4l/xzDgSD4J0ro7
        U1d59YtwCsuxf2jjZce/BcH9UQ==
X-Google-Smtp-Source: ABdhPJzZZ+V9efisgmMyAO3oDI+WBPt0+snsianMHoV0AyqRCDmP/vePGjFA5vRhXqN9n5Px5XYwqg==
X-Received: by 2002:a92:3501:: with SMTP id c1mr7256723ila.146.1602169047657;
        Thu, 08 Oct 2020 07:57:27 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d6sm2711297ilf.19.2020.10.08.07.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:57:27 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.10
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20201008141041.GA1493538@infradead.org>
 <2b4ad1d6-3d77-d14e-2275-0f9326b19514@kernel.dk>
 <20201008145614.GA23622@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6c77e5f5-0316-9893-1c8a-8fe25bbbb506@kernel.dk>
Date:   Thu, 8 Oct 2020 08:57:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008145614.GA23622@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/8/20 8:56 AM, Christoph Hellwig wrote:
> On Thu, Oct 08, 2020 at 08:52:50AM -0600, Jens Axboe wrote:
>> On 10/8/20 8:10 AM, Christoph Hellwig wrote:
>>> The following changes since commit 103fbf8e4020845e4fcf63819288cedb092a3c91:
>>>
>>>   scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug (2020-10-06 08:33:44 -0600)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-08
>>>
>>> for you to fetch changes up to c4485252cf36ae62c8bf12c4aede72345cad0d2b:
>>>
>>>   nvme-core: remove extra condition for vwc (2020-10-07 07:56:20 +0200)
>>>
>>> ----------------------------------------------------------------
>>> nvme update for 5.8:
>>>
>>>  - fix a controller refcount leak on init failure (Chaitanya Kulkarni)
>>>  - misc cleanups (Chaitanya Kulkarni)
>>>  - major refactoring of the scanning code (me)
>>
>> Seems to be a typo here, 5.8?
> 
> should be 5.10 of course.
> 
> Do you want a resend as this is also in the tag?

Yeah I think that'd be best, thanks.

-- 
Jens Axboe

