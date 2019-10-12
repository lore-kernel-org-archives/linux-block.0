Return-Path: <SRS0=KslL=YF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D6BC4360C
	for <linux-block@archiver.kernel.org>; Sat, 12 Oct 2019 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01CC121850
	for <linux-block@archiver.kernel.org>; Sat, 12 Oct 2019 17:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JCyzeP1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfJLRFI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Oct 2019 13:05:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45070 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729346AbfJLRDI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Oct 2019 13:03:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1so6399988pgj.12
        for <linux-block@vger.kernel.org>; Sat, 12 Oct 2019 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/WsQCyes4ObKQHiw8e1UHg/RMEFajdHiBZAFdINZMRE=;
        b=JCyzeP1s2yZ40JSad4xYQGkQm5rCFUt8zKRvkq5apjx/BlAIS0yL0wMZxXvLoaTs9Z
         JD/ho5tsN17D/8Eolen1s1Aml+J/p2bXkDAkZw+kawmcPKNSg8MnFA0vxpwdGrM3oEeD
         ckWZo5yk9Y3DfBw4k+aeuG+dB6Cfk3jDUik8VYSckqI+89oILtZ1NRFDBshq6g/+Jv6M
         AWALuMUR6eXJrxgnlgLOYJoLUTcnfize5MYKTpADkTPvvPW/FzTxLqo+/dq7todvJuwm
         v/FHVDHDaMLbUNWZNPPZ37WyRG7jvPv9riKhEumdbBQpiZqbPhyAzrgfSq47BDs3bXMJ
         dwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/WsQCyes4ObKQHiw8e1UHg/RMEFajdHiBZAFdINZMRE=;
        b=G0qxWVmhFcb2u9OrtEHm5GWU9y+C7GAEg/gBh4gb1bKMTl4Vd0eEo4Bbe+LV5Dn+cv
         uafdQHlLgqWAiKuqsY9FYwxHAEVt3E6hSge+TqY/87Dnx1Kv7mIwMHoASrbDc+g9qDeM
         NXtBRqmkTk/uLUKbZH6u5GBwBkInUGgtoCv0OiObMt8yIzIKK5TPfF22iipOipPhgfth
         jX4KuSMInFhSwIdKCYGZ/TrmcgDotntHtLFUPMx5NBbgO9laRXHGsFT4NW5O4qnUhIzl
         lH1wJdC7hTxVPq/SY86joE9afwOpdMKuSRnJyDKhXVYF5oagL7HM+j52FcaV9qxJmLwc
         FeMg==
X-Gm-Message-State: APjAAAUKu64JJ13H7Dys9SwK926JnjX5g+jkz5dpe8NDBJZC1TnPr3kW
        GYm1bJ7if5g8RLDNroZzaNe5i5rlDSUoAw==
X-Google-Smtp-Source: APXvYqwcf0LDBHDv+tu4dDjBCZQpPEcgY9Nyp9GDuGbTgqSW6Fubqy9MNN0DGRGqFUQ01/uCMV6Qhw==
X-Received: by 2002:a63:f956:: with SMTP id q22mr22702460pgk.435.1570899785635;
        Sat, 12 Oct 2019 10:03:05 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id d6sm12428816pgj.22.2019.10.12.10.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2019 10:03:04 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Single io_uring fix for 5.4-rc3
Message-ID: <5d635c9a-7373-2a12-2a0d-e94806c2c114@kernel.dk>
Date:   Sat, 12 Oct 2019 11:03:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Single small fix for a regression in the sequence logic for linked
commands, it missed the cut off for the pull request I sent two
days ago. Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20191012


----------------------------------------------------------------
Jens Axboe (1):
      io_uring: fix sequence logic for timeout requests

 fs/io_uring.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
Jens Axboe

