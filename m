Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF08C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B8B20811
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 19:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MfBobtSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B8B20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeLKTXj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 14:23:39 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:34823 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLKTXj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 14:23:39 -0500
Received: by mail-it1-f181.google.com with SMTP id p197so5813341itp.0
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 11:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rxqHnGm9KbigctjtimCbVONrpX/zPYLzJf3B8c+9R+0=;
        b=MfBobtSfFUhobmoHqpue+uQ1VqruREXDXk7E2Eje7gEiqW+VHnyE+YfnRg6UfIyMMg
         Pm/2cJ9Be313tfPBMVTsHhwl14t8Gmv7XI4mxm/fSjt64JHdsrcO13eDk4uWcgUF/d6U
         sLr7i7R7rvRFW9O56JroQNU76klV44qPtFqPtG6GSn49aZLX7RnL880Riqxjgd+3i3Ns
         BMeOMYrVRZrgU0ynSgTo9o+KJCxhAPut7KoTjEGZj2pwc3gQJxuNbjBCd8J62qhCcjBp
         FIzHvo5+nbWxdv1yE9mJhcf6fxbBkE7fSwOTBlBFuiB8h3PsJlQBjclBQMrYrC9L/1WQ
         RFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rxqHnGm9KbigctjtimCbVONrpX/zPYLzJf3B8c+9R+0=;
        b=CautOCjdb+uouUWybAWSuo0dBNVqOsSlJJhST8+g4lG25qCGAsnYiX3v/m1ypnRjKw
         v3nCtpzQjger8LgKJ42YwyqBgIKnSN0PW6qp9b0Fwj1tayTfIRmz82IzyvEIXU+Ff5w4
         qsM9o0Mqk/GsTUB2nuJTZfw8tc0VKtGPlk5rYTKFvUjC9ipAvhpuuz9oKooqSbq4HWUE
         yK2xChjuUEVsHe2eJZLq/Kn6GRZ0WgmdhquKs408e7SlBM5ybo7dP6wJSlmSYhbeGltg
         Sf5fUMK+J7SzZS3nH7njcpTYS+securA4oDTKIS9FX82B2hlm0ZhWv3RI/FmN2WX2u39
         so9Q==
X-Gm-Message-State: AA+aEWa28Onjr6YDgZbYjgdTxrBV+RA6bsUSuO9s9eggvKAXgO7XFnuf
        xLwfqt98rOjWhyKMA+zniLsavQ==
X-Google-Smtp-Source: AFSGD/WFXXRGnvTtZ1DK1Q+C13mT8H17iq4q643nygZmUf8Mebhs6Wau3znIw7L6D2p777FaYEOU2g==
X-Received: by 2002:a24:5084:: with SMTP id m126mr3227482itb.100.1544556218585;
        Tue, 11 Dec 2018 11:23:38 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k64sm1745209itb.7.2018.12.11.11.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 11:23:37 -0800 (PST)
Subject: Re: [GIT PULL 00/21] lightnvm updates for 4.21
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181211191627.15542-1-mb@lightnvm.io>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <97c93914-4fab-fedf-761a-39e6b2fd8dc4@kernel.dk>
Date:   Tue, 11 Dec 2018 12:23:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211191627.15542-1-mb@lightnvm.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/18 12:16 PM, Matias Bjørling wrote:
> Hi Jens,
> 
> Would you please pick up the following patches for 4.21?
> 
> Changelog:
> 
>  - Igor added packed metadata to pblk. Now drives without metadata
>    per LBA can be used as well.
>  - Fix from Geert on uninitialized value on chunk metadata reads.
>  - Fixes from Hans and Javier to pblk recovery and write path.
>  - Fix from Hua Su to fix a race condition in the pblk recovery code.
>  - Scan optimization added to pblk recovery from Zhoujie.
>  - Small geometry cleanup from me.

Applied, thanks.

-- 
Jens Axboe

