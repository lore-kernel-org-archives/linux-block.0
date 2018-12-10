Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A713C5CFFE
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 16:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620292081F
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 16:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ootPNiaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620292081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeLJQ6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:58:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40335 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbeLJQ6Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 11:58:16 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so19251032ita.5
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 08:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kJ0Uh/sz9+ZfwHuRQutOjBLD6AcNatJC4J4LKf97Spw=;
        b=ootPNiaXJohTA5J3F8DAZAYMKokXrJm+GhTQrrlKJNHsQFKjr6fJ3lC6DyiQKJSVVc
         qPRVJmV6ckg/V45QIigFJe2TXPw40fKYI0zn1sCwPG9CsLc2lXIDW8HY9sA5hhn2xmUR
         W9n5f/wlrB8fcdfl4cMqkZF55VFrEAWG++nA/haOxg42h3V00jxV7cUQ9tWK2SbSebf0
         OfW2FlgydOCVhXSLyuK7LbLeT1dYdrLzI/xmPvid4sEuDxEtyJQa89J70D+v8NP/ovZo
         H036TJOvPRmOeC4cR3ryggXUYGeDXAVCG1ng8AO8Nq9Yk78iR9Y1qccOn2Q93Dnz+jA5
         HOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kJ0Uh/sz9+ZfwHuRQutOjBLD6AcNatJC4J4LKf97Spw=;
        b=U6xOMvyfhEpW2pSJmUQNSRTmXGHL0QSmKeQy1IVSqA1kvrYzBCBPAOy2kMnL1fnE0w
         Zw3TS/ncT6H6v50nuXHdMn+6wCgzZdpxP3ra9sWmRZVY/3/f6/9WhcOgpGeeo6w+JVns
         LfpKfjqZN9AMjBcf+D9RdJna4Ig4FuQRnKbgQasQBUMtPJwFT2p2IdLh0VdlV02nQTYL
         lFIsqWZmVjxe+VOegwamBP3YMrxTmFriFDc4QIr8e1oGFWWqZnejB8fKQXyS/ctFgCK6
         DTx9lM+X/3Qxryih+QvFvaaY6/JXZ4SaoEFxkwprZTF4xSay+JaBr+oIpm/jvn1/DDfR
         hXkQ==
X-Gm-Message-State: AA+aEWZ4oA8kfxWXY38O3XbxBI2j5P1DNCJFr6eSpBVNHvrybHMMPSZs
        GSex+gRdGnSnfTRvYsU+1EnVMQ==
X-Google-Smtp-Source: AFSGD/XuzbeEsWvQK1HZ83QmL2YWpGByFEqR0vJ1JemZGwq5mIlvztg3cz7yiQpcJVaFm9LFvWlFfQ==
X-Received: by 2002:a24:5084:: with SMTP id m126mr11134390itb.100.1544461095122;
        Mon, 10 Dec 2018 08:58:15 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h139sm6647668ith.24.2018.12.10.08.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:58:14 -0800 (PST)
Subject: Re: [PATCH] block: fix iolat timestamp and restore accounting
 semantics
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181210163510.58985-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f698e396-2577-b0d9-e300-f65d4f062986@kernel.dk>
Date:   Mon, 10 Dec 2018 09:58:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210163510.58985-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/10/18 9:35 AM, Dennis Zhou wrote:
> The blk-iolatency controller measures the time from rq_qos_throttle() to
> rq_qos_done_bio() and attributes this time to the first bio that needs
> to create the request. This means if a bio is plug-mergeable or
> bio-mergeable, it gets to bypass the blk-iolatency controller.
> 
> The recent series, to tag all bios w/ blkgs in [1] changed the timing
> incorrectly as well. First, the iolatency controller was tagging bios
> and using that information if it should process it in rq_qos_done_bio().
> However, now that all bios are tagged, this caused the atomic_t for the
> struct rq_wait inflight count to underflow resulting in a stall. Second,
> now the timing was using the duration a bio from generic_make_request()
> rather than the timing mentioned above.
> 
> This patch fixes the errors by accounting time separately in a bio
> adding the field bi_start. If this field is set, the bio should be
> processed by blk-iolatency in rq_qos_done_bio().
> 
> [1] https://lore.kernel.org/lkml/20181205171039.73066-1-dennis@kernel.org/

Looks reasonable to me, but it needs a Fixes tag as well.

-- 
Jens Axboe

