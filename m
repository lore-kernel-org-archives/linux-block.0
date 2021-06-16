Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B69C48BE6
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 14:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B0A6115C
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 14:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhFPOo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 10:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbhFPOo0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 10:44:26 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3FFC061574
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 07:42:20 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d9so3287641ioo.2
        for <linux-block@vger.kernel.org>; Wed, 16 Jun 2021 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LiH0D4iBszbElDYTuuId+s1v7sAPLxTu6PxBxnKADK0=;
        b=kg6vvpvwDdbYHJeX9qfFTJH+ZFdh+LvF199iOZ3mOA9XJ0+9j8bm2xA/hCe1/m2h5s
         qE3sMvKextLFkLjRLSD68qMH4/B8a8jJt2EtaeInPR8c8H3Wz25304Xq2yVeIXC+FsRX
         J+1xBh0IikcQFJSdy+8VmGAm+hYvB+1rjrPgOohmnL4ecYfzmcDY/GDepQ/ZIh7GSCZX
         kzAHq1ZD+S9xti8qSt4oPyM8HpXwt+TnvEOtWFLaPPQou4oe8jOhJHuaI/m+4yWEG7Fy
         QG97bGm6WfntodOTrDpEwOQlbj94DaZH42Tz0QGWv9kOf3q+AIMbOcm7/xVXfb7wSpbr
         m18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LiH0D4iBszbElDYTuuId+s1v7sAPLxTu6PxBxnKADK0=;
        b=X46gGfvtdt12BYRLWy32hcGYleltXGN12bjBOGIZMcHFSDwU3EzQFKqxhySUF6qfLY
         cHw3lpTcsg4t/nZ5ONA1CyOg47Z3ARHpLfqku+YkHuZVHARJ81PYtCLdUqfr1V1CPJma
         e+7WguVrSrd0Hv93bi958S4/KoVqGijI7iDZ4a0nOWYahP3omsEGq+IAM13gJ7rY5aMA
         nfa/Z0vLk9fE/I1VKuDPh1SOH4nMAg2umbOzN8CQQM4WO8zWO9skGtb0Ux2yttAwnAbB
         1Lowc3L34vb1X3AW20ddcfktTHwSkeXoeGCX7JcJwDwYcPhVDuI9CCpGNOVnf1LxU2T7
         k8qQ==
X-Gm-Message-State: AOAM532+6Z3vDVQexNYLz54NzpyjO1ZNiiOUzn5x6Bhf2lEXrTVwfwP3
        0DMVX45bQ2zZilS1OxfyWG1PVemCkOPgBJEq
X-Google-Smtp-Source: ABdhPJzvMVFOAdjcJi7CTPPgauIMPn1MuQHiDHsFrTDse44D9/y5AMCSDFvDZXHkHBuYdmD6HlxJ/w==
X-Received: by 2002:a05:6602:2e8a:: with SMTP id m10mr245618iow.153.1623854539663;
        Wed, 16 Jun 2021 07:42:19 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k4sm1199274ilh.76.2021.06.16.07.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 07:42:19 -0700 (PDT)
Subject: Re: [PATCH V3 0/2] block: fix race between adding wbt and normal IO
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20210609015822.103433-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d369b6c-bb80-87e6-b970-1c5b7556f027@kernel.dk>
Date:   Wed, 16 Jun 2021 08:42:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210609015822.103433-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/21 7:58 PM, Ming Lei wrote:
> Hello,
> 
> Yi reported several kernel panics on:
> 
> [16687.001777] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> ...
> [16687.163549] pc : __rq_qos_track+0x38/0x60
> 
> or
> 
> [  997.690455] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
> ...
> [  997.850347] pc : __rq_qos_done+0x2c/0x50
> 
> Turns out it is caused by race between adding wbt and normal IO.
> 
> Fix the issue by freezing request queue when adding/deleting rq qos.

Applied, thanks.

-- 
Jens Axboe

