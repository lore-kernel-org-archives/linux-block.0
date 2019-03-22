Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E322C10F03
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1190521900
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553290173;
	bh=JYXpnfLScPq1fKIDnHyeO1pbFRN4/z/QJAHolJ7HGPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0/CoCGdstRQVxr/VYhRDPazJ8A5ekOdvJ3XAN8OeU7omvhr6ivvVRC5QDhTI+0cDp
	 hFvCaodpqw6paLoSHdZsZrZP7WegM8JjNH3J3moRTP+aHaiVikHdlHFrdDUfdfnTnE
	 CyC9/fLQzPKBZX8UQMVM/t8oA+SjZImW3UrvjCSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCVV3b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:29:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:29414 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfCVV3b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 17:29:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 14:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="216699338"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 22 Mar 2019 14:29:30 -0700
Date:   Fri, 22 Mar 2019 15:30:32 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] block: bio: introduce BIO_ALLOCED flag and check
 it in bio_free
Message-ID: <20190322213031.GD31194@localhost.localdomain>
References: <20190322131346.20169-1-jthumshirn@suse.de>
 <20190322131346.20169-4-jthumshirn@suse.de>
 <20190322140233.GC17767@lst.de>
 <3ab3d268-68a7-0c23-601b-d86d26aa3936@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab3d268-68a7-0c23-601b-d86d26aa3936@suse.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 22, 2019 at 03:05:46PM +0100, Hannes Reinecke wrote:
> On 3/22/19 3:02 PM, Christoph Hellwig wrote:
> > But how do you manage to get the tiny on-stack bios split?  What kind
> > of setup is this?
> > 
> It's not tiny if you send a 2M file via direct-io, _and_ have a non-zero
> MDTS setting...

I see a larger request can create a bio chain (though I think 1M
is the max that goes through _simple), but how does the stack bio
get used in a bio_put()? The chained bios are allocated through a
bio_set, and their bio_end_io() calls bio_put() on themselves through
bio_chain_endio(), but that's it. The original's endio is never modified
from blkdev_bio_end_io_simple(), so who's calling bio_put() on the
on-stack bio?
