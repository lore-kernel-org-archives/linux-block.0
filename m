Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162804AbdD1P1y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 11:27:54 -0400
Date: Fri, 28 Apr 2017 23:27:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Josef Bacik <jbacik@fb.com>
Cc: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block: nbd: fix double free
Message-ID: <20170428152739.GC25592@ming.t460p>
References: <20170428042942.6567-1-ming.lei@redhat.com>
 <B95137F4-8B73-47EA-9DB6-BF008F59B2AD@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <B95137F4-8B73-47EA-9DB6-BF008F59B2AD@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 28, 2017 at 01:00:30PM +0000, Josef Bacik wrote:
> We should have 2 references on the device at this point, did you see a “nbd: possibly leaking a device” message before the kasan stuff?  Thanks,
> 

There isn't such message before kasan warning.

Thanks,
Ming
