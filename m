Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56833 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbcGUGAq (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 21 Jul 2016 02:00:46 -0400
Subject: Re: [PATCH 6/6] block: Add 'BLK_MQ_RQ_QUEUE_DONE' return value
To: Christoph Hellwig <hch@infradead.org>
References: <1468934439-93579-1-git-send-email-hare@suse.de>
 <1468934439-93579-7-git-send-email-hare@suse.de>
 <20160721055351.GA14568@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Damien Le Moal <damien.lemoal@hgst.com>,
	Hannes Reinecke <hare@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <24e83314-a4fa-76de-04ee-43b7b50cbbd2@suse.de>
Date: Thu, 21 Jul 2016 08:00:43 +0200
MIME-Version: 1.0
In-Reply-To: <20160721055351.GA14568@infradead.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/21/2016 07:53 AM, Christoph Hellwig wrote:
> On Tue, Jul 19, 2016 at 03:20:39PM +0200, Hannes Reinecke wrote:
>> Add a return value BLK_MQ_RQ_QUEUE_DONE to terminate a request
>> without error.
> 
> NAK.  You can just do a blk_mq_end_request on the request and return
> 0 from ->queue_rq.
> 
Okay, will be doing so.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
