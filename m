Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A2EC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 21:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809922086A
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 21:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809922086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbeKTHrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:47:33 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46185 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbeKTHrd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 02:47:33 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so28299970otm.13;
        Mon, 19 Nov 2018 13:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F9BZdKrM4kSDNwgZKEroAUMejaz9BLY0JzWMyDkE7iQ=;
        b=mtd+54sBZNmhZbL6AxJgZZJoyXYDwzgsb7Bs2yUvHTzfbgJJY1t8dMrK/s8a724y/S
         TsAHWxW6xUn9JxCLlrBtkC6ri256QpsaCIK0U8TqMdBwf3x4TBuo47nBkgON7NiiqM7t
         PTc1GzFnJ9cb47VCe4Bu/R2UozQCvxsi2A5LNRzTOFJb2OmNw5Y2tzjnh8Lc1BUwr6F9
         dELU1LF8MJxgpX6Yy1aLKRub3nG5D/kZTF4T+7HztsGAUGRZqWHmNSy7nQdL0ANgPcS8
         8O5dvaXyJO/nQ+FWP5g5QA6mZIkD93jWVOB1Pd6n7xbjAhngtHCtg9sm0R3TgwuzX8I4
         M/3Q==
X-Gm-Message-State: AA+aEWYT2gz4w0D3a7WF46wvWF74HkQk/wElkZsygzpsCwEquT6LsZ8o
        8anI8Vwi8RHrsyikqZ0acPoZjnOO
X-Google-Smtp-Source: AFSGD/VjudCFDO9eP5qEJYGFFAIZhyZuUagokoMPVBbHpnIsd1Hlj8658VEujNBjuc9/2I5JqdlfmA==
X-Received: by 2002:a9d:6f8e:: with SMTP id h14mr70240otq.241.1542662521365;
        Mon, 19 Nov 2018 13:22:01 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id b128sm951256oif.7.2018.11.19.13.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 13:22:00 -0800 (PST)
Subject: Re: [PATCH 05/11] nvmet: Add install_queue callout
To:     Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@lightbitslabs.com>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-6-sagi@lightbitslabs.com>
 <af370da9-3d56-e1a8-27db-c0a8e9291417@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <98230184-074a-84cf-3aa5-8ad30f2b5339@grimberg.me>
Date:   Mon, 19 Nov 2018 13:21:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <af370da9-3d56-e1a8-27db-c0a8e9291417@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> diff --git a/drivers/nvme/target/fabrics-cmd.c 
>> b/drivers/nvme/target/fabrics-cmd.c
>> index 1f05d8507e35..a84668e8939c 100644
>> --- a/drivers/nvme/target/fabrics-cmd.c
>> +++ b/drivers/nvme/target/fabrics-cmd.c
>> @@ -117,6 +117,15 @@ static u16 nvmet_install_queue(struct nvmet_ctrl 
>> *ctrl, struct nvmet_req *req)
>>       nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1,
>>               !!(c->cattr & NVME_CONNECT_DISABLE_SQFLOW));
> 
> what is your code base ? does SQFLOW must for TCP ?

Not really, just happens to sit on top..

>> +    if (ctrl->ops->install_queue) {
>> +        int ret = ctrl->ops->install_queue(req->sq);
>> +        if (ret) {
>> +            pr_err("failed to install queue %d cntlid %d ret %d\n",
>> +                qid, ret, ctrl->cntlid);
>> +            return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
> 
> I'm not sure regarding the INVALID_PARAM rc.
> 
> maybe use NVME_SC_INTERNAL ?

You're right, perhaps we should propagate ->install_queue() status.
