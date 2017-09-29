Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48515 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752448AbdI2XAm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Sep 2017 19:00:42 -0400
Date: Fri, 29 Sep 2017 17:00:07 -0600
From: Keith Busch <keith.busch@intel.com>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        Martin Wilck <mwilck@suse.de>
Subject: Re: [PATCH 2/2] nvme: use device_add_disk_with_groups()
Message-ID: <20170929230006.GQ8463@localhost.localdomain>
References: <20170928193637.24707-1-mwilck@suse.com>
 <20170928193637.24707-2-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170928193637.24707-2-mwilck@suse.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 28, 2017 at 09:36:37PM +0200, Martin Wilck wrote:
> By using device_add_disk_with_groups(), we can avoid the race
> condition with udev rule processing, because no udev event will
> be triggered before all attributes are available.
> 
> Signed-off-by: Martin Wilck <mwilck@suse.com>

Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
