Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753309AbdC2O5u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2017 10:57:50 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 12/23] sd: handle REQ_UNMAP
To: Bart Van Assche <bart.vanassche@sandisk.com>,
        Alasdair G Kergon <agk@redhat.com>,
        "lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
        Jens Axboe <axboe@fb.com>, "shli@kernel.org" <shli@kernel.org>
References: <20170323143341.31549-1-hch@lst.de>
 <20170323143341.31549-13-hch@lst.de> <1490719722.2573.8.camel@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        dm <dm-devel@redhat.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Message-ID: <dab09af5-521a-99da-9852-2d18cc28ca4f@redhat.com>
Date: Wed, 29 Mar 2017 16:57:39 +0200
MIME-Version: 1.0
In-Reply-To: <1490719722.2573.8.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 28/03/2017 18:48, Bart Van Assche wrote:
>> +	if (rq->cmd_flags & REQ_UNMAP) {
>> +		switch (sdkp->provisioning_mode) {
>> +		case SD_LBP_WS16:
>> +			return sd_setup_write_same16_cmnd(cmd, true);
>> +		case SD_LBP_WS10:
>> +			return sd_setup_write_same10_cmnd(cmd, true);
>> +		}
>> +	}
>> +
>>  	if (sdp->no_write_same)
>>  		return BLKPREP_INVALID;
>>  	if (sdkp->ws16 || sector > 0xffffffff || nr_sectors > 0xffff)
> Users can change the provisioning mode from user space from SD_LBP_WS16 into
> SD_LBP_WS10 so I'm not sure it's safe to skip the (sdkp->ws16 || sector >
> 0xffffffff || nr_sectors > 0xffff) check if REQ_UNMAP is set.

Yeah, if REQ_UNMAP is set you should probably check sdkp->provisioning_mode
instead of sdkp->ws16, but apart from this it should still go through the
checks below.

Plus, if the provisioning mode is not ws10 or ws16, should
sd_setup_write_zeroes_cmnd:

1) do a WRITE SAME without UNMAP (what Christoph's code does)

2) return BLKPREP_INVALID

3) ignore provisioning mode and do a WRITE SAME with UNMAP

4) do a WRITE SAME without UNMAP for SD_LBP_{ZERO,FULL,DISABLE},
do a WRITE SAME with UNMAP for SD_LBP_{WS10,WS16,UNMAP}.

I'm in favor of (4).  The distinction between SD_LBP_UNMAP, SD_LBP_WS10
and SD_LBP_WS16 is as problematic as discard_zeroes_data in my opinion.

Thanks,

Paolo
