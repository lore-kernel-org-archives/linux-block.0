Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20FFC74A35
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB80A2064A
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 20:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vjC+j6Fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfGJUS0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:18:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32843 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJUS0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 16:18:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so1777011plo.0
        for <linux-block@vger.kernel.org>; Wed, 10 Jul 2019 13:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=D4XvEcbOboHLZqc3XKlmyLSy/pnvEhK+/qNJMBXzBn4=;
        b=vjC+j6FnF+X4oj2Cuo5PteXyba5kmNOz87Bpz5yUaDDwmDzZgsQGLEItII1krT8wCO
         gEdeqktUJOv8CsibtLLxRUztOdeho80sDOvSwS7uTumL1tnQ4x2Yrd72scXPbq7XVNst
         s4ogA+omPEgl9nWKUg4gMZvbxWMUfClZoYSVVgJHJK24vFigOnvN3v2S84DG97b8J5vP
         /GBVaKJbLnR+vwsEQsWTi67VMIZhjmgn1Oho2RLMBxySvl2Tc7Shc3SDwQiNH+J5bp8k
         WAE5yBaeZbaU3rz7yG9yGrIrfKiMUuVlhbLZrWuo7pWr1340bQiqAQXv8qqCxPm3PE6a
         TVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D4XvEcbOboHLZqc3XKlmyLSy/pnvEhK+/qNJMBXzBn4=;
        b=tkIBlOZDQTWiUSzxaWcPkpQbIupDuBziTvcZVqY+MZFiMqaOaOZi3bxVIHxWIW4i8h
         2Ss3wJRBBF2JJMmRMx6muoEdWaPkKH07JdZkLIIUy7UnLvdTeI+yVXdSoKTPEINmMNSB
         g9C4QzK2Kog6sqV/BafeBbdZ375us8jGfpo9uqBjLHifiVKjTmEmC2Zh5PgusCqON+oT
         Pyu/9X8mcCYbI7rJs4sjjfU32amOeuZbZYhZmDV+cT5KppziDzWuED142NedRiCByowJ
         ppAGOAMnGLwspzSxzEtTnWKKfPEXsqOiDbA6CvA9MyVX44lHsUe2zLImbh2btlW8UpdV
         xt3A==
X-Gm-Message-State: APjAAAVlk+b5YYMf9MSxXxgLWlh945mOJAV2Y298/NL9Z99s9pYJ0JnG
        01ixjon6GN//kQIgQ8m2M8OC9MAr4OBh2w==
X-Google-Smtp-Source: APXvYqyX4UXi6y/hY3b9GCwgDfD1D1z1zPrLAGP5yMTjitx4fKEKtw44Z0Iryb7auykASDiySPlmSw==
X-Received: by 2002:a17:902:bcc4:: with SMTP id o4mr123897pls.90.1562789904926;
        Wed, 10 Jul 2019 13:18:24 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id f72sm5553337pjg.10.2019.07.10.13.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:18:24 -0700 (PDT)
Subject: Re: [PATCH V3] block: Disable write plugging for zoned block devices
From:   Jens Axboe <axboe@kernel.dk>
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20190710161831.25250-1-damien.lemoal@wdc.com>
 <c9b5b4cd-68d5-7c29-8f76-ad5b04007594@kernel.dk>
Message-ID: <26e4505d-7de8-5e7c-d20c-3d82b9cff2d9@kernel.dk>
Date:   Wed, 10 Jul 2019 14:18:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c9b5b4cd-68d5-7c29-8f76-ad5b04007594@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/10/19 2:05 PM, Jens Axboe wrote:
> Looks fine to me now, but doesn't apply cleanly to master/for-linus.

I fixed it up manually, fwiw.

-- 
Jens Axboe

