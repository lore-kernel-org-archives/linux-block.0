Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51849 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755133AbdL2JsP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Dec 2017 04:48:15 -0500
Date: Fri, 29 Dec 2017 10:48:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/3] nvme/pci: Remove cq_vector check in IO path
Message-ID: <20171229094814.GC24043@lst.de>
References: <20171221204636.2924-1-keith.busch@intel.com> <20171221204636.2924-3-keith.busch@intel.com> <95c8319b-3e01-07b5-88a8-864c5a8f60a5@grimberg.me> <33f024c8-b4be-c8cb-decb-f36eb68fb99a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <33f024c8-b4be-c8cb-decb-f36eb68fb99a@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Dec 27, 2017 at 11:01:48PM +0200, Sagi Grimberg wrote:
>
>> Awesome!
>>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>
> Wait, aren't we unquiesce queues also in nvme_dev_disable?
>
> Doesn't that rely that the queues are suspended and queue_rq
> will fail there?

We don't seem to have any other check as far as I can tell.
