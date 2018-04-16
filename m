Return-Path: <linux-ide-owner@vger.kernel.org>
Subject: Re: [PATCH 04/12] iommu-helper: move the IOMMU_HELPER config symbol
 to lib/
To: Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
References: <20180415145947.1248-1-hch@lst.de>
 <20180415145947.1248-5-hch@lst.de>
Cc: x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 15:13:04 +0530
MIME-Version: 1.0
In-Reply-To: <20180415145947.1248-5-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Message-Id: <69224eb2-7056-4894-36d8-c6e9518df647@linux.vnet.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 04/15/2018 08:29 PM, Christoph Hellwig wrote:
> This way we have one central definition of it, and user can select it as
> needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

