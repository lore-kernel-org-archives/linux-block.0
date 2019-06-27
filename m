Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5A5C48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 06:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3E720656
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 06:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m4qtlRsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfF0GcZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 02:32:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34746 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0GcZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 02:32:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so722632plt.1
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2019 23:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CxcmhcduYl1f+p8Q6K2P2tN31Ue+lZEcvfx29yQXcTA=;
        b=m4qtlRsuSk58BwN1KjuVxv1OBILIvoJnLL/W5x8gKQGKClqscPAZtSz5HIvZkBZeaP
         3YNDZbTITdkT9d4NODS4YBRtUWymp+dc1Frl9vN52KgPgeSBy8PuVOd1wpDqdViUXGuU
         TaoL6w12s1LCWVE6nAVStEUf6ToOh2LrH0l4rAjW0YWcykR1wBUiW/kiHYkRyaFw/b+m
         5RKkHPbZrlfJtX/jysSBDiQyarjXby+MLOi6XZdFtLwkUxPqEd3s89nrZCy07o0cLs07
         /nNhohMH1gqtNbY5OQLkVy7sE3hn5AauPYz18DSUKOmknEkjo7985c+vomp74sOA3gvV
         PN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CxcmhcduYl1f+p8Q6K2P2tN31Ue+lZEcvfx29yQXcTA=;
        b=Pg9CY2LGNUPYSk7tbTJdvabABFTQsTbTGBG+3KCNROcB9BhxeUCKb1ubRG3ndKgUcl
         6bWgPoV6WFx5gsOeOzQ42Kbr+povz8zL7moRy0BLnMlyqYK1yXJVj/E+xv2ta6BTTpnE
         nhQzcuoIR0OCF6Eh3qTnvD6wLB9HiBEsdmfhC7+wyJ4m0G5hx4FOGOaBQyIroIgZ6Y0T
         rsTHoW0U3fG9+r7/90UUnRmg4XAPQ8lai6GSWa+ThdhW5V3OAEztxRtYY3wZRr/cUPc6
         Brc3NPxtDfgh3itG0cD9lulRzLh1FlmO/nKOYZQ5DECGSZqe1T32YyqDCI5U0C0x+3Pj
         QsPQ==
X-Gm-Message-State: APjAAAWHKWY1ncTpVb80U9WHiGJQk0CBC4TykBPieMfRNj1QfKxVdURU
        ssfdPcuhPMug37xNt23dvtC3Yw==
X-Google-Smtp-Source: APXvYqwZ07G5863ndEAB+RksF+e+99jGlEHoSljL/kmhY9ivkki8aBvxOy/aBdnHgI3TPZQaVOsxJA==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr2700794plf.86.1561617144785;
        Wed, 26 Jun 2019 23:32:24 -0700 (PDT)
Received: from ziepe.ca ([12.199.206.50])
        by smtp.gmail.com with ESMTPSA id k184sm1017237pgk.7.2019.06.26.23.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 23:32:24 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgNxH-00029V-At; Thu, 27 Jun 2019 03:32:23 -0300
Date:   Thu, 27 Jun 2019 03:32:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190627063223.GA7736@ziepe.ca>
References: <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
 <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
 <20190626202107.GA5850@ziepe.ca>
 <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
 <20190626210018.GB6392@ziepe.ca>
 <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 26, 2019 at 03:18:07PM -0600, Logan Gunthorpe wrote:
> > I don't think we should make drives do that. What if it got CMB memory
> > on some other device?
> 
> Huh? A driver submitting P2P requests finds appropriate memory to use
> based on the DMA device that will be doing the mapping. It *has* to. It
> doesn't necessarily have control over which P2P provider it might find
> (ie. it may get CMB memory from a random NVMe device), but it easily
> knows the NVMe device it got the CMB memory for. Look at the existing
> code in the nvme target.

No, this all thinking about things from the CMB perspective. With CMB
you don't care about the BAR location because it is just a temporary
buffer. That is a unique use model.

Every other case has data residing in BAR memory that can really only
reside in that one place (ie on a GPU/FPGA DRAM or something). When an IO
against that is run it should succeed, even if that means bounce
buffering the IO - as the user has really asked for this transfer to
happen.

We certainly don't get to generally pick where the data resides before
starting the IO, that luxury is only for CMB.

> > I think with some simple caching this will become negligible for cases
> > you care about
> 
> Well *maybe* it will be negligible performance wise, but it's also a lot
> more complicated, code wise. Tree lookups will always be a lot more
> expensive than just checking a flag.

Interval trees are pretty simple API wise, and if we only populate
them with P2P providers you probably find the tree depth is negligible
in current systems with one or two P2P providers.

Jason
