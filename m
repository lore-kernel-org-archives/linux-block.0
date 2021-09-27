Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B626AC433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 19:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985FF60FED
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 19:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbhI0UBW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 16:01:22 -0400
Received: from ale.deltatee.com ([204.191.154.188]:49918 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbhI0UBW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 16:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=nFEeN0ujMiWdqCQg1tqJRECutZ61Fc29BGC8Ude8l7g=; b=HYTSUNK2m6vrGXoe7SbsnxxGxe
        UQhGMqvZ/3e0mwmIFqbh3/n3ys2rpANTZZ08LPv9vUH+eRel9L/vzT/IV52IDaRD8cbIVcNhkde4Y
        BjPnJkoG3FgF8gieIcEetEXupBiv03MzpOEGqmyAIxf/kUOigsbkdwvNJIlqLB2iU3DSGdnb4zcSb
        bFvSDuFQkjonU4Kfg53nhrYhkbKPbtnaiMtkFHIF3SWjAy7qk4+miKMdzHmkmmFDGNkPtqyrV2uK2
        zrS2ECxQknjsTZ93JZDzAAansVKP85mqOC5PGL6qdXlqF6jxkLQOPblVFCO//uAc3RMqAr4PZHfhC
        YakW+B5A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mUwmL-0003kf-0f; Mon, 27 Sep 2021 13:59:09 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210927185348.GA668256@bhelgaas>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <863fcca6-e1e7-38f4-2f67-b52d33eb3aab@deltatee.com>
Date:   Mon, 27 Sep 2021 13:59:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210927185348.GA668256@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 04/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021-09-27 12:53 p.m., Bjorn Helgaas wrote:
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Ditto.

Thanks Bjorn, I'll make these changes and add your Acks for subsequent
postings.

Logan
