Subject: Re: [PATCH 5/6] mtip32xx: convert internal command issue to block IO
 path
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1493333494-600-1-git-send-email-axboe@fb.com>
 <1493333494-600-6-git-send-email-axboe@fb.com>
 <1493335751.2625.19.camel@sandisk.com>
Cc: "hch@lst.de" <hch@lst.de>, "ming.lei@redhat.com" <ming.lei@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <5b667f22-d12a-7e57-237a-155faba55409@fb.com>
Date: Thu, 27 Apr 2017 17:35:39 -0600
MIME-Version: 1.0
In-Reply-To: <1493335751.2625.19.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/27/2017 05:29 PM, Bart Van Assche wrote:
> On Thu, 2017-04-27 at 16:51 -0600, Jens Axboe wrote:
>> @@ -1114,10 +1121,16 @@ static int mtip_exec_internal_command(struct mtip_port *port,
>>  					u32 opts,
>>  					unsigned long timeout)
>>  {
>> -	struct mtip_cmd_sg *command_sg;
>>  	DECLARE_COMPLETION_ONSTACK(wait);
>>  	struct mtip_cmd *int_cmd;
>>  	struct driver_data *dd = port->dd;
>> +	struct request *rq;
>> +	struct mtip_int_cmd icmd = {
>> +		.fis_len = fis_len,
>> +		.buffer = buffer,
>> +		.buf_len = buf_len,
>> +		.opts = opts
>> +	};
>>  	int rv = 0;
>>  	unsigned long start;
>>  
>> @@ -1132,6 +1145,8 @@ static int mtip_exec_internal_command(struct mtip_port *port,
>>  		dbg_printk(MTIP_DRV_NAME "Unable to allocate tag for PIO cmd\n");
>>  		return -EFAULT;
>>  	}
>> +	rq = blk_mq_rq_from_pdu(int_cmd);
>> +	rq->end_io_data = &icmd;
>>  
>>  	set_bit(MTIP_PF_IC_ACTIVE_BIT, &port->flags);
>>  
>> @@ -1158,30 +1173,10 @@ static int mtip_exec_internal_command(struct mtip_port *port,
>>  	/* Copy the command to the command table */
>>  	memcpy(int_cmd->command, fis, fis_len*4);
>>  
>> -	/* Populate the SG list */
>> -	int_cmd->command_header->opts =
>> -		 __force_bit2int cpu_to_le32(opts | fis_len);
>> -	if (buf_len) {
>> -		command_sg = int_cmd->command + AHCI_CMD_TBL_HDR_SZ;
>> -
>> -		command_sg->info =
>> -			__force_bit2int cpu_to_le32((buf_len-1) & 0x3FFFFF);
>> -		command_sg->dba	=
>> -			__force_bit2int cpu_to_le32(buffer & 0xFFFFFFFF);
>> -		command_sg->dba_upper =
>> -			__force_bit2int cpu_to_le32((buffer >> 16) >> 16);
>> -
>> -		int_cmd->command_header->opts |=
>> -			__force_bit2int cpu_to_le32((1 << 16));
>> -	}
>> -
>> -	/* Populate the command header */
>> -	int_cmd->command_header->byte_count = 0;
>> -
>>  	start = jiffies;
>>  
>> -	/* Issue the command to the hardware */
>> -	mtip_issue_non_ncq_command(port, MTIP_TAG_INTERNAL);
>> +	/* insert request and run queue */
>> +	blk_execute_rq_nowait(rq->q, NULL, rq, true, NULL);
>>  
>>  	/* Wait for the command to complete or timeout. */
>>  	rv = wait_for_completion_interruptible_timeout(&wait,
> 
> Hello Jens,
> 
> What will happen upon timeout? Will the end_io_data pointer be dereferenced if
> a timeout occurs? Can that cause the completion function to access data on the
> stack after it has been freed?

Good point - since we know get timeouts courtesy of blk-mq, I will kill
this individual timeout to avoid having any races there.

-- 
Jens Axboe
