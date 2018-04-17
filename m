Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751082AbeDQFvJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Apr 2018 01:51:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3H5nWHV090340
        for <linux-block@vger.kernel.org>; Tue, 17 Apr 2018 01:51:09 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hd7dcrj9n-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 17 Apr 2018 01:51:09 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Tue, 17 Apr 2018 06:51:07 +0100
Subject: Re: [PATCH 01/12] iommu-common: move to arch/sparc
To: David Miller <davem@davemloft.net>, khandual@linux.vnet.ibm.com
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-2-hch@lst.de>
 <f0305a92-b206-1567-3c25-67fbd194047d@linux.vnet.ibm.com>
 <20180416.095833.969403163564136309.davem@davemloft.net>
Cc: hch@lst.de, konrad.wilk@oracle.com,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-ide@vger.kernel.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 11:20:58 +0530
MIME-Version: 1.0
In-Reply-To: <20180416.095833.969403163564136309.davem@davemloft.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <f5741528-427d-3537-5498-2080766df0fe@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/16/2018 07:28 PM, David Miller wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Date: Mon, 16 Apr 2018 14:26:07 +0530
> 
>> On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
>>> This code is only used by sparc, and all new iommu drivers should use the
>>> drivers/iommu/ framework.  Also remove the unused exports.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Right, these functions are used only from SPARC architecture. Simple
>> git grep confirms it as well. Hence it makes sense to move them into
>> arch code instead.
> 
> Well, we put these into a common location and used type friendly for
> powerpc because we hoped powerpc would convert over to using this
> common piece of code as well.
> 
> But nobody did the powerpc work.
> 
> If you look at the powerpc iommu support, it's the same code basically
> for entry allocation.

I understand. But there are some differences in iommu_table structure,
how both regular and large IOMMU pools are being initialized etc. So
if the movement of code into SPARC help cleaning up these generic config
options in general, I guess we should do that. But I will leave it upto
others who have more experience in this area.

+mpe
