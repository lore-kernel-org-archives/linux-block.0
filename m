Return-Path: <SRS0=mBf9=44=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7612FC0044D
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 19:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF2B2074B
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 19:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UT46SWQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgCKTDP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:03:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41608 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgCKTDP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 15:03:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id l21so2408799qtr.8
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2020 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vPEXaVzZ83ctsAcbnGyir6CbgBRHZk7g043rsBdHS7A=;
        b=UT46SWQURx3Jox3NieovHdHKn1S/dJt42j0ej3amOv24/IYkMP4E7ImEe8LHZL8ib3
         qgukaPorVF+fAF3Eh/1eWul7pf5fDMb1fMY74r0N2nSLBeWGD+YeYbkvy1swMmh5cYPu
         zvhSzSEbXaOTIv4C+QvGsD8/+4DBnoweKHDAEEMktY3mk8kNgPdoZZCPMbWuXuhaoZWX
         t60cICXzvoz4xFAfHwFrBFTYV27+fxJ5WjzO9RzjrFeUXyfO6B0hdQV2C5877snrwuqH
         cN00+ygB1DN5YsHND14hOWG31WlD4svEEFV55ixVmhjpniVRPb9Fae2lNVQZ6N1jY2Lq
         ZOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vPEXaVzZ83ctsAcbnGyir6CbgBRHZk7g043rsBdHS7A=;
        b=HKZgEBjggDZNfV6+IINeyWChcJ4ZQbQ23G3/Tg+AKIpDlVbnqJ5gcgDG/HReLj88xS
         5ETyJUu8jYaPBQjpfbBPI0+OHTo5SsW4ajE858QGCd5OModdSFjHbOjd6fm6AVwfdvW2
         W+ZE001eQXwtLhtkwqookqsHvvnv/b0QREy4nnwRrUvYxokoRkX2nmLvl3suUKG5hkFq
         v8CZwmbb2qbT+IoEas4oDuFRwWxiiUpJFeNJLXlPlLF8IjrfSm/GsRlUzLpYf3qfSFju
         zw12jF2VC9jhIhIHGQe/FC+zpJgJKh/ZPGKGLASaGh+GuSb1zGZQ/ZR9/b9btbi7bdBn
         4U8A==
X-Gm-Message-State: ANhLgQ0TDyR6YaxsE1JqbvSHs/4U/OE6HJVIgbeCfkqBWCCGfg7aWDCR
        8bcTkfmJ3EPUA9leZZx4s+X9RQ==
X-Google-Smtp-Source: ADFU+vu5sssFtROMrydzHyogrnks202IHFdOtGSlESGnx7j483omqNKOGCOJiKW9YhoVfjVOy9zT8g==
X-Received: by 2002:ac8:5448:: with SMTP id d8mr3912011qtq.205.1583953394809;
        Wed, 11 Mar 2020 12:03:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w2sm26029985qto.73.2020.03.11.12.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 12:03:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jC6dN-0001Ox-Ur; Wed, 11 Mar 2020 16:03:13 -0300
Date:   Wed, 11 Mar 2020 16:03:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v10 13/26] RDMA/rtrs: include client and server modules
 into kernel compilation
Message-ID: <20200311190313.GI31668@ziepe.ca>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-14-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311161240.30190-14-jinpu.wang@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 11, 2020 at 05:12:27PM +0100, Jack Wang wrote:
> Add rtrs Makefile, Kconfig and also corresponding lines into upper
> layer infiniband/ulp files.
> 
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/Kconfig           |  1 +
>  drivers/infiniband/ulp/Makefile      |  1 +
>  drivers/infiniband/ulp/rtrs/Kconfig  | 27 +++++++++++++++++++++++++++
>  drivers/infiniband/ulp/rtrs/Makefile | 15 +++++++++++++++
>  4 files changed, 44 insertions(+)
>  create mode 100644 drivers/infiniband/ulp/rtrs/Kconfig
>  create mode 100644 drivers/infiniband/ulp/rtrs/Makefile

How is this using ib_devices without having a struct ib_client ?

Jason
