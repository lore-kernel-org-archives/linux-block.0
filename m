Return-Path: <SRS0=31JE=UY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745F7C48BD5
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBEB208E3
	for <linux-block@archiver.kernel.org>; Tue, 25 Jun 2019 16:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfFYQXH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:23:07 -0400
Received: from verein.lst.de ([213.95.11.211]:36124 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfFYQXH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 12:23:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1399068B05; Tue, 25 Jun 2019 18:22:36 +0200 (CEST)
Date:   Tue, 25 Jun 2019 18:22:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
Message-ID: <20190625162235.GA9203@lst.de>
References: <20190625024625.23976-1-damien.lemoal@wdc.com> <20190625024625.23976-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625024625.23976-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 25, 2019 at 11:46:23AM +0900, Damien Le Moal wrote:
> To allow the SCSI subsystem scsi_execute_req() function to issue
> requests using large buffers that are better allocated with vmalloc()
> rather than kmalloc(), modify bio_map_kern() to allow passing a buffer
> allocated with the vmalloc() function. To do so, simply test the buffer
> address using is_vmalloc_addr() and use vmalloc_to_page() instead of
> virt_to_page() to obtain the pages of vmalloc-ed buffers.

This is broken on architectures with VIVT caches.  You need to flush
and invalidate the caches based on the virtual address on those before
performing DMA operations.
