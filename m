Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932698AbdIYOFU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Sep 2017 10:05:20 -0400
Subject: Re: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
 <1fb2f077-151a-b02f-2bf5-329ef5951a68@suse.de> <20170925135007.GA9725@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <55a10165-ac3c-f808-b031-6d907c314c30@suse.de>
Date: Mon, 25 Sep 2017 16:05:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170925135007.GA9725@lst.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/25/2017 03:50 PM, Christoph Hellwig wrote:
> On Mon, Sep 25, 2017 at 03:47:43PM +0200, Hannes Reinecke wrote:
>> Can't we make the multipath support invisible to the host?
>> IE check the shared namespaces before creating the device node, and just
>> move them under the existing namespaces if one exists?
> 
> That was what my first version did, but various people talked me
> out of it.  Unfortunately just multiplexing breaks a few things,
> including the userspace passthrough ioctls.
> 
Care to give some specifics?
How would userspace passthrough be affected?
I would've thought that we're sending the ioctl down one path, and we'd
be getting the completion back on the same path/queue/whatever.
(Unless we're talking multi-command ioctls, but those are evil anyway)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
