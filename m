Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6FEC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FDD20823
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 15:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfBDPhr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:37:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:51638 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726926AbfBDPhr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Feb 2019 10:37:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56FC7AF01;
        Mon,  4 Feb 2019 15:37:46 +0000 (UTC)
Subject: Re: [PATCH] bsg: allocate response buffer if requested
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
References: <20190130094424.94255-1-hare@suse.de>
 <20190204144040.GA23983@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <81ff4b98-32aa-11a5-f929-18cdacdba9a3@suse.de>
Date:   Mon, 4 Feb 2019 16:37:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190204144040.GA23983@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/19 3:40 PM, Christoph Hellwig wrote:
> On Wed, Jan 30, 2019 at 10:44:24AM +0100, Hannes Reinecke wrote:
>> The 'response' buffer from bsg is mapped onto the SCSI sense buffer,
>> however after commit 82ed4db499b8 we need to allocate them ourselves
>> as the bsg queue is _not_ a SCSI queue, and hence the sense buffer
>> won't be allocated from the scsi stack.
> 
> I don't think this is the full story.  Plain old bsg nodes are on SCSI
> (or legacy IDE) request queues, so this should be initialized, and
> your patch creates a memory leak by overwriting the sense pointer.
> 
> bsg-lib nodes aren't on scsi request queues, but they don't use the code
> path your patch to start with.
> 
> What exactly is the reproducer for this problem?
> 
The problem is here:

static int bsg_scsi_complete_rq(struct request *rq, struct sg_io_v4 *hdr)
{
	struct scsi_request *sreq = scsi_req(rq);
	int ret = 0;

	/*
	 * fill in all the output members
	 */
	hdr->device_status = sreq->result & 0xff;
	hdr->transport_status = host_byte(sreq->result);
	hdr->driver_status = driver_byte(sreq->result);
	hdr->info = 0;
	if (hdr->device_status || hdr->transport_status || hdr->driver_status)
		hdr->info |= SG_INFO_CHECK;
	hdr->response_len = 0;

->	if (sreq->sense_len && hdr->response) {
		int len = min_t(unsigned int, hdr->max_response_len,
					sreq->sense_len);

		if (copy_to_user(uptr64(hdr->response), sreq->sense, len))
			ret = -EFAULT;
		else
			hdr->response_len = len;
	}

This expects the 'response' to be allocated.
Yet nowhere in the block/bsg.c we actually _do_ allocate the 'response' 
field.
And as the header is pretty much copied from userspace we don't really 
have any control about the contents of the 'response' nor the 
'response_len' parameter.

These fields used to be filled by mpt3sas (to hold the sense code), but 
with commit 651a01364994 ("scsi: scsi_transport_sas: switch to bsg-lib 
for SMP passthrough") the sense code handling got removed.

Alternatively we might kill 'response' handling altogether, but then 
that might have an impact on userland.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
