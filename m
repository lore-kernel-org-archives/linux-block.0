Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57066 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbcGUGBU (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 21 Jul 2016 02:01:20 -0400
Subject: Re: [PATCH 1/3] block: add flag for single-threaded submission
To: Christoph Hellwig <hch@infradead.org>
References: <1468936978-9124-1-git-send-email-hare@suse.de>
 <1468936978-9124-2-git-send-email-hare@suse.de>
 <20160721055431.GB14568@infradead.org>
Cc: Mike Snitzer <snitzer@redhat.com>, dm-devel-redhat.com@suse.de,
	Damien Le Moal <damien.lemoal@hgst.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@fb.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2cef3971-54cc-73d6-dbff-acd1379d19d5@suse.de>
Date: Thu, 21 Jul 2016 08:01:17 +0200
MIME-Version: 1.0
In-Reply-To: <20160721055431.GB14568@infradead.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/21/2016 07:54 AM, Christoph Hellwig wrote:
> On Tue, Jul 19, 2016 at 04:02:56PM +0200, Hannes Reinecke wrote:
>> Some devices (most notably SMR drives) support only
>> one I/O stream eg for ensuring ordered I/O submission.
>> This patch adds a new block queue flag
>> 'BLK_QUEUE_SINGLE' to support these devices.
> 
> We'll need a blk-mq implementation of this flag as well before it can
> be merged.
> 
Yes, indeed. Will be fixed for the next round of submissions.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
