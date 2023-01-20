Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFB6C05027
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 15:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjATPJW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjATPJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 10:09:21 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D8C41EA
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 07:09:17 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r71so2575945iod.2
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 07:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/R9KZW2ypRwSFYmNL3DdGEYqt1RnjYffMb7JhYlSXM=;
        b=UfMaYiIiaMMe9NQYNKdvlcBwHZjsGmkTJkAw2JgQxng/BX3fP7aJ+Z2hEhKuS9rvUs
         57CvIFeWZYRAKV+EFOVGICIGM8syssDzylE9hvwO9FWsSSGYkv7nCDLss6GcNm2SK/eK
         O36O7CWmUvYR29RB5c728FcWs6ikE0OZ8HnWgXqfPDgysK40Pk5XXa5edK5L3+f/V9ld
         THbBqzyqJ625SoWFlP4QbH+wLAQ/tDGaA5yPc3wCMQl/rnQLHr1YMSiHsdNc6Yu+78l0
         yWr+6vTRXY+UQdRwlrdpAA+rjA6CKpWvPH5APyLadwAuMVqQlN7Ziiv3f6pjGdl6jOag
         ghTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/R9KZW2ypRwSFYmNL3DdGEYqt1RnjYffMb7JhYlSXM=;
        b=459v4C3h/ch3sbkD1wp3RhUtvtn8BLVRbivd3SRr+iw86bG2OziX/pVTXqTS+wJ6Zo
         Bkc64j41/YQ1z8t7z5Geu3L2Z6sIPhiAqWbEAm+wEKHD8PkC1F+BW8EteK1ptEd0L+dJ
         vxC2ioZljgfauVI09cj87y/oB355gup1KsMHQbeubY0ChHyXQhT1CXzLIkgz31tczvyj
         cJnur2rbfIbO3Hxstz9mcIySDgrMA6lApNZP1TBbgo/uN531WErPXmtJWKQ5TtAuxVEp
         CEQ4gJrXtGGAcIvqLPvIXgkuXXOwRVL+Ot2VO2HYaMj7SaC7X7nE2Ux05RNL1Wv8JmBE
         7ojw==
X-Gm-Message-State: AFqh2kqlA1hIVnfAz6lI69mkNi+AdpE4YSCHErbxw903rglYpjEdQdPQ
        5WCZm7HRq4iJB3ISRcZrMSwTTqO9CYEppQMB
X-Google-Smtp-Source: AMrXdXsQblyHcEqK/fT04ILN7rk3rYlA4Hz3TToRbe+MU5lipN5BkyBWLq5KUz0L4UNQ/vmjbYWIXA==
X-Received: by 2002:a5d:9482:0:b0:6cc:8b29:9a73 with SMTP id v2-20020a5d9482000000b006cc8b299a73mr1897192ioj.1.1674227356776;
        Fri, 20 Jan 2023 07:09:16 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i13-20020a0566022c8d00b00704d3db650bsm3050076iow.46.2023.01.20.07.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 07:09:16 -0800 (PST)
Message-ID: <1cdd9e67-c62f-6c41-1308-5dab525e56e6@kernel.dk>
Date:   Fri, 20 Jan 2023 08:09:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <Y8osKhxLSgeKMrSj@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y8osKhxLSgeKMrSj@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/19/23 10:52 PM, Christoph Hellwig wrote:
> The following changes since commit 7746564793978fe2f43b18a302b22dca0ad3a0e8:
> 
>   block: fix hctx checks for batch allocation (2023-01-17 09:56:52 -0700)
> 
> are available in the Git repository at:
> 
>   ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-6.2-2023-01-20

You really need to fix your script, I used:

git://git.infradead.org/nvme

as per usual (with that tag).

Pulled, thanks.

-- 
Jens Axboe


