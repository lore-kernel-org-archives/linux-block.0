Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116BBC63797
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 12:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjAJMZb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 07:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbjAJMYy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 07:24:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED82DCC1
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 04:23:50 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v30so17250927edb.9
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 04:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVE17Z1afUE5aimPhcBOm02ZYutHWykpOarYjQuH6oY=;
        b=O3KW7QMzUkRxbxZYSfVj6E8EIMHx2hQE7B4YBSgnv2rr+0Ut8myBphgkl2Dz3+eRjQ
         et8NTH6KzDA9ZbMhkVvLqzulCxaKS3hu0S+QRSn/AgpTJUVvjApmHTAwhSdaGjCYXoFk
         mNklK9mwc8ubagHuDaL13fB9iAQDeqfunOUw5ccBAoxzj2ktkmAMguIuCEawdO7gp5lx
         mVZMLoO1q23tc6pPy6RqJs1Bt7NhHlQeiBMzgWQOcFKLdufFgQFotWzH6rNlIYgTRg6C
         PvO+HVB2OVe2y8wM2yg0KV+gTXoggxsxoU9jweVxFnCYAs9gaUNteXuzNh39aRPFcnnD
         9kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVE17Z1afUE5aimPhcBOm02ZYutHWykpOarYjQuH6oY=;
        b=CRboKfBw1r36y+lD7DsBlR4hAYCPQlIj7oIDrhhk2C68lquwqVuGsIF0U+kAdFSjIU
         PMbAw1RpTE5njZsjwFyEj4r/SAFtx8zw+A+gYwAlqpwCyAYbniIj6Ey02BhXuY4u6q3R
         dWr4Sbs2KHPBb5jrPir+89rqeE0ILIjhzPlqBct0eIfNQO1ne0i13UrUuHWDWSGjNT47
         vIBtGIqhbTgx5TwPjNw8CGPhraQfS7MQU7pEqsUPV8x5RjCNRqlvVw2YcYmgbo9Dx/OG
         siqXuJBRvontzLkc110qQrIWTC2FywEWudSXHQBv1vJjhPNKRTkNQoYIrD/f7LeoUvRO
         bGxA==
X-Gm-Message-State: AFqh2kpBjTMBJecJ0KwvhUqbEPk1zR/y+7ED66+cw4r+cRkeIGrF0E5o
        TaBMH1o5ufkai2krZbZxJ/0aQsIwUSs=
X-Google-Smtp-Source: AMrXdXvoil0HbCFGhJu7V2Ra/oSUdXCn6aK0tyU7Kgn5avSVdb2q/k/4LLXzDnV4G2Uug4iGtz0qIQ==
X-Received: by 2002:a05:6402:7c4:b0:499:376e:6b35 with SMTP id u4-20020a05640207c400b00499376e6b35mr7890600edy.25.1673353429416;
        Tue, 10 Jan 2023 04:23:49 -0800 (PST)
Received: from [10.176.235.173] ([137.201.254.41])
        by smtp.gmail.com with ESMTPSA id k16-20020a05640212d000b0048b4e2aaba0sm4888067edx.34.2023.01.10.04.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 04:23:48 -0800 (PST)
Message-ID: <9666c23b-dba0-7025-8be7-7abbc3c0fae2@gmail.com>
Date:   Tue, 10 Jan 2023 13:23:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 8/8] scsi: ufs: Enable zoned write pipelining
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-9-bvanassche@acm.org>
Content-Language: en-US
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <20230109232738.169886-9-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart,

So few changes to the UFS and SCSI layers! Does this require a VPD probe 
to check if the UFS

device is a Zoned block device and Zone size?

Kind regards,

Bean

On 10.01.23 12:27 AM, Bart Van Assche wrote:
>  From the UFSHCI 4.0 specification, about the legacy (single queue) mode:
> "The host controller always process transfer requests in-order according
> to the order submitted to the list. In case of multiple commands with
> single doorbell register ringing (batch mode), The dispatch order for
> these transfer requests by host controller will base on their index in
> the List. A transfer request with lower index value will be executed
> before a transfer request with higher index value."
>
>  From the UFSHCI 4.0 specification, about the MCQ mode:
> "Command Submission
> 1. Host SW writes an Entry to SQ
> 2. Host SW updates SQ doorbell tail pointer
>
> Command Processing
> 3. After fetching the Entry, Host Controller updates SQ doorbell head
>     pointer
> 4. Host controller sends COMMAND UPIU to UFS device"
>
> In other words, for both legacy and MCQ mode, UFS controllers are
> required to forward commands to the UFS device in the order these
> commands have been received from the host.
>
> Note: for legacy mode this is only correct if the host submits one
> command at a time. The UFS driver does this.
>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Avri Altman <avri.altman@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/ufs/core/ufshcd.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index e18c9f4463ec..9198505e953b 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5031,6 +5031,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
>   
>   	ufshcd_hpb_configure(hba, sdev);
>   
> +	blk_queue_flag_set(QUEUE_FLAG_PIPELINE_ZONED_WRITES, q);
>   	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
>   	if (hba->quirks & UFSHCD_QUIRK_ALIGN_SG_WITH_PAGE_SIZE)
>   		blk_queue_update_dma_alignment(q, PAGE_SIZE - 1);
