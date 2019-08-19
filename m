Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C2DC3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 22:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6971E214DA
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 22:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BaHoxrWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfHSWBy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 18:01:54 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:39344 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfHSWBy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 18:01:54 -0400
Received: by mail-pf1-f178.google.com with SMTP id f17so1984461pfn.6
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2019 15:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rTQ/4aUgGH0Yv5fVn+rCKn3dYxUnSMN1xFaIHfYqJus=;
        b=BaHoxrWZOkFoaJwTRoYXWxvXVqwV7UbNcSEcYBphYepoME1g+xx8Zza/cEtrB+arHw
         k0IPcSJ3qry/nXd9OXT0cWD6NT+neQCaZD7N7ul7AaLU8g8vEkLGNo6sh41ojD8By315
         lDmGCTwmTuQxhf1R3564LzeqoEFYP+oVS7O9zkWGdHfuceeoD81pUalUJtD0Q5/BvzWM
         K8Cv9lNGNZsEXr2wrkPvL9Mw3opgJgPHryfhbGybzKA1bdkUKmjkGRsEwJCoY8kJQdpm
         /YHVyEU2yrXdtpdVVAp2knCH9ptC4IqgRGuvufiYpUjyrQjtoVkr+ZsIhMaZ110HkXqx
         OfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rTQ/4aUgGH0Yv5fVn+rCKn3dYxUnSMN1xFaIHfYqJus=;
        b=A/FDivvTtveIrewpD92iMUDITJM4+zLDl2DbRyEdxNBAdrQND59A84AQf+JLtuisKK
         wBPkFf1/NmSeDcdL/bJ7/RgeyEeUl8NFnMBeFMkRRikBoV8kxHJqlcR2Qig7qR4OMIZ4
         4ALfZ9JYn/KW8orniShfE0/hOEP6Kdr054zkgljuPPtP4IS/lTcZhneKVpDvK7Fy4N4T
         kc+0AicYolngUlis53/SWnXBguL2ae7GR6pOQB5Ur0nbATRdVJsqCfAkgcgtC3pgMkHt
         IzqHpT0fdv+YZzYpdKPwXmIusHLC+t+VMbx8zZuGySfgYp9cn20dM8XZNIy7rEPRMFV7
         jKvA==
X-Gm-Message-State: APjAAAWX280mW9CYgrtj9SwZIdNdmZXyCdT3jogUpvj042QZmj42s2E0
        amNqIQpxI+BlmAMu+YPm52HoDiwCYW3wrg==
X-Google-Smtp-Source: APXvYqxxFUeXBcUf7ObfpnLfADVLWvyQ4+apRipg52lZ/m4Dnxty9oTKbQ7T95eIGVV1iT2D0WylLQ==
X-Received: by 2002:a65:5144:: with SMTP id g4mr22000467pgq.202.1566252112672;
        Mon, 19 Aug 2019 15:01:52 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id w26sm19135774pfq.100.2019.08.19.15.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:01:51 -0700 (PDT)
Subject: Re: [GIT PULL] some more nvme fixes for the next round of 5.3-rc
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20190819215911.28552-1-sagi@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2e55d822-ada3-9b84-77eb-a38085bde489@kernel.dk>
Date:   Mon, 19 Aug 2019 16:01:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819215911.28552-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/19 3:59 PM, Sagi Grimberg wrote:
> Hey Jens,
> 
> Few important late fixes for nvme:
> - multipath fix that prevent possible I/O hangs in path failover from Anton
> - cntlid verification caused regression in pci controllers from Guilherme
> - suspend/resume quirk that fixes a regression on the LiteON device from Mario

Pulled, thanks.

-- 
Jens Axboe

