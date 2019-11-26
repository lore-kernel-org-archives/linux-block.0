Return-Path: <SRS0=BQu2=ZS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8BBC432C0
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7512071A
	for <linux-block@archiver.kernel.org>; Tue, 26 Nov 2019 16:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfKZQcg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:32:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:54994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbfKZQcf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 11:32:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9723B3EB;
        Tue, 26 Nov 2019 16:32:33 +0000 (UTC)
Subject: Re: [PATCH] nvme: Add support for ACRE Command Interrupted status
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, John Meneghini <johnm@netapp.com>,
        Jen Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20191126133650.72196-1-hare@suse.de>
 <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <90bb47cc-8a4b-1ddb-be6c-d237bfbe88f8@suse.de>
Date:   Tue, 26 Nov 2019 17:32:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191126160546.GA2906@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/19 5:05 PM, Keith Busch wrote:
> [cc'ing linux-block, Jens]
> 
> On Tue, Nov 26, 2019 at 02:36:50PM +0100, Hannes Reinecke wrote:
>> This patch fixes a bug in nvme_complete_rq logic introduced by
>> Enhanced Command Retry code. According to TP-4033 the controller
>> only sets CDR when the Command Interrupted status is returned.
>> The current code interprets Command Interrupted status as a
>> BLK_STS_IOERR, which results in a controller reset if
>> REQ_NVME_MPATH is set.
> 
> I see that Command Interrupted status requires ACRE enabled, but I don't
> see the TP saying that the CQE CRD fields are used only with that status
> code. I'm pretty sure I've seen it used for Namespace Not Ready status
> as well. That would also fail MPATH for the same reason as this new
> status...
> 
No, true, CRD is not directly related to 'command interrupted'.
According to the powers that be CRD evaluation is depending on the ACRE 
setting (and hence should be evaluated whenever a command needs to be 
retried), but 'command interrupted' will only be returned if ACRE is 
enabled.
Consequently, whenever you get a 'command interrupted' you need to check 
the CRD setting to figure out the delay.

>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 108f60b46804..752a40daf2b3 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -201,6 +201,8 @@ static blk_status_t nvme_error_status(u16 status)
>>   	switch (status & 0x7ff) {
>>   	case NVME_SC_SUCCESS:
>>   		return BLK_STS_OK;
>> +	case NVME_SC_COMMAND_INTERRUPTED:
>> +		return BLK_STS_RESOURCE;
>>   	case NVME_SC_CAP_EXCEEDED:
>>   		return BLK_STS_NOSPC;
>>   	case NVME_SC_LBA_RANGE:
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index d688b96d1d63..3a0d84528325 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -84,6 +84,7 @@ static inline bool blk_path_error(blk_status_t error)
>>   	case BLK_STS_NEXUS:
>>   	case BLK_STS_MEDIUM:
>>   	case BLK_STS_PROTECTION:
>> +	case BLK_STS_RESOURCE:
>>   		return false;
>>   	}
> 
> I agree we need to make this status a non-path error, but we at least
> need an Ack from Jens or have this patch go through linux-block if we're
> changing BLK_STS_RESOURCE to mean a non-path error.
> 
Alternatively we can define a new return value, if we shouldn't re-use 
existing ones. Either way I'm fine with.

>> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>> index f61d6906e59d..6b21f3888cad 100644
>> --- a/include/linux/nvme.h
>> +++ b/include/linux/nvme.h
>> @@ -1292,6 +1292,8 @@ enum {
>>   
>>   	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
>>   
>> +	NVME_SC_COMMAND_INTERRUPTED	= 0x21,
> 
> This command status was actually already defined in commit
> 48c9e85b23464, though with a slightly different name.
> 
Ah. Will be modifying the patch then.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
