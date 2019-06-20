Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBECFC48BE1
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 17:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F7521479
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 17:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fDa+hMU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbfFTRXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:23:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46527 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbfFTRXu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so3929353qtn.13
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SfbKUCdSGF4+jFDRzcaQ+Fna6TrcXDnyta04yl7lq1Y=;
        b=fDa+hMU4rcsLRRCH2gWRtgjYh9RFedwMwqv0Trz+YbWuMGaoX85v7I71KOkTii51uB
         oO9IljJOAF7bcm1YYxdaerj3SB1eX+ROcV7aGqi3ZBwoKVBEGC2K9Gm0a4yLiiEn/uAk
         fBk5sWnkPe6Qfa4DgWWmQRbh4XlFAlCgTAsATQPIvgIfBdORGI7YHDMsJoSK7wBXLdyk
         G7L29YhKyUqgAQjd6fwdckTK5NEQcVswgxlSYd5TMwXXMxxdYk5swQozsEqhRL82kEHN
         PYoc9M2dsT9k3d119XICrYvVvAjQcFqPNiWbp3QBf8xLIqoPCbUOF1ztjjMN/UPlCr8M
         O9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SfbKUCdSGF4+jFDRzcaQ+Fna6TrcXDnyta04yl7lq1Y=;
        b=l6WDndZdviZswJ4SGKIyzee8vTietrUiRZuLaiqX1eL7IGkjU9beFTJr8+A6BdlG4C
         t4ltAiahlNnOM8vg7e6Q1dxTapktxBgq9XdGlaAVagu5kEFgIGEOqGln2jk7dIaMFDdS
         ReWa6Ol6d5G//PQ9YgghjuPqs/J7cZMmzsMCKMukRdciDYekBYBgYzGbAD0T4azjd1gG
         b7hJ5MR36EG5M3wN0khpT0eZ3uhLnUxdE/3KiGJaxB5ZZpMicgdh/rmyOUL9LHE+Ioba
         666E3noJuN5SxEXeWe4DzA3MtSTqHXcOdsytciDB9ptRn3LgjKrLmq0PkZZ4CjMfMvKy
         m2/A==
X-Gm-Message-State: APjAAAW+1fUpIkqfQsAVTINSNCHOlw2pcrYpj+HLOrIBUkIHg1St1lQV
        CH1ZdqHlXTvpts5kkzSdBLdR6w==
X-Google-Smtp-Source: APXvYqw404QwKeABmWhU9qLItoqgwLK+kwwRuUpz/G8u1JQs97zHuMB8xnbcA0CiswhJAlAz0nkrug==
X-Received: by 2002:ac8:2409:: with SMTP id c9mr53861547qtc.145.1561051428982;
        Thu, 20 Jun 2019 10:23:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c5sm109198qtj.27.2019.06.20.10.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 10:23:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1he0mq-0005eq-0K; Thu, 20 Jun 2019 14:23:48 -0300
Date:   Thu, 20 Jun 2019 14:23:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 04/28] block: Never bounce dma-direct bios
Message-ID: <20190620172347.GE19891@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <20190620161240.22738-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620161240.22738-5-logang@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 20, 2019 at 10:12:16AM -0600, Logan Gunthorpe wrote:
> It is expected the creator of the dma-direct bio will ensure the
> target device can access the DMA address it's creating bios for.
> It's also not possible to bounce a dma-direct bio seeing the block
> layer doesn't have any way to access the underlying data behind
> the DMA address.
> 
> Thus, never bounce dma-direct bios.

I wonder how feasible it would be to implement a 'dma vec' copy
from/to? 

That is about the only operation you could safely do on P2P BAR
memory. 

I wonder if a copy implementation could somehow query the iommu layer
to get a kmap of the memory pointed at by the dma address so we don't
need to carry struct page around?

Jason
