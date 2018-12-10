Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B6FC67839
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 20:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E1E2084C
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 20:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KC5fPuDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E1E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeLJUh5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:37:57 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:33297 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeLJUh5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 15:37:57 -0500
Received: by mail-it1-f169.google.com with SMTP id m8so8955538itk.0
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 12:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=66gKwcVrFoutyQG8o37NMsSe7yrPyCp0a44uTBfIufg=;
        b=KC5fPuDd3Xk5yj+3qqWTWPWnHFi3eQD//m19HZhxnd+gAArZJLlLqf71W2VCrPoqYn
         STziNNnpgrygKAvfvgZVmGMEvJ2FzBhLPpzfMtTJOISAW4i/LDGgNMb7xws/Qqs24w3r
         JajInvGVSmfx84+bab5S1pz+YhECoIsQx3N0ZavpFtm4swDnq3WmNl+DJw+r+R2n9Jrd
         mz/zEGmtuony1k4BCHV6ebnaLI5nExjmz0OxsIx2V/2d3qK9szFk543mUNkHVNZXGtHK
         VvwGOBsRDwgMkGMyLKXhUrjrRXQrouOjiCwq/bVe4+QBs1Qdvvy0Z8a/QLOSxxw6xxb/
         ZsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=66gKwcVrFoutyQG8o37NMsSe7yrPyCp0a44uTBfIufg=;
        b=h7QABjppMnL9HcL7Gfb8D2t7Jy037B18Hbe/KGUAGPr+EBpX5NgzkSNLdSp+JEJGCM
         QQaaLlNam2aBDhS1jhqqaa/2QdaLYQW4F9FhfjQ2c2XlsHuLqAaW9AwIoyyBQt6Lfh4v
         S2Sph7pFw+NTm9Pd1UuTadC3930IOGauHYsx6nfyVY2VIV6zZwmdVHZvCLum3OXsJx4n
         sS4LskZ7fPd/bCFVYQC7SOEnulQ60CGtsd2jyZUP4winphLvt2sXs9KhuEeBZCjQ9W1W
         2B7IVdsv7R/eCWdWTy7bnucb9TPr03GHMN23RgrJs7vex3KgtLlyu8tuz4qG+vALhLEg
         EGjg==
X-Gm-Message-State: AA+aEWboj/GFwhHzMq9na1hF0XlVayAGi4px6JXtxRzQ2wBCh8k6cFUZ
        Dd24o3ur/pqC8InXZEjl0QMP0g==
X-Google-Smtp-Source: AFSGD/WJtEv/ub5ZUIHdMnOHRhj11RsdfErjn7DvDJdKZo6ca1T1bTznZRuK0PZdzyNSN8qhVaBpTw==
X-Received: by 2002:a24:6c12:: with SMTP id w18mr13789305itb.14.1544474276491;
        Mon, 10 Dec 2018 12:37:56 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s13sm4690616ioj.0.2018.12.10.12.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 12:37:55 -0800 (PST)
Subject: Re: [PATCH] block/bio: Do not zero user pages
To:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
References: <20181210154442.7772-1-keith.busch@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3344e39-fe22-832c-208d-02e742da8fc0@kernel.dk>
Date:   Mon, 10 Dec 2018 13:37:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210154442.7772-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/18 8:44 AM, Keith Busch wrote:
> We don't need to zero fill the bio if not using kernel allocated pages.

Applied, thanks Keith. I added Laurence's Tested-by to the commit.

-- 
Jens Axboe

