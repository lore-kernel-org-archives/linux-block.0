Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754280AbeALIMc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jan 2018 03:12:32 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0C89m8r012927
        for <linux-block@vger.kernel.org>; Fri, 12 Jan 2018 03:12:31 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fes650a7h-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 12 Jan 2018 03:12:31 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 12 Jan 2018 08:12:29 -0000
Subject: Re: [PATCH 0/2] blk-mq: support physical CPU hotplug
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20180112025306.28004-1-ming.lei@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 12 Jan 2018 09:12:24 +0100
MIME-Version: 1.0
In-Reply-To: <20180112025306.28004-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <64c62449-27d2-a0a1-c7db-d2d08a3eb893@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I think we also need cc stable for this. The bug was introduced with 
 
commit 4b855ad37194f7bdbb200ce7a1c7051fecb56a08 upstream.
("blk-mq: Create hctx for each present CPU")

and that was even backported into 4.12 stable.



On 01/12/2018 03:53 AM, Ming Lei wrote:
> Hi,
> 
> This two patches support physical CPU hotplug, so that we can make blk-mq
> scale well when new physical CPU is added or removed, and this use case
> is normal for VM world.
> 
> Also this patchset fixes the following warning reported by Christian
> Borntraeger:
> 
> 	https://marc.info/?l=linux-block&m=151092973417143&w=2
> 
> Christoph Hellwig (2):
>   genirq/affinity: assign vectors to all possible CPUs
>   blk-mq: simplify queue mapping & schedule with each possisble CPU
> 
>  block/blk-mq.c        | 19 ++++++++-----------
>  kernel/irq/affinity.c | 30 +++++++++++++++---------------
>  2 files changed, 23 insertions(+), 26 deletions(-)
> 
