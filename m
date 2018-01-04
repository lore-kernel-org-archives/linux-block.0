Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:39526 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752663AbeADTIb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jan 2018 14:08:31 -0500
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-9-logang@deltatee.com>
Message-ID: <4432ed79-e463-e868-64af-0f130dafb261@deltatee.com>
Date: Thu, 4 Jan 2018 12:08:29 -0700
MIME-Version: 1.0
In-Reply-To: <20180104190137.7654-9-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 08/12] nvme-pci: clean up SMBSZ bit definitions
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 04/01/18 12:01 PM, Logan Gunthorpe wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Define the bit positions instead of macros using the magic values,
> and move the expanded helpers to calculate the size and size unit into
> the implementation C file.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Oops, I forgot:

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
