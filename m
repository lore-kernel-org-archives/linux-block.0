Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9952C433E0
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 06:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7D364FF6
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 06:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhCJGyf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 01:54:35 -0500
Received: from verein.lst.de ([213.95.11.211]:34771 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhCJGy2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 01:54:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 68A4768B05; Wed, 10 Mar 2021 07:54:25 +0100 (CET)
Date:   Wed, 10 Mar 2021 07:54:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <lkp@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] libnvdimm: Notify disk drivers to revalidate region
 read-only
Message-ID: <20210310065425.GA1794@lst.de>
References: <161534060720.528671.2341213328968989192.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161534060720.528671.2341213328968989192.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Question on the pre-existing code: given that nvdimm_check_and_set_ro is
the only caller of set_disk_ro for nvdimm devices, we'll also get
the message when initially setting up any read-only disk.  Is that
intentional?
