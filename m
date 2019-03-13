Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0945C10F0C
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 19:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73E142075C
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 19:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfCMTOx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:14:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42825 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfCMTOw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 15:14:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id m4so2382982oim.9
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2019 12:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OR7Ivfy/65Sptgxtm1bbhFiv3XtRPKvRGnxJf7ouwaw=;
        b=iSetVqbGEwEWxvB66Bnu8HwUYjKI6VIQPwsJPVGflDDo1oCGm59JvYUIUA5NAcQvnc
         J8N+ArAdzasvHRsUPxoAXriyaXSmFJBMN5nMnfS0twVDOkJ/fVFJPq9DPPIouR94tGib
         QyJucfiBsUezn2xyqnywdBJLKMS6HgAiX3+QzWkMz3ArN+PaJwFyQIbamwtajbCrLWIQ
         ztE5gL6+1XJqboXlej4dhejjG8HQV6RsM6kMRzOnQ66GNN3MZ+uvpmUNatdkfBjsmx9a
         am2Y/Q3CaiySIs9BlcJmTMFaayfL53Hu6EdmuQyabL/UnsHHiU6lJiWVSq7OMZcs0Nba
         cI0w==
X-Gm-Message-State: APjAAAXf1ICusevt+w+CIX40+kcmFKSkK0pvFXeD5HGBTlyyEwTZ2Nm2
        xvB9PyM/04SRAUzdYqD1FGI=
X-Google-Smtp-Source: APXvYqysqzWB2hrBB+gM8G0VZMJ7FNAbaZZQ//g5QGTF+RMvgQzptjoz2oKrc+EFKjgfT85NWXe5EA==
X-Received: by 2002:aca:5dc1:: with SMTP id r184mr122256oib.127.1552504492245;
        Wed, 13 Mar 2019 12:14:52 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id u5sm4880047otb.62.2019.03.13.12.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:14:51 -0700 (PDT)
Subject: Re: [PATCH 17/17] nvme-tcp: support C2HData with SUCCESS flag
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Steve Blightman <steve.blightman@oracle.com>,
        Oliver Smith-Denny <osmithde@cisco.com>
References: <20190313175510.20725-1-hch@lst.de>
 <20190313175510.20725-18-hch@lst.de>
 <b0ddd0f2-4a4b-bab6-5d7d-07322be8a0a6@grimberg.me>
Message-ID: <977db6cd-a2fc-4327-e3d8-c942fb275867@grimberg.me>
Date:   Wed, 13 Mar 2019 12:14:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <b0ddd0f2-4a4b-bab6-5d7d-07322be8a0a6@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Christoph, what about nvmet-tcp side?

Yea, I see it in 5.2..
