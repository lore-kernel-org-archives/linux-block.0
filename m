Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40377C54EBC
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 17:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjAJRlg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Jan 2023 12:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjAJRle (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 12:41:34 -0500
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DB343192
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 09:41:22 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id s3so6901466pfd.12
        for <linux-block@vger.kernel.org>; Tue, 10 Jan 2023 09:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpdwvCCSdX1jZMp+HTfKx/go71aChAkI+zbDrzqgpAo=;
        b=4H4Nx0xUJ/4CUDaX0PWn2eRTjPkEtWdcFg0a7WiWZWAo8AgsdfxnTizLLPV+8Cp7pg
         A3CsOkrCCZ0LiVvscAJu7VtLh/sqQ9kpME79hC1Tm/RkIUp5IpgG2h9x9czBkBFdGh7d
         AAA8Lmb7K6xlm6+xd3+jFU4IbaqWtxQ+9dXiGItnlvmAp22NPdHhDMZDkj1pw/Q3Cq5n
         bVbWzFeiCXi1jbbIhGQrdNkXp6lGwW+VGxR3HdkGlCEN0nqMTr6mCPr/I7DfDtS5ubl9
         dHW0cxztR4jkcDm2sZoI1D1CBm9rPHdB8ofpR/Gmr2NPITCNvfzyMvG8hmkSlqEOVl69
         4ewQ==
X-Gm-Message-State: AFqh2kpZrIgOqibTJ3RJ+lR/NzGUxM2/YAYn9lkP7DOJzWPyayQZxqhu
        7B75FHMsA6ryAJDUR8Y+oVU=
X-Google-Smtp-Source: AMrXdXsEXSX/zfy7O+1FQ4yM8jcUG7kaS5uPcmG89tiKuEQqG1yeO3BL6BWV5ZLN3DzBZx1MPZrV0g==
X-Received: by 2002:a05:6a00:1c82:b0:587:4171:30c9 with SMTP id y2-20020a056a001c8200b00587417130c9mr9121630pfw.18.1673372481472;
        Tue, 10 Jan 2023 09:41:21 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:aeba:fdb:7986:a5f9? ([2620:15c:211:201:aeba:fdb:7986:a5f9])
        by smtp.gmail.com with ESMTPSA id i8-20020a056a00004800b00576145a9bd0sm8333994pfk.127.2023.01.10.09.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 09:41:20 -0800 (PST)
Message-ID: <a88ac514-09a2-09c2-488e-69237c612fc2@acm.org>
Date:   Tue, 10 Jan 2023 09:41:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 8/8] scsi: ufs: Enable zoned write pipelining
Content-Language: en-US
To:     Bean Huo <huobean@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-9-bvanassche@acm.org>
 <9666c23b-dba0-7025-8be7-7abbc3c0fae2@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9666c23b-dba0-7025-8be7-7abbc3c0fae2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 04:23, Bean Huo wrote:
> So few changes to the UFS and SCSI layers! Does this require a VPD probe 
> to check if the UFS device is a Zoned block device and Zone size?

Hi Bean,

I think it is safe to set QUEUE_FLAG_PIPELINE_ZONED_WRITES for any UFS 
logical unit - zoned or not. The changes in the SCSI disk (sd) driver 
are such that the number of retries is only adjusted for zoned logical 
units. Only zoned logical units should report the "UNALIGNED WRITE 
COMMAND" sense code.

As you may have noticed, Damien Le Moal plans to implement a new 
approach - a single queue per zoned logical unit for all write commands.

Thanks,

Bart.

