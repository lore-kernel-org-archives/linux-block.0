Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAC7C4363A
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBBA217BA
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 14:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OtjKLWoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgJHOCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 10:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgJHOCJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 10:02:09 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189D1C061755
        for <linux-block@vger.kernel.org>; Thu,  8 Oct 2020 07:02:08 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d197so6306606iof.0
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2020 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+v0FBMBQHdikeISvOs9/H6RdJVjsvgJipGvlxdEATrw=;
        b=OtjKLWoNFnJwBG+iIBsnfGAFJ4zdt7leYN6+IZMnSqbHnvoXh5fOLZV1t5S4zHKUK+
         KlLNhwQDcsdOJ+V6LCgAsTRNBvCb+hz8mhghFlo0yiw4O2KRm4ZtDM9yfQnRV0uSBSer
         C9/7OPQObbekrl9Gh4aVoZUyL5YHShCtmwpHSrZO3WnByHNC2KioGmRAmwwGQnvmB2VT
         zZjChPKRCnH8sXBxdxwX+sVzpfg5961ZI6KZIqRSaKXhs2v0NxRWX9XSl4VdF3M1eOP6
         09lAFvYNw26lHxgYb/xSqunH/NmCfM9e73cUCb7zv4dadb8bBohqNr3EeFusZoM46jjQ
         DEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+v0FBMBQHdikeISvOs9/H6RdJVjsvgJipGvlxdEATrw=;
        b=fS3L66uk5Yw2qIrkwyLpk31T3QoCa+9B0fpQqmiec3sjQJffjZIKaWA5sdQyrsRh3y
         vkomT/iQ7Pbv+deR1LpUWQnrA0kh4lhZrg2CBQuBySNn5Qsp3JcQolaMGCreb2pR7ZkF
         Fl0G0g/b+WxRs10mLHXmEUq3YT/TxT9nGuAQxaf2iAeRjoSEJ3opht5ZaDpqyNF0Ya5S
         BeHvBInP+M+0+XjlGlP7lQaNppsG3q5O+CduyaSWTalu3s7TrRHbf9u4iBs4qjKoz3by
         K5vPnPNJhO5x4gIIlDO6xQc4XGLrSTvFM0Qvbp5UuiyZEMDk9xqye533nYGs8/fka7oC
         QQgg==
X-Gm-Message-State: AOAM533R4S/2u1NeuQborJ5izGK2hV3fHltLQz1lL0hYBnf4fwu2XJFs
        xbCa11nB5WFKyKq47itat4TpN6quCQJpGA==
X-Google-Smtp-Source: ABdhPJy/LL8lIwlhJyCrinad2Oa+KhO+WtX+sKYdSYwFbXtVAptuvPI1GFZpqt98YjTtzz2k0dg+Lg==
X-Received: by 2002:a02:82c8:: with SMTP id u8mr6948237jag.61.1602165727444;
        Thu, 08 Oct 2020 07:02:07 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l4sm2695327ilk.14.2020.10.08.07.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:02:06 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] Some improvements for blk throttle
To:     Baolin Wang <baolin.wang@linux.alibaba.com>, tj@kernel.org
Cc:     baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b54c6741-10dc-2768-bc37-f1965672f039@kernel.dk>
Date:   Thu, 8 Oct 2020 08:02:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1602128837.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/20 9:52 PM, Baolin Wang wrote:
> Hi,
> 
> This patch set did some improvements for blk throttle, please
> help to review. Thanks.
> 
> Changes from v1:
>  - Add another 4 new patches in this patch set.
> 
> Baolin Wang (8):
>   blk-throttle: Remove a meaningless parameter for
>     throtl_downgrade_state()
>   blk-throttle: Avoid getting the current time if tg->last_finish_time
>     is 0
>   blk-throttle: Avoid tracking latency if low limit is invalid
>   blk-throttle: Fix IO hang for a corner case
>   blk-throttle: Move the list operation after list validation
>   blk-throttle: Move service tree validation out of the
>     throtl_rb_first()
>   blk-throttle: Open code __throtl_de/enqueue_tg()
>   blk-throttle: Re-use the throtl_set_slice_end()
> 
>  block/blk-throttle.c | 69 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 35 insertions(+), 34 deletions(-)

LGTM, applied, thanks.

-- 
Jens Axboe

