Return-Path: <SRS0=3eIv=UZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF782C48BD3
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29172086D
	for <linux-block@archiver.kernel.org>; Wed, 26 Jun 2019 20:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TBi220P0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZUzB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:55:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39042 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZUzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 16:55:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so2086201pls.6
        for <linux-block@vger.kernel.org>; Wed, 26 Jun 2019 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bMxdvEdLjD1A9AKJa7buamnua6ndE13zHk8/3SA0xpk=;
        b=TBi220P0cqoilOs0VNo/aK3h3vIh4DHqMWYM3/xsM7rxg8vRC9vB3FeKKle7xEF+Ub
         c/A2Ia6QYlSw7cwbMBQyfBdYv54uyZ6xKUQ+QkDRfgWgo5RypRkGjFaWm2ykPW6JTo8F
         AnNSsV+rqWfslkCLRdq/e71/2TQZYL1quvSzRdMEfoUwlhYKvfJFQIhaWQUK4ia+k7eR
         cgPQ5KRJ0Rg5DrgjBR3TmHFiMZKA7Ljeag/N58i2HxUNVWt0ybAgynqXMm44Jvtl115E
         cwHup5Tv7BqDlSNc2j2kshgnuFrTydujMQM6+FISacSwwNM9jBiIB0QzVlt2S/qrgn6h
         p0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bMxdvEdLjD1A9AKJa7buamnua6ndE13zHk8/3SA0xpk=;
        b=c8DAp/eLUKfInokTejHyiC/mhC9S6iFVpxAHkc6Zw8lgVTJ0ctZBW0KojGxwpK3QaZ
         fzIDhH2HH3TT3IR/FchYwVq8vnw8aSLNpV/P0ER65tde73o2Xm/z+bmFl+kgAMWP1Z9Q
         2VWp2/cM0Sb5bITOkhvtBeApa8dnkLv8Ltc+KEMtpUeMZRpBJ9HDJHyNaHMAU+Pdh7ZX
         APH1QFPXWlpCThgl5h4IfN9FwjGkP/anvhgOwgbj+/4UWvZr35M0OGjuJtnY13weA87Z
         jwq3B5ilmTF53GzGH0XsfG155F2o9AeCz6LWmHrW+AccZveu50zkOfjfl9s9X6gbfBTU
         f0Hg==
X-Gm-Message-State: APjAAAWJEbC3bi29X8QR+8wCQYus2rxPv2S4YAQAxN8xJWmQT7OnRVno
        6hJiNB5Wy8Av28bB7uFZeA27pw==
X-Google-Smtp-Source: APXvYqzgDH5/ikCzES5M0MRO5K7K3ifgbGjP1mRuUaIUZdDHCGw68bO7qf91SGAx47qMnghFOmD8Fw==
X-Received: by 2002:a17:902:9a87:: with SMTP id w7mr65029plp.221.1561582500008;
        Wed, 26 Jun 2019 13:55:00 -0700 (PDT)
Received: from ziepe.ca ([148.87.23.38])
        by smtp.gmail.com with ESMTPSA id t13sm3856107pjo.13.2019.06.26.13.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:54:59 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgEwU-0001lK-9d; Wed, 26 Jun 2019 17:54:58 -0300
Date:   Wed, 26 Jun 2019 17:54:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190626205458.GA6392@ziepe.ca>
References: <20190624072752.GA3954@lst.de>
 <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com>
 <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
 <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
 <20190626202107.GA5850@ziepe.ca>
 <CAPcyv4hCNoMeFyOE588=kuNUXaPS-rzaXnF2cN2TFejso1SGRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hCNoMeFyOE588=kuNUXaPS-rzaXnF2cN2TFejso1SGRw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 26, 2019 at 01:39:01PM -0700, Dan Williams wrote:
> Hmm, that sounds like dev_pagemap without the pages.

Yes, and other page related overhead. Maybe both ideas can exist in
the pagemap code?

All that is needed here is to map a bar phys_addr_t to some 'bar info'
that helps the mapping.

Jason
