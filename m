Return-Path: <SRS0=HnxX=UJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FECC43218
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 21:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C4B20859
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 21:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="N1u0tdk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbfFJV4y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:56:54 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:40895 "EHLO
        smtp.aristanetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388328AbfFJV4y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jun 2019 17:56:54 -0400
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jun 2019 17:56:54 EDT
Received: from smtp.aristanetworks.com (localhost [127.0.0.1])
        by smtp.aristanetworks.com (Postfix) with ESMTP id E862441C563;
        Mon, 10 Jun 2019 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1560203420;
        bh=SDUUrT3RcmDg9hRVIrJ4rtuNmtlz5wGHFXGKRoT5qvg=;
        h=Date:To:Subject:From;
        b=N1u0tdk+5JhKTazLCB5efNPr45odSOjNj7H70c8TZ73yKAHrLZ0aUVHIGkqy+e0tz
         3Y3jZIKwcbNV6c/cen3xxioAyhL+9OfimaGuFOHwlhyEk+bDInYCzB+YU/s9qGTfFy
         F/HnyKNjwj1c8YPOa4IDd2VW0oMzq2Z/OYNt5AF3HmGnwuj6JiOukFcKg1rhiKV+pD
         0je5lz0odpkfS4zVkFh61HdEMCiCzRkVo6W6J2+I35uxSlhA3AckKMGVPmX3rP2Ty6
         D55Oz+hyIOSMsfQbgp477ClvVmwPYLycv1N9V9W1BrvQAMHK11ze36qbvGS/CLbdT9
         SdWYukF/LDvEQ==
Received: from us180.sjc.aristanetworks.com (us180.sjc.aristanetworks.com [172.25.230.4])
        by smtp.aristanetworks.com (Postfix) with ESMTP id E51B941C562;
        Mon, 10 Jun 2019 14:50:20 -0700 (PDT)
Received: by us180.sjc.aristanetworks.com (Postfix, from userid 10189)
        id 694BA95C1DF4; Mon, 10 Jun 2019 14:49:54 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:49:54 -0700
To:     fruggeri@arista.com, gtertych@cisco.com, gwendal@chromium.org,
        bvanassche@acm.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        stable@vger.kernel.org, jaegeuk@kernel.org
Subject: Re: [PATCH v2] loop: avoid EAGAIN, if offset or block size are
 changed
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20190610214954.694BA95C1DF4@us180.sjc.aristanetworks.com>
From:   fruggeri@arista.com (Francesco Ruggeri)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> This patch tries to avoid EAGAIN due to nrpages!=0 that was originally trying
> to drop stale pages resulting in wrong data access.
> Report: https://bugs.chromium.org/p/chromium/issues/detail?id=938958#c38
> 
> Cc: <stable@vger.kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Bart Van Assche <bvanassche@acm.org>
> Fixes: 5db470e229e2 ("loop: drop caches if offset or block_size are changed")
> Reported-by: Gwendal Grignou <gwendal@chromium.org>
> Reported-by: grygorii tertychnyi <gtertych@cisco.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v2 from v1:
>  - remove obsolete jump

FWIW, after applying this patch to 4.19.47, losetup is not failing any
more for me.

Thanks,
Francesco Ruggeri


