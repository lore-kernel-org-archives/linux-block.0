Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E62CCA473
	for <linux-block@archiver.kernel.org>; Mon,  6 Jun 2022 16:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbiFFQYm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jun 2022 12:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241771AbiFFQYl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jun 2022 12:24:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11781BD7C7;
        Mon,  6 Jun 2022 09:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9259B81AA1;
        Mon,  6 Jun 2022 16:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87627C385A9;
        Mon,  6 Jun 2022 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654532677;
        bh=mtLfee9Bx8DrJcwaPAKjPVfMgxAETeU+QPZ4CTQzjBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqlXho3KkCXDVeD8FWClwQMjaafep83RRtbb/+MdH1SuT4Hl617EsdNKGyCwUIt9W
         rlNMcnglwPjc2BuK7NyZ+XZKf/BpjzCI1GdNOpS7ktM/vkLzwg3g1ZbNqlJSownkco
         2SmEIG92dMWvfhICruLW7EvgMhxD7z4yYxLAWIo6q838M3NMh/MwXiiSH3PcLWzLAF
         O0eMEZc/lvNVwO+JOc2X+2MbCScUAbABo8xfOPiN+DQi2ywwfZQW62I0bp4YIs8o4Q
         MFp8MKWVNcaqjZRQxTyrc+mra2k+Kzr3Jrvpys8sfiG5s8tP/TafeDOmHAex17ymcj
         dWRTBtuYFkDcQ==
Date:   Mon, 6 Jun 2022 10:24:33 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com
Subject: Re: [PATCHv5 00/11] direct-io dma alignment
Message-ID: <Yp4qQRI5awiycml1@kbusch-mbp.dhcp.thefacebook.com>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <YpcRLKwZpN+NQRxn@sol.localdomain>
 <Ypd3j9ABXhIuQDbt@kbusch-mbp.dhcp.thefacebook.com>
 <YpeP6u0XXAPra3MV@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpeP6u0XXAPra3MV@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01, 2022 at 10:12:26AM -0600, Keith Busch wrote:
> On Wed, Jun 01, 2022 at 08:28:31AM -0600, Keith Busch wrote:
> > On Wed, Jun 01, 2022 at 12:11:40AM -0700, Eric Biggers wrote:
> > > I still don't think you've taken care of all the assumptions that bv_len is a
> > > multiple of logical block size, or at least SECTOR_SIZE.  Try this:
> > > 
> > > 	git grep -E 'bv_len (>>|/)'
> > 
> > There are only 8 drivers that set the request_queue's dma alignment, which are
> > the only ones that could be affected from this patch series.
> 
> It's actually even simpler to audit than that. Of the 8 drivers that explicitly
> set dma alignment, only 3 set it to something smaller than a sector size. None
> of them assume any particular bv_len, so I think we're fine.

Eric,

Do you have any more concerns on this area? I'm reasonably confident this is
safe with all the existing users, and I have a new series ready to go with the
trivial fix-ups from the last round. I don't want to post it, though, if you
think I've missed something.

Thanks,
Keith
