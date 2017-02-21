Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:38830 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752960AbdBUSbK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Feb 2017 13:31:10 -0500
Date: Tue, 21 Feb 2017 19:31:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, kernel-team@fb.com
Subject: Re: [PATCH] scsi_transport_sas: fix BSG ioctl memory corruption
Message-ID: <20170221183107.GA32368@lst.de>
References: <e33a218846e718a310fd8bd92acbafd0b6252aca.1487700062.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e33a218846e718a310fd8bd92acbafd0b6252aca.1487700062.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Feb 21, 2017 at 10:03:50AM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The end_device and sas_host devices support BSG ioctls, but the
> request_queue allocated for them isn't set up to allocate the struct
> scsi_request payload. This leads to memory corruption in the call to
> scsi_req_init() in bsg_map_hdr(), since it will memset past the end of
> the allocated request. Fix it by setting ->cmd_size on the allocated
> request_queue.

Oh, I missed that SAS still opencodes it's queue allocations.

Acked-by: Christoph Hellwig <hch@lst.de>
