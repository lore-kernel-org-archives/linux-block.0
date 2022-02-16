Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13C2C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 18:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiBPSpZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 13:45:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiBPSpZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 13:45:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC5B623A1A2
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 10:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645037112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OOx+E3QllfryzTFmIymhQ3ST1693x2OfbOWkWxjfBfw=;
        b=XsVbwmPcoj0OvA9VesA65GAUjvsK0+A/EhzrnMsYP3NGAz1Io4gWeuLruYhhwZKFN6/K1Q
        aM44LPyYXujcyqDPC5XMSAYnFVaJnnyGLe71VoUnbdTGrnl/wbCpWSSY3bj9d+8Ur4H9OC
        D9WQYNH4OFPwLG0BT/E2RMX1BsTMZTA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-hSQ1VrQmMWmGecY4RsB9Tw-1; Wed, 16 Feb 2022 13:45:10 -0500
X-MC-Unique: hSQ1VrQmMWmGecY4RsB9Tw-1
Received: by mail-qk1-f197.google.com with SMTP id t10-20020a37aa0a000000b00605b9764f71so1921555qke.22
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 10:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OOx+E3QllfryzTFmIymhQ3ST1693x2OfbOWkWxjfBfw=;
        b=lbpxNkwtxSW+PF/kndj6lu+bNgCHcHXl0nk92c76ErUMpWT4XHVS2ujh1iVZoUeECI
         wUgsvaXZyeRSvjMMZe7DtQ92nTJ0yU4p2G61TLbPcFve5TEhgOCrDyeATodxTMyhDeQA
         oowOUK+i3pCd5I8sTAD48KuvmzjLeDj7DoxrVz9CqW8OJu+9OttLJI6qhlrKG0yaFleh
         5RqVOVO9n+A9pNMygOHr+pMDoCA2OdtjBUj4yWTxh3rfmpLS+kPNtu+mr/ExmbYkmwJe
         2W8KOSnwM2syAucq+yhrRRU9IcoMh4bHXmHkkiY9p0kyKwZEn6a4aC+obnggTUPbPL/W
         /lMA==
X-Gm-Message-State: AOAM533ENLH6L2pGbx4uapz1Pc3L7A5PWgG/YFP3StOX3vdotVj9fKBG
        afAPblpKZr8bFHkEFB91jvr2i3j+Ib6ukBIQNqOzE6QKHld+QlT/uRN1/yRN/UqajQMKM7ksOy4
        6aIFOYv5Cua2mUYQ+kc5Ekg==
X-Received: by 2002:a05:6214:21ed:b0:42c:11d1:70cd with SMTP id p13-20020a05621421ed00b0042c11d170cdmr2797946qvj.115.1645037110081;
        Wed, 16 Feb 2022 10:45:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJgOjhzSS8RxxVMNtzc6xG6mkVlUt//oPzsjAQ7SdjdxSfis7RMELX8WfonQ2JnnKXjLlDqw==
X-Received: by 2002:a05:6214:21ed:b0:42c:11d1:70cd with SMTP id p13-20020a05621421ed00b0042c11d170cdmr2797925qvj.115.1645037109867;
        Wed, 16 Feb 2022 10:45:09 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id i4sm20421081qkn.13.2022.02.16.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 10:45:09 -0800 (PST)
Date:   Wed, 16 Feb 2022 13:45:08 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        target-devel@vger.kernel.org, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, manoj@linux.ibm.com, mrochs@linux.ibm.com,
        ukrishn@linux.ibm.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com
Subject: Re: [PATCH 6/7] dm: remove write same support
Message-ID: <Yg1GNMD6jIrKOxBE@redhat.com>
References: <20220209082828.2629273-1-hch@lst.de>
 <20220209082828.2629273-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209082828.2629273-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 09 2022 at  3:28P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> There are no more end-users of REQ_OP_WRITE_SAME left, so we can start
> deleting it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks.

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

