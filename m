Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A0C2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 18:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AB422522
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 18:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M9Vgqe1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgAWS7N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:59:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38582 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWS7N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 13:59:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so1738290pje.3
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2020 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hAqWpJ1NuJTGK5OF4DpdL8tVTeFlEZehO0INBb+L18s=;
        b=M9Vgqe1fI4i1vkrxFL94iqUTtEMBkNNpQs1Jzc7292AqRfj9q/5vvSUaw2jVl5Ghyz
         tTJrd0Ilejp/eyhwIfFLkzi5V2FBdZgW5PMuUSJ8jSuzgZ1TeO0yenU8WQJqhe3+mKHz
         t0XknWPJgsX/ni67qERPzuVT0b7IABVBticzPrv/0X2ZrdPrD3gFfRWrXCuFjlHjjg6F
         URB+1y9Q4a+zaR+1DX9f0oM3BMINDMhZFuN2+WT3zurC4b3cYpvkz2SdXueZNvTulPTf
         ZN4uwHr3mbX3gAfsFyjfFnK5bDIiPmAEKlcSdpXVCfw6Qrts/CICt4bYicizXTmrFKch
         O6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hAqWpJ1NuJTGK5OF4DpdL8tVTeFlEZehO0INBb+L18s=;
        b=IQWL9V0yR20Wa58/9vfOQ9ABSMAdgPo3JoU/g6rC5zh4NdyX3I5K6IjQuhfcJn6UeF
         JvtvakPXThi8TZ8sqofmhET+cu24nqBuLwcrDZfKIBOhyaiHhizIBAfM38PkkowhXvlc
         PUnapEG25J4olt/pib4kvWwupXca3VbJHJJwvVkzEzMezRSx8KyZY+YCb30YQFf0XVeG
         fTtGpIHLBXFoAhKDAnGgisdLaLw5X//XHzww2KctFHw/ul+d/dswrigWpMO62dGugZLq
         y6U6EzBW6mvyAQjouoYAHMBFkluNKf/7f3mcl5IhTYETft2rBZQnF6mHV3xB2pQtfSkT
         LP1g==
X-Gm-Message-State: APjAAAWnfbtlTgB3Z7AcwYwP+tI3tAfFPPtaQGI7h58XSMsJnYn/coED
        QyZ8hcaq//hvI0IH9jVX5mI6Xm1Y6+zyrg==
X-Google-Smtp-Source: APXvYqyz2oXSsDtYYv3RSa6VA5HhqPv2N44KU2lqJNVnXf6/2pcJ37hmJrAs7TseU0myONmwtXsu/Q==
X-Received: by 2002:a17:902:59cd:: with SMTP id d13mr17953917plj.146.1579805952557;
        Thu, 23 Jan 2020 10:59:12 -0800 (PST)
Received: from ?IPv6:2600:380:4562:fb25:b980:6664:b71f:35b5? ([2600:380:4562:fb25:b980:6664:b71f:35b5])
        by smtp.gmail.com with ESMTPSA id v4sm4123577pgo.63.2020.01.23.10.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 10:59:12 -0800 (PST)
Subject: Re: [PATCH] Adding multiple workers to the loop device.
To:     "muraliraja.muniraju" <muraliraja.muniraju@rubrik.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200121192540.51642-1-muraliraja.muniraju@rubrik.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <88d16046-f9aa-d5e8-1b1c-7c3ff9516290@kernel.dk>
Date:   Thu, 23 Jan 2020 11:59:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121192540.51642-1-muraliraja.muniraju@rubrik.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/20 12:25 PM, muraliraja.muniraju wrote:
> Current loop device implementation has a single kthread worker and
> drains one request at a time to completion. If the underneath device is
> slow then this reduces the concurrency significantly. To help in these
> cases, adding multiple loop workers increases the concurrency. Also to
> retain the old behaviour the default number of loop workers is 1 and can
> be tuned via the ioctl.

Have you considered using blk-mq for this? Right now loop just does
some basic checks and then queues for a thread. If you bump nr_hw_queues
up (provide a parameter for that) and set BLK_MQ_F_BLOCKING in the
tag flags, then that might be a more viable approach for handling this.

-- 
Jens Axboe

