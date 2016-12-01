Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759009AbcLARvo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Dec 2016 12:51:44 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uB1Hp70Y102539
        for <linux-block@vger.kernel.org>; Thu, 1 Dec 2016 12:51:43 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
        by mx0a-001b2d01.pphosted.com with ESMTP id 272muj7ddr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 01 Dec 2016 12:51:43 -0500
Received: from localhost
        by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <krisman@linux.vnet.ibm.com>;
        Thu, 1 Dec 2016 15:51:40 -0200
From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Brian King <brking@linux.vnet.ibm.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 1/2] blk-mq: Fix failed allocation path when mapping queues
References: <1479837269-5742-1-git-send-email-krisman@linux.vnet.ibm.com>
Date: Thu, 01 Dec 2016 15:51:37 -0200
In-Reply-To: <1479837269-5742-1-git-send-email-krisman@linux.vnet.ibm.com>
        (Gabriel Krisman Bertazi's message of "Tue, 22 Nov 2016 15:54:28
        -0200")
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737i7sfkm.fsf@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com> writes:

> My one concern about this patch is if remapping an arbitrary queue to
> hctx_0 could result in outstanding requests getting submitted to the
> wrong hctx.  I couldn't observe this happening during tests, but I'm not
> entirely sure it'll never happen.  I believe the queue will be empty if
> we are trying to allocate tags for it, unless it was using another alive
> hctx queue and for some reason got reassigned to this new hctx.  is this
> possible at all?

I no longer believe this case to be an issue for accepting this patch,
since if a queue enters this path and get's remapped to hctx_0, it means
the ctx would already be getting remaped to a new queue anyway, and it
should use the requests that were just mapped for that queue.  So, for a
correctness standpoint it doesn't matter which queue we are remaping,
the failed hctx or hctx_0, no request would get redirected to the wrong
queue with this change.

Jens, do you think this set is good for merging in 4.10?  It fixes some
issues for us on low memory conditions.

-- 
Gabriel Krisman Bertazi

