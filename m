Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDA4C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 23:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62B920878
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 23:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N4DNw4xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62B920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbeLFX7J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:59:09 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:40525 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbeLFX7J (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 18:59:09 -0500
Received: by mail-pf1-f179.google.com with SMTP id i12so967651pfo.7
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 15:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=azV8kCeuRaTdhQKYTUfb8cvz86yKXk+0K+sthXsfeq8=;
        b=N4DNw4xuo9wPzbGoZm89iMg5s+s/ePeYr8JWFQl/LVDA1Z4rdJ1B2UN9j+ZLoYBnzH
         m22HoZ5kyzjb57RXlBlDLt01Vaz3I2gCE7/sik+O1u63QlyyHAd9fJlNbGGWCLsOA21S
         YTYsh2kUlcPKs5c4t42FXNHsH5m9AYdjQu5UErbYOPT8jexq/kkd0U62tiSVwg+2b+6K
         uBirkZuBniAIN1Q6wABchJJsRs2jfYnWdP1lNk60EXB+7dkjutHBsci9+VC4k/IU42Pa
         qlrjvlpL8iRSIb5qOumXNhSq1Pqa/5toBzC+ctNeaYlWstV6nYY99x9pxVVzzw44vWPb
         vtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=azV8kCeuRaTdhQKYTUfb8cvz86yKXk+0K+sthXsfeq8=;
        b=JuakwUXU/EZvRcT/oe2CllcsJn3Bho6DTN8x2vEE2/E88RVEG+cmmKq9cUxIRdYTrx
         SB9USK/M1ANSVLpNufIhhsFbK/7YUW2KVOfuJPS4D6VMVJEaZDRMGkiouoL2OviutS2G
         p9ntSwIgKVx8AbUxS0aDlwiulIxu+WJw3iSo2FJ5ChvqWFsiL68lEWW2+bukOyGng8Zy
         ckkGVoaOMQX3qzybo1dz+VL61GHYO3AAHTwq0ksUHG9tBwzgRwgqm7t/TAK0xEXL/HMQ
         2c4n34B3vpGf/uN2Zoba/T3/zhZJu928yNZ9inATHulj8VvWo3kKVbr+ycyaFBOjWg4u
         CaKA==
X-Gm-Message-State: AA+aEWax4sRRTvzDISZLD9if5AUmMFTeKMNKi6R3/tF+bn1Z4XT9LImQ
        UY7xprh1LO+62OpxeOy+NgR0g2gCszk=
X-Google-Smtp-Source: AFSGD/WEdaTXuqBC2whOIVUIMMWn54aXzoLtpch+EbbI8HiVkTSwCWbCVop+DTppBhjUcNwDsUfiYA==
X-Received: by 2002:a63:5761:: with SMTP id h33mr25844299pgm.283.1544140747839;
        Thu, 06 Dec 2018 15:59:07 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g15sm6151314pfj.131.2018.12.06.15.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 15:59:06 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Follow up block fix
Message-ID: <fd37a010-d44e-dab7-4e39-059a339091eb@kernel.dk>
Date:   Thu, 6 Dec 2018 16:59:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single followup fix to the corruption fix from yesterday. We have
an exported interface that does direct dispatch, with DM being the sole
user of it. Change that to do bypass insert always instead of attempting
direct dispatch. This fixes a deadlock that can happen on DM.
Additionally, it gets rid of any exported user of direct dispatch, and
enables DM to drop any BUSY handling from using the interface.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181206


----------------------------------------------------------------
Jens Axboe (1):
      block: fix direct dispatch issue failure for clones

 block/blk-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
Jens Axboe

