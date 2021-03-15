Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B97C433E6
	for <linux-block@archiver.kernel.org>; Mon, 15 Mar 2021 16:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADEA464F41
	for <linux-block@archiver.kernel.org>; Mon, 15 Mar 2021 16:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhCOQdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Mar 2021 12:33:38 -0400
Received: from ale.deltatee.com ([204.191.154.188]:41178 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhCOQdc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Mar 2021 12:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=25tvzr6LDKuaRWZ7Kq1InXgjrQLBkOCY64hHowQXZig=; b=jd/7txTKwBaK4XM4L4pEdPfaXK
        j77z2FSuQPygPyzOaNtQeB/WuPI0mEHeLQ5XoVaOvM0peJGMT0rSFK7QLdYPovQdiR6d9crYwP30V
        U3qzhU7lI4cnhPY5eLbFwsQgHc3dgrwJ+5RCrXGFRhWPpVYBx20B8JOfELVsToLgjg+JhMv9AAQoV
        QXi+qBm+8NQLJ8YR2We0YcMp4QAshPbXnXH9nMM7W7FgIHCSgDMML5rQNraVpwyWQFm6LURTNIcjG
        M4ZrRp9VjFELAy3KrIPg5y1v+lSFYwe8hnogW0iDZtEp5btt8nr/QzFZs11lfwZQdVaCWefOipyWS
        LCYU1tFQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lLq9a-0000OV-Kj; Mon, 15 Mar 2021 10:33:15 -0600
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-8-logang@deltatee.com>
 <20210313023657.GC3402637@iweiny-DESK2.sc.intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e9a6689a-3cb7-aa30-33e7-b27015754b73@deltatee.com>
Date:   Mon, 15 Mar 2021 10:33:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210313023657.GC3402637@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, ira.weiny@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH v2 07/11] dma-mapping: Add flags to dma_map_ops to
 indicate PCI P2PDMA support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2021-03-12 7:36 p.m., Ira Weiny wrote:
> On Thu, Mar 11, 2021 at 04:31:37PM -0700, Logan Gunthorpe wrote:
>  
>> +int dma_pci_p2pdma_supported(struct device *dev)
>    ^^^
>   bool?

Sure.

> 
>> +{
>> +	const struct dma_map_ops *ops = get_dma_ops(dev);
>> +
>> +	return !ops || ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
> 
> Is this logic correct?  I would have expected.
> 
> 	return (ops && ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED);


If ops is NULL then the operations in kernel/dma/direct.c are used and
support is added to those in patch 6. So it is correct as written.

Logan
