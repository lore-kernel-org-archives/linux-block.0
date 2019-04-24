Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A37C10F03
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 01:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070182148D
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 01:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsdnSyt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfDXBKk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:10:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42197 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfDXBKk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 21:10:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so18430609qtc.9;
        Tue, 23 Apr 2019 18:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tkHovkGoLeUJmBUAXRcEdP2u6Q/Uk6F1LzPacVk5rJ8=;
        b=gsdnSyt4gtUMCnRM+azrKEaFIk36F6Mmvah/m9Ubdw7XaljkcKtMQFPWJh2uj7HUwF
         9ALRfjtxdkmZKf0rUYWCz/D6MA237XSRKdr2SK7Fkw1/iP5/AQbdGiOHBrguVDI4BrsO
         rUvvUA9CPK/xSD8bEn3TXMI7+RCq+MbL2yLh5Ewkuhgk4QvbP06RcVrvgZczegUqG1En
         /przdaZi/2UhDpY5Tav1+Ng2uMB8r0X6MN1uwVyrXw3eUDDGsGYdMx077Tpv26OC5cAA
         DdB+GqvbZBhY+NlogbC+/cBGGAHtgR5Nv/qIQueQZ9N6HONFwVLowAdcVHfG/pzmvCkM
         gLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tkHovkGoLeUJmBUAXRcEdP2u6Q/Uk6F1LzPacVk5rJ8=;
        b=WSj6R3xhJNbLqMsq1d8c/ha581V3Fe7qdZnHuW0NTDXOP5PXkdFjkU0AKyAe9jBrPF
         /GV9edlnwb7sVGVXY2dUPcSTO75MWOmKAv3oRWfze14nIguokf/UtdqlQgu7RKO5V3UT
         N0R45XNxSiN5y/kiy5U7v8JzO9H7CKpF4B6PTGdbsQAy57bs4VlVTsKZKTOgey8XR6tU
         FILDyiQUJJ55SeVz3LBHEw5mLTb1VbN/kR/TjuhfC6NfXGM0cStMQR5tS2Xo5asR0sGo
         TEAQDrDPl7Destz2LH25raojXs2jGduq0+Q2JJGXpW/oyYd+5+mLWM6VIBYaPK9+NNjz
         CXBQ==
X-Gm-Message-State: APjAAAUnSQihUU40g0SAyWfpRZ5qUk3Ktj7LQTcGNMh0ZuAT9Z6ULw6l
        XSnd2iyBncHQBH8hOdFCJi8nStQgdD4=
X-Google-Smtp-Source: APXvYqzn9IFQO1GLAIwF4rLgEpLc4SQzDHcjNwDRT6Jzs8JSL/iV2acm2dlR+MGywIAeBpUGEaPYPA==
X-Received: by 2002:aed:2314:: with SMTP id h20mr24005362qtc.24.1556068238795;
        Tue, 23 Apr 2019 18:10:38 -0700 (PDT)
Received: from geeko ([179.183.202.242])
        by smtp.gmail.com with ESMTPSA id h27sm11319955qtc.1.2019.04.23.18.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 18:10:37 -0700 (PDT)
Date:   Tue, 23 Apr 2019 22:10:28 -0300
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH v3 0/3] Add documentation of some blk-mq functions
Message-ID: <20190424011025.GA32345@geeko>
References: <20190417021030.82998-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417021030.82998-1-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

gentle ping.

On Tue, Apr 16, 2019 at 11:10:27PM -0300, Marcos Paulo de Souza wrote:
> blk_mq_init_sq_queue and blk_mq_init_queue are being documented, more will be
> added in further patches.
> 
> I would like to thank Chaitanya and Bart for their reviews.
> 
> Changes from v2:
> * Changed the description of argument @set of blk_mq_init_sq_queue, making it
>   less obvious and more informative. Now this argument has two example of
>   possible flags for tag_set (suggested by Bart)
> * Cover letter added (suggested by Bart)
> 
> Changes from v1:
> * Change "SQ" to "only one hw_queue (SQ)" in the function signature
>   documentation (suggested by Chaitanya)
> 
> Marcos Paulo de Souza (3):
>   blk-mq.c: Add documention of function blk_mq_init_queue
>   blk-mq.c: Rework documention of blk_mq_init_sq_queue function
>   Documentation: kernel-api.rst: Add block/blk-mq.c
> 
>  Documentation/core-api/kernel-api.rst |  6 ++++++
>  block/blk-mq.c                        | 27 ++++++++++++++++++++++++---
>  2 files changed, 30 insertions(+), 3 deletions(-)
> 
> -- 
> 2.16.4
> 

-- 
Thanks,
Marcos
