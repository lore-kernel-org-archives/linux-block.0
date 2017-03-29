Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36796 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbdC2CLo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 22:11:44 -0400
Received: by mail-pg0-f68.google.com with SMTP id 81so667712pgh.3
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2017 19:11:43 -0700 (PDT)
Date: Wed, 29 Mar 2017 10:11:38 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 0/4] block: misc changes
Message-ID: <20170329021136.GA4625@ming.t460p>
References: <20170327120658.29864-1-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170327120658.29864-1-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 27, 2017 at 08:06:54PM +0800, Ming Lei wrote:
> Hi,
> 
> The 1st  patch add comments on blk-mq races with timeout handler.
> 
> The other 3 patches improves handling for dying queue:
> 	- the 2nd one adds one barrier in blk_queue_enter() for
> 	avoiding hanging caused by out-of-order
> 	- the 3rd and 4th patches block new I/O entering queue
> 	after queue is set as dying
> 
> V3:
> 	- tweak comments as suggested by Bart Van Assche

Hi Jens,

This patchset has been posted several times without real code change
for a while, could you consider it for v4.12?

Thanks,
Ming
