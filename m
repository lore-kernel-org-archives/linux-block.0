Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B02C46467
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 14:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiK2OA1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiK2OA0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 09:00:26 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF6F2AC65
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:00:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id v3so13092468pgh.4
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vfmdPrG/d/sdcfBpP/NPY9FRIiiTUjLGS4u7Y99UOIE=;
        b=oGZ/Yt/gIKSQvsmmQAqcqfOeW8pLTBZ4YW8Ym0mEQmIDNl5xMsrQl5yKcC1yfph0lv
         VWJkIZGtWuD/YOiGYGQvZVo5EmLaBfe051c6fokhgSyIjPtz7Nho5gEoeXmDikdvp10V
         VneR3YhPNehWBtWji7zUkuLqXzBIEzgbn8OpBXNhk60XRLhNXQn/vNXNMKIVhWcapXdw
         ju9p+VGhx8ZOTMLRo/aTaNfdUCPx5CM4/opnYwAGqgZ2/tx/BpmnvR8wUg+1QB4geIFp
         PlM5sGl4kAqj8HRJcTY4h42mOtNpLriihJ50p+eTyVRlNf/K2Gp/LLzwik2tHbJ3E5rR
         ejzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfmdPrG/d/sdcfBpP/NPY9FRIiiTUjLGS4u7Y99UOIE=;
        b=Ewl9KQ2bY+5bsLOFFdQ86w1g6huitxqZPBZsEZvehsuvr7/kcY+lENKtCnku2Pz4IV
         FGxsjYtKe2MZDc4StBH7GG0ckjafE7ABy0BvO1wsinzio8jWD/R093TMy1Ct51iAb87c
         F3pupbny3hF6S2JZqRKPF4xsd4/ibXtTfdw/Z7Vw39h3rxgpMX7rsjnMl3ddgkk/0xXP
         PmGEOb76dbOrOGIr1eDeVcEsRds0cWkIcSyQantX7lJw/bIKDHAFdePyS0b/tV0PcZFW
         UTs+Mc9QRwD91AnEg77D+05DBJ0JaoPSuDD2lNnso2HgVGtD9VBXhOoLuOO4OdLvnYww
         JPsg==
X-Gm-Message-State: ANoB5pm8JVzy3R13gJ5D3YKTC0G2L2eg0fKk/MbK0rrznh6lkawyw7LJ
        KQ5WzFQbi8OokSAfeDu2gLajOg==
X-Google-Smtp-Source: AA0mqf5pYbhR7pkuhHMFk67yso4Z04ENb6/JaLVqnj5Qm3hFaKDh2I38Mgs3uXFHWikR7bv14adqbw==
X-Received: by 2002:a63:d21:0:b0:438:c2f0:c2cf with SMTP id c33-20020a630d21000000b00438c2f0c2cfmr17408182pgl.116.1669730425127;
        Tue, 29 Nov 2022 06:00:25 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id kb1-20020a17090ae7c100b0020b21019086sm1863999pjb.3.2022.11.29.06.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:00:24 -0800 (PST)
Message-ID: <613117ce-56ce-10cb-1548-eac1741ceae5@kernel.dk>
Date:   Tue, 29 Nov 2022 07:00:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 0/4] block/scsi/nvme: Add error codes for PR ops
Content-Language: en-US
To:     "hch@lst.de" <hch@lst.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Christie <michael.christie@oracle.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20221122032603.32766-1-michael.christie@oracle.com>
 <yq1o7sumo0c.fsf@ca-mkp.ca.oracle.com>
 <538bcade-c453-e6f8-4530-808a9bf2140a@nvidia.com>
 <20221129132805.GA13061@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221129132805.GA13061@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/22 6:28 AM, hch@lst.de wrote:
> On Tue, Nov 29, 2022 at 04:18:19AM +0000, Chaitanya Kulkarni wrote:
>>> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
>>>
>>
>> perhaps a block tree since it has block/scsi/nvme ?
> 
> I think Mike has SCSI work that builds on top of this, and reservations
> ar originally a SCSI feature.  But either block or scsi is fine with
> me.

I'm fine with scsi or block, I'm assuming we won't have any
conflicts from this on the block/nvme side?

If we're doing block just let me know and I can queue it up.

-- 
Jens Axboe


