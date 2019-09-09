Return-Path: <SRS0=IO0U=XE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3768C4740C
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 22:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92861218AF
	for <linux-block@archiver.kernel.org>; Mon,  9 Sep 2019 22:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yAxScMIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391888AbfIIWOb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Sep 2019 18:14:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35137 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391863AbfIIWOa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Sep 2019 18:14:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so8640084pgv.2
        for <linux-block@vger.kernel.org>; Mon, 09 Sep 2019 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t0VaP+b935tIbvaXKak7YIW921zY/0VsLU09Aq4H790=;
        b=yAxScMITd5jDui8qk3e2Yu8PiAeRCX521k+gxLe27hdefn/vsRE5M2YB8+eVYx9Wnx
         jDfkRJTyjop+Qz1QueW6GCZpPiDnOZ3raChU76HpgXurSlGcsvajo3prdI7wdwK7qCvu
         F4luU3L2JKBjNQUYbpr2TFtuf7IizpMfsYwnzH3VpOfO4fGH1fetEA7v2vV9+7kkYvkX
         gPqfQV4l0NBW+h06RqsDAVopC/Fm/QmrBEu8sb7onx0DztszlDVtCYZght2syarZ0Ixk
         Uu8sECgDEYmEF2oFoKT6oVy21iOyQuvJq7yH8+amrZ8XdwMzOiUqfYwi7j0EuezgXJjd
         ZAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t0VaP+b935tIbvaXKak7YIW921zY/0VsLU09Aq4H790=;
        b=rBomrT5u2IggIhhcW10u1z6RKAD20+Sun9cOqdTNcs0cAcjT9pCySJJAubQm3+JGlz
         JRnIa4z0ATEbBS1KfhNPqNq4sZl12UmFSC3hWRBdEJpZB2mf7sNVbCy8tAdEiYsE/evI
         xVeuqbTwPC5DhR9OT83DeciJr0WiJ1MNuOHVdnMcbzvjIpmBFYzUYVeOvlswDUVHcT7a
         MBByaA3gh0eJxqEyD9HOWXQLw84J6QP4GizwrLduH7ERMNVtmKMzLc7aMZp8X5e09UfI
         kYzxSCfWX2p9UWk4lgU+ydtDWr29Qmqxrbz292na8yqpelHuweqtONN0zoXVH8oGbnLg
         49nQ==
X-Gm-Message-State: APjAAAWgstHeHJuZj3r5zja1mB6UwNa/qt/oukISOv2YUtK/5WA/QMb7
        XpjCthWAtCAi3rjZqZEUgx2Kwz0D7ZQ6mw==
X-Google-Smtp-Source: APXvYqyiF21PPKvhbiEQqpzBRtltE+dwckR5M90IROXZJT0e85FH99EMuFlhiqI+lbO7HnMN3R5bfg==
X-Received: by 2002:a63:6c46:: with SMTP id h67mr24635711pgc.248.1568067268368;
        Mon, 09 Sep 2019 15:14:28 -0700 (PDT)
Received: from [192.168.1.188] ([23.158.160.2])
        by smtp.gmail.com with ESMTPSA id a1sm15424406pgd.74.2019.09.09.15.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 15:14:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: fix wrong sequence setting logic
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <20190909125040.7119-1-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b10e8425-be7e-c52e-9dd0-20f8c9f9890c@kernel.dk>
Date:   Mon, 9 Sep 2019 16:14:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909125040.7119-1-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/9/19 6:50 AM, Jackie Liu wrote:
> Sqo_thread will get sqring in batches, which will cause
> ctx->cached_sq_head to be added in batches. if one of these
> sqes is set with the DRAIN flag, then he will never get a
> chance to process, and finally sqo_thread will not exit.

This (and 2/2) look good to me, and they test out fine. Thanks!
Applied for 5.4.

-- 
Jens Axboe

