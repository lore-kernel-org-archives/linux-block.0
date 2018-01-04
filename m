Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:39516 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbeADTIU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jan 2018 14:08:20 -0500
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-8-logang@deltatee.com>
Message-ID: <078f4435-22ac-1ff7-0b91-5022e22d126e@deltatee.com>
Date: Thu, 4 Jan 2018 12:08:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180104190137.7654-8-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 07/12] nvme-pci: clean up CMB initialization
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 04/01/18 12:01 PM, Logan Gunthorpe wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Refactor the call to nvme_map_cmb, and change the conditions for probing
> for the CMB.  First remove the version check as NVMe TPs always apply
> to earlier versions of the spec as well.  Second check for the whole CMBSZ
> register for support of the CMB feature instead of just the size field
> inside of it to simplify the code a bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Oops, I forgot:

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
