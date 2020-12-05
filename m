Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CD3C4361B
	for <linux-block@archiver.kernel.org>; Sat,  5 Dec 2020 21:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2FB2310E
	for <linux-block@archiver.kernel.org>; Sat,  5 Dec 2020 21:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgLEVoK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Dec 2020 16:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgLEVoK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Dec 2020 16:44:10 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5279CC0613CF
        for <linux-block@vger.kernel.org>; Sat,  5 Dec 2020 13:43:24 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2so2443137pfq.5
        for <linux-block@vger.kernel.org>; Sat, 05 Dec 2020 13:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=YbLMjIQhdEsZF+sagM+1Z43StQBtcV8vHFR13ehX/JY=;
        b=N1QZ7UaX/vI4KIsDomIdMgtPBQST/Y9c2EDHg57fyiN1Dqz5cZOrmGTVpMi8Q0v5Q/
         bxNoDlBKwzQ48eEhTXHfWTRULa1YZGGHKbfzMgt1vDsji5hNhF+ZdyhP8ae4nSEWxcez
         o3hhseUP/XPzZcFlUTJ3+ZNpUgZD3b2SzE/Rdk+4PPk6JOTUEImtL+1rQKJ4LIlJNH/f
         zNLNcCv1310wKJ0D8WAbtjnXVmEnMJfUQKGzPoykSRenAn7LXMgNxLEk2bWueV3ZB+QT
         tMj31QfWakgidMmL/YakHwNDrKKuxzWhGXd9dFn1w3duSO2K/FIXYm5F6RQVT4UAEw6D
         4b2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=YbLMjIQhdEsZF+sagM+1Z43StQBtcV8vHFR13ehX/JY=;
        b=uJx7dZxqpeikjXWDcBep/H3RAdDs6r2qgmvWgzZi4n1bn8T0cjRiajAxjgQwZTtMSb
         D3gSQGIM4qe4ovxDFuVdHWypFPUIDGYQVS7DVv7SeTfrQ13PV1l0yczDllRbGdfQDYMh
         gLKhSnl5ttVyCCy0AeN6TsFBwTvAGgyHJ058F6z/evLaTGQ0QkcQ7UiAe1pddFAGkfBj
         Qn1JmBWpFlyeItwWwqSY1dvvKwNOwi4AdR38m+66PTk1VvvWbSlmQXpIWWu4RLKWqvxa
         cSp14PWORiTsBzKJSw6YKaXR25Q0iMViRsKwaWNIAVPUlmabcNB/EAyI4FG+6/3BJS+x
         VwRw==
X-Gm-Message-State: AOAM532ombbJmV/wzsKbB+/T6I3o7mmgMHrALXBTS241wI4XE/PDZZI4
        KwnpR+WUEdvXcXJx+FAgP+DQyQ/74o6w1w==
X-Google-Smtp-Source: ABdhPJy3viK5R39Ulw50O9CtwGvAi8y8oqmEJx88eUqtoAXpViFY3WQxWWtUShOeZOcAh3ILjrhMFg==
X-Received: by 2002:a63:4e4c:: with SMTP id o12mr12701769pgl.348.1607204603619;
        Sat, 05 Dec 2020 13:43:23 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g33sm7947160pgm.74.2020.12.05.13.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 13:43:23 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 5.10-rc
Message-ID: <cdf79314-f43e-644f-910b-f1738d728624@kernel.dk>
Date:   Sat, 5 Dec 2020 14:43:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Single fix this time, fixing an issue with chunk_sectors and stacked
devices.

Please pull.


The following changes since commit 47a846536e1bf62626f1c0d8488f3718ce5f8296:

  block/keyslot-manager: prevent crash when num_slots=1 (2020-11-20 11:52:52 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.10-2020-12-05

for you to fetch changes up to 7e7986f9d3ba69a7375a41080a1f8c8012cb0923:

  block: use gcd() to fix chunk_sectors limit stacking (2020-12-01 11:02:55 -0700)

----------------------------------------------------------------
block-5.10-2020-12-05

----------------------------------------------------------------
Mike Snitzer (1):
      block: use gcd() to fix chunk_sectors limit stacking

 block/blk-settings.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
Jens Axboe

