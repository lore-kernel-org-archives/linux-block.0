Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429D7C282CE
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 18:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB4F2146F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 18:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J4QopgTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbfDESBB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:01:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37319 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDESBB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 14:01:01 -0400
Received: by mail-io1-f66.google.com with SMTP id x7so5741054ioh.4
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+NDSRx5h5x+TfG4bSns5PJZMQKSAxX5BnzBxZnj70YA=;
        b=J4QopgTzxefhwc27/eqj1K3dY6iHaaoQO/ASitMuMh6EVkD0sXyXRB5nNmDKCBQYFr
         Nn2vKbZRvJsVxYhhUfFb5AOSz7GKP8cTQLEy/83+95WMU2kUa93OF85HnYkIANozOfAH
         ZernX9Exkqe39E2Mdn/8MFIk75JDuUU4D+aZFSzM7EGm/1grxd8dq5p6TafcvKc6xRsM
         M3eDLrQIftbnM4r0bRsJSZ8uzMN+LRIjvmkjOheq0LKGE8Ezf9vsurWLs0izWWS9p8yP
         uUbvVimaL/oYoKgWfm6MNz9k2p3jSy/2xPv0SteGRkrx+9GDxkMo10BubuYypLPrezB9
         pNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+NDSRx5h5x+TfG4bSns5PJZMQKSAxX5BnzBxZnj70YA=;
        b=Uc2S6fsj1/HDs+i4ENJPF7/nbaaSR3wq52QmAvqHP+W0088Iyk9KN7QF0JVgz6QPDS
         lDlqMlsHDHlfjg7kw43lhmJmsPYprDrLXak3efOMXiDCDPhABr3kz3wlMdwANl9HS9LG
         NVntS3VLvqqOUG4gu4M4kI4iSNjXk/adVU1qavzdCzoZ7Q3kodmGWLzSPE0mh0aFeLoW
         H0MNxZr20a0n6LKf3xKUf8L1rnc03zXWUU8djeoJfPH4T/CJF1LGMjsPJJwrprZjcuB+
         SKM3I4i+ciMHdkk+3nuDOq7QLcRQQ9XpYeLhePSwH4IdoqYppDAQjgYQ/ISYYnRC0laB
         MmWQ==
X-Gm-Message-State: APjAAAWpogjXS09iewCrg6HGsKuR/YtcgQB0ZLQebuByhVqZ35agBqTw
        3o5uhIprOLmPvqFE2QVVny2xpfows1+F+Q==
X-Google-Smtp-Source: APXvYqzmtNedjjz8k8qBQ077Zig66RaX0gxWoW/oIoUNzCDkFe2YrA9adnsi82XWiCBNhqMO2HvCMQ==
X-Received: by 2002:a6b:f419:: with SMTP id i25mr9107514iog.216.1554487260312;
        Fri, 05 Apr 2019 11:01:00 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q8sm8641376ioi.33.2019.04.05.11.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 11:00:58 -0700 (PDT)
Subject: Re: [PATCH] block: remove CONFIG_LBDAF
To:     Christoph Hellwig <hch@lst.de>
Cc:     torvalds@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190405160859.5288-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <802e6ae2-40b2-8f46-fe9f-1277bf55d50f@kernel.dk>
Date:   Fri, 5 Apr 2019 12:00:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405160859.5288-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/19 10:08 AM, Christoph Hellwig wrote:
> Currently support for 64-bit sector_t and blkcnt_t is optional on 32-bit
> architectures.  These types are required to support block device and/or
> file sizes larger than 2 TiB, and have generally defaulted to on for
> a long time.  Enabling the option only increases the i386 tinyconfig
> size by 145 bytes, and many data structures already always use
> 64-bit values for their in-core and on-disk data structures anyway,
> so there should not be a large change in dynamic memory usage either.
> 
> Dropping this option removes a somewhat weird non-default config that
> has cause various bugs or compiler warnings when actually used.

I'm greatly in favor of this - but can we drop the defconfig changes?
Not strictly needed, it's not like they will cause issues with the
symbol still being there.

-- 
Jens Axboe

