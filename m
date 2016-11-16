Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36435 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752679AbcKPQX0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 11:23:26 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uAGGIgLZ084014
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2016 11:23:25 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 26rq3fw13h-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2016 11:23:24 -0500
Received: from localhost
        by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <krisman@linux.vnet.ibm.com>;
        Wed, 16 Nov 2016 14:23:23 -0200
From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: <axboe@fb.com>, <linux-block@vger.kernel.org>,
        Brian King <brking@linux.vnet.ibm.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2/2] blk-mq: Avoid memory reclaim when remapping queues
References: <1479151478-19725-1-git-send-email-krisman@linux.vnet.ibm.com>
        <1479151478-19725-2-git-send-email-krisman@linux.vnet.ibm.com>
        <39a42839-b877-21b7-aa85-314cf499e234@sandisk.com>
Date: Wed, 16 Nov 2016 14:23:18 -0200
In-Reply-To: <39a42839-b877-21b7-aa85-314cf499e234@sandisk.com> (Bart Van
        Assche's message of "Tue, 15 Nov 2016 14:51:30 -0800")
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8737irmm15.fsf@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Bart Van Assche <bart.vanassche@sandisk.com> writes:

> I don't think that GFP_NOWAIT is acceptable in this context. Have you
> tried GFP_NOIO instead of GFP_NOWAIT?

At first I used GFP_NOIO, but after reviewing gfp.h I convinced myself
GFP_NOWAIT was what I wanted because I was concerned about FS accesses
that aren't restricted in GFP_NOIO.  For some reason, I assumed this was
an issue.  I'm ok with the change and can submit a v2 shortly, after
more tests.  in fact, this will make the change more compliant with the
rest of block layer critical allocations that use GFP_NOIO.

Thanks,

-- 
Gabriel Krisman Bertazi

