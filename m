Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50612 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964900AbcJ1Ppa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2016 11:45:30 -0400
Subject: Re: Block layer state diagrams
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.de>
References: <0213e715-5d87-1110-45d5-ed48f8837842@sandisk.com>
 <865bd65b-b26e-d8e0-1b0e-ad715ea4d8d2@suse.de>
 <702a719e-d979-8a38-c434-55f607c21f40@sandisk.com>
CC: Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <aa53ddef-e359-e085-79a1-cce9ef74994a@fb.com>
Date: Fri, 28 Oct 2016 09:45:14 -0600
MIME-Version: 1.0
In-Reply-To: <702a719e-d979-8a38-c434-55f607c21f40@sandisk.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/27/2016 04:37 PM, Bart Van Assche wrote:
> On 10/26/2016 10:45 PM, Hannes Reinecke wrote:
>> On 10/26/2016 10:21 PM, Bart Van Assche wrote:
>>> Some time ago I created the attached state diagrams for myself to avoid
>>> that I would have to reread the entire block layer core source code if
>>> it has been a while since I had a look at it. Do you think it would be
>>> useful to add these diagrams somewhere in the Documentation directory?
>>>
>> Can you add a step for the mapping between software and
>> hardware queues?
>> Also the actual submission to the LLDD (in step 'executing') could do
>> with a bit more emphasis.
>> And maybe the fontsize could be a tad smaller; currently it's hard to
>> figure out which label goes where, expecially in the bottom half.
>
> Thanks Hannes for the review. How about the attached second version of
> these diagrams?

I think they are a little confusing. Some of it is specific to non-fs
requests, yet you have the plugging path in there as well. Was the
intent to just show the PC path?

-- 
Jens Axboe

