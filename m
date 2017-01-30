Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752113AbdA3G62 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2017 01:58:28 -0500
Subject: Re: split scsi passthrough fields out of struct request V2
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
References: <1485365126-23210-1-git-send-email-hch@lst.de>
 <1485552454.4267.29.camel@sandisk.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "j-nomura@ce.jp.nec.com" <j-nomura@ce.jp.nec.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <00141930-e69b-ccfa-3f1f-4dff5cd3b680@suse.de>
Date: Mon, 30 Jan 2017 07:58:24 +0100
MIME-Version: 1.0
In-Reply-To: <1485552454.4267.29.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/27/2017 10:27 PM, Bart Van Assche wrote:
> On Wed, 2017-01-25 at 18:25 +0100, Christoph Hellwig wrote:
>> this series splits the support for SCSI passthrough commands from the
>> main struct request used all over the block layer into a separate
>> scsi_request structure that drivers that want to support SCSI passthough
>> need to embedded as the first thing into their request-private data,
>> similar to how we handle NVMe passthrough commands.
>>
>> To support this I've added support for that the private data after
>> request structure to the legacy request path instead, so that it can
>> be treated the same way as the blk-mq path.  Compare to the current
>> scsi_cmnd allocator that actually is a major simplification.
>>
>> Changes since V1:
>>  - fix handling of a NULL sense pointer in __scsi_execute
>>  - clean up handling of the flush flags in the block layer and MD
>>  - additional small cleanup in dm-rq
> 
> Hello Christoph,
> 
> A general comment: patch "block: allow specifying size for extra
> command data" is a very welcome improvement but unfortunately also
> introduces an inconsistency among block drivers. This patch series
> namely creates two kinds of block drivers:
> - Block drivers that use the block layer core to allocate
>   request-private data. These block drivers set request.cmd_size
>   to a non-zero value and do not need request.special.
> - Block drivers that allocate request-private data themselves.
>   These block drivers set request.cmd_size to zero and use
>   request.special to translate a request pointer into the private
>   data pointer.
> 
> Have you considered to convert all block drivers to the new
> approach and to get rid of request.special? If so, do you already
> have plans to start working on this? I'm namely wondering wheter I
> should start working on this myself.
> 
I was actually looking into it, too.
Once scsi passthrough is removed from struct request there is no
reasonable need to rely on '->special' for anything, and we should just
ditch it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
