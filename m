Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597DFC432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 17:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9512231A
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 17:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BEXmi+6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKSR4v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Nov 2019 12:56:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45862 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKSR4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Nov 2019 12:56:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id z10so24938595wrs.12
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2019 09:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wHMq7ZSXETEh3bWFK8tDMFeKTKRJwY8yw2CvHPvlDuU=;
        b=BEXmi+6OtL05WTMHqA9kU52x1sEwxJ1k4xaPQVEv5N21RR5rqdd3q7+4KHvHVWSAHJ
         5l1uOSQy+G5Lv94shjqGNgKlEMnqLIwWCLaKtoIQSoCJV+Vqwe4mzyXeK+4Kpk6ur2Aj
         ubNMsGCnQK9bH7pRKIVJ8Ly2bYQMtcjrqhxfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wHMq7ZSXETEh3bWFK8tDMFeKTKRJwY8yw2CvHPvlDuU=;
        b=KTM5DWc037kTxLEk2q3GtV41Yl4mgMCkf22j3s9IrLPWi+cajXjB/sn+tgpLd0bV4m
         xZ9JzAubLHssHcz2bk2Tdkp+5Ki9hWmhY9HczjHRHTZQahdzwd/FXgS7mtQEWu58T1cV
         1cTi2DFege4v279h5qQV3a4OYEWyWVu0Cc8tXzp4mW/rMOGfwHPFnloAyVNfpiX37huO
         xOQsUxyMe2y6vBLJ8FrvKuP3hjuMi/zwcRyRzaDlpx9DFacuBuvu6/C6UH/ZkajOq0sX
         2t1Rpc5Rgysc0OFKgEJnAaMAL6RIwCImuaSy20SdRiYaLBenHKEe0Aqdhq5EGij3z0zp
         BRwQ==
X-Gm-Message-State: APjAAAXSTEU2BdvipbWRQOQeh+WGGLXowMpustRZ/t7Ts7XLoqsryT0U
        sFc5/Cyb/TPr6wXhYmyvX9uFVw==
X-Google-Smtp-Source: APXvYqwTgYMrTrVFs2MZa2BfEo+k8IC9QTdLnvbdU6z2fDdUmIjIjRKD/bJa6S2+rzutNjGpTu5W3w==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr23456298wrw.126.1574186209419;
        Tue, 19 Nov 2019 09:56:49 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q5sm3770821wmc.27.2019.11.19.09.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 09:56:48 -0800 (PST)
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <fda43a50-a484-dde7-84a1-94ccf9346bdd@broadcom.com>
Date:   Tue, 19 Nov 2019 09:56:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <016afdbc-9c63-4193-e64b-aad91ba5fcc1@grimberg.me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/18/2019 4:05 PM, Sagi Grimberg wrote:
>
> This is a much simpler fix that does not create this churn local to
> every driver. Also, I don't like the assumptions about tag reservations
> that the drivers is taking locally (that the connect will have tag 0
> for example). All this makes this look like a hack.

Agree with Sagi on this last statement. When I reviewed the patch, it 
was very non-intuitive. Why dependency on tag 0, why a queue number 
squirrelled away on this one request only. Why change the initialization 
(queue pointer) on this one specific request from its hctx and so on. 
For someone without the history, ugly.

>
> I'm starting to think we maybe need to get the connect out of the block
> layer execution if its such a big problem... Its a real shame if that is
> the case...

Yep. This is starting to be another case of perhaps I should be changing 
nvme-fc's blk-mq hctx to nvme queue relationship in a different manner.  
I'm having a very hard time with all the queue resources today's policy 
is wasting on targets.

-- james


