Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D09CA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E87C20882
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oIyuv1YO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfJUO3a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:29:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38192 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbfJUO3a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 10:29:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3so7930256pgt.5
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K8c8oYwEcfui3biHr5k/oY1BAcsxWVcUKfm7CAs+tEs=;
        b=oIyuv1YOVavrfi+QBnEhondwVTfLmYBs6aSTDU7SAnhkceG5A8gvL1qHB1qOrEk8cD
         yo9NGRzqbh63iH3xlD8QjSx60BzIIzeHFOC6boPYQKmVZ34IoEeaFi9er4nEkkTLg09V
         mC22WF0kXOgF7GEkcACXX6Q3AibhQGjUv3/dKej+K9Qe8MsDynE5C6nO9XSZRz/0MypR
         UEWIBoUlb5u52nTIS0WRwavmh9Fyyrxadl3uX67wAhUXCnlvcTTrXYGUHSRZmR0wcsjZ
         V9QhBrXiPzhLAM6V18iXaO0bmcMxe8HVCfXWFkCzglE2Hbl2PTa0zdotMCv/RB400Qes
         0e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K8c8oYwEcfui3biHr5k/oY1BAcsxWVcUKfm7CAs+tEs=;
        b=DJjRMCAm/D7GbL+SXPEOmh+nfxgPlJSnLA8wbPxQnUVaqK1Wdlmw/bXOtPuP8Zr3l2
         v7jZWSvs8Y5kemdLH9cSrVHPn2kMsBoZn2OK5XmgUSc9BSQVvsi99UVMkS1GokBjJQea
         tcBKOKZgakVdMdFKtXUWMqCRleaGUC2SDY8tUrA/R/jEGqrAVcwVOovu7Szo/kH0BHpG
         NyZioW6Nofj4nMGW6AkAlXocMzPMaJxUmWpxWD0Eenv+tVyQoA7zfGay9vxI82canobW
         /E/Da2o3NikEMGyn7w81hZV+fVi2rNZIlvmRpVrVARX5ttpf57OQfDSl0U/j2mJGUd3D
         iqxg==
X-Gm-Message-State: APjAAAXI8DiA0EYgce+Pn/RkxpPfx3xuysPds1Fk9H6TBOWxoqJTnGiv
        BhHW/Cqi03jRNaPJNavMXiQRmA==
X-Google-Smtp-Source: APXvYqw3+kx/HCNPYmoaAm/yOXzN0R3qIN0r4F+aVx0hCoie7xihhl63r/RLBa1FywtcIKpVbagFHw==
X-Received: by 2002:a63:7c03:: with SMTP id x3mr26546166pgc.382.1571668168944;
        Mon, 21 Oct 2019 07:29:28 -0700 (PDT)
Received: from [192.168.1.182] ([192.40.64.15])
        by smtp.gmail.com with ESMTPSA id g9sm14051285pjl.20.2019.10.21.07.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 07:29:28 -0700 (PDT)
Subject: Re: [PATCH liburing] Add test for overflow of timeout request's
 sequence
To:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
Cc:     yi.zhang@huawei.com, houtao1@huawei.com
References: <20191021120217.31213-1-yangerkun@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4508c75f-eca6-ccd7-cbe2-ccdafa5e3899@kernel.dk>
Date:   Mon, 21 Oct 2019 08:29:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021120217.31213-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/19 6:02 AM, yangerkun wrote:
> Before 5da0fb1ab34c ("io_uring: consider the overflow of sequence for
> timeout req"). We can meet some situation like below:
> 
> 1. setup
> 2. prepare 4 timeout req which expected count is 1,1,2,UINT_MAX, and the
> sequence of this 4 requests will be 1,2,4,2, this 4 requests will not
> lead the change of cached_cq_tail and sq_dropped until the timeout
> really happened. So the tail_index in io_timeout will still be 0.
> 3. based on the above and before this patch, the order of timeout_list
> will be req1->req2->req4->req3, which the right order should be
> req1->req2->req3->req4.
> 4. setup two nop requests. And the timeout requests will return
> correctly with the patch.
> 
> Add this testcase to cover it.

Thanks, applied.

-- 
Jens Axboe

