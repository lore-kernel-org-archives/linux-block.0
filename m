Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA47C433E6
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 14:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEBCE64F54
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 14:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbhBBOqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 09:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbhBBOnz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 09:43:55 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73433C0613ED
        for <linux-block@vger.kernel.org>; Tue,  2 Feb 2021 06:43:13 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i7so15017073pgc.8
        for <linux-block@vger.kernel.org>; Tue, 02 Feb 2021 06:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QSnIdi/e9yVAo9x8m93IfOCoHH7w6yNsBlBzekuSq58=;
        b=BebiQp/vuL3hgQKiqlex6GBVDzG6L6NbS5VxnIUq44qW9nNU7bd75USJRsEoP2MZVF
         +e4SwtpiUJ+1/ZjR6GuXJGCJ2Gp1L9glLeLVgvIpO6No99EZBSXeGzSd7YHExG6hgiZ2
         Tg1yKYqllpYonDwL4LQbXVjYp830zo9XdAEBmqhGlShZbREr4Xp306dbbkJbFuTtXaCK
         sHWV9AbCcG8D5Kkly1xatDZt2SQ/Yj9dYkr397AaQtzA6EXPHelEutxASbHEDvYc1NXl
         g5HN5lPYdIL+wyALJYFIYPSZEjVKo8pP3aVJ6Nba96rRSO5LoTsua9/BbUE6K+BVTpZf
         5JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QSnIdi/e9yVAo9x8m93IfOCoHH7w6yNsBlBzekuSq58=;
        b=lBhRjLrn6DRQtIbcRhJM7uTYMEWYRL4nrB4GFk1gAXGestPi2llNrHoUTbtmnk/537
         njRA2YrKItB9RAcsezDSh1C+dVmT+mPjJ4zG9Y2I0Y+WZPyxDhDJmfytINY4zysZr6m0
         WX5aLvvOJs92jIP91hVOdu1ERE3xDLz22JOnmgJEcmjG39JSFaaR8xqQ/5gTbsTbLLzX
         If/S2DnRd4UWqqtX/csfO2c/tZnEF8EuWPi7rlEjibgv0RYSXCt1SleNWch52diKXWI3
         X9Kiw4FeQPl3/mH/Wh41tIr3FWfbdEIyUteI3ZO5SOnxNy0xCTLYaPKeZk5hzqf/CS1d
         cTpQ==
X-Gm-Message-State: AOAM530uIu7yUvqmdWemjqKevD7Iit/pVluqqL2VBuDns8DY2m2kyF+d
        9SUS93EpcvYPFn0A6oDYf4bKGA==
X-Google-Smtp-Source: ABdhPJwEiaXPT6raIkfTP0UCXuzDM0iep9jIyK26hYq/xmU0UEWBKmptmK+CjhDzmYMqFA9K5ZJGNA==
X-Received: by 2002:a63:794a:: with SMTP id u71mr22029715pgc.91.1612276991840;
        Tue, 02 Feb 2021 06:43:11 -0800 (PST)
Received: from [0.0.0.0] ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id e191sm23220790pfh.149.2021.02.02.06.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 06:43:11 -0800 (PST)
Subject: Re: [PATCH V3 0/3] block: add two statistic tables
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
References: <20210202031009.11584-1-guoqing.jiang@cloud.ionos.com>
 <SN4PR0401MB359830835C1F9ECEDF7ECACA9BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <7f78132a-affc-eb03-735a-4da43e143b6e@cloud.ionos.com>
Date:   Tue, 2 Feb 2021 15:42:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB359830835C1F9ECEDF7ECACA9BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/2/21 11:48, Johannes Thumshirn wrote:
> Not a huge fan of the function names, but I don't have a better idea either.
> 
> For the whole series,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 

Thanks! I will add it if I need to send a new version.

Guoqing
