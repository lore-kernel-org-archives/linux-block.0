Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44595 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbeCPEdN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Mar 2018 00:33:13 -0400
Subject: Re: [PATCH 13/16] bcache: Make bch_dump_read() fail if copying to
 user space fails
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "mlyle@lyle.org" <mlyle@lyle.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-14-bart.vanassche@wdc.com>
 <f72260be-9288-37c3-c7c8-a6f9a7d3955d@suse.de>
 <1521133564.2834.10.camel@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <f1adca76-6aee-e37d-1d38-325a019ba81f@suse.de>
Date: Fri, 16 Mar 2018 12:33:01 +0800
MIME-Version: 1.0
In-Reply-To: <1521133564.2834.10.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 16/03/2018 1:06 AM, Bart Van Assche wrote:
> On Fri, 2018-03-16 at 01:00 +0800, Coly Li wrote:
>> On 15/03/2018 11:08 PM, Bart Van Assche wrote:
>>> copy_to_user() returns the number of remaining bytes. Avoid that
>>> a larger value is returned than the number of bytes that have
>>> been copied by returning -EFAULT if not all bytes have been copied.
>>>
>>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>>> ---
>>>  drivers/md/bcache/debug.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
>>> index af89408befe8..376899cfcbf1 100644
>>> --- a/drivers/md/bcache/debug.c
>>> +++ b/drivers/md/bcache/debug.c
>>> @@ -175,9 +175,8 @@ static ssize_t bch_dump_read(struct file *file, char __user *buf,
>>>  		struct keybuf_key *w;
>>>  		unsigned bytes = min(i->bytes, size);
>>>  
>>> -		int err = copy_to_user(buf, i->buf, bytes);
>>> -		if (err)
>>> -			return err;
>>> +		if (copy_to_user(buf, i->buf, bytes))
>>> +			return -EFAULT;
>>>  
>>
>> Hi Bart,
>>
>> I am not sure whether this change is correct. -EFAULT seems not an
>> expected return value of read(2), while -1 is the expected return value
>> when error occurs.
>>
>> Maybe if copy_to_user() returns value in (0, size], "ret + (size - err)"
>> should be returned. An exception is when copy_to_user() returns 0 and
>> ret is 0 too, in this situation -1 should be returned.
>>
>> Correct me if I am wrong.
> 
> Hello Coly,
> 
> I'm not familiar enough with bcache to provide the answer to your question so
> I will drop this patch from this series.

Hi Bart,

It seems you catch a code bug here. I will look into this and handle it
here.

Thanks for the hint :-)

Coly Li
