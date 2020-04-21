Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6447EC54FD0
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 15:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C2920661
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 15:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LTqSdoD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgDUPuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726124AbgDUPuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 11:50:19 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394A2C0610D5
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2020 08:50:19 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id f82so13789692ilh.8
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2020 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qcGkRm5B6/y2G7+o+8knsoRwPwaIjT33dqtXOR9suII=;
        b=LTqSdoD2p6ZggutU2qU4llC5M7CPI3Gj8DJ+/v0Dv8ZlWjeqj2DEwXzu3d2OB/bMxO
         RTavrl7IaqUSrcSAUg9Y4WhYZnU1+9PHlD0mHnFl0aS5Ch5HXpveSjz7QMpnl+XOUAIm
         x6+EIMk3ytPbhnznixgTsUJA3MzIJpybBmMJZEsJ6Pz0uGwHETdU6ogbalOsUh903L1p
         i/9OXm2e5dGtV2G7M7eEBGvHXX86rtEWrS79jbIyZ7KAyX79GkONfg64QF3zUpEjPj34
         tsVnyx6SpBNEEGF73pB/HjrMPX6m/rUW3pwOITIOTZt1X3iiqYlaIDlrn/hD23XnKU9O
         Y7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qcGkRm5B6/y2G7+o+8knsoRwPwaIjT33dqtXOR9suII=;
        b=GofF8H2b6VP0HszWjGQFtEaXvLVFDGpIGjvrgZ7gt7hrN/bYMdrohVqBdeBf7MEtKs
         6kkrEjAN3Z6MjJnkbR4ac491t23aR/vrr8igsCwJjySsoytYLhldPC0OhamMTAs3ekHo
         TQ/QbYOAddwE/HBIK2KQVZTu76OVtBfye+VziO6eB4IcttmyLIkKhx72Wanh1m1NMGEy
         +o7DqxtY1kceeGDQChbUQ1O2SWfk0UeWc6fJgQqjPnBSqlD5woxEzcc56RqdQaF9JkQ/
         RGpnrcLLLcDwKKWxkJiXt0fIv5oxPtBW7XBtGiBbIvuvPPb2zPcfbEqR2YktzzmGCHMn
         L3AQ==
X-Gm-Message-State: AGi0PubJyA9v537WvBxrT63uAEAmNVLrAVLQplQct+lQDWfNyJMiHKZ4
        m1aMVOkQN2/CkD14YdoZ8NEbyQ==
X-Google-Smtp-Source: APiQypKPLk26mkWusup1d/4oA1eOuQ+oFhDUweYJPtbtExABcgxJzTrIonyBnP3rXaRS2xOmveqNaA==
X-Received: by 2002:a92:5dca:: with SMTP id e71mr20627198ilg.34.1587484218448;
        Tue, 21 Apr 2020 08:50:18 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c87sm1041220ilg.2.2020.04.21.08.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 08:50:17 -0700 (PDT)
Subject: Re: [PATCH] blk-iocost: Fix systemtap error on iocost_ioc_vrate_adj
To:     Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20200421130755.18370-1-longman@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4ba2d62-993e-9da3-9adb-4049bda6ba63@kernel.dk>
Date:   Tue, 21 Apr 2020 09:50:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421130755.18370-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/20 7:07 AM, Waiman Long wrote:
> Systemtap 4.2 is unable to correctly interpret the "u32 (*missed_ppm)[2]"
> argument of the iocost_ioc_vrate_adj trace entry defined in
> include/trace/events/iocost.h leading to the following error:
> 
>   /tmp/stapAcz0G0/stap_c89c58b83cea1724e26395efa9ed4939_6321_aux_6.c:78:8:
>   error: expected ‘;’, ‘,’ or ‘)’ before ‘*’ token
>    , u32[]* __tracepoint_arg_missed_ppm
> 
> That argument type is indeed rather complex and hard to read. Looking
> at block/blk-iocost.c. It is just a 2-entry u32 array. By simplifying
> the argument to a simple "u32 *missed_ppm" and adjusting the trace
> entry accordingly, the compilation error was gone.

Applied, thanks.

-- 
Jens Axboe

