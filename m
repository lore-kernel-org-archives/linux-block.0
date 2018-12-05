Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AEDC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03E020989
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="trKiRHFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03E020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeLEUZv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:25:51 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50586 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLEUZv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 15:25:51 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so23525645iti.0
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3xGilgYtM9FXfWKPwTR6omtunFRVZV25qn1pfInbAX0=;
        b=trKiRHFU4u6QhHNDMYkmO8Y60cGsJd3b8jQmpKKirRIp4I2rntOewyXJirRAF7Rvxf
         M6Qot2pZFd2T67h2AGV5ILWohWK37jgqBorFmngeLgaSfDsQivHvGocUq7BHtt+dD9Q7
         c8l9z+6f856kG+c8Lk3gSHLEHE9Xrgjw4eCDJ6xV7eA6n3QURF6+YBgbQs5J7ijwycrg
         Ztif/W67XgGB+E8VuszMCybGozGNwQmxSLdE336dA73nrtUvTV+L77masCY1OkQP0E1q
         at1ODbATjzv+gHO9r3e65JcAgBXfDjAii8SJWJnoNmmZf6ZF8TWWn4mIcauZskj6ysVp
         Fs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=3xGilgYtM9FXfWKPwTR6omtunFRVZV25qn1pfInbAX0=;
        b=HYgH/+CxHeVVqiuWBF6Dy07CtTrX8CMTTSIdrYAOEXLcF20yDkGzvllCTp5B1FuRJ4
         8EdS/uLRTzexwJBU+lu92UIeOhsxcpz60Iy65FR3VRLImMZjyQq66RQFafL0y+0xLSoJ
         +GMAak4FWeULQ0KpDboTd31TtOGckWNpF/OQnB7hy/fIARE8R/Xg+YwjTVRXox2R7ZVq
         b1SHy5u+Q6rl+k1SbRjr2XIUvyjCHIx3mytCf9lxgJlR3LklNIyJXBIeqLEmDxT3HC7i
         tGfeFWXWY+Hx9MTZgWaX/m7iyaWlJxyyCWKVkkrSB8PSkBHY3ce6lIbtIad5jtP8D4ts
         jbwg==
X-Gm-Message-State: AA+aEWYC8p7E6oKLWJj62kz/yQJoRVNMmeekEGuzfZ8mw/AHwgQdt/hV
        PvCvzBt3egSbo3DL4Zl1mtsAY5kvdno=
X-Google-Smtp-Source: AFSGD/U167xcddo3YJZ45z4B9J+fBgISz87R9ieUTgQ+9370IWr2fCWYR2icTt4KGzL9H82Yiws1hA==
X-Received: by 2002:a05:660c:b12:: with SMTP id f18mr9145207itk.118.1544041549913;
        Wed, 05 Dec 2018 12:25:49 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w26sm8319960iol.60.2018.12.05.12.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:25:49 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 4.20-rc6
Message-ID: <4c60c846-1423-83e2-1795-b94c7f569920@kernel.dk>
Date:   Wed, 5 Dec 2018 13:25:47 -0700
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

A bit earlier in the week as usual, but there's a fix here that should
go in sooner rather than later. Under a combination of circumstance, the
direct issue path in blk-mq could corrupt data. This wasn't easy to hit,
but the ones that are affected by it, seem to hit it pretty easily. Full
explanation in the patch. None of the regular filesystem and storage
testing has triggered it, even though it's been around since 4.19-rc1.

Outside of that, whitelist trim tweak for certain Samsung devices for
libata.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181205


----------------------------------------------------------------
Jens Axboe (1):
      blk-mq: fix corruption with direct issue

Juha-Matti Tilli (1):
      libata: whitelist all SAMSUNG MZ7KM* solid-state disks

 block/blk-mq.c            | 26 +++++++++++++++++++++++++-
 drivers/ata/libata-core.c |  1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

-- 
Jens Axboe

