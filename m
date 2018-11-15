Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C94DC43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 01:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63C9214F1
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 01:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kYWGozDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63C9214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeKOLzy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:55:54 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:38261 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOLzy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 06:55:54 -0500
Received: by mail-pl1-f178.google.com with SMTP id p4-v6so8673748plo.5
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 17:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ydy9PAOX0bvSjQe3p2AUQ6FPZYdf3i0kQ/PcqZeUZKM=;
        b=kYWGozDoFDJvr8OTWNCXJh1PtEwpI5J0MhPzQ4YYHt1R/w/Mxd+WdE7lPd+ELWvji4
         xRqc7qaqLS7Z5vxYEXmriKaIgrHgptUx9bk4AXUm2L+WqbkGM2hCMbY3+nQUAtiQnuKM
         z6WXbt+AjkmjGSwrFoxHvttN5NNyWgkrGhdUedCVyEL5O/p8f+mA/IKq5n3eqMe95VCL
         uLrlwBXaP5zlEsGaSkXvVqw99t9usjrV5EmCfugMiRWzszDtyTwypHy3UeQsrgtFY13s
         /o7I6eeFYOQfois70UwSIHaNYzBQR0OoPExjtkmc+MtbCpdgQPpnUGgyucbJy7NtmiB3
         Vnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ydy9PAOX0bvSjQe3p2AUQ6FPZYdf3i0kQ/PcqZeUZKM=;
        b=Ji0dAXaz8RjCvGuR4YrKPByNfLEayCaEkHjJmhu2tmm8FhWP0Tj4d1bp4unYRq6o/5
         NN2Hh+4D5Ow5ABP0I3TH/T16X7Uity+g52uOuer9MtKcZZ/DfgYFIeDr4/XpLbLTG7i5
         FxBEGntWh9ilFZxPSJBj8oRwwbi1tlPwm/iyNhPpf6zCT4CUMLhR9SMY3J38mKiKivXv
         xzNt/wtl9h6OWRPvUgIFMgR0jZ0buVuiYwOI5PXznLfEKHqUtrLFKF2U2KFoTPvwdBlF
         Mt3ZTJJ+509WIDV+Egz0HAPT/B9lWBGKDF1od8SEwIvYBJMi0kzisqLGKiMGEF3NkqhD
         fQyg==
X-Gm-Message-State: AGRZ1gLemimn/BdRfbnTzxpeSvNPN7jZU9nc5DVXSJWC5bqn/1C6aouO
        4MMJiP/h147vXVasau6S3Cmqm8xu118=
X-Google-Smtp-Source: AJdET5epIJjeIIqfmL0KfBhdFpMw+dzblYjEA4eWE04kvo38JWuCAhpTpJNH7kOT0ues2Z7jhSnShg==
X-Received: by 2002:a17:902:112b:: with SMTP id d40-v6mr4346331pla.48.1542246607784;
        Wed, 14 Nov 2018 17:50:07 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 186sm23454294pga.36.2018.11.14.17.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 17:50:06 -0800 (PST)
Subject: Re: [PATCH] block: make blk_try_req_merge() static
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
References: <20181115011946.123485-1-ebiggers@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <46236046-aa9f-05aa-679b-22295aa3341b@kernel.dk>
Date:   Wed, 14 Nov 2018 18:50:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115011946.123485-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 6:19 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> blk_try_req_merge() is only used in block/blk-merge.c, so make it
> static.
> 
> This addresses a gcc warning when -Wmissing-prototypes is enabled.

Added for 4.21, thanks.

-- 
Jens Axboe

