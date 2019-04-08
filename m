Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA70C10F13
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 17:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5005220879
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 17:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Ih0iRH9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbfDHRlY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:41:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40724 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfDHRlW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 13:41:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so8035452pfc.7
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cqpWNodamv1eUSJSNNofxMV6WCSyHNg+Yh/sQooGGpw=;
        b=Ih0iRH9JDgXLJ1qyKayI8LBXShhh2MPHgqF5i3y4gOTn+jABAPdIq7iPlBWpdBqF/A
         wbmfSYI7zXudrI8+pRxFLwzZ67STju6nXw56KWZm0yeMAIAt2qnrn2GsajOjmC5nPDch
         Xvp5QiLqLxYlgezRlC1oY7G8qifyPFOiTUYtHAr7ugVC5MmkkKG43OS32jwR+J1cs8cs
         U56mMu7sqtAFi8XCYVV5em7eUXQnKSsRP4Q1pHY7pzIX0lwiQxV23HVJhOR+8AyZEQzz
         rJ9AdMZ7pHn9hDp5hhtySGcr0VbIskAnDpqNj95MVmip9qcJkKCLbhUdGrrXVUuHrogh
         ZviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cqpWNodamv1eUSJSNNofxMV6WCSyHNg+Yh/sQooGGpw=;
        b=pgeEu3SlMvAEnK2iQnBU/UhYUbUEwnaxLJpWMq3bmsEIcgxdqkjEKylaDvAApJwGzD
         eqhhxFmy80xlPrHV+4njegVX99Cp6k+jxW7XHTTLHqiLAHxoIllNKSMRcIOUjTFk0WFm
         e+IlbWmgmtyHRMyuf2mnjgPKEKT+iCYCbAumTCvOPd0717E273IimrKGei3dg+DgoWqR
         4str2kfZVi0JvCkhcSxmhF/E3f1GcbsnXJ5U6uOeOTmz2C2kMPUwkqPzmXEpi5eeYzom
         hCTLApemwgnUcVBvX2QO0X/ih8kLR6NujwarjTKFC0/MY0wz9SdtRbaVujYNyxDaj3CW
         vIzQ==
X-Gm-Message-State: APjAAAUVoZhCu3SiRliYdu+Ie0ylVScgERaP7cILEJZJCQ+0+krAaOBS
        wZ3LO1hRvuDvwX9w6bZTPot5Yg==
X-Google-Smtp-Source: APXvYqx1T9NOaiyozTTZjIPOheuJaw8zj1M7E1Cm8p4SgRVrH+TRsD204yf9gWKXMzK+SOScLTpQRA==
X-Received: by 2002:a63:360c:: with SMTP id d12mr28202147pga.404.1554745281911;
        Mon, 08 Apr 2019 10:41:21 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i2sm43527566pfo.9.2019.04.08.10.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 10:41:21 -0700 (PDT)
Subject: Re: Thinkpad X60: regression with 5.1-rc1 and 5.1-rc4
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Cc:     paolo.valente@linaro.org, linux-block@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
References: <20190408173914.GA13260@amd>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <678ab058-986c-9727-58d7-d3f5283e2225@kernel.dk>
Date:   Mon, 8 Apr 2019 11:41:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408173914.GA13260@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/19 11:39 AM, Pavel Machek wrote:
> Hi!
> 
> For some reason, Thinkpad X60 now crashes during boot. I see some
> weird backtraces, and it may be bfq related... or maybe ACPI idle.
> 
> Does x86-32 work for you?
> 
> Weird thing is, 5.1.0-rc3-next-20190408 boots here (but later has
> problems during resume, making it unusable, too). They may not have
> 100% same configs. 

Can you try and revert:

9dee8b3b057e1

and see if that helps?

-- 
Jens Axboe

