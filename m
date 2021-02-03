Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC70CC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AB764F7C
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 16:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBCQku (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 11:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBCQkt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Feb 2021 11:40:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F938C061573
        for <linux-block@vger.kernel.org>; Wed,  3 Feb 2021 08:40:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z9so4846926pjl.5
        for <linux-block@vger.kernel.org>; Wed, 03 Feb 2021 08:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j3MACQpnuqGVpQsy3KngN7JFxGDPqflMkHc7jCu2+Bk=;
        b=kb75osgVkGLP7nw/eUzoCa917IYCAL78mQwibl/pzX9xAIu/hojZ7Byalq05Bn5Kt1
         JgfGQmpFfGwrvtgm/w716eSErLcQVGa4Sk2HcQkLhlZ6lrVAFBdxtiJ3CfTl+JV9UQJv
         DtnLnBOKPmwcfGhGwpD1F5pYTKqegD3YbjSKY1nhTm3WtZ2yaF3C878k22cDqJzQeVVm
         ejIVUQH9V164yi0Y3mjj+sHd10xsJGfk2zVsy7c4erErjW1kLTHGFVL0pawkO0svsNgv
         oN0cxsSLsKVuEvt8ISkurPWPY9dEpV1ruX0su0GWEdjMpMY3DVljy2qultYnLMeUeVLT
         hvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j3MACQpnuqGVpQsy3KngN7JFxGDPqflMkHc7jCu2+Bk=;
        b=R0QsdgIB4WSvFMQ3J18f55NpMfE3yPnijEoaWMcU/ukOh/X9oX2i/52VEHa71X9lmJ
         koURUEcttVHpqLzpNdX0Tuh6T/9rs9QHLIwYIZYU6Fl3coQAO62cM2+hOR7JUT7mVNn+
         8nzqan8EvWO6Ts8pN7+kOBpXyIVCOzsgfJRV/wNBLoFsMrRcUHcbMVlw8ck5hwzAalKX
         jjZzHFdi/hyC4qIMDH7N5KZJCc347+A52seMV+MgEiMm6nunLeXKehoOxX8Lbi2hL+//
         yXQrNHT1R4V9BbPv4flJpvQOuXJeAn1iKgSMTpNf/eU4yiWUTTEgrx+WuxQpsONPBpHR
         g3aQ==
X-Gm-Message-State: AOAM532zL2hGmvX3q2lPZaXTq9ekVlkIxKXNovPiRR/ABHgcnpfhd5Xr
        0PyZ/IBGpKalrl9fAB2RDnwssg==
X-Google-Smtp-Source: ABdhPJwVKtcUzVUTXRCBLNcvhjzd6kFIOtwnEtIx1aqjn0knDk0sGs7/KlJ5XREuFU08UxT0YKCiaA==
X-Received: by 2002:a17:90a:590c:: with SMTP id k12mr3861544pji.233.1612370408647;
        Wed, 03 Feb 2021 08:40:08 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1510])
        by smtp.gmail.com with ESMTPSA id v21sm2793904pfn.80.2021.02.03.08.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 08:40:06 -0800 (PST)
Date:   Wed, 3 Feb 2021 08:40:05 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH blktests 3/3] rdma: Use rdma link instead of
 /sys/class/infiniband/*/parent
Message-ID: <YBrR5anAHkyL4EVg@relinquished.localdomain>
References: <20210126044519.6366-1-bvanassche@acm.org>
 <20210126044519.6366-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126044519.6366-4-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 25, 2021 at 08:45:19PM -0800, Bart Van Assche wrote:
> The approach of verifying whether or not an RDMA interface is associated
> with the rdma_rxe interface by looking up its parent device is deprecated
> and will be removed soon from the Linux kernel. Hence this patch that uses
> the rdma link command instead.
> 
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  common/multipath-over-rdma | 111 +++++++++++--------------------------
>  tests/srp/rc               |   9 +--
>  2 files changed, 32 insertions(+), 88 deletions(-)

I think we need to add _have_program rdma checks to srp and nvmeof-mp,
right? The first two patches look fine, I'll merge those.
