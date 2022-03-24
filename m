Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE63FC433EF
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 23:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiCXXjl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 19:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356977AbiCXXiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 19:38:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A08B6D3C
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 16:36:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w4so6344766ply.13
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GebMZe55xHN1I+0YXbeTh7daUrmbTo6OsaivpOl4mhM=;
        b=ZTsDnLd6GGJ/CDNND38btHDAVkn3zbXuN/5tHhxkl/olLbx9B/SxKx7u3z/q25MPmm
         6qCZwQ1+j7YORPvJZ9GBwsqPD1TGedIrtEMcCUlPYEu0Jwn+egh8rAG4RZyYYqFt83Ya
         BmP837YpxGYX8Gi76uQZIT0sue2hPve4uK1ufIGT9LY665Jbi2T0P4MNc37dEhf/VdMe
         z7c3t1lMbTUX+yAsG4sOCRETXzAWCu/ylwvScmtYLgvftncFBspdMgh/rZJSnrrugRti
         l8DKyTe5OT6sdGIWlIA+1GeI6CjaTvHAfuVLE7dymwW1MYsyr6VQX0XaDPUSM0Qb1nmQ
         2fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GebMZe55xHN1I+0YXbeTh7daUrmbTo6OsaivpOl4mhM=;
        b=1MenWrHUTaHraJAfg9Qh5llW1XJJFf2HptRlpX2QppCK5bDaJParJa/ccxxEL2QnqD
         P6+qkF5hfAukBr2dBZsCuqrZhhyCd1bZBmv0BeJNMmF7OnKeYhrp2GeMnn88TX/OY819
         AF8yWEkANRsI7huVFIqarEnAI4guLxNNy5Ao7ivtRLCy7kAbAcqnTMnvUgb9XmM/EQ98
         1/ulP942WH0CTt2NaW3veVevSkrcLg5LPQg4kQ1nYRIJy5Dky98uOQEYpzcYdkcoc8Ml
         IKGqdeLUba2CpEcsVPD7P3zpgmSzbhP9t0wbaOTZjsEwcDbfqoCqFK4tANLRtAIhLFSp
         swqg==
X-Gm-Message-State: AOAM532MeU/PMbKmZq3M3BzXre68sglrnw7DSQVsZX/PyMKxYjSxMA63
        +FxwhybsMnJkhiT11Cfo0BFNOA==
X-Google-Smtp-Source: ABdhPJzqMNc0ahbFfodPumpJQOiINRzZGitX9G+hqCRFpKVPql6rpnnDAM2cR9akyaGDaLiOylrvLQ==
X-Received: by 2002:a17:90b:4f86:b0:1c6:b3eb:99a3 with SMTP id qe6-20020a17090b4f8600b001c6b3eb99a3mr9261128pjb.66.1648165009872;
        Thu, 24 Mar 2022 16:36:49 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y9-20020a056a00180900b004faa45a2230sm4754641pfa.210.2022.03.24.16.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 16:36:49 -0700 (PDT)
Message-ID: <2e4e5faa-ca1e-75b1-b864-646270b708ed@kernel.dk>
Date:   Thu, 24 Mar 2022 17:36:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Content-Language: en-US
To:     Clay Mayers <Clay.Mayers@kioxia.com>,
        Kanchan Joshi <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>
Cc:     "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sbates@raithlin.com" <sbates@raithlin.com>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "anuj20.g@samsung.com" <anuj20.g@samsung.com>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com>
 <6a1cf782310d481aa5ef2fc172f55826@kioxia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6a1cf782310d481aa5ef2fc172f55826@kioxia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/22 3:09 PM, Clay Mayers wrote:
>> From: Kanchan Joshi
>> Sent: Tuesday, March 8, 2022 7:21 AM
>> To: axboe@kernel.dk; hch@lst.de; kbusch@kernel.org;
>> asml.silence@gmail.com
>> Cc: io-uring@vger.kernel.org; linux-nvme@lists.infradead.org; linux-
>> block@vger.kernel.org; sbates@raithlin.com; logang@deltatee.com;
>> pankydev8@gmail.com; javier@javigon.com; mcgrof@kernel.org;
>> a.manzanares@samsung.com; joshiiitr@gmail.com; anuj20.g@samsung.com
>> Subject: [PATCH 17/17] nvme: enable non-inline passthru commands
>>
>> From: Anuj Gupta <anuj20.g@samsung.com>
>>
>> On submission,just fetch the commmand from userspace pointer and reuse
>> everything else. On completion, update the result field inside the passthru
>> command.
>>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> ---
>>  drivers/nvme/host/ioctl.c | 29 +++++++++++++++++++++++++----
>>  1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c index
>> 701feaecabbe..ddb7e5864be6 100644
>> --- a/drivers/nvme/host/ioctl.c
>> +++ b/drivers/nvme/host/ioctl.c
>> @@ -65,6 +65,14 @@ static void nvme_pt_task_cb(struct io_uring_cmd
>> *ioucmd)
>>  	}
>>  	kfree(pdu->meta);
>>
>> +	if (ioucmd->flags & IO_URING_F_UCMD_INDIRECT) {
>> +		struct nvme_passthru_cmd64 __user *ptcmd64 = ioucmd-
>>> cmd;
>> +		u64 result = le64_to_cpu(nvme_req(req)->result.u64);
>> +
>> +		if (put_user(result, &ptcmd64->result))
>> +			status = -EFAULT;
> 
> When the thread that submitted the io_uring_cmd has exited, the CB is
> called by a system worker instead so put_user() fails.  The cqe is
> still completed and the process sees a failed i/o status, but the i/o
> did not fail.  The same is true for meta data being returned in patch
> 5.
> 
> I can't say if it's a requirement to support this case.  It does break
> our current proto-type but we can adjust.

Just don't do that then - it's all very much task based. If the task
goes away and completions haven't been reaped, don't count on anything
sane happening in terms of them completing successfully or not.

The common case for this happening is offloading submit to a submit
thread, which is utterly pointless with io_uring anyway.

-- 
Jens Axboe

