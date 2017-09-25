Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:46661 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933355AbdIYOkf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Sep 2017 10:40:35 -0400
Date: Mon, 25 Sep 2017 10:45:35 -0400
From: Keith Busch <keith.busch@intel.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170925144535.GB6331@localhost.localdomain>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
 <1fb2f077-151a-b02f-2bf5-329ef5951a68@suse.de>
 <20170925135007.GA9725@lst.de>
 <55a10165-ac3c-f808-b031-6d907c314c30@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55a10165-ac3c-f808-b031-6d907c314c30@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 25, 2017 at 04:05:17PM +0200, Hannes Reinecke wrote:
> On 09/25/2017 03:50 PM, Christoph Hellwig wrote:
> > On Mon, Sep 25, 2017 at 03:47:43PM +0200, Hannes Reinecke wrote:
> >> Can't we make the multipath support invisible to the host?
> >> IE check the shared namespaces before creating the device node, and just
> >> move them under the existing namespaces if one exists?
> > 
> > That was what my first version did, but various people talked me
> > out of it.  Unfortunately just multiplexing breaks a few things,
> > including the userspace passthrough ioctls.
> > 
> Care to give some specifics?
> How would userspace passthrough be affected?

Ioctls aside, if you've only one disk handle, it's a little difficult to
compare iostats on each path, which can be useful for diagnosing issues.

> I would've thought that we're sending the ioctl down one path, and we'd
> be getting the completion back on the same path/queue/whatever.
> (Unless we're talking multi-command ioctls, but those are evil anyway)
