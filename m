Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50797 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752494AbdDFSvG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Apr 2017 14:51:06 -0400
Date: Thu, 6 Apr 2017 20:50:53 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        James Smart <james.smart@broadcom.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 03/25] nvme-fc: fix status code handling in
 nvme_fc_fcpio_done
Message-ID: <20170406185053.GC8673@linux-x5ow.site>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170406153944.10058-4-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 06, 2017 at 05:39:22PM +0200, Christoph Hellwig wrote:
> nvme_complete_async_event expects the little endian status code
> including the phase bit, and a new completion handler I plan to
> introduce will do so as well.
> 
> Change the status variable into the little endian format with the
> phase bit used in the NVMe CQE to fix / enable this.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
