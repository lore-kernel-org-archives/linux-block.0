Return-Path: <linux-block-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:41426 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755040AbeDPN6s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Apr 2018 09:58:48 -0400
Date: Mon, 16 Apr 2018 09:58:33 -0400 (EDT)
Message-Id: <20180416.095833.969403163564136309.davem@davemloft.net>
To: khandual@linux.vnet.ibm.com
Cc: hch@lst.de, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/12] iommu-common: move to arch/sparc
From: David Miller <davem@davemloft.net>
In-Reply-To: <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com>
References: <20180415145947.1248-1-hch@lst.de>
        <20180415145947.1248-2-hch@lst.de>
        <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 14:26:07 +0530

> On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
>> This code is only used by sparc, and all new iommu drivers should use the
>> drivers/iommu/ framework.  Also remove the unused exports.
>> 
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Right, these functions are used only from SPARC architecture. Simple
> git grep confirms it as well. Hence it makes sense to move them into
> arch code instead.

Well, we put these into a common location and used type friendly for
powerpc because we hoped powerpc would convert over to using this
common piece of code as well.

But nobody did the powerpc work.

If you look at the powerpc iommu support, it's the same code basically
for entry allocation.
