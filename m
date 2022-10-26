Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8C8FA373E
	for <linux-block@archiver.kernel.org>; Wed, 26 Oct 2022 12:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiJZM5Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Oct 2022 08:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiJZM5Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:57:24 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815EF3B942
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:57:23 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id g12so13383916wrs.10
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZGKHZT7eHDVXHyhk81/G/GgKEUUUIkoFm8tFpTO+q4=;
        b=6xysE2ed8ZLTiFiWhVo/QyXtnVuuOr8paWQu8Lq7iHeEdpkGVIRKNSpvatcw8uHcIW
         4j+dDGaBJDBSiWyEnvmllNMZUdKb0heT2xs0vrPhparr+lDtk9WHv0X03M34p7gtqrav
         1h6CRdFKLuIBcEM47nfI0fDBJXMxuSxyjxECVhNPtAEfgpDtDHradeg0fwxE8MtbkvgR
         UXLipB2p9nILnzR2z7jAuqicxeHnE6279aO3uox4zwUAPDsyYeemtDR7r+/wlS+YpTpa
         ejDWcMmn4R2nXgmhgrJB4BswEb2jIqeVl88hineB8u0DLZa/8Fd09kHj9QASX/z2264E
         Bj8g==
X-Gm-Message-State: ACrzQf0vXvTnLwsZaDGE53zPWL3ahNgvO7VRZhdeVmF99ybwwZ8QQK01
        gCarDkzRqD+uJebWoNGZKrs=
X-Google-Smtp-Source: AMsMyM7k459DzhGpKR6gZ+BNCuarlj+8Ojb4Dz1RA4xpxPQpDc2g52AicH/P5Am/t2I1HkmiMYXHZg==
X-Received: by 2002:a5d:6d85:0:b0:232:770:aaaf with SMTP id l5-20020a5d6d85000000b002320770aaafmr29544055wrs.595.1666789042111;
        Wed, 26 Oct 2022 05:57:22 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003b4cba4ef71sm1833278wmo.41.2022.10.26.05.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:57:21 -0700 (PDT)
Message-ID: <be199534-260c-f587-923e-3972f56f97ce@grimberg.me>
Date:   Wed, 26 Oct 2022 15:57:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 10/17] nvme-pci: mark the namespaces dead earlier in
 nvme_remove
Content-Language: en-US
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-11-hch@lst.de>
 <5ad559f0-d6c3-54c8-da0d-910b24d159b4@grimberg.me>
In-Reply-To: <5ad559f0-d6c3-54c8-da0d-910b24d159b4@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> When we have a non-present controller there is no reason to wait in
>> marking the namespaces dead, so do it ASAP.  Also remove the superflous
>> call to nvme_start_queues as nvme_dev_disable already did that for us.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/nvme/host/pci.c | 18 ++++++------------
>>   1 file changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 8ab54857cfd50..bef98f6e1396c 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3244,25 +3244,19 @@ static void nvme_remove(struct pci_dev *pdev)
>>       nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
>>       pci_set_drvdata(pdev, NULL);
>> +    /*
>> +     * Mark the namespaces dead as we can't flush the data, and 
>> disable the
>> +     * controller ASAP as we can't shut it down properly if it was 
>> surprise
>> +     * removed.
>> +     */
>>       if (!pci_device_is_present(pdev)) {
>>           nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
>> +        nvme_mark_namespaces_dead(&dev->ctrl);
> 
> Don't you need to start the queues as well here?

nevermind, you call disable with shutdown=true

> 
>>           nvme_dev_disable(dev, true);
