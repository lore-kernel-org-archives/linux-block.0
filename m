Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0088.outbound.protection.outlook.com ([104.47.34.88]:7615
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933042AbdA0RjT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 12:39:19 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH 11/18] scsi: remove gfp_flags member in
 scsi_host_cmd_pool
Date: Fri, 27 Jan 2017 17:38:47 +0000
Message-ID: <1485538708.4267.12.camel@sandisk.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
         <1485365126-23210-12-git-send-email-hch@lst.de>
In-Reply-To: <1485365126-23210-12-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-25 at 18:25 +0100, Christoph Hellwig wrote:
> When using the slab allocator we already decide at cache creation time if
> an allocation comes from a GFP_DMA pool using the SLAB_CACHE_DMA flag,
> and there is no point passing the kmalloc-family only GFP_DMA flag to
> kmem_cache_alloc.  Drop all the infrastructure for doing so.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
