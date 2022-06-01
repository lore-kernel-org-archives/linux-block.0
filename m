Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C8AC433FE
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 05:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346213AbiFAFah (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 01:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349652AbiFAFaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 01:30:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D375B9E9D3;
        Tue, 31 May 2022 22:30:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A670368AFE; Wed,  1 Jun 2022 07:30:31 +0200 (CEST)
Date:   Wed, 1 Jun 2022 07:30:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCHv5 08/11] iov: introduce iov_iter_aligned
Message-ID: <20220601053031.GB21743@lst.de>
References: <20220531191137.2291467-1-kbusch@fb.com> <20220531191137.2291467-9-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-9-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 31, 2022 at 12:11:34PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The existing iov_iter_alignment() function returns the logical OR of
> address and length. For cases where address and length need to be
> considered separately, introduce a helper function that a caller can
> specificy length and address masks that indicate if the iov is
> unaligned.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
