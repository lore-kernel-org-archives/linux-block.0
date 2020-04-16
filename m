Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139FFC2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 15:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E378B21927
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 15:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xig6g/Wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395278AbgDPPaN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2395275AbgDPPaJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 11:30:09 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15995C061A0C
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2020 08:30:09 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 19so5576086ioz.10
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2020 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bgLKTDMc966pLZePK7Gy4v5POGBi54ywnFTq5rJSgzs=;
        b=xig6g/WfEF6trkg+0bcPLBXurHgj5BTteF/0bBs3S1SiPTI9eFkmsiah/l6oXRYuc4
         zkslZZdVvLAWgF0iEVZIyTeaxPgYk0LncDabFx/Kt7CGJC0/Wcztp1H/XH7BCabWb2Li
         +3iteA8k8S4RTWplvYBrO8hJ9kQIVhFywXE3gVg2U9sjyHWhwQTswfZut7DE1JL3jYzF
         okcX8eMj9A7MTPleU1A+uVJD+E8ajXhwpEK/djVcnI5BC9ciULzrr8zoBF6Qi2bWBJLC
         J92SSWGu9sUk3rF/7qe+Hw+ct6OCLF373Xl5/deOMRiBil0k4xNutPCfd0ZT0SBfF5QU
         PT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bgLKTDMc966pLZePK7Gy4v5POGBi54ywnFTq5rJSgzs=;
        b=GBc5bS+8Q5cv9ZTm344UNWIJ6fxbOsOWfZMqafHN0UB8QN04d3Ox+yjKx83q10VB/I
         e0dVYwW5i2DAsCuITuyDmFPegxYJAo64s0KrM2B+GL3S46p92WN99UDEfvPeNncpFCeL
         q8onEIU+0EjwYEUpnSMdY/AB9ONHc5kOGr5sIEUh/xWwpFw2189JaCltu99xDE3FYf/x
         e4Vpoqip14oxSll0y5CMScJpKfmYdPkwQcEG83canw8MJ/y0HMzmcXnyhNAcVqOihYek
         1HVP5fquDpOklS+g78Kj6SqYWdbf5tqOdJj/jZBHvdB/tRKFlJLkNxrcy2g/QNQx13Fg
         +qAA==
X-Gm-Message-State: AGi0Pua3mczlROUeGulMbWwLr2YVNESKB7uT6/Px+mGZT86vvf1FIold
        avNxVepy6/f2EX346ZFJ2DX3ww==
X-Google-Smtp-Source: APiQypJ3ogc/LftQFKCcQO/enKyIUEms8Z22MlRj0HPuqyykMQA7qtclm9/YE48pZzjgb3iq7VFBJw==
X-Received: by 2002:a5d:8f02:: with SMTP id f2mr2254689iof.55.1587051008389;
        Thu, 16 Apr 2020 08:30:08 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a19sm5725806ilk.34.2020.04.16.08.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 08:30:07 -0700 (PDT)
Subject: Re: bdi: fix use-after-free for dev_name(bdi->dev)
To:     Christoph Hellwig <hch@lst.de>
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200416071519.807660-1-hch@lst.de>
 <874d57cb-90f1-db09-8f9d-29527451e241@kernel.dk>
 <20200416152946.GA10845@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca7973dc-3be5-e482-900a-1018a0762b93@kernel.dk>
Date:   Thu, 16 Apr 2020 09:30:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416152946.GA10845@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/20 9:29 AM, Christoph Hellwig wrote:
> On Thu, Apr 16, 2020 at 09:29:13AM -0600, Jens Axboe wrote:
>> On 4/16/20 1:15 AM, Christoph Hellwig wrote:
>>> Hi all,
>>>
>>> the first three patches are my take on the proposal from Yufen Yu
>>> to fix the use after free of the device name of the bdi device.
>>>
>>> The rest is vaguely related cleanups.
>>
>> Applied, thanks.
> 
> Please hold back, we still have a major issues with it.  I will resend
> a fixed version tomorrow.

OK, will do.

-- 
Jens Axboe

