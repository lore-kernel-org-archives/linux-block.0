Return-Path: <SRS0=4yxV=O7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F038C43387
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 17:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3E321939
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 17:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TVpc/jn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbeLVRKx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:10:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39593 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731640AbeLVRKx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Dec 2018 12:10:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so3903260pld.6
        for <linux-block@vger.kernel.org>; Sat, 22 Dec 2018 09:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9DFmUPgo51Q0v2TKOYnu7GJg/pJ6kGrcS5UCGyLFDBA=;
        b=TVpc/jn3mdNfuwLgT9PXmAE18hClNi2qQQdHCSkZyBfQ0mrL2D7Zf5sFlyGpmWY+q7
         CI0zxYMNdKIImsGKizr07wI8w/o8eyAVAGoN58shS1ETFXsN3qh4zhlQlRYU7lp0CLIz
         gtpksL94w8F4LrjGtNVVJY/z8aCA1mPxDVXkc18Nj1Hmh51I9o7jYrTiz6okMsAnvTye
         A0B5rhlZyPa5gxULxqhqsw3NYNmE8qVHpP9vG9lB0rYjLuPnP0F7Qm7YMZmmarDUC2Gm
         W4VmVMrn0CB/mnvRoMJN1xRQGGX537SGUsq6DhEtNV9/Hk3tEIwyEyip99hSXY+AgX6L
         r/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9DFmUPgo51Q0v2TKOYnu7GJg/pJ6kGrcS5UCGyLFDBA=;
        b=h7jnekpFPOKsfnggpnDO2gPqLAQ4SxCFH/Lo8XHBf6rRA7Q7GqAvHcwLI2aiyZlSZ+
         jPcguArZyF+jcHQPX/reA9pgi3YSwsj76KEbGtNlysl8ka+6rrZYKVI7dkBZ48onOh+d
         B6KiuuGT/LI7YUgiEaRB0KoibFvtx9ta6rTSsQQ8TvrB07/k1awAm/OTH410kHHZlXNg
         vNg3wOYGZzc3W05khrdvt4mMzjeyWlNvlWqTtQxLUPwD61M+FXKYBno566STLQ3dXBHF
         ZVfwGaSvtSDsPSeRpJj0orutHjCNQatU46hgCJuoqHZz8KT8uhbLHToYQIGDYEcLPWKf
         F4yQ==
X-Gm-Message-State: AJcUukdvTCY3T5j7u/O6lBoNOEyl/Y75BenCaQySDM/liV6WS1GRTGN8
        3P5P0qQ8dwx5MaaiVMar83gTRItErhPT2g==
X-Google-Smtp-Source: ALg8bN7eBsmB7uxnnep7A3UFMXpJyDQ6w9ziWb78OuCRtk8MizCbSTH8ThCyHVOuuei6I+YVIR4LHw==
X-Received: by 2002:a17:902:48:: with SMTP id 66mr6646902pla.68.1545492356273;
        Sat, 22 Dec 2018 07:25:56 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v2sm33952341pgs.0.2018.12.22.07.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 07:25:55 -0800 (PST)
Subject: Re: [GIT PULL] Aio changes for 4.21-rc
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <947a6dca-5ba5-c8ed-8e64-3cede8fcc028@kernel.dk>
Message-ID: <df71c03f-9cf3-ff21-8d8f-625bf3855cd6@kernel.dk>
Date:   Sat, 22 Dec 2018 08:25:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <947a6dca-5ba5-c8ed-8e64-3cede8fcc028@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 9:05 PM, Jens Axboe wrote:
> Hi Linus,
> 
> Flushing out pre-patches for the buffered/polled aio series. Some fixes
> in here, but also optimizations.
> 
> Please pull!
> 
> 
>   git://git.kernel.dk/linux-block.git tags/for-4.21/aio-20181221

Linus, Jeff sent in his tested-by for these. I've amended and provided
a new tag for you to pull, so you get his too:

  git://git.kernel.dk/linux-block.git tags/for-4.21/aio-20121222

Same diffstat and everything, no other changes than just commit
message. If you already pulled and stashed somewhere, no worries.

Should also have mentioned that I forked this one off from
for-4.21/block, so you probably want to pull that first.

Happy holidays!

-- 
Jens Axboe

