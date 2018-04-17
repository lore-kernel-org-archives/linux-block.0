Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:51685 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753443AbeDQMx6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Apr 2018 08:53:58 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        David Miller <davem@davemloft.net>, khandual@linux.vnet.ibm.com
Cc: hch@lst.de, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/12] iommu-common: move to arch/sparc
In-Reply-To: <f5741528-427d-3537-5498-2080766df0fe@linux.vnet.ibm.com>
References: <20180415145947.1248-1-hch@lst.de> <20180415145947.1248-2-hch@lst.de> <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com> <20180416.095833.969403163564136309.davem@davemloft.net> <f5741528-427d-3537-5498-2080766df0fe@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 22:53:53 +1000
Message-ID: <87wox60za6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> On 04/16/2018 07:28 PM, David Miller wrote:
>> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> Date: Mon, 16 Apr 2018 14:26:07 +0530
>> 
>>> On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
>>>> This code is only used by sparc, and all new iommu drivers should use the
>>>> drivers/iommu/ framework.  Also remove the unused exports.
>>>>
>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>
>>> Right, these functions are used only from SPARC architecture. Simple
>>> git grep confirms it as well. Hence it makes sense to move them into
>>> arch code instead.
>> 
>> Well, we put these into a common location and used type friendly for
>> powerpc because we hoped powerpc would convert over to using this
>> common piece of code as well.
>> 
>> But nobody did the powerpc work.
 
Sorry.

>> If you look at the powerpc iommu support, it's the same code basically
>> for entry allocation.
>
> I understand. But there are some differences in iommu_table structure,
> how both regular and large IOMMU pools are being initialized etc. So
> if the movement of code into SPARC help cleaning up these generic config
> options in general, I guess we should do that. But I will leave it upto
> others who have more experience in this area.
>
> +mpe

This is the first I've heard of it, I guess it's probably somewhere on
Ben's append-only TODO list.

Some of the code does look very similar, but not 100%. So someone would
need to do some work to reconcile the two and test the result. TBH I
doubt we're going to get around to it any time soon. Unless we have a
volunteer?

cheers
