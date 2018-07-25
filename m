Return-Path: <dgilbert@interlog.com>
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCHv2 2/2] scsi: set timed out out mq requests to complete
To: Keith Busch <keith.busch@linux.intel.com>,
 Bart Van Assche <bart.vanassche@wdc.com>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Jianchao Wang <jianchao.w.wang@oracle.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20180723143751.10843-1-keith.busch@intel.com>
 <20180723143751.10843-2-keith.busch@intel.com>
 <86e23e58-6f80-7957-30f7-8b0ce8cb50ce@wdc.com>
 <20180725011543.GA14596@localhost.localdomain>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <70619fc4-3b98-4213-0d4e-aa7aa248f88d@interlog.com>
Date: Tue, 24 Jul 2018 21:56:35 -0400
MIME-Version: 1.0
In-Reply-To: <20180725011543.GA14596@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 2018-07-24 09:15 PM, Keith Busch wrote:
> On Tue, Jul 24, 2018 at 03:46:17PM -0700, Bart Van Assche wrote:
>> On 07/23/18 07:37, Keith Busch wrote:
>>> +		if (req->q->mq_ops && !blk_mq_mark_complete(req))
>>> +			return rtn;
>>>    		if (scsi_abort_command(scmd) != SUCCESS) {
>>>    			set_host_byte(scmd, DID_TIME_OUT);
>>>    			scsi_eh_scmd_add(scmd);
>>
>> This change looks incomplete to me. I think the following scenario is not
>> handled properly by the above patch:
>> - host->hostt->eh_timed_out() gets called.
>> - The request "req" completes from another context while
>>    host->hostt->eh_timed_out() is in progress.
>> - host->hostt->eh_timed_out() calls scsi_finish_command().
>>
>> I think that scenario will lead to a double completion.
> 
> A bit of a moot point, isn't it? Not a single scsi lld directly calls
> scsi_finish_command() from anywhere, much less through eh_timed_out().

" * scsi_finish_command - cleanup and pass command back to upper layer"

That is from the comment block above the definition of scsi_finish_command().
To me that means the mid-level has already got the response from the LLD
(directly via a queuecommand() return, or asynchronously via the scsi_done()
callback) and this function will call the "upper layer" which will be
the one of the sd, sr, st, sg, ses, etc drivers that originated the command
for that UL-driver's completion.

In USB Type C speak, the SCSI mid level has two interfaces, one downward
facing (toward LLDs) and one upward facing (toward the drivers listed above).
No LLD should be calling scsi_finish_command() IMO.

Doug Gilbert
