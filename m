Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:46458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755403AbcLUHuG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2016 02:50:06 -0500
Date: Tue, 20 Dec 2016 23:50:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Cc: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, gpiccoli@linux.vnet.ibm.com
Subject: Re: [PATCH] scsi: do not requeue requests unaligned with device
 sector size
Message-ID: <20161221075003.GA22860@infradead.org>
References: <1482199347-9128-1-git-send-email-mauricfo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482199347-9128-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 20, 2016 at 12:02:27AM -0200, Mauricio Faria de Oliveira wrote:
> When a SCSI command (e.g., read operation) is partially completed
> with good status and residual bytes (i.e., not all the bytes from
> the specified transfer length were transferred) the SCSI midlayer
> will update the request/bios with the completed bytes and requeue
> the request in order to complete the remainder/pending bytes.
> 
> However, when the device sector size is greater than the 512-byte
> default/kernel sector size, alignment restrictions and validation
> apply (both to the starting logical block address, and the number
> of logical blocks to transfer) -- values must be multiples of the
> device sector size, otherwise the kernel fails the request in the
> preparation stage (e.g., sd_setup_read_write_cmnd() at sd.c file):

How do you even get an unaligned residual count?  Except for SES
processor devices (which will only issue BLOCK_PC commands) this is
not allowed by SPC:

"The residual count shall be reported in bytes if the peripheral device
 type in the destination target descriptor is 03h (i.e., processor device),
 and in destination device blocks for all other device type codes."
