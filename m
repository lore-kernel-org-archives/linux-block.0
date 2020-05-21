Return-Path: <SRS0=t9QE=7D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1ACC433DF
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 14:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552A5206F6
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 14:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Uv1D67Rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgEUOfN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 May 2020 10:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbgEUOfL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 May 2020 10:35:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E5C061A0F
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 07:35:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q9so3147399pjm.2
        for <linux-block@vger.kernel.org>; Thu, 21 May 2020 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J51At+hbotKe/uyCWwztTgcU/DKyC1up14t8RJPYJKs=;
        b=Uv1D67Rbj3w+JIfTeS0RoEMnLi28XeDKRpNgO6o1c4n8FDQcTZSsUz09B1X8ugGsbA
         Pgkw3JTRFMvmGaZtFwGFJV+IuFVjI8wGqvxxcciM8e7LBQ6hP6N3xx5CCtfPjlFOP1h5
         XDqyiErYrA8ZHFn5DItUl2oIdDyGLKCbHc1LyK11kRZ1KaZZLDWfRXec+TGA5/6GhKAg
         ceSQJbMPtVF5ByuClk9Y+mb8WYBueHtKp3Kk6dZdl6Se3SgTfETB43iw+jkueRx8I/hZ
         u81yEnt6XEXTi0bktUTlTbF2Y3525FraxUIc5iNJykWW0qKyEbssi+C1Uthh6+09QGzj
         UT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J51At+hbotKe/uyCWwztTgcU/DKyC1up14t8RJPYJKs=;
        b=VApbtEsKHnftDgjsBRIZGc0Mxr6Yr5BqcLcx40dlvuEbXm//jca5URBEWENga3WlZ0
         xVMkLHEYp/u6DEmw6vK6FkuFn4MW/d+B0HL3eKzu5PL43GpRtuVjFRnTZ3xl7QPJDM57
         9Ao9qBzOMlD4tNUTeB1NV8A/wIi2vPg7rIRhwjfYpYWJLsoHAmhRM8T8DAMZucHza1Tt
         qsnwyRkAxn5kMoZr3yi7LrrRJ7RZ7uiwRPk/k59rrj94638SSYF7oocleJSYN3uzb8N/
         SlXxptJVcgEYLTMiFxQUsb9KyH3b1+ADUUYryHJwl1Fk8oTKCs7cgeYxWDqecGycuy/L
         fEWA==
X-Gm-Message-State: AOAM531MXMqDYG7aueY5HD+sVhtdGBlrWi/IBs3u+pSwD+WMXLTdKFND
        6/XUQ6UBV1mIi3AWiWW2TH0ZxguySi8=
X-Google-Smtp-Source: ABdhPJzslJOtTY+QZx6oTAX3n0Ux5CKV15SysD/PgQzEqKZIALlHgXxia3Q8MwRo8M1fcjOL8hhQgA==
X-Received: by 2002:a17:902:b18b:: with SMTP id s11mr9668569plr.160.1590071710297;
        Thu, 21 May 2020 07:35:10 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:c00a:8fd2:4246:efbe? ([2605:e000:100e:8c61:c00a:8fd2:4246:efbe])
        by smtp.gmail.com with ESMTPSA id p12sm4251968pgj.22.2020.05.21.07.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 07:35:09 -0700 (PDT)
Subject: Re: small blkdev_issue_flush cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200513123601.2465370-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b115def-6506-7bcb-3703-961d1b3d1412@kernel.dk>
Date:   Thu, 21 May 2020 08:35:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513123601.2465370-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/13/20 6:35 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> two small cleanups for blkdev_issue_flush below.

Looks fine to me, but I hate patches that touch so wide in the tree,
often ends up being a hassle for me. This one looks pretty low risk
in that regard, hopefully it will be. Added for 5.8.

-- 
Jens Axboe

