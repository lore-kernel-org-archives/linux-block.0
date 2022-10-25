Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A5EC38A2D
	for <linux-block@archiver.kernel.org>; Tue, 25 Oct 2022 20:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbiJYURO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Oct 2022 16:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiJYURN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 16:17:13 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86BAC8941
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 13:17:08 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id a14so20221242wru.5
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 13:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97GpEQ2+6Ykh6KgprSH5be6D6WMxByu7zMpaNrCZEeY=;
        b=PIeldrA9epW8VxLcqstrvnVYHfpflxSuaW1ijFHKaClFZjGKsW/gKCicAiZAjopbyj
         ym8ASLbgka2bQNVxDtM1k+OOXUuNZENmOTUrtsb6Uux7/+Jlb/mChomjIBJkr3tf+TtD
         CImMT+H83OpMl32u69hT6L+0cV0KzA3Nw4YSfNOCu8r3zf+pSQk3+q+02tGM9IK1dia4
         cPqawCJ8ETZ3l2RqYGjoGMd93yNo2+9uKanFJMlHCljBKZM4rrA+Ty9H/ERgHkHrMNWm
         NJUsvK5FJNszeqytGwvZ77IFeffDqV6JFMs5drxIiOgI9mv4+HWZYLwC3n97CYmftZKA
         VwUQ==
X-Gm-Message-State: ACrzQf3ox3rd5erMx6EDrmw50EPiy64Ex5nggh0o7HFwywIhnF1nlCf6
        TfGCuKg81mYcJAOI2CjGYro=
X-Google-Smtp-Source: AMsMyM5a1FeYsBbMRzCZtprCw+A2mLQrmVG/96WZ5BZLQiiu3e1XHmmXMkoH0J4o6OVBti4WBHAG2Q==
X-Received: by 2002:a5d:51c2:0:b0:236:7000:8e82 with SMTP id n2-20020a5d51c2000000b0023670008e82mr8650982wrv.191.1666729027231;
        Tue, 25 Oct 2022 13:17:07 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003c6f27d275dsm12763840wmq.33.2022.10.25.13.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 13:17:06 -0700 (PDT)
Message-ID: <63c062dd-babb-e815-131a-bc0e513bb33e@grimberg.me>
Date:   Tue, 25 Oct 2022 23:17:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 04/17] nvme: don't call nvme_kill_queues from
 nvme_remove_namespaces
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-5-hch@lst.de>
 <Y1ggN68V/mbAw1q2@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y1ggN68V/mbAw1q2@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/25/22 20:43, Keith Busch wrote:
> On Tue, Oct 25, 2022 at 07:40:07AM -0700, Christoph Hellwig wrote:
>> @@ -4560,15 +4560,6 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>>   	/* prevent racing with ns scanning */
>>   	flush_work(&ctrl->scan_work);
>>   
>> -	/*
>> -	 * The dead states indicates the controller was not gracefully
>> -	 * disconnected. In that case, we won't be able to flush any data while
>> -	 * removing the namespaces' disks; fail all the queues now to avoid
>> -	 * potentially having to clean up the failed sync later.
>> -	 */
>> -	if (ctrl->state == NVME_CTRL_DEAD)
>> -		nvme_kill_queues(ctrl);
>> -
>>   	/* this is a no-op when called from the controller reset handler */
>>   	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
>>   
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index ec034d4dd9eff..f971e96ffd3f6 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -3249,6 +3249,16 @@ static void nvme_remove(struct pci_dev *pdev)
>>   
>>   	flush_work(&dev->ctrl.reset_work);
>>   	nvme_stop_ctrl(&dev->ctrl);
>> +
>> +	/*
>> +	 * The dead states indicates the controller was not gracefully
>> +	 * disconnected. In that case, we won't be able to flush any data while
>> +	 * removing the namespaces' disks; fail all the queues now to avoid
>> +	 * potentially having to clean up the failed sync later.
>> +	 */
>> +	if (dev->ctrl.state == NVME_CTRL_DEAD)
>> +		nvme_kill_queues(&dev->ctrl);
>> +
>>   	nvme_remove_namespaces(&dev->ctrl);
>>   	nvme_dev_disable(dev, true);
>>   	nvme_remove_attrs(dev);
>> -- 
>> 2.30.2
>>
> 
> We still need the flush_work(scan_work) prior to killing the queues. It
> looks like it could safely be moved to nvme_stop_ctrl(), which might
> make it easier on everyone if it were there.

If we do end up moving it to nvme_stop_ctrl, can we make a sub-version
of nvme_stop_ctrl that cannot block on I/O (i.e. without ana/scan/auth)?
for multipathing where we want to teardown the controller quickly so we
can failover I/O asap.

IIRC this is why scan_work is not in nvme_stop_ctrl to begin with, but
it is also possible that there was some other deadlock caused by that.
