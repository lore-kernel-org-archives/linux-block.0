Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751304AbcJ0Fph (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 01:45:37 -0400
Subject: Re: Block layer state diagrams
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
References: <0213e715-5d87-1110-45d5-ed48f8837842@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <865bd65b-b26e-d8e0-1b0e-ad715ea4d8d2@suse.de>
Date: Thu, 27 Oct 2016 07:45:35 +0200
MIME-Version: 1.0
In-Reply-To: <0213e715-5d87-1110-45d5-ed48f8837842@sandisk.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/26/2016 10:21 PM, Bart Van Assche wrote:
> Hello Jens,
> 
> Some time ago I created the attached state diagrams for myself to avoid
> that I would have to reread the entire block layer core source code if
> it has been a while since I had a look at it. Do you think it would be
> useful to add these diagrams somewhere in the Documentation directory?
> 
Can you add a step for the mapping between software and
hardware queues?
Also the actual submission to the LLDD (in step 'executing') could do
with a bit more emphasis.
And maybe the fontsize could be a tad smaller; currently it's hard to
figure out which label goes where, expecially in the bottom half.

Otherwise looking good.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
