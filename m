Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52875 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750714AbdAXQEY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 11:04:24 -0500
Subject: Re: [PATCH] queue stall with blk-mq-sched
To: Hannes Reinecke <hare@suse.de>
References: <aa1c23e1-1beb-a26d-3e77-fe78aa281771@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <1c9beccc-c7cc-dd3e-703d-e91d8110ec86@fb.com>
Date: Tue, 24 Jan 2017 09:03:26 -0700
MIME-Version: 1.0
In-Reply-To: <aa1c23e1-1beb-a26d-3e77-fe78aa281771@suse.de>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/24/2017 08:54 AM, Hannes Reinecke wrote:
> Hi Jens,
> 
> I'm trying to debug a queue stall with your blk-mq-sched branch; with my
> latest mpt3sas patches fio stops basically directly after starting a
> sequential read :-(
> 
> I've debugged things and came up with the attached patch; we need to
> restart waiters with blk_mq_tag_idle() after completing a tag.
> We're already calling blk_mq_tag_busy() when fetching a tag, so I think
> calling blk_mq_tag_idle() is required when retiring a tag.

I'll take a look at this. It sounds like all your grief is related to
shared tag maps, which I don't have anything that uses here. I'll see
if we are leaking it, you should be able to check that by reading the
'active' file in the sysfs directory.

-- 
Jens Axboe

