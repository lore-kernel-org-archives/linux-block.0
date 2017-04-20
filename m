Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60806 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1033104AbdDTQLh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2017 12:11:37 -0400
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
To: Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20170415123825.32716-1-ming.lei@redhat.com>
 <cafbd7d9-1027-5282-6f1a-48f7ccec3d45@fb.com>
 <20170420004410.GA16917@ming.t460p>
 <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
 <20170420010346.GC16917@ming.t460p> <20170420045408.GB2235@infradead.org>
CC: <linux-block@vger.kernel.org>, Omar Sandoval <osandov@fb.com>,
        "Jozef Mikovic" <jmikovic@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <68f95811-380e-21f8-cdcb-2e47c6af4d56@fb.com>
Date: Thu, 20 Apr 2017 10:10:59 -0600
MIME-Version: 1.0
In-Reply-To: <20170420045408.GB2235@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/19/2017 10:54 PM, Christoph Hellwig wrote:
> On Thu, Apr 20, 2017 at 09:03:47AM +0800, Ming Lei wrote:
>> If we don't need to reserve tag for internal command, I am happy
>> to fix it in the interim. However, the mtip32xx driver has to
>> ask blk-mq to reserve the tag zero for internal command. Then
>> if we can't allow the driver to use that reserved tag, it looks
>> quite awkward, doesn't it?
> 
> It doesn't.  Just offset the hardware tags by 1 from the blk-mq tags.
> 
> But I'm pretty sure the hardware wouldn't require a specific tag
> for the internal ops.

Right, the hardware doesn't require it at all, it's just an oddity
of the driver that it hardwares tag 0 as an internal tag. That could
definitely get cleaned up.

-- 
Jens Axboe
