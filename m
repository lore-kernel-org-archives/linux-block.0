Return-Path: <SRS0=wgWW=CI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DFEC433E2
	for <linux-block@archiver.kernel.org>; Sun, 30 Aug 2020 10:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB97920738
	for <linux-block@archiver.kernel.org>; Sun, 30 Aug 2020 10:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgH3KXm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Aug 2020 06:23:42 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:40208 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgH3KXl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Aug 2020 06:23:41 -0400
Received: by mail-pl1-f173.google.com with SMTP id z15so1669174plo.7
        for <linux-block@vger.kernel.org>; Sun, 30 Aug 2020 03:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IXZCGHGRFnaeWsgRrshQlWtmfEgzeVg0SXdtn9KGpxU=;
        b=dUm1G1n/DLPDAgODdxoEz7lwGbcM6FTcnM8QnNolP1sqqpGdink8xrP5iDtt8P69i6
         zy4VZuXrJErLv1EDBbJljc97tjqlItqnL0NuYdSC/6bb7M5GF3WQAp/uMF5a9T5ZhuMy
         j41n64o4uqjizANtmoaezW0xl7hGBnNdBRX5+bByu41B6YTqpMcZM3J0Hln733OQCpQG
         EiaAdOK/wsvA7cNZgG29uXiAKA3gxSMevXRvhjHyISDiC5rRdnc8mSvCiDe9vxbzT/Eb
         7gyBHh9RjMAD8OLfuXVYRIwMsOjaTcwlyRZlPfmAv+U6TyN+Q0lGlCNf56SIGU9T6Vmn
         GQtw==
X-Gm-Message-State: AOAM531v2QR+LHiv1tJk2ZIUXjPIVLUhj23oy53QDjl53/yHJCM14Kt4
        mUx8vDZx4k5he340UIWF7eFILK+5Q8wvTQ==
X-Google-Smtp-Source: ABdhPJyrDyA5GQu7ffy0iWOE/cPTtyshaBWaSc9LLlgXI+9vvMtl6QmMTEwtapJgyiyCmyspIg7f4g==
X-Received: by 2002:a17:90a:aa8e:: with SMTP id l14mr6535431pjq.67.1598783020980;
        Sun, 30 Aug 2020 03:23:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cc5c:f2a5:487:1dba? ([2601:647:4802:9070:cc5c:f2a5:487:1dba])
        by smtp.gmail.com with ESMTPSA id e65sm4069788pjk.45.2020.08.30.03.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 03:23:40 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.9 next rc
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200829153243.324252-1-sagi@grimberg.me>
 <18fdb68f-8747-6f44-de0d-390a3fbd41c3@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c904c8f6-15bd-41a6-aa3b-a17a73f052c5@grimberg.me>
Date:   Sun, 30 Aug 2020 03:23:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <18fdb68f-8747-6f44-de0d-390a3fbd41c3@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Hey Jens,
>>
>> Some more nvme fixes:
>> - instance leak and io boundary fixes from Keith
>> - fc locking fix from Christophe
>> - various tcp/rdma reset during traffic fixes from Me
>> - pci use-after-free fix from Tong
>> - tcp target null deref fix from Ziye
>>
>> Please pull.
>>
>> The following changes since commit a433d7217feab712ff69ef5cc2a86f95ed1aca40:
>>
>>    Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.9 (2020-08-28 07:52:02 -0600)
>>
>> are available in the Git repository at:
>>
>>    ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.9-rc
> 
> This doesn't look right... I pulled from the usual spot, diffstat and
> changes match up.

Rrr, sorry forgot to fixup this line.

> BTW, in the future, can you switch to signed tags? They are nice to use
> in general, but particularly for git repos that are outside the kernel.org
> infrastructure.

We'll look into that.

Thanks Jens!
