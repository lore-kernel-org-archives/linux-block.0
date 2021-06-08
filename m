Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D12DC4743D
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E22856135D
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 21:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFHVJD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 17:09:03 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45841 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhFHVJC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 17:09:02 -0400
Received: by mail-pg1-f171.google.com with SMTP id q15so17554189pgg.12
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rTsMdC4BXmfgTF7pG31W014xkPHrZAxJCnEYouFG+gQ=;
        b=oMzG0SfeYUnoGEuhJHQ7htz2XgVPAaGjqbJCsNrsjv0VT/wTC6by508zL98Ft+ChNL
         YJ3flE4tYQf42oFERX+vkSK+a1A5e4FDwYQxuFNtDDwNBoSr0N2mvxKytkLtUpU7uzYP
         cCJ7OGIf+41isZ2k+YShyaRwJv7hxwyaBHtqHPlKg5tCRB6TQBWf58QBiNkLGtLQdawx
         mzMrlPKtVgQqgY+3J9TPxWERH/iVjIoJCKCCU5CTjjS+L967Mhu/k+frrX4pWsD0reVX
         qZ1uRRRruSBovnL0kBpyCSxnp7Id1hloFaT2wzGWDYiWrFTykDalzKCkMJE8e3LIeJ3k
         VDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rTsMdC4BXmfgTF7pG31W014xkPHrZAxJCnEYouFG+gQ=;
        b=KHc0wAs2xi64K6jd2UIGNWPu3udfzyH00Dgd0a27fDfUr+hXjIFIRbwHyD0NobKCNQ
         Tz9wwWeJPmnoDvlxvqLg5UtobEqy2s7brY6n0l5hQkeG1Uemwh9mjxVhd/UUkKv7ddEs
         9DK69kehcoGUFBnmgmYAs+tVCrjd21Cr6uN0svd+CrX+LU52PTUpdnXMWH+PL1Hv9fTH
         aQIDDg3hJdTAuzX/Jog5DOh0cmBQZU/pVTZX04tU6L+xF+vyRfKxk1nXhoJkqUB/N86x
         2mW58YJguQUq27BE4HzoD++cvBEGX9IA3baSLjTuzQwpwlCEv508Ojn8yr+BT9pM1NP5
         rr6w==
X-Gm-Message-State: AOAM530Ak8rILdm2R0ync3jsaoyXE4zPRc0eWP9GMY9zZfc/jzCzpiHN
        BM+5wfx5F95O/31NFI3lkQC9Nw==
X-Google-Smtp-Source: ABdhPJxmIxuV54xftG6ihDeETBpL1x1bpTjcbMTDiFUjG1Hdy0sEIgM/suXMIB2EpZgu4yPgzkKiqQ==
X-Received: by 2002:a63:1349:: with SMTP id 9mr130994pgt.235.1623186357366;
        Tue, 08 Jun 2021 14:05:57 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a66sm9471059pfb.162.2021.06.08.14.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 14:05:56 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] bcache fixes for Linux v5.13-rc6
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de
References: <20210607125052.21277-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <180599cb-7c2e-da35-96a5-225462c6cd71@kernel.dk>
Date:   Tue, 8 Jun 2021 15:06:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210607125052.21277-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/7/21 6:50 AM, Coly Li wrote:
> Hi Jens,
> 
> This series is important for recent reported bcache panic partially
> triggered by recent bio changes since Linux v5.12.
> 
> Current fix is 5th version since the first effort, it might not be
> perfect yet, but it survives from different workloads from Rolf,
> Thorsten and me for more than 1 week in total.
> 
> Considering many people are waiting for a stable enough fix and it is
> kind of such fix. Please take them for Linux v5.13-rc6.
> 
> Thank you in advance for taking care of them.

Applied, thanks.

-- 
Jens Axboe

