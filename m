Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46240 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753180AbcKDEBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Nov 2016 00:01:38 -0400
Subject: Re: [PATCH V2 2/2] blk-mq: immediately dispatch big size request
To: Shaohua Li <shli@fb.com>, Christoph Hellwig <hch@infradead.org>
References: <05e8cb8c7e09903c7db36e81a6bbd0b39b24deff.1478217670.git.shli@fb.com>
 <6297c9a39cf21c94c65d5a9b3a19e54ba5b8b573.1478217671.git.shli@fb.com>
 <20161104000954.GA10266@infradead.org>
 <20161104001353.GA58908@omida-mbp.local.dhcp.thefacebook.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Kernel-team@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <32bef0f6-c194-e31e-3a85-5aa21a6e81a4@fb.com>
Date: Thu, 3 Nov 2016 22:00:58 -0600
MIME-Version: 1.0
In-Reply-To: <20161104001353.GA58908@omida-mbp.local.dhcp.thefacebook.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/03/2016 06:13 PM, Shaohua Li wrote:
> On Thu, Nov 03, 2016 at 05:09:54PM -0700, Christoph Hellwig wrote:
>> On Thu, Nov 03, 2016 at 05:03:54PM -0700, Shaohua Li wrote:
>>> This is corresponding part for blk-mq. Disk with multiple hardware
>>> queues doesn't need this as we only hold 1 request at most.
>>
>> Any reason you only do this for the SQ and not the MQ case?
>
> Right above:
> Disk with multiple hardware queues doesn't need this as we only hold 1
> request at most.

I've applied 1-2 for 4.10, but we probably should look into unifying
those parts of sq and mq in general. For instance, it doesn't seem to
make a lot of sense why we'd depth limit sq and not mq.

-- 
Jens Axboe

