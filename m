Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58642 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S940627AbdDTA4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 20:56:12 -0400
Subject: Re: [PATCH 0/4] blk-mq-sched: allow to use hw tag for sched
To: Ming Lei <ming.lei@redhat.com>
References: <20170415123825.32716-1-ming.lei@redhat.com>
 <cafbd7d9-1027-5282-6f1a-48f7ccec3d45@fb.com>
 <20170420004410.GA16917@ming.t460p>
CC: <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Omar Sandoval" <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <90e249d6-996c-a8d9-f54d-e8142082bfa5@fb.com>
Date: Wed, 19 Apr 2017 18:55:30 -0600
MIME-Version: 1.0
In-Reply-To: <20170420004410.GA16917@ming.t460p>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/19/2017 06:44 PM, Ming Lei wrote:
> On Wed, Apr 19, 2017 at 02:17:45PM -0600, Jens Axboe wrote:
>> On 04/15/2017 06:38 AM, Ming Lei wrote:
>>> The 1st patch enhances BLK_MQ_F_NO_SCHED so that we can't change/
>>> show available io schedulers on devices which don't support io
>>> scheduler.
>>>
>>> The 2nd patch passes BLK_MQ_F_NO_SCHED for avoiding one regression
>>> on mtip32xx, which is introduced by blk-mq io scheduler.
>>
>> I've added 1-2 for 4.11 for now, and then let's plan on getting
>> a real fix done for 4.12.
> 
> The real fix has been posted out already:
> 
> 	http://marc.info/?t=149256196700001&r=1&w=2
> 
> Could you consider that for 4.12?

I didn't particularly like that approach. And we are really late
in the 4.11 cycle, and your first two patches fit the bill for
how we should fix it in the interim.

I'll take a closer look for 4.12, I want to get this fixed
for real, obviously.

-- 
Jens Axboe
