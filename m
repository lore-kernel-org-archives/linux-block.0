Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34124C433DF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E154207BC
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ln8xmXfw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGPO6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPO6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 10:58:47 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000EBC061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:58:46 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id s21so5300927ilk.5
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sbSSrPonKJfXJbjkODGw5kCeYi2eB9jEjMNe2MWe9po=;
        b=ln8xmXfwt0w2jAmcOb3H5wB7TSW0eNCcj/TOTdQTA/mv8BpAV/mSSA1vClJY4MUZIt
         L1MRoY1nkwneHe45S5yKdLgJkFGBa6xHbSho2ZkrAQSo8e5GnWvuA4v2mwVPxybrG3p8
         loApfClf2p6O3LVFfOPVwtAkY8xxQE35dmLc6VBouSkjIBIXsXYquhZWYyVDPyp7XWPe
         0fJ/Nyh7ofzp6xfMrDi8E+mC5/g1K0wTvNORNJcXks3p6iFKoPw46LSHmTRal8/C6Hpl
         uFHGLV/G2YYCxMEll68QvyC03Cqcj7nslY7Tmc5LVgnsXw0XiBnFyynpNUkcrMQHWPqn
         R9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sbSSrPonKJfXJbjkODGw5kCeYi2eB9jEjMNe2MWe9po=;
        b=mDNLdU3+EHYEJknka67XeKrnYnypYTYUpgVFLesnky0Nso/3LPu2Mq7ExcQTfBSGlV
         cZkkC5MDruaakRNobWJh7pL6bnUtroYjsL0Ffius57cQV/Rk/fG5nr1cWNEILMwKVIH4
         wNluF7nHLxrzbe+4TQobZfQn+mvp+6p5ezwwKRyVIaMeJan3bMGn02aJSDwimgMPPREI
         dEOPkkJX8kz4i+opIATOI2BcBS8+xqjj0RQ5MQCopd3/fJqj3paY7mwkQASX4QYPN/Ob
         yxnUJ+53xGZXI71n4IpYhD3sHLC1zB/7JeqTYPoP/rvoWhzPN8hPmNMPY7B0LsVxrLJ6
         H85g==
X-Gm-Message-State: AOAM531Vl3nOY6Ixx/aDXWnO1/XjpALLiLy6iOnhnLkoWDQPfCedUime
        0nsIm2wCVRF89DQbYK/3VUzl/+CX6Dao3g==
X-Google-Smtp-Source: ABdhPJzIvvEXWrGMQ9FKZ0wfeJsFuBTqCmuAM56PUkcJsNVfl8zR1IoiMpo9B2TxvKd/2uBK5JmfBg==
X-Received: by 2002:a92:d812:: with SMTP id y18mr5271885ilm.286.1594911526273;
        Thu, 16 Jul 2020 07:58:46 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s18sm2757180ilj.63.2020.07.16.07.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 07:58:45 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fix for 5.8
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20200716144205.GA475287@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1e305554-0f7d-06a6-cd3c-689249a2557c@kernel.dk>
Date:   Thu, 16 Jul 2020 08:58:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716144205.GA475287@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/16/20 8:42 AM, Christoph Hellwig wrote:
> The following changes since commit 579dd91ab3a5446b148e7f179b6596b270dace46:
> 
>   nbd: Fix memory leak in nbd_add_socket (2020-07-08 15:42:18 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8
> 
> for you to fetch changes up to 05b29021fba5e725dd385151ef00b6340229b500:
> 
>   nvme: explicitly update mpath disk capacity on revalidation (2020-07-16 16:40:27 +0200)
> 
> ----------------------------------------------------------------
> Anthony Iliopoulos (1):
>       nvme: explicitly update mpath disk capacity on revalidation
> 
>  drivers/nvme/host/core.c |  1 +
>  drivers/nvme/host/nvme.h | 13 +++++++++++++
>  2 files changed, 14 insertions(+)

Pulled, thanks.

-- 
Jens Axboe

