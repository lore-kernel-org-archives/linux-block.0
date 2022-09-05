Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6880C54EE9
	for <linux-block@archiver.kernel.org>; Mon,  5 Sep 2022 14:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiIEOd6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Sep 2022 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiIEOd5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2022 10:33:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29945A883;
        Mon,  5 Sep 2022 07:33:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D5E668AA6; Mon,  5 Sep 2022 16:33:51 +0200 (CEST)
Date:   Mon, 5 Sep 2022 16:33:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 2/8] iov_iter: introduce
 iov_iter_get_pages_[alloc_]flags()
Message-ID: <20220905143351.GA5813@lst.de>
References: <20220825152425.6296-1-logang@deltatee.com> <20220825152425.6296-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825152425.6296-3-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 25, 2022 at 09:24:19AM -0600, Logan Gunthorpe wrote:
> Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
> which take a flags argument that is passed to get_user_pages_fast().
> 
> This is so that FOLL_PCI_P2PDMA can be passed when appropriate.

Any reason why iov_iter_get_pages2 doesn't call iov_iter_get_pages_flags
and same for the __alloc version?

Also with the "main" version now having the 2 postfix, we can just
use the iov_iter_get_pages name for the flags version, and maybe
eventually just convert all users over to it.
