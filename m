Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:43428 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932565AbeFLNCJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jun 2018 09:02:09 -0400
Subject: Re: Regarding the recent new blk-mq timeout handling
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <88c22c6d-8482-8854-6e9b-88605eab3735@oracle.com>
 <CACVXFVN8r6LNxayK-Kp0H_aq=pjMxK0Q1a8Q4fj2BaQeh1-Yhw@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <cfafc2df-1003-67dd-4978-058dfca265bd@oracle.com>
Date: Tue, 12 Jun 2018 21:01:38 +0800
MIME-Version: 1.0
In-Reply-To: <CACVXFVN8r6LNxayK-Kp0H_aq=pjMxK0Q1a8Q4fj2BaQeh1-Yhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi ming

Thanks for your kindly response.

On 06/12/2018 06:17 PM, Ming Lei wrote:
> On Tue, Jun 12, 2018 at 6:04 PM, jianchao.wang
> <jianchao.w.wang@oracle.com> wrote:
>> Hi Jens and Christoph
>>
>> In the recent commit of new blk-mq timeout handling, we don't have any protection
>> on timed out request against the completion path. We just hold a request->ref count,
>> it just could avoid the request tag to be released and life-recycle, but not completion.
>>
>> For the scsi mid-layer, what if a request is in error handler and normal completion come
>> at the moment ?
> 
> Per my understanding, now the protection needs to be done completely by driver.
> 

But looks like the drivers have not prepared well to take over this work right now.

Thanks
Jianchao


> 
> Thanks,
> Ming Lei
> 
