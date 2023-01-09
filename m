Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C10C54EBD
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjAIXwC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbjAIXwB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:52:01 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7073EF44
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673308320; x=1704844320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jp9PP5F0cg96g/+LLD/vtRBvryG7CMOWMgy0J96EZ8k=;
  b=PQMSumntR6x+a82KUUnCf+Hs2PhadGCiKvSMDsLwKiY19hmn0a2KFxtU
   GXGKrbVjwFQVmA9/NPxzdPblfHnv9ZRcoVZGFsyxg//v4MEmTmXtFOz+E
   kWzZEfATtuliB4P2FkpHjPDyZJpLPTeFIISZoKtPJVDxdKGP4Z5z4ZgIA
   iGdP7XegtKnBG3JYhzA4vRsF5U9T0eTuAnpbIw6jA2Jd8m6bypP6TwIeq
   yiuDWcTmiyx2Sz505j3UQi9aOPA5cvCVn+tSMRs1u8sGR/oNT89ibzMXR
   EQXz98++FT8t2NSijYwFnYSov6khoFnXQMLwO4g65xUbH1f9f9q38G0nB
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,313,1665417600"; 
   d="scan'208";a="220268815"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 07:51:59 +0800
IronPort-SDR: p+kK7Js0iu+KoUzdDJV/4LqUTtrPqFG2TFoXoDEHtTXKq7YTv+6xN+tsW20tN//W0A6lK2nkoD
 BNVL7QL2Xjbirj7QNtj14YT4o9SV9YcMieZuTPSQnQVkGmiPcEvsKK9WNdwDv87lGtipCJeO2b
 18qHlYwwfDkMjeIj87IgDOT3T7Y7QYzphI3kjkKFgJKdv5T0hQOMRHWxwHN+2TYUtyj3fup5lu
 oUjqWlRxq1C3ZgCbZsaNw7OQciyzfvXr6laNdrQgbeZh4fs+VY4l9RCphbNZZMqFcdac+zrjPK
 5NE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 15:04:05 -0800
IronPort-SDR: YnpDqCOR4R8cZ2U+mFHMYSQEPbAhDY2Ivx93ISMzhzZtjdImo9Cu5wH0xnc0HmN1cGw98Et9/I
 wY3/zEPdCiM3pCp6jv0ui+EtK8aAz72iTOcaxxHiJt+rGgKRgXSXWOZGcTQ/KCDlbWXD+YlVUd
 q/0Tjqyc6iXqJbfw1NS8iBau/dDvk6xqgp1kVFy5Bh58LE9AdUFiXgFJGkSVYA4jFZh4W2rUVi
 MIehG41Fb9sDHDGK5uZOSsHnHeI6oQym60vWpVDmNJZ/eHing0LfiVfYYSPf6ndbJ/VBsS6Oxo
 GPs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2023 15:51:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NrW273Bjpz1Rwt8
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:51:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673308318; x=1675900319; bh=Jp9PP5F0cg96g/+LLD/vtRBvryG7CMOWMgy
        0J96EZ8k=; b=HlCkim1/R5wTphjzvfLZXpu1MbZJpDZjGCnNsJdjEPy3kVKF3fH
        rFLGTvuIRzC+FdtR/dFunlCL+f8U+XJGYdIl9z2Jy1HtYm8YHT1nlMITmOn4kpnm
        NlDSUZOqvnDuvcJKSoIn1D68ScplaIBMciBlXi7Kz3PSULAyqk+OSlPNjd9skCMm
        DsHXCxcS8PufyJY1sWdQFvjNusnG55qCgdZ6lMg+bmZkxI4XDpRLWWUHr4fTUWdY
        PqzBFcdMHrMxV4JMyH46V2c/l2flRyuTVIGCCLN3Xk/sIJindZ959n264vhVdu+3
        BR0NsMxpRtlP8/Nz6KdBRFhSIN2/WMpUg0A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FHVY8Dfz5LVO for <linux-block@vger.kernel.org>;
        Mon,  9 Jan 2023 15:51:58 -0800 (PST)
Received: from [10.225.163.12] (unknown [10.225.163.12])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NrW255r0Bz1RvLy;
        Mon,  9 Jan 2023 15:51:57 -0800 (PST)
Message-ID: <ea52044b-13ef-d71b-a14a-6e1bebe59638@opensource.wdc.com>
Date:   Tue, 10 Jan 2023 08:51:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 7/8] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-8-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230109232738.169886-8-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 08:27, Bart Van Assche wrote:
> From ZBC-2: "The device server terminates with CHECK CONDITION status, with
> the sense key set to ILLEGAL REQUEST, and the additional sense code set to
> UNALIGNED WRITE COMMAND a write command, other than an entire medium write
> same command, that specifies: a) the starting LBA in a sequential write
> required zone set to a value that is not equal to the write pointer for that
> sequential write required zone; or b) an ending LBA that is not equal to the
> last logical block within a physical block (see SBC-5)."
> 
> I am not aware of any other conditions that may trigger the UNALIGNED
> WRITE COMMAND response.
> 
> Retry unaligned writes in preparation of removing zone locking.
> 
> Increase the number of retries for write commands sent to a sequential
> zone to the maximum number of outstanding commands.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/scsi_error.c | 7 +++++++
>  drivers/scsi/sd.c         | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index a7960ad2d386..e17f36b0b18a 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -676,6 +676,13 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
>  		fallthrough;
>  
>  	case ILLEGAL_REQUEST:
> +		/*
> +		 * Unaligned write command. Retry immediately if pipelining
> +		 * zoned writes has been enabled.
> +		 */
> +		if (sshdr.asc == 0x21 && sshdr.ascq == 0x04 &&
> +		    blk_queue_pipeline_zoned_writes(sdev->request_queue))
> +			return NEEDS_RETRY;
>  		if (sshdr.asc == 0x20 || /* Invalid command operation code */
>  		    sshdr.asc == 0x21 || /* Logical block address out of range */
>  		    sshdr.asc == 0x22 || /* Invalid function */
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 47dafe6b8a66..cd90b54a6597 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1207,6 +1207,9 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>  	cmd->transfersize = sdp->sector_size;
>  	cmd->underflow = nr_blocks << 9;
>  	cmd->allowed = sdkp->max_retries;
> +	if (blk_queue_pipeline_zoned_writes(rq->q) &&
> +	    blk_rq_is_seq_zone_write(rq))
> +		cmd->allowed += rq->q->nr_requests;
>  	cmd->sdb.length = nr_blocks * sdp->sector_size;
>  
>  	SCSI_LOG_HLQUEUE(1,

Aouch... The amount of IO errors logged in the the kernel log will not be
pretty, no ?

At least for scsi disks, the problem is that a write may partially fail
(the command hit a bad sector). Such write failure will cause all queued
writes after it to fail and no amount of retry will help. Not sure about
UFS devices though. Can you get a partial failure ?


-- 
Damien Le Moal
Western Digital Research

