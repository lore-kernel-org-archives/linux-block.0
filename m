Return-Path: <SRS0=SpOq=7F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CC6C433E2
	for <linux-block@archiver.kernel.org>; Sat, 23 May 2020 00:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0323A206B6
	for <linux-block@archiver.kernel.org>; Sat, 23 May 2020 00:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ndFRfkW+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbgEWAY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 20:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731169AbgEWAY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 20:24:59 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE148C061A0E
        for <linux-block@vger.kernel.org>; Fri, 22 May 2020 17:24:57 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id fb16so5586230qvb.5
        for <linux-block@vger.kernel.org>; Fri, 22 May 2020 17:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mDfFc75sDDtwBZ/uqNakKrJId/ZguX7g2hGxTq1lsgw=;
        b=ndFRfkW+UVWd402BkSqR2tPWtzIY+uzl9pPRC7BsX8lKsZw/j3+0yHvtc4O2CMbW97
         H+n+qgYDLxUBknuKdDE0f1TuzcBjPFITotx5Io3/y/u+1oQURn1k3QtNyEh0PKZPsTVz
         LaZRm4kHOKHeybQoaCtY4yq8cDvuJkQPYygCpgp3YJCjd8U+ChphPk7SsdnrrhEvkYBw
         M5+yq+Xvt2BFfrPHusTKMSczLZfuKOIU8GkLdlhlbm+qTYnMRa8W7LlNGXJkc4/a4ZDh
         vt9p7HXjFANbtFdyUwPAegYUVkOcQLUP8ucBqA4b8qzx73YS+ZC2Ee/fD5aEAAa+cW4Z
         XN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mDfFc75sDDtwBZ/uqNakKrJId/ZguX7g2hGxTq1lsgw=;
        b=KYSkZBbN0XqOOLateeWM2rdh/hOo2hWO5oAaaQR1cglW6661cwvdNfpzRiT+JF7E/+
         XcQDw6A/aKQmhZdYE1v0K/dObBgTRdzZB3QGl8ykrHz2n+vDD118MtJDXu+4XpF6vnxH
         Q2v7DZs8dCvt9t/3mmKTzTqwVEKpdMLR9oYMphPvoJFA4e+wcK4vsGKh7mo/VF13DyOY
         JqM/vsFFSSPUPnCEblcxJexENtEQPhRVUb0mo9SDQ/ENDgtVMn4bA7bDV6MiNAyqMxE3
         xVXbeuHRzC3jMJpVrsGP6We0vPs4IKnMWRdwc5FyYaYWxkdnO4nlx5wuz7VS3UbKdp/7
         Hfew==
X-Gm-Message-State: AOAM5323kci/M5Dybp9r4qBPgIzSXcjpFGIkh8EiQSDtGD2Xg1G/IVWe
        7FK0AabVsmVsk9yQnR5axPo8vQ==
X-Google-Smtp-Source: ABdhPJwuCk5GLW1hGu/4YSRsK4CT5gffdiyTNILlyjPzeYizgnAuYaXuUJnzHN2b/0P+jPdRQuFSVw==
X-Received: by 2002:a05:6214:506:: with SMTP id v6mr6445844qvw.70.1590193497112;
        Fri, 22 May 2020 17:24:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x4sm1971826qtj.43.2020.05.22.17.24.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 17:24:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jcHyC-0002Q6-9t; Fri, 22 May 2020 21:24:56 -0300
Date:   Fri, 22 May 2020 21:24:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-next@vger.kernel.org, bvanassche@acm.org,
        dledford@redhat.com, axboe@kernel.dk, lkp@intel.com,
        jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH] RDMA/rtrs: get rid of the do_next_path while_next_path
 macros
Message-ID: <20200523002456.GB9180@ziepe.ca>
References: <20200520191105.GK31189@ziepe.ca>
 <20200522053924.528980-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522053924.528980-1-danil.kipnis@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 22, 2020 at 07:39:24AM +0200, Danil Kipnis wrote:
> The macros do_each_path/while_each_path lead to a smatch warning:
> drivers/infiniband/ulp/rtrs/rtrs-clt.c:1196 rtrs_clt_failover_req() warn: inconsistent indenting
> drivers/infiniband/ulp/rtrs/rtrs-clt.c:2890 rtrs_clt_request() warn: inconsistent indenting
> 
> Also checkpatch complains:
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> 
> The macros are used only in two places: for a normal IO path and for the
> failover path triggered after errors.
> 
> Get rid of the macros and just use a for loop iterating over the list
> of paths in both places. It is easier to read and also less lines of code.
> 
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 29 ++++++++++++--------------
>  1 file changed, 13 insertions(+), 16 deletions(-)

Applied to for-next, thanks

Jason
