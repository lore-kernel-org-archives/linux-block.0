Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52088C4361B
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 15:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02FD922DBF
	for <linux-block@archiver.kernel.org>; Wed, 16 Dec 2020 15:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgLPPsf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Dec 2020 10:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgLPPsf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 10:48:35 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31408C061794
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 07:47:55 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z136so24394961iof.3
        for <linux-block@vger.kernel.org>; Wed, 16 Dec 2020 07:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dsUdMt3elLnLhHpjUMmHSgKb+jK8/Q+XkCcYb65d6H8=;
        b=a8xk4VHLbgY/7YE6M65uEnOLeFyG51dM1svLyeiQa03r90JVHp/sqG8zxiSW2xr+jj
         VS0HoFwJl9YrbUcXiIGWXyaW7nb1CMarpOhhiHv6p42J1WLHYb9yxA7X46KWhSBlY25W
         +851g4fafLZS8U7PqZLOUUNoHFhci0jt2gZMfvWiDbUG9AbRzUchxo5LBejw9AjIMNb0
         LikQ/MyYy4eRic/LRbx7gGPqtmX33BMdO2DqXl4wSHDbRZ00yes5C69kQ0gaY+j23KR+
         /FWZhuuD+ThiryH+Ull3tW8XC565HQIoHif1EzJX3HYeina0iszQlh92suDQ6Th2K3mY
         PtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dsUdMt3elLnLhHpjUMmHSgKb+jK8/Q+XkCcYb65d6H8=;
        b=gleNecazvUVaCeJgI43Zm+SwVB9n5/9WUv/I0OhInmHHbjzK+w62OAxlUmzliznOOH
         IcPXnkubmULKoC0PZ9EYON8FNo0ffxcOZdz9vvucuFMj1B7rvuYKPcqessJKQDBUp8PU
         OQc4//7omtqodWIHKTspUYtfoHlACDgrJn+n7vsS4aWu0DD1frLf8PRtQCpbobG0YSEJ
         YXgyGjprgBs8x+CcQvsliYsyLKbRMbQmRxRJP1FmVD+Vyq8gPkn+WlQBfOavfrnAHbSw
         dVxJgaHbcKzbFF6kU+dWV0qY6HfuVS/9Vya26j4IzkfkUHlxkFdTRijNehlr5fJfCxgw
         Lllw==
X-Gm-Message-State: AOAM5333sSRIJbVI1LRIRAdGtaex0QUGhgusOc8u44C+G6JT5u2ZY544
        asbhnpA8xoAoomC3EUHL42nLb8hhvtePHw==
X-Google-Smtp-Source: ABdhPJwxGQ7xFQdW/UJttZzPjXJn5YuaIjYFK48rzhEyhZICoqU1gykblinNwbreDVZ++HEW18syMg==
X-Received: by 2002:a05:6638:2a5:: with SMTP id d5mr43495814jaq.92.1608133674293;
        Wed, 16 Dec 2020 07:47:54 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v22sm1489979ila.84.2020.12.16.07.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 07:47:53 -0800 (PST)
Subject: Re: [PATCH v2] blk-mq: Remove 'running from the wrong CPU' warning
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
References: <20201130101921.52754-1-dwagner@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <65f4cd1b-d629-7bf3-36c9-e503efb53c97@kernel.dk>
Date:   Wed, 16 Dec 2020 08:47:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201130101921.52754-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/20 3:19 AM, Daniel Wagner wrote:
> It's guaranteed that no request is in flight when a hctx is going
> offline. This warning is only triggered when the wq's CPU is hot
> plugged and the blk-mq is not synced up yet.
> 
> As this state is temporary and the request is still processed
> correctly, better remove the warning as this is the fast path.

Applied, thanks.

-- 
Jens Axboe

