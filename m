Return-Path: <SRS0=4yxV=O7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7B1C43387
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 21:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC7221939
	for <linux-block@archiver.kernel.org>; Sat, 22 Dec 2018 21:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hTXqEry/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390143AbeLVVqX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Dec 2018 16:46:23 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35770 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389327AbeLVVqW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Dec 2018 16:46:22 -0500
Received: by mail-pl1-f171.google.com with SMTP id p8so4079858plo.2
        for <linux-block@vger.kernel.org>; Sat, 22 Dec 2018 13:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ytj7gMbpowbrGKDZt5NR1y1PXxhxqd5lg2zYd+Jzz6o=;
        b=hTXqEry/hoW0dOpajz0BKYeJQMxkw2zPL3NHxdhchEumaJMRvD8q+xZhhYwq0DFRNx
         RQRwy9S0J5KU/FbA8F5qLW3voOjUB7aUmHHg6SyF6PF4pDYrWI7753KuJ3Z38t3q0b0b
         jL/5ZxhteICp60K6fYhBvsZzcYIh8fufUhrNbfBtpoWdoOLWgVI9LFx/j5bDlWJZ4yEG
         jEjlTVjp36+2o3RF+EUh3ty5eREQjEY8stIucv15G5Ds+bZoCgoEK9PLkfXT+rxRmtpq
         +6lsnnx4p704lDB7CFzJHg7Txobbln3a1mDYfnb70IEeD/5nA+nNKCDBkGqXQI1Gt6H7
         zvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ytj7gMbpowbrGKDZt5NR1y1PXxhxqd5lg2zYd+Jzz6o=;
        b=eAzmVpQ0QZWyoSHugRToL4dfftjkSbCOR7/E5tql3Sm8XmKurfDfAln/sXN28gt3ZV
         LOdFwjhnsTvddXeli03CkAjNBaPksjB0XPdqeHSSVIKKWwTsP/esA/98BD7vWVsOeDp8
         IUqm3M7lNcIO9qc5BzXpKaAiA2NSj2mqPRAN48zyqadrYeGB0PWpGWJ08Ypp367dGnVK
         FMNlSqxjeDgvlcqnM5AdkAQ/pmo8lKfjwlrLQVEeIw7vzdNaIwISc5uRPzI6oqS6ZQEX
         Vs/xBXeX+OKlHVU3ZrpvPdGbYW6XgYB8nY79ooEuZ1f1XwCbnBW4Q5XySS+vd19hZbWB
         y1VA==
X-Gm-Message-State: AJcUukcHEVwIZrl+YlZpXJXCY07iGn3G743V/AqPW/4pSWzwsvq74Mov
        7J1aWXZQcGp5F7GiwrqxB2nhGoJPcS0N3w==
X-Google-Smtp-Source: ALg8bN5C7N5f7T5bv1zMvk1+z+2mcIKqpUsGG7FvbUEcXhG9rbpbB/VlXZyQHkmhMxLg6TDp1ZZGLw==
X-Received: by 2002:a17:902:f20d:: with SMTP id gn13mr7492668plb.11.1545515181688;
        Sat, 22 Dec 2018 13:46:21 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e131sm7603238pfg.75.2018.12.22.13.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Dec 2018 13:46:20 -0800 (PST)
Subject: Re: [PATCH] block: sunvdc: remvoe redundant code
To:     Chengguang Xu <cgxu519@gmx.com>
Cc:     linux-block@vger.kernel.org
References: <20181222124756.29623-1-cgxu519@gmx.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <437f0fb1-1098-ba3e-e3ec-146d5dfaebaf@kernel.dk>
Date:   Sat, 22 Dec 2018 14:46:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181222124756.29623-1-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/22/18 5:47 AM, Chengguang Xu wrote:
> Code cleanup for removing redundant break in switch case.

Applied, thanks.

-- 
Jens Axboe

