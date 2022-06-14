Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0AEC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 23:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiFNX30 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 19:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiFNX3Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 19:29:25 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4129C4AE06
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 16:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655249364; x=1686785364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+XncXI8eMEeyF1rceibLDKgbRoZqSqmlCtN38028VBg=;
  b=IpkJKRoLyoi8IlHsHJcUBjh1o0MLBCNV3rqSKUQRtu1sSJ1ugz3RrBKb
   yynkvw7uVNRaK6Cl2eymHXbCOcnAk89ctrt2J319fp9hv+JxbbEmtVBGV
   bBbIPVRKJxPEDgpof/rofQXByzO89Nq79WLHuV/ShwUk1chaW0yFrCcZT
   rBmU3+OW/DEG48S6TlhNy86EPo+/DuBNRdwPbTaxxdkpjKB3CYHhNqXMm
   4Egge0XxYHPEi8cg8EiiJOMwjISvwFy4Z0xFKEi+i+6D7B6PFYKtAvx5M
   7/sTUuNIOm056twDdiJ1C5hjC3O7j8BMJs7zkBSeIriVURHiWrrHAgDPZ
   A==;
X-IronPort-AV: E=Sophos;i="5.91,300,1647273600"; 
   d="scan'208";a="203935561"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jun 2022 07:29:23 +0800
IronPort-SDR: 3v1+jmPAaHcCl6vMxX1l1tV4KN8hTiqkANfXKlJGUnHvt0RnIwod9e/Zh2oa694WubkZPLtNmp
 G+RUeY07hYHEl8Cc/XAzsqjKYIE48OFylDxHqw2vcwslKSMg7yt7t88tdCVbJJGYNBXcEMrk0m
 9GfuosUR8zj18PS5Fgti6iJWMGWmOlrL6+QgG8E6n0QdQz39wgrKKuFjsZWrA8Li1Ps96FW611
 kHZMszyS7fkdEAMiuYROeJcvrxBQG2iGI9JcHPlx9KgElpyA0Tmfr6Rn8To/fG81Y+jSRkPg+w
 kQgHTCkwImbp7ll/JKztd41L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 15:47:57 -0700
IronPort-SDR: Z6eHK9bo29bFP/1qjQgDxOWD4LP6qxVjvb2YAHoTewpFHIjMY7u6QLCRWfy1R7BF/Ord9FQHpS
 Dh9a9VJGcxN8KcjtgFxfxxUWZvpH1J0MB3qbzQMDk0GyZZt6ps1+cXtmi457QGvp3ugJh6P7fD
 uO7lt4Cau8eitcqHrLkibt3mKPYgTwbs7MdM/fE64hExnLENR93Wr+EK61n3x9LIme6m5kR+WY
 iaoOkQlKl1oNXIfeQ3CFrvKGoIatAdwbeQoDtb3NyQfSXBAppFJZ+I+8FD4U3NrMuHC0fcCBTo
 b4c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2022 16:29:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LN4QV69LTz1Rwrw
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 16:29:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655249362; x=1657841363; bh=+XncXI8eMEeyF1rceibLDKgbRoZqSqmlCtN
        38028VBg=; b=t5PzsPtq6aUvX0JdlBjTXgPYIJSlXomEx38+pzCL6TGWPY/z6xB
        DO9V54vemSG4eA6ajhpM48V/OnYldYWfo5G+lcfI8iFgDXUwaWAU77Vumi5UwxTr
        oPbhjasxFScstDDiQncqV2oKEMCPdWtDy68BC/vOgDEEevzDS9bnL56AO0UkQfEc
        q1JjPAILMuyHNL5Bg8ORKxKDd9MrQviUSPyOmt9Ja5WB+xSXvpbiAjdZmmrlwz4I
        nNZO8Gjl8KyZ6dJ5zOsUU/Mgs4T72bahlcNPzZ3OD9+lLRb3xnj0jbNl3AVAMVzD
        QcD2QHDBdfuxvjqfHeR8V6IFGwGR2uoqbVw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LJgoFBrKCwwo for <linux-block@vger.kernel.org>;
        Tue, 14 Jun 2022 16:29:22 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LN4QS6XlJz1Rvlc;
        Tue, 14 Jun 2022 16:29:20 -0700 (PDT)
Message-ID: <399e595b-06d2-ceb1-1b42-2a98a7724320@opensource.wdc.com>
Date:   Wed, 15 Jun 2022 08:29:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-3-bvanassche@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220614174943.611369-3-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/22 02:49, Bart Van Assche wrote:
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

Arg. No. No way. AHCI will totally break with that because most AHCI
adapters do not send commands to the drive in the order they are delivered
to the LLD. In more details, the order in which tag bit in the AHCI ready
register are set does not determine the order of command delivery to the
disk. So if zone locking is removed, you constantly get unaligned write
errors.

> 
> Increase the number of retries for write commands sent to a sequential
> zone to the maximum number of outstanding commands.
> 
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/scsi/scsi_error.c | 6 ++++++
>  drivers/scsi/sd.c         | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 49ef864df581..8e22d4ba22a3 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -674,6 +674,12 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
>  		fallthrough;
>  
>  	case ILLEGAL_REQUEST:
> +		/*
> +		 * Unaligned write command. Retry immediately to handle
> +		 * out-of-order zoned writes.
> +		 */
> +		if (sshdr.asc == 0x21 && sshdr.ascq == 0x04)
> +			return NEEDS_RETRY;
>  		if (sshdr.asc == 0x20 || /* Invalid command operation code */
>  		    sshdr.asc == 0x21 || /* Logical block address out of range */
>  		    sshdr.asc == 0x22 || /* Invalid function */
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a1a2ac09066f..8d68bd20723e 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -1202,6 +1202,8 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
>  	cmd->transfersize = sdp->sector_size;
>  	cmd->underflow = nr_blocks << 9;
>  	cmd->allowed = sdkp->max_retries;
> +	if (blk_rq_is_seq_write(rq))
> +		cmd->allowed += rq->q->nr_hw_queues * rq->q->nr_requests;
>  	cmd->sdb.length = nr_blocks * sdp->sector_size;
>  
>  	SCSI_LOG_HLQUEUE(1,


-- 
Damien Le Moal
Western Digital Research
