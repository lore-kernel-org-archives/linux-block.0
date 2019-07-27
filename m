Return-Path: <SRS0=8nuL=VY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77267C7618F
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 00:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450A1229F9
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 00:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t2wtr+Y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfG0AxE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jul 2019 20:53:04 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:36190 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfG0AxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 20:53:04 -0400
Received: by mail-pg1-f177.google.com with SMTP id l21so25509791pgm.3
        for <linux-block@vger.kernel.org>; Fri, 26 Jul 2019 17:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=pBDaQsNPbMngSOGWsxGqOo1v3/WFuFGJRLFYHVAZiwY=;
        b=t2wtr+Y//I93lm4AWDhEExpMUyyTSFp5//Om3GqsLU+uS4pshwOqkkvJOReCwwKlwj
         dS81cQyODNiIIxE+c870k85frdc5jWA6yqdp6P+pz4wfxUrmIDJt6maAqlRikKPuHyOd
         K1lRmOOz9cbtLoYLa461Q6LtHVm3/8/5c/duVSwQNC1YcJZczRn54w9q/JFvcu4StEtx
         6RQlkNX4Gjr0fIYw+gqFEhFaUUrnpQ3mHUWMhcfyAQFslHrrENsdb9JL6XRXHH90m+ZM
         sRfVBifGu4j0minS5pksyMSx1mMTJbEbzIAEorIPqhHO+6hczPB82vSJOiClBnu0dQfl
         /iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=pBDaQsNPbMngSOGWsxGqOo1v3/WFuFGJRLFYHVAZiwY=;
        b=IPg6LDvhUNVXm/1F88ObuNtGQCUWM7p4MA2i8KDesrAFl/veQqpUByZnW0Iiyvn+vy
         OvOcyPEXwQPFNo+u4h0p7epvF/4Xpn/tdxjdWKW4glOqHTxxCZSNKnCOT1EdeGKDMdu8
         FFsk3Aw4Qj07DMC1TaSHtXp7hu7RXXybReQjpOBxyjojdSAOhm2TwG2KK9Fe6Of1A/hH
         zu6Jl+3F2qO4mkxr2IMOfTYlkydz4dQXviqHKoIXVZsY7+nn+gi+yZjzAekjYegJiGPk
         re2rf63R3gO4T0xPvnpNKbOpb8GfEdX88jd2IzeY4T74ufiT36fNptxR3NAqFUpJocDv
         cA0A==
X-Gm-Message-State: APjAAAUo/z14s7VbEESlubxr+GRiE8eZn/e3UdnSQ9cAbaccZqq6tqpi
        S6S4fLR9A1U3wAvD9sdrLKt+LzNRMC4=
X-Google-Smtp-Source: APXvYqzkliY8dG3ps7zphbpGxEj9Mkzvg13BjULpnrDDFvGn0jd+wIto3kSRgUtt+o9QpMnBDRj/Hg==
X-Received: by 2002:a65:6454:: with SMTP id s20mr93944794pgv.15.1564188783204;
        Fri, 26 Jul 2019 17:53:03 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id x22sm58893030pff.5.2019.07.26.17.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 17:53:02 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block DMA segment fix
Message-ID: <71d2d2b5-77fa-e984-b417-bbfd24ad0309@kernel.dk>
Date:   Fri, 26 Jul 2019 18:53:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Might as well ship this one sooner rather than later. Here's the virtual
boundary segment size fix, please pull.


  git://git.kernel.dk/linux-block.git tags/for-linus-20190726-2


----------------------------------------------------------------
Christoph Hellwig (1):
      block: fix max segment size handling in blk_queue_virt_boundary

 block/blk-settings.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
Jens Axboe

