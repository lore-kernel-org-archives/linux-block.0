Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A19C3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 15:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1E5206B9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 15:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="og5xvkjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgEDPwG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 11:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgEDPwG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 11:52:06 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD5C061A0F
        for <linux-block@vger.kernel.org>; Mon,  4 May 2020 08:52:04 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y26so12852810ioj.2
        for <linux-block@vger.kernel.org>; Mon, 04 May 2020 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1zJVO2gIxX4aAMF9gU336L6lcgeaMOzZQkhUWsTLGpo=;
        b=og5xvkjhQE+U8D+oeADyVJ0arMRIquQWzh5QoboLqz8lHbm2eheAnQow6wqDABGhp9
         xIO6yyBYbZ4iPaWhGIYNKrq585MRlGPxqF5YanRAqXpuFLO1z08nblnrza0pYT1WD8Er
         aMsjqIF6AYtDIkCmcBB7PGliKNB8MmfrnjlFNTWf3UULNtMa2LNByunIDFJmj3w4nKpW
         4Bw71whEBFmfqr4tsqYK3LH4O8fqCXeWCwEUA8PandEUAuY7BGnWNzyvmywuyv56wkSy
         IyD005x3jT3e/tONd/gFIm0nryDxvwtQZsCtHchPGcsIe+AGAI8E1zekI9wM2fcAv3vg
         iJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1zJVO2gIxX4aAMF9gU336L6lcgeaMOzZQkhUWsTLGpo=;
        b=Xk3ZXT9tcJrFcfwCyDSqSgC60ZrAyDgdcpgJvUmuyeGx2b6srOAvCtH7sUDFJjjhqS
         VdxTKANyDIFD2wj25xzwZZN5zZrzZvahmA7wcus+wSQMXMVRbS710ewxco+zJFJRu5KC
         OW8unfMAaWQPZhBkL/GFikXu4zm36cfMfhFb3beoTudeFyMVhH6kD9OWyFeMazDwumOz
         ptWN0vfdoAWJpfPxjaeWj1RPEqHhtekUmU8OAn5Z8f9NnNDFlGed+7Ec68PzlCjfomA+
         WuBV+7XeNtq6mYlF20Cmn2VHglTlTqk3J/n+HudEQ9fNUeeQiS6Sx6vIxYECrci9Bww/
         e5hA==
X-Gm-Message-State: AGi0PuZ6aT4pRRhIgWsYRsJ+Fk2NlTOGzdjjk++4sezN3QmQUSq2fpQQ
        kZZsXkRtHHqh14SqM9ve+R8oF/aRZLxV3A==
X-Google-Smtp-Source: APiQypKjMgjkihbrm+NDJF6d0zYsKgvVAb1cfCwDx2zBStLgPRBkp5ul4VTYBPvR1LnzG5UhMLclZw==
X-Received: by 2002:a02:3b1d:: with SMTP id c29mr15431997jaa.67.1588607523292;
        Mon, 04 May 2020 08:52:03 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x75sm5278407ill.33.2020.05.04.08.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 08:52:02 -0700 (PDT)
Subject: Re: [PATCH 0/2] bcache patches for Linux v5.7-rc5
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20200504153529.2242-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ade380f2-e124-9e64-572a-3299bebcd658@kernel.dk>
Date:   Mon, 4 May 2020 09:52:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504153529.2242-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/4/20 9:35 AM, Coly Li wrote:
> Hi Jens,
> 
> These two patches are in my testing directory for weeks and it is
> about time to submit them for Linux v5.7-rc5.
> 
> The first one from Colin helps to remove unncessary local variables.
> And Joe contributes second patch to improve the kernel message format
> by remove extra '\n' from existing pr_format() and adds the '\n' to
> the location of printing kernel messages. 
> 
> Please them for v5.7.

Why not 5.8? Doesn't look critical, nor something that was introduced
in this series. More like cleanups, hence should go into 5.8 instead.

-- 
Jens Axboe

