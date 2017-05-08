Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751737AbdEHILD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 May 2017 04:11:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v48846VZ108965
        for <linux-block@vger.kernel.org>; Mon, 8 May 2017 04:11:02 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2aakxebc0p-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 08 May 2017 04:10:57 -0400
Received: from localhost
        by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <abdhalee@linux.vnet.ibm.com>;
        Mon, 8 May 2017 17:15:23 +1000
Subject: Re: [linux-next][bock] WARNING: CPU: 22 PID: 0 at
 block/blk-core.c:2655 .blk_update_request+0x4f8/0x500
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>,
        sachinp <sachinp@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Mon, 08 May 2017 12:43:19 +0530
In-Reply-To: <15a0a50a-d57d-736b-634c-4d0131ec5af3@kernel.dk>
References: <1493965539.7355.44.camel@abdul.in.ibm.com>
         <15a0a50a-d57d-736b-634c-4d0131ec5af3@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1494227599.2983.2.camel@abdul.in.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2017-05-05 at 08:02 -0600, Jens Axboe wrote:
> On 05/05/2017 12:25 AM, Abdul Haleem wrote:
> > Hi,
> > 
> > 4.11.0 Linus mainline booted with Warnings on PowerPC.
> > 
> > We did not see this on next-20170407 but on next-20170410 and later.
> 
> Have you tried current Linus -git? Both of the -next versions you list
> are rather old.
> 

Hi Jens, 

Warning is still seen with next-20170505 and also with today's mainline.

It was first seen on next-20170410, so the last good was next-20170407.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
