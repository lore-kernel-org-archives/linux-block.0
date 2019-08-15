Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2686CC3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 19:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1DB20656
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 19:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W/vU/7xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbfHOTbG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 15:31:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46580 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbfHOTbG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 15:31:06 -0400
Received: by mail-io1-f65.google.com with SMTP id x4so1453935iog.13
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2019 12:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0zU1UzGhGpSs42osUb1VwxYmT+F95oS3ySvyshFJEKk=;
        b=W/vU/7xc7p47Vimmqfb1G2QAFDNTCqMFaGRsHe74Wkbx3UmQHnCznpOGppBbaqTWcc
         +VolBhjCxYDeXdliOmI2HmmxY4nH8B8J+UBWDvk+IL36DHmxcQmAU1ln3BX7cctIfCBF
         yjwLo/ZtJOegnWApB777y2VXG2wTFCipZVImeKD1AtIYfliO9cqFDmP8BCzcekMgAXuu
         Zw9Kmzt3+xaa4mJg6S0NR9wwpYJK4FjvLmgDrPv1UWddx0BEpCy/bwkd95d1TrvQsNKP
         JCQRpzjCTHUGnQCc7F0fhTww1+q9U2m4YSB9y9BKNZqZSTOrrvp07VVWalqxEYnHimfO
         wHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0zU1UzGhGpSs42osUb1VwxYmT+F95oS3ySvyshFJEKk=;
        b=koA6PRd0XdJnPJSPZ3GFIl1rdyV6Mkrj7Re6oIRhJgtactkYHdBx+4HBsv2UR5T1hu
         d0ZkIS1uPWUTtC6HDifpfN1tfrT4TVWUlkQOKs1tDLLXE5r/Cx4OXS2DmHNkcRCTs9dC
         t4OQZ/Gjcr6bJWuxozKcjEiBn+Hh7R1uPv4yAb1e/RCA4EQi/BKZaxviQVrYWKYz97qA
         gN2QP9BHES6aZQl0rA83mMlfQqORPyDfbJ+XQ9aaQoxzh0OE33bsa96lFsGTBGNQIUAB
         6BPQdrb7Webu8H0q7jCEtnNeDrW9BGdpk0wiG2caj6naL1gbthSgxaccj8AWSHFUGcyl
         EhZQ==
X-Gm-Message-State: APjAAAWPrLVlAMA7YDvjBUMdSmdI+wJOxP4imECnI1/j3Hx9tfWkg1QY
        A78OV7OqKN5O5Lwq3ZrF8BNuzg==
X-Google-Smtp-Source: APXvYqzqTPRFTBKjlHaL1Hke9CdTLw+pYgxq+9XjlO17fN4eFFBk9o/pg1C4j6n/IYoXtb76mhp+Yg==
X-Received: by 2002:a5d:9448:: with SMTP id x8mr7675761ior.102.1565897465344;
        Thu, 15 Aug 2019 12:31:05 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h8sm2468682ioq.61.2019.08.15.12.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 12:31:03 -0700 (PDT)
Subject: Re: [PATCH v2 block 1/2] writeback, cgroup: Adjust
 WB_FRN_TIME_CUT_DIV to accelerate foreign inode switching
To:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
References: <20190802190738.GB136335@devbig004.ftw2.facebook.com>
 <20190815192528.GA2240241@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ba595b28-3669-d16f-07de-d05c6164dee5@kernel.dk>
Date:   Thu, 15 Aug 2019 13:31:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815192528.GA2240241@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/15/19 1:25 PM, Tejun Heo wrote:
> WB_FRN_TIME_CUT_DIV is used to tell the foreign inode detection logic
> to ignore short writeback rounds to prevent getting confused by a
> burst of short writebacks.  The parameter is currently 2 meaning that
> anything smaller than half of the running average writback duration
> will be ignored.
> 
> This is unnecessarily aggressive.  The detection logic uses 16 history
> slots and is already reasonably protected against some short bursts
> confusing it and the current parameter can lead to tens of seconds of
> missed detection depending on the writeback pattern.
> 
> Let's change the parameter to 8, so that it only ignores writeback
> with are smaller than 12.5% of the current running average.
> 
> v2: Add comment explaining what's going on with the foreign detection
>      parameters.

Applied 1-2 for 5.4, thanks.

-- 
Jens Axboe

