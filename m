Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832F8C47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 05:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E0D601FC
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 05:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFHFiW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 01:38:22 -0400
Received: from verein.lst.de ([213.95.11.211]:49180 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhFHFiV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 01:38:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 23B5C67373; Tue,  8 Jun 2021 07:36:28 +0200 (CEST)
Date:   Tue, 8 Jun 2021 07:36:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     axboe@kernel.dk, Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>, nvdimm@lists.linux.dev,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] libnvdimm/pmem: Fix blk_cleanup_disk() usage
Message-ID: <20210608053627.GB14116@lst.de>
References: <162310861219.1571453.6561642225122047071.stgit@dwillia2-desk3.amr.corp.intel.com> <162310994435.1571616.334551212901820961.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162310994435.1571616.334551212901820961.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Dan, this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Jens, can you quickly pick this up?
