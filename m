Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99039C3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 19:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76582206BB
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 19:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfICTPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:15:51 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37010 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfICTPv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 15:15:51 -0400
Received: by mail-oi1-f193.google.com with SMTP id b25so13719514oib.4
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2019 12:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mAOsk3v+mGWoFMnNBMYGwd8dnmyJmNgXPI3w1pcXB+c=;
        b=LomRawf0V/L8SsrNV2oXDdSE0T7VxcU5Md4wLsxhc+eSDK5eP8/TZwnCCUvtisbfDG
         5AamNYEvketnm9H2QNpE0m+Yj2OlZUc+9tXJabIejj65wI0AdHZvlvarPIHwvV/YMQ3y
         GkYUFyZbuK/tdKFwVg87yCWCKfYkq4aEvCO4JXOjxYEyq8Ls/MbHnFEf6dTDZwC3MkMR
         nXWWSM3qzmaDO7UjIDc02NpmLZUeRPHyyVslzYS04h7WClBoPHFwLvry1ReYcKanIsCe
         +Clt/G0HscUCna6cq9tbfmj6ACFH6+eJLLQPfm78q/AwqI0MlG1pV9WbOW/5eMnaGQzq
         8xAw==
X-Gm-Message-State: APjAAAWbgGus6xY7BVlRlbE29/ttGGYzelN6Hbm8CJH4eDAmPKg1Jb6d
        bVfmVXUFbfxOfy4t5xTMcKY=
X-Google-Smtp-Source: APXvYqwE2C7oaOtRtmT8t2Z8lATUvZSej/eQ/Z51Mp1OstlAFQOhFD07S4XgepHERL72YIfHU80nPg==
X-Received: by 2002:a05:6808:7c8:: with SMTP id f8mr615332oij.118.1567538150702;
        Tue, 03 Sep 2019 12:15:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 36sm94811ott.66.2019.09.03.12.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 12:15:49 -0700 (PDT)
Subject: Re: [PATCH 3/4] nvme-tcp: introduce nvme_tcp_complete_rq callback
To:     Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de
Cc:     shlomin@mellanox.com, israelr@mellanox.com
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
 <1567523655-23989-3-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c5757c95-2a4f-410d-a275-85d8c9da737f@grimberg.me>
Date:   Tue, 3 Sep 2019 12:15:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567523655-23989-3-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> The nvme_cleanup_cmd function should be called to avoid resource leakage
> (it's the opposite to nvme_setup_cmd). Fix the error flow during command
> submission and also fix the missing call in command completion.

Is it always called with nvme_complete_rq? Why not just put it there?
