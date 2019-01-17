Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001D7C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 00:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE49A20657
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 00:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfAQAyy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:54:54 -0500
Received: from smtp.infotech.no ([82.134.31.41]:45637 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbfAQAyy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 19:54:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 48E7B204237;
        Thu, 17 Jan 2019 01:54:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ptcb4IXvIIvT; Thu, 17 Jan 2019 01:54:44 +0100 (CET)
Received: from [192.168.48.23] (host-192.252-161-233.dyn.295.ca [192.252.161.233])
        by smtp.infotech.no (Postfix) with ESMTPA id 64165204144;
        Thu, 17 Jan 2019 01:54:42 +0100 (CET)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH fix] scsi_lib: make sure scsi_request.sense valid
To:     Bart Van Assche <bvanassche@acm.org>, hch@infradead.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com
References: <20190116155700.28967-1-dgilbert@interlog.com>
 <1547682979.83374.126.camel@acm.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <023a9df4-8295-bf2e-ed3e-e191994b5fb1@interlog.com>
Date:   Wed, 16 Jan 2019 19:54:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547682979.83374.126.camel@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-01-16 6:56 p.m., Bart Van Assche wrote:
> On Wed, 2019-01-16 at 10:57 -0500, Douglas Gilbert wrote:
>> The block layer assumes scsi_request:sense is always a valid
>> pointer. This is set up once in scsi_mq_init_request() and the
>> containing scsi_cmnd object is used often, being re-initialized
>> by scsi_init_command(). That works unless some code re-purposes
>> part of the scsi_cmnd object for something else. And that is
>> what bidi handling does in scsi_mq_prep_fn(). The result is an
>> oops at some later time when the partly overwritten object is
>> re-used. The overwrite is from d285203cf647d but 'git blame'
>> does not show removed code, so that commit may not be the
>> culprit.
>>
>> Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
>> ---
>>
>> This was found while injecting errors (thus generating sense data)
>> into a sequence of bidi commands. At some later time the block
>> layer blew up with a scsi_request::sense NULL dereference in
>> sg_rq_end_io(). Without testing I'm confident the bsg driver,
>> the osd ULD and exofs are exposed to this bug.
>>
>>   drivers/scsi/scsi_lib.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index b13cc9288ba0..71259bd4040a 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -1175,6 +1175,7 @@ void scsi_init_command(struct scsi_device *dev, struct scsi_cmnd *cmd)
>>   
>>   	cmd->device = dev;
>>   	cmd->sense_buffer = buf;
>> +	cmd->req.sense = buf;
>>   	cmd->prot_sdb = prot;
>>   	cmd->flags = flags;
>>   	INIT_DELAYED_WORK(&cmd->abort_work, scmd_eh_abort_handler);
> 
> Hi Doug,
> 
> The description of this patch does not look correct to me. scsi_init_command()
> does not overwrite the sense pointer. From the body of that function:
> 
> 	/* zero out the cmd, except for the embedded scsi_request */
> 	memset((char *)cmd + sizeof(cmd->req), 0,
> 		sizeof(*cmd) - sizeof(cmd->req) + dev->host->hostt->cmd_size);
> 
> It is not clear to me which code overwrites the sense pointer. I think that
> needs to be figured out before discussion of this patch can continue.

Bart,
Please re-read the explanation. The two sentences in the middle should tell
you that you are looking at the wrong memset().

And I'm waiting for the person who wrote the questionable code to comment.


If you don't believe me, try sending a device reset to a scsi_debug device.
Then use sg_raw *** to send a XDWRITREAD(10) bidi command to the same scsi_debug
device, you should get a Unit Attention concerning that device reset. If
you do, keep sending that bidi command. Make sure you have no important
files open because that machine will lock solid. Basically what happens
when a rq_end_io() callback de-references a NULL pointer. It looks like
it has been there since 2014 and took me 2 days to find. Sorry that I can't
explain it in one simple sentence.

Douglas


*** Use 'man sg_raw' and see the EXAMPLES section (second to last example)
     You can use a bsg device as shown.


