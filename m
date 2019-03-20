Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E00C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D542218AE
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NuL7Z9BR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCTUjX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:39:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39283 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCTUjX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 16:39:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so2754675pfo.6
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 13:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Yw3ZCZw96vOko4Ys42p+EC0VVfUIyMvG8i46muadKbk=;
        b=NuL7Z9BR2v4CYCJ1+1d0PXIIPbUktRehL+gNvpbZ7uWimj5pkvlwZbdpZ0E5PixvYa
         /2Md2DdzhJffavAtxVYfLphCJF1N+Dp/Cb6TVjm7HNTNX55HRl+WfePouHFm6v2S46w6
         9Qi3r78XuJpKmMDj4iEL5PnOocEndChtZoAFOET1wJmeR5qMfGTX9/maL2jTlhErK5gu
         5YY1PxLdUqQXAD7CHKAryC56GcXOKFRwixJfDWEXNnxPiGaEbLXZY6eD1yOssxScQyTp
         +laMmbyFb+w5xk6IDy67y99xvVtHG+y2ENYvrD2T7nIgbZiDYSc6azHKZqtg3MxizhqY
         kdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yw3ZCZw96vOko4Ys42p+EC0VVfUIyMvG8i46muadKbk=;
        b=J0CBjbbX0jgAzXCMdVjvoyKhRwgwdEo+oNfBpTmDpQPIuVcyhW82eT4nNPlb09UfaS
         W0BhtVTX1qA90B93NEm2pe2TqyPMH6rPjNZZ3orCkUKTh+6dZpjNIu1RgvGcv1LMEY6Y
         pfOxLso6My1IM/hTGSA2kPPtq4E4s5a/aTyhsodSmnr7OsrxnWmMlU2H7oww8vS5RID5
         j4GLrRvwt1oXnXFOsx8BvYUGb+s7bMWzG3h/73iVdVocGEbwDGn4hmlxdAEH8yuahdsS
         gjZItqYQiMiJdts0ahzCLgobpaHm+qf1Hcx57wGBS2wdAnNkJk7axhBw1kGdEYfUfF/s
         xa/Q==
X-Gm-Message-State: APjAAAVlG8e4OjypLh1mFGXBNFQDSP6uyltuSuGeTuoqo6PCcTukwDKX
        go5SKB/7zR1WYCIwC4AuvTHAeQ==
X-Google-Smtp-Source: APXvYqxORTlMckjyeVFJ5WawfTUVDzRFuWRqHlVSX8quvNyXPr9pBU3oXewlZ09K2bBQZt6DYPB1Mw==
X-Received: by 2002:a65:64cc:: with SMTP id t12mr9449836pgv.438.1553114362912;
        Wed, 20 Mar 2019 13:39:22 -0700 (PDT)
Received: from [10.155.59.239] (96-86-215-89-static.hfc.comcastbusiness.net. [96.86.215.89])
        by smtp.gmail.com with ESMTPSA id k26sm3542604pfo.111.2019.03.20.13.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:39:21 -0700 (PDT)
Subject: Re: [PATCH] blkcg: Fix kernel-doc warnings
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20190320201845.39595-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9a320d78-50de-85b1-1ae6-abdadfeb247d@kernel.dk>
Date:   Wed, 20 Mar 2019 14:39:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320201845.39595-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/19 2:18 PM, Bart Van Assche wrote:
> Avoid that the following warnings are reported when building with W=1:
> 
> block/blk-cgroup.c:1755: warning: Function parameter or member 'q' not described in 'blkcg_schedule_throttle'
> block/blk-cgroup.c:1755: warning: Function parameter or member 'use_memdelay' not described in 'blkcg_schedule_throttle'
> block/blk-cgroup.c:1779: warning: Function parameter or member 'blkg' not described in 'blkcg_add_delay'
> block/blk-cgroup.c:1779: warning: Function parameter or member 'now' not described in 'blkcg_add_delay'
> block/blk-cgroup.c:1779: warning: Function parameter or member 'delta' not described in 'blkcg_add_delay'

Applied, thanks.

-- 
Jens Axboe

