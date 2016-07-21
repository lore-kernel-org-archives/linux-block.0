Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57177 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbcGUGBp (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Thu, 21 Jul 2016 02:01:45 -0400
Subject: Re: [PATCH 5/6] block: Introduce BLKPREP_DONE
To: Christoph Hellwig <hch@infradead.org>
References: <1468934439-93579-1-git-send-email-hare@suse.de>
 <1468934439-93579-6-git-send-email-hare@suse.de>
 <20160721055857.GC14568@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, Damien Le Moal <damien.lemoal@hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e69ec3c4-a6ee-714b-6c5e-af1463a8214a@suse.de>
Date: Thu, 21 Jul 2016 08:01:43 +0200
MIME-Version: 1.0
In-Reply-To: <20160721055857.GC14568@infradead.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/21/2016 07:58 AM, Christoph Hellwig wrote:
>> +++ b/block/blk-core.c
>> @@ -2462,9 +2462,13 @@ struct request *blk_peek_request(struct request_queue *q)
>>  
>>  			rq = NULL;
>>  			break;
>> -		} else if (ret == BLKPREP_KILL || ret == BLKPREP_INVALID) {
>> +		} else if (ret == BLKPREP_KILL || ret == BLKPREP_INVALID ||
>> +			   ret == BLKPREP_DONE) {
>>  			int err = (ret == BLKPREP_INVALID) ? -EREMOTEIO : -EIO;
>>  
>> +			if (ret == BLKPREP_DONE)
>> +				err = 0;
>> +
> 
> Please just use a proper switch statement for the return values.
> 
Ok.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
