Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51638 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752855AbcI2OEU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2016 10:04:20 -0400
Subject: Re: [Nbd] [PATCH][V3] nbd: add multi-connection support
To: Wouter Verhelst <w@uter.be>
References: <1475092892-8230-1-git-send-email-jbacik@fb.com>
 <20160929095204.mexr6wpypo3bl6mx@grep.be>
CC: <axboe@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <nbd-general@lists.sourceforge.net>
From: Josef Bacik <jbacik@fb.com>
Message-ID: <87908d95-0b7c-bc3f-f69d-94d006829daf@fb.com>
Date: Thu, 29 Sep 2016 10:03:50 -0400
MIME-Version: 1.0
In-Reply-To: <20160929095204.mexr6wpypo3bl6mx@grep.be>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/29/2016 05:52 AM, Wouter Verhelst wrote:
> Hi Josef,
>
> On Wed, Sep 28, 2016 at 04:01:32PM -0400, Josef Bacik wrote:
>> NBD can become contended on its single connection.  We have to serialize all
>> writes and we can only process one read response at a time.  Fix this by
>> allowing userspace to provide multiple connections to a single nbd device.  This
>> coupled with block-mq drastically increases performance in multi-process cases.
>> Thanks,
>
> This reminds me: I've been pondering this for a while, and I think there
> is no way we can guarantee the correct ordering of FLUSH replies in the
> face of multiple connections, since a WRITE reply on one connection may
> arrive before a FLUSH reply on another which it does not cover, even if
> the server has no cache coherency issues otherwise.
>
> Having said that, there can certainly be cases where that is not a
> problem, and where performance considerations are more important than
> reliability guarantees; so once this patch lands in the kernel (and the
> necessary support patch lands in the userland utilities), I think I'll
> just update the documentation to mention the problems that might ensue,
> and be done with it.
>
> I can see only a few ways in which to potentially solve this problem:
> - Kernel-side nbd-client could send a FLUSH command over every channel,
>   and only report successful completion once all replies have been
>   received. This might negate some of the performance benefits, however.
> - Multiplexing commands over a single connection (perhaps an SCTP one,
>   rather than TCP); this would require some effort though, as you said,
>   and would probably complicate the protocol significantly.
>

So think of it like normal disks with multiple channels.  We don't send flushes 
down all the hwq's to make sure they are clear, we leave that decision up to the 
application (usually a FS of course).  So what we're doing here is no worse than 
what every real disk on the planet does, our hw queues are just have a lot 
longer transfer times and are more error prone ;).  I definitely think 
documenting the behavior is important so that people don't expect magic to 
happen, and perhaps we could add a flag later that says send all the flushes 
down all the connections for the paranoid, it should be relatively 
straightforward to do.  Thanks,

Josef

