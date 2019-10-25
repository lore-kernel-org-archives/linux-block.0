Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B86CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AD921E6F
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 20:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="q7QS/AL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfJYUUV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:20:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43492 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfJYUUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 16:20:19 -0400
Received: by mail-io1-f67.google.com with SMTP id c11so3809050iom.10
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xAAiYYk0xZv3OQ4bIpixpu+H5Kr/KOMzMnqKGzGYvyw=;
        b=q7QS/AL2Ywv77I0A1b8Whl+ujJhPJcrIEXK7HrU69l3R2PK6fB1/oFE0NpG70wM8ei
         h1EwGEAtsGwptZjF+wcQ4TPRbMZM7hKpDDnAnHUqmIqoe8v7neoE2JnXGLzq/BZjwLW5
         67mM33H01S6FHIg0NvFSulK60ZURLi5Fl+BLTMOBNxfOv4v89HdPmRb33AMK/5WE83xq
         5FyFPZcj2JBxUsOH2IeyOAtH2tcUGNlRMc4Nhpsk6tTSlY2yYq1GXz9NcjSOw2kAT9Nb
         51T/XOyY4gT3v+FQphk02V14xEcVzXM1M8O6eyPu78p/mYyc3wbiGXVrDxw8K8dJ4CH/
         0eKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xAAiYYk0xZv3OQ4bIpixpu+H5Kr/KOMzMnqKGzGYvyw=;
        b=bxAdwyvLWWI3cvFIyxA6RJ+2SvTKty6BF0PHZ2aq5Wvj/bh1xooDCP/d/hOSqpAXeR
         NArdHPnDU/O5Ts+MuwKX58RPPWVitqaG2UREOU4fE0YHIQl3Mk3sxWHxE3oOlIbXWU66
         39idrkkOy3vkWP1KTRZtRTmJjhoc99IPJbYWpJy4wiSu12Xs2/OmgYpAyFSVNLqC/2pu
         TrEKPnzC5hXpkQfvIACOCIPg1d/LJCzbgJfWd4e2NBWp12SCxloGBlU4U9mUvP9FlipA
         nfgP+okj9eulUGlxgx1v9XhInjRTNs8tYHZNPDn2RbA93ANMOL2EWkuBK8jNM+OPRL/9
         0zlA==
X-Gm-Message-State: APjAAAVj92YK9virVQa1q9ESsVwHqSzyOhYjzFhii8IvN0sk9+wERd99
        yJSt4EDTf10Z2FYDnRj7axGT2oxePMrzjA==
X-Google-Smtp-Source: APXvYqzJ6GnutgF6fFKINClKY+KF/w16vhPh2FXclM3XBKPJhjmK89dnzlJMd20Y63JjXJ/qFX9a/w==
X-Received: by 2002:a05:6602:2547:: with SMTP id j7mr5952332ioe.77.1572034817055;
        Fri, 25 Oct 2019 13:20:17 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h24sm408169ioh.0.2019.10.25.13.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 13:20:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] fix double completion of timed out commands
To:     Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
        linux-block@vger.kernel.org, kernel-team@fb.com,
        mchristi@redhat.com
References: <20191021195628.19849-1-josef@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a6bb9e93-8572-4fb9-3ca1-f2442945d150@kernel.dk>
Date:   Fri, 25 Oct 2019 14:20:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021195628.19849-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/19 1:56 PM, Josef Bacik wrote:
> We noticed a problem where NBD sometimes double completes the same request when
> things go wrong and we time out the request.  If the other side goes out to
> lunch but happens to reply just as we're timing out the requests we can end up
> with a double completion on the request.
> 
> We already keep track of the command status, we just need to make sure we
> protect all cases where we set cmd->status with the cmd->lock, which is patch
> #1.  Patch #2 is the fix for the problem, which catches the case where we race
> with the timeout handler and the reply handler.  Thanks,

Applied, thanks.

-- 
Jens Axboe

