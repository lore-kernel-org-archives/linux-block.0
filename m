Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCBEC282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F8421773
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jUpSI+ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfBLQNc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:13:32 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51034 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfBLQNc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 11:13:32 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so8534202iti.0
        for <linux-block@vger.kernel.org>; Tue, 12 Feb 2019 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AFaQZtnNrrgsB4YEdsdJIa0sQY3vuum87jj0X9EtiO4=;
        b=jUpSI+kopFAEt77hYBDsGVogbFXUQwO4WBcXashtxV+NRko5q0q/rm3L8KTzCmlbow
         06khbHhmJC/CnLGghjPB39Xm5tYC32lhwkzRxG4pHC8kb872P7bkBf8GtnF8q0prgLit
         0nwFUfWiUO419VJ/LZxllmQk7qGYd1PAoYyxrWs0ejoQmj5UhPFrkHhicKlAkI/waFa9
         AMfde9sDB5rgS+mf5A8/T16pMk2cgGie6LbVfnIYOkPq5QdpnrEWgHK1CZGWe5HnDg6v
         Oj/XuboBrv0KKtajQGBruD4DR+MCBTCJCPgT6ZXSlKRFqoU/TN8dgJoMs6G87WOv3zTv
         K38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AFaQZtnNrrgsB4YEdsdJIa0sQY3vuum87jj0X9EtiO4=;
        b=hQpCLay67v/mjtEz3a53vJ+ZL82A4w4l0lti3D79VKiTPL8Ub7mNYNX+rIepGTTKXh
         GEeu1cjNaXVPwKzcLf2eJU1fPQMlY5zSIn8XNlKjSYWscAnuG6MlAVCrLzQSYQPZ47hZ
         mMzZmKuRBBz8OZTufdLTm6YZstIVSFYZPiSPCjGhY2WBBJwMVaXETdFe0pccm406B/3j
         oYtaQOk4vkNq2t2mkYcflvv04b06Sq8Ij9y4fHNi8FbP0Oo2keMSn4MwZvJJQUS7hqbk
         BGqp/N+ALe2aSqydzBkzkBx5SgPFtPxVQGV3sGdh/oZVFhhyw+tC2DEmk/B7jDZQ9Jjt
         rQ3w==
X-Gm-Message-State: AHQUAuZu8RVhCqjudz42o53sAwc5Ctq3gDNW+Yvz/a3YwvPwMv8+ZKum
        QxyADNzhoAi64cNiJtgxVkOR5Q==
X-Google-Smtp-Source: AHgI3IbUghMmxoDM+8BrXh1hR2LSRKZGBKTjUCtyT2HakGkNeL4Vs/nOE5PiRUrkiq7dnBqf/1lZbw==
X-Received: by 2002:a24:7f81:: with SMTP id r123mr1181796itc.89.1549988011239;
        Tue, 12 Feb 2019 08:13:31 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm1655954itj.16.2019.02.12.08.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:13:30 -0800 (PST)
Subject: Re: [PATCH v2] floppy: check_events callback should not return a
 negative number
To:     Yufen Yu <yuyufen@huawei.com>, dan.carpenter@oracle.com
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190129083404.47318-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8bf64920-f0fe-b9da-8759-0d05a0fa39e0@kernel.dk>
Date:   Tue, 12 Feb 2019 09:13:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129083404.47318-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 1:34 AM, Yufen Yu wrote:
> floppy_check_events() is supposed to return bit flags to say which
> events occured. We should return zero to say that no event flags are
> set.  Only BIT(0) and BIT(1) are used in the caller. And .check_events
> interface also expect to return an unsigned int value.
> 
> However, after commit a0c80efe5956, it may return -EINTR (-4u).
> Here, both BIT(0) and BIT(1) are cleared. So this patch shouldn't
> affect runtime, but it obviously is still worth fixing.

Applied, thanks.

-- 
Jens Axboe

