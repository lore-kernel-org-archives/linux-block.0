Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750859AbdBOITU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2017 03:19:20 -0500
Subject: Re: sense handling improvements
To: Christoph Hellwig <hch@lst.de>, axboe@kernek.dk
References: <20170214191600.17480-1-hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <cfc712df-f0e6-59c0-46d8-6af02542f14b@suse.de>
Date: Wed, 15 Feb 2017 09:19:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170214191600.17480-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/14/2017 08:15 PM, Christoph Hellwig wrote:
> Hi all,
> 
> this series is on top of the scsi_request changes in Jens' tree and
> further improves the handling of the sense buffer.
> 
Sorry, but I'm feeling really daft: which scsi_request changes?
To be found in which tree?
I dimly remember seeing them, but have been unable to find them again.

> The first patch prevents any possibily of reusing stale sense codes
> in sense headers, and is a bug fix that we should probably get into
> the block tree ASAP.
> 
> The rest cleans up handling of the parsed sense data and could go in
> either through the block tree, or a SCSI branch on top of the block
> tree.
> 
Have we audited all drivers to _not_ do DMA into the sense buffer?
By first glance some still do, so they'll break horribly when moving the
sense buffer onto the stack ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
