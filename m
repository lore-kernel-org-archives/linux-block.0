Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbdCGHeR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Mar 2017 02:34:17 -0500
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
To: Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20170306102335.9180-1-jthumshirn@suse.de>
 <20170307052242.GA29458@bbox>
Cc: Jens Axboe <axboe@fb.com>, Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        yizhan@redhat.com,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <95c31a93-32cd-ad06-6cc0-e11b42ec2f68@suse.de>
Date: Tue, 7 Mar 2017 08:00:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170307052242.GA29458@bbox>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/07/2017 06:22 AM, Minchan Kim wrote:
> Hello Johannes,
> 
> On Mon, Mar 06, 2017 at 11:23:35AM +0100, Johannes Thumshirn wrote:
>> zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
>> the NVMe over Fabrics loopback target which potentially sends a huge bulk of
>> pages attached to the bio's bvec this results in a kernel panic because of
>> array out of bounds accesses in zram_decompress_page().
> 
> First of all, thanks for the report and fix up!
> Unfortunately, I'm not familiar with that interface of block layer.
> 
> It seems this is a material for stable so I want to understand it clear.
> Could you say more specific things to educate me?
> 
> What scenario/When/How it is problem?  It will help for me to understand!
> 
The problem is that zram as it currently stands can only handle bios
where each bvec contains a single page (or, to be precise, a chunk of
data with a length of a page).

This is not an automatic guarantee from the block layer (who is free to
send us bios with arbitrary-sized bvecs), so we need to set the queue
limits to ensure that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
