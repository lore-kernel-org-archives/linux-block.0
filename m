Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE300C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 18:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74E120850
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 18:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfCTSie (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:38:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43817 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCTSie (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 14:38:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id l11so2401809pgq.10;
        Wed, 20 Mar 2019 11:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qTsbPLLgt3/ihQ/bqjstgfgG4v0W4yVW3lAcoVi1qmw=;
        b=N4QLekSFdErtji+pB+Z7v54gV7jTDgxnMDaoSFjT3o+S4sY4bowM/qmiSFXuz693Dq
         N/6yeZA6RojsTQ5FXM1kVDaDwUMYB5Xsf7mHVoU7xXNCx2NaubZ8RMrxekiAZVyvv6tk
         dt9hSG2B8G5sUxwSX//i3iFVF0u2JoTZ//kRMnr2WB9p2sC3P6QfOuCJBLnDDfq77Bkg
         HHdtkidBR6cykC0QTlxRSaKlnHtLBY4zIuZ3GKoLJzwQeCP6Qp2PawcjeuoUStygW9TR
         o2E9gaoB3wKPfRzcxDsSCLiqLCywG+6fI+ut6wVaULElxSEZHvrxWIdXVb4ZBoNgvTfd
         bYKQ==
X-Gm-Message-State: APjAAAXGwzPJQNjLWY8G01HDV4bTJO4a0XudT0A6Pr9f7KfK3/hib8aW
        D9mRarelb1OfqUH6diKgbag=
X-Google-Smtp-Source: APXvYqxjipooht+viFnMDIXb/Kke+WegR9mhUqgDUSG3bYauUxvb7PrnBsMiZkohg4fCKENkKG61Zw==
X-Received: by 2002:a65:6383:: with SMTP id h3mr8727105pgv.11.1553107113094;
        Wed, 20 Mar 2019 11:38:33 -0700 (PDT)
Received: from [172.20.40.56] (50-207-206-41-static.hfc.comcastbusiness.net. [50.207.206.41])
        by smtp.gmail.com with ESMTPSA id l5sm4532445pfi.97.2019.03.20.11.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 11:38:32 -0700 (PDT)
Subject: Re: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
To:     Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     axboe@kernel.dk, keith.busch@intel.com, jsmart2021@gmail.com,
        josef@toxicpanda.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hare@suse.de, "jianchao.wang" <jianchao.w.wang@oracle.com>,
        jthumshirn@suse.de, hch@lst.de
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552930085.152266.36.camel@acm.org>
 <3cd58454-eda3-de9a-0eed-b6a7edbce28f@oracle.com>
 <1553008222.152266.43.camel@acm.org>
 <20190319152533.GD24176@localhost.localdomain>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5879cad9-9d47-4690-0f85-00835346029b@grimberg.me>
Date:   Wed, 20 Mar 2019 11:38:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319152533.GD24176@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Hi Jianchao,
>>
>> I think that's an additional reason to rewrite NVMe error handling ...
> 
> Nonesense. Block timeout handling runs in a work queue precicesly so
> handlers can actually do useful work in line with the notification.

I have to agree with Keith on this one, there is absolutely no reason to
force this constraint on the error handler. If we want to teardown stuff
to guarantee that we can free the request safely we may very well need
to block on queue flushing.
