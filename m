Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB4FC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 21:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DFB2053B
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 21:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gfokrAic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfEBVyc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 17:54:32 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37151 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfEBVyc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 17:54:32 -0400
Received: by mail-pg1-f180.google.com with SMTP id e6so1672946pgc.4
        for <linux-block@vger.kernel.org>; Thu, 02 May 2019 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MBID6pBuuXLp9VD3vm7yEVW/E0fVBtd0jBdpqdXVLC0=;
        b=gfokrAicLKNGer/uo0EkviXH3nnCofvHPG9FIRrkF+5Oj1bmdkbcVVSCHjnMHpgZnF
         hz0+cKKKbq/QQ/3QzXgJzXwuaG/2OYo6YkMmmux7LNzf4EOC/7KJWtk7bMVALPcU2siP
         txZddaANjlieQT9vDwmH1OvOubliJMluG5kA4QSLwO6x+OwUh0BPOSck0hELCBmzu0GE
         WiI29FelhNMxankj023zpy6B+FRkeSOX+ZPtIvqT1Y0dpleXm9KpKhiG0VrqmEY3/mWF
         Q6KZkYTS24ShbIkZtYK4S59Ia1AV+5jfClKGAP5BEX4ngu2uNFhFQdpUrj2C3aLJrEy+
         AJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MBID6pBuuXLp9VD3vm7yEVW/E0fVBtd0jBdpqdXVLC0=;
        b=Tw+Sp/eqNVYX6iTQu+qsmK/rC2ZUwNk7sI2cvJDxnoPh/Jwa8vqFKIolNwWLaWvrRA
         Za1m9ns0gS4dxettR7JOcZoUV9HOkgIs7Ofdp2Sd/JjYosyLdupJUxWk51Zq1oyMD/1w
         dLTbDdnUR83ycqa1pxO6FpZUjI3OjD5J0utmXaHvFXjsOXTDp1wHqCfIiP2rD3lT7MEz
         +wG+MrXGY0200rji4FG5BFdvkwtwtN4oadtvicxRNvpuvCypHHx3lvgqWtsgveqW90AC
         2Txef2PAcKFHKg1otFZIVfn4x40HgWIqFedh6+CRf4L8mJMOG3tttM3JctHaXzIs/EpT
         D+hA==
X-Gm-Message-State: APjAAAV0Fq+d7+ckW3M5/VP9kExLmUCmpr+qXOgY/Oo3kGtf6uj8hJ5b
        5C8ioywHP3tib4T7wfCu/deB+A==
X-Google-Smtp-Source: APXvYqyhV1eEt6chsop8uJjOJ+wfqlGOQH4zCm2/kWX1Rwv0owrFJMOClqEdxV67K+VYlA5QFhd1RA==
X-Received: by 2002:a63:7c6:: with SMTP id 189mr6257276pgh.247.1556834071704;
        Thu, 02 May 2019 14:54:31 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z9sm239392pga.92.2019.05.02.14.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 14:54:30 -0700 (PDT)
Subject: Re: [PATCH] block: Fix function name in comment
To:     Raul E Rangel <rrangel@chromium.org>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20190502194811.200677-1-rrangel@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c620d95-0194-eaf1-f492-62716e188efd@kernel.dk>
Date:   Thu, 2 May 2019 15:54:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502194811.200677-1-rrangel@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/2/19 1:48 PM, Raul E Rangel wrote:
> The comment was out of date.

Applied, thanks.

-- 
Jens Axboe

