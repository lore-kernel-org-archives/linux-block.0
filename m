Return-Path: <meng.xu@gatech.edu>
Subject: Re: [PATCH] scsi: ensure the header peeked does not change in the
 actual message
To: Christoph Hellwig <hch@infradead.org>, Meng Xu <mengxu.gatech@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sanidhya@gatech.edu,
 taesoo@gatech.edu
References: <1505834638-37142-1-git-send-email-mengxu.gatech@gmail.com>
 <20170919160102.GA17416@infradead.org>
From: Meng Xu <meng.xu@gatech.edu>
Message-ID: <11095dd2-e6b1-e3c6-4295-b52941822889@gatech.edu>
Date: Tue, 19 Sep 2017 12:15:57 -0400
MIME-Version: 1.0
In-Reply-To: <20170919160102.GA17416@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: meng.xu@gatech.edu
List-ID: <linux-block@vger.kernel.org>

Hi Christoph,

By saying not copying the byte twice, did you mean
copy_from_user(req->cmd, sic->data + sizeof(opcode), cmdlen - 
sizeof(opcode)) ?

Does it affect the how req->cmd will be used later?
If no, I'll submit another patch as instructed.

Best Regards,
Meng

On 09/19/2017 12:01 PM, Christoph Hellwig wrote:
>> diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
>> index 7440de4..971044d 100644
>> --- a/block/scsi_ioctl.c
>> +++ b/block/scsi_ioctl.c
>> @@ -466,6 +466,12 @@ int sg_scsi_ioctl(struct request_queue *q, struct gendisk *disk, fmode_t mode,
>>   	if (copy_from_user(req->cmd, sic->data, cmdlen))
>>   		goto error;
>>   
>> +	/*
>> +	 * override the request header (opcode) to make sure that it matches
>> +	 * the first fetch from sic->data
>> +	 */
>> +	*((unsigned int *)req->cmd) = opcode;
>> +
>>   	if (in_len && copy_from_user(buffer, sic->data + cmdlen, in_len))
> NAK.
>
> Just don't copy the byte twice.  E.g. change things to not copy
> the first byte again.
>
