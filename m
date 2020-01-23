Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F958C2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 19:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B26924655
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 19:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QFdnZHlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAWTCH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:02:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAWTCH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 14:02:07 -0500
Received: by mail-pg1-f193.google.com with SMTP id 4so1831739pgd.6
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2020 11:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JDqGNaOU+OwVln0dzK2nT8DTnHHQRSdxLk/XuVMWiSQ=;
        b=QFdnZHlJtCj4Oy+7oJbxuWKVV0ECx/rlQCVFhlmB+52x61vEwBhpiQXa43jt/lnkbV
         p6XiEaUiejYAkK71xJcrWGZeFW++yamXWT6zrIRa/BN6ew06EcJbCCn3cBwWtrpgJxDG
         cKuxbhELihsapmjbfUh1mM5g4yz1td08rJQ0swu32EfLdI39Cs0Pb+0jlibT5iHRWZU1
         KiHEUXDSniqIR4Tuja3bp6bacnReGomVFHWcoIPsDqvmlN0qWOTZQCDk5Xr5ksj7A1x0
         oVBEyvPek0cNH0D6BDok/VnKxR6e1ensFSJzG7APIxldzGo1nynP8MTiu7E3B63JhyoZ
         ApZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JDqGNaOU+OwVln0dzK2nT8DTnHHQRSdxLk/XuVMWiSQ=;
        b=eSBz6XtBM+aTfmSg/AYjFLlayzzu7RDaCpkfQv/Y1uYQfztclTfQT1tkYqA8XIu1d4
         ZsCT4ubC1BQMiqyz6LbLTXAc+Zv8MVfbuSPK26JMbtTaoQyq63YfpslJ5WP0Ed4XGNE2
         QtyDXj6E8aQ3s1rZukiVFwrazD/qwvmY0hdt9GVfRF6luCPHwex6/+EUwuJVN4aIkSVR
         a3tr+RoyzFFEuuK/zUvnakc8Qk99/hJ3h87anRq7d1OjekP9e+EwBlDHgN/KimfzWDr8
         iwcCXnz9KPNXfEDjC9gxW26OHGftoUUQVmfvgCVgoQDotn63jSdQmmgQ9TTgTTt/nGLy
         UafA==
X-Gm-Message-State: APjAAAWfcbI0ONxTvaIJtOUV0ixT80DpOSlXaqYK+FonXHFFlC+aPfo/
        08JPR68hVLHPe2YqVt1f/FX9lg==
X-Google-Smtp-Source: APXvYqyt2uhVluabaUh6hPDe+Tnb4Utnz0lL4dYyPEqzWvwuAb1bjw2fjA/OLSNW3Lua/SlPfC8Gkw==
X-Received: by 2002:a63:3084:: with SMTP id w126mr221379pgw.169.1579806126311;
        Thu, 23 Jan 2020 11:02:06 -0800 (PST)
Received: from ?IPv6:2600:380:4562:fb25:b980:6664:b71f:35b5? ([2600:380:4562:fb25:b980:6664:b71f:35b5])
        by smtp.gmail.com with ESMTPSA id o184sm3672230pgo.62.2020.01.23.11.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 11:02:05 -0800 (PST)
Subject: Re: [PATCH] Adding multiple workers to the loop device.
From:   Jens Axboe <axboe@kernel.dk>
To:     "muraliraja.muniraju" <muraliraja.muniraju@rubrik.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200121192540.51642-1-muraliraja.muniraju@rubrik.com>
 <88d16046-f9aa-d5e8-1b1c-7c3ff9516290@kernel.dk>
Message-ID: <2571ea8b-9d64-b0c1-0311-be0a69cf1320@kernel.dk>
Date:   Thu, 23 Jan 2020 12:02:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <88d16046-f9aa-d5e8-1b1c-7c3ff9516290@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/23/20 11:59 AM, Jens Axboe wrote:
> On 1/21/20 12:25 PM, muraliraja.muniraju wrote:
>> Current loop device implementation has a single kthread worker and
>> drains one request at a time to completion. If the underneath device is
>> slow then this reduces the concurrency significantly. To help in these
>> cases, adding multiple loop workers increases the concurrency. Also to
>> retain the old behaviour the default number of loop workers is 1 and can
>> be tuned via the ioctl.
> 
> Have you considered using blk-mq for this? Right now loop just does
> some basic checks and then queues for a thread. If you bump nr_hw_queues
> up (provide a parameter for that) and set BLK_MQ_F_BLOCKING in the
> tag flags, then that might be a more viable approach for handling this.

Then you could also dump cmd->work, which would shrink loop_cmd by more
than 1/3rd.

-- 
Jens Axboe

