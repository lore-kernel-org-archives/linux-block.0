Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41790 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753603AbdF2VYO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 17:24:14 -0400
Subject: Re: [PATCH] block: call __bio_free in bio_endio
To: Christoph Hellwig <hch@lst.de>, Shaohua Li <shli@fb.com>
CC: <linux-block@vger.kernel.org>, <Kernel-team@fb.com>
References: <a4ff33f2c114d0d0e1d1f41b7524078d2e9fd3f0.1498762065.git.shli@fb.com>
 <20170629202403.GB416@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <2a683dff-48d7-5182-7ac6-f1865ddf403d@fb.com>
Date: Thu, 29 Jun 2017 15:23:47 -0600
MIME-Version: 1.0
In-Reply-To: <20170629202403.GB416@lst.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/29/2017 02:24 PM, Christoph Hellwig wrote:
> On Thu, Jun 29, 2017 at 11:54:17AM -0700, Shaohua Li wrote:
>> bio_free isn't a good place to free cgroup info. There are a
>> lot of cases bio is allocated in special way (for example, in stack) and
>> never gets called by bio_put hence bio_free, we are leaking memory. This
>> patch moves the free to bio endio, which should be called anyway. The
>> __bio_free call in bio_free is kept, in case the bio never gets called
>> bio endio.
> 
> Jens already renamed __bio_free to bio_uninit in Linus' tree.
> 
> That being said I think we should just kill __bio_free once all
> the work is in.  But I think we should defer this post the
> initial pull for 4.12-rc to reduce the merge pain.

Yes, let's pick up that work after the existing for-4.13/block has
been merged upstream.

-- 
Jens Axboe
