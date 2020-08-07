Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB01FC433E1
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B957B2086A
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgHGRuG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:50:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39770 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgHGRuE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 13:50:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id z20so1404754plo.6
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 10:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kPqLvSjBtNhosmOzfD57lqo68y3MNqQVLpj1nOFbUS8=;
        b=AGOIKG3EMDYZZF4xaCR142G32CRevvfKQCJTsDzBSG/uRPnnZzzJ/nQLzkUX5Z25OQ
         c9Pvdj9Q6rx4KN+5s7tbIE+oXLqTs2R3WXR9QfIs1tzDidXVB7utHoiN2XPMQEokfp8h
         tXMA/5eJDYDv5sDIwThKdVrMLb253zgFHufmONLO+n+bf+Nxnv1adyxYeH2pn27VZXUR
         4oGd2FEHZFao1DCdiRPtiGo/Yu3v659K4FiQVVVfg+43cuOW59JnDuxXCQ9tG1mbQj+o
         hrEQrwii5/hjitm8TxY1E4rvktwFwk42Y2mZ0pnh1zVIoIqVu1/HL9zfYJWZVrpJgFDV
         gyuw==
X-Gm-Message-State: AOAM531h3wfuQq6Rucozxrnto7tWbTEIc5Gtfe4rNS4165BGff6yL4rq
        u463NNT7/kqa2tlKcs7JsIDWO+jSXqQ=
X-Google-Smtp-Source: ABdhPJwBbORYb2EeSyn0noJyl5KOZ6p5KfLV51EINNVNgwEFOlBMDV6kycSszn2fWuFV38dpMMCvNQ==
X-Received: by 2002:a17:90a:1fca:: with SMTP id z10mr14355771pjz.209.1596822604289;
        Fri, 07 Aug 2020 10:50:04 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c? ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
        by smtp.gmail.com with ESMTPSA id w15sm9382517pjk.13.2020.08.07.10.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 10:50:03 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] common/multipath-over-rdma: don't retry module
 unload
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-7-sagi@grimberg.me>
 <925e1ac6-38fa-6fe9-c0b7-7e665559a989@acm.org>
 <155cb916-062f-e23f-9790-35dee850687b@grimberg.me>
 <b3ab660e-fd36-36da-fdff-f7582baf47fc@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <083db343-9809-559a-9fa3-cb54a1c23b82@grimberg.me>
Date:   Fri, 7 Aug 2020 10:50:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b3ab660e-fd36-36da-fdff-f7582baf47fc@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> There is no need to retry module unload for rdma_rxe
>>>> and siw. This also creates a dependency on
>>>> tests/nvmeof/rc which prevents it from using in
>>>> other test subsystems.
>>>
>>> If it wouldn't be necessary to retry module unload I wouldn't have
>>> introduced a loop.
>>
>> I thought it was to work-around a driver issue as these drivers
>> traditionally had plenty of stability issues.
>>
>> To be honest this retry loop to me indicated that either the
>> driver has a bug or the test. But maybe there is a need I
>> am not seeing.
> 
> That loop was introduced a long time ago. I haven't tried to root-cause
> it but my guess is that the loop is necessary because the module refcount
> only drops to zero a short time after the first attempt to unload these
> kernel modules.

Didn't see any of that in the nvme testing...
