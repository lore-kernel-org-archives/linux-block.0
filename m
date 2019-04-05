Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB863C282CE
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 23:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7AE206B6
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 23:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Y7wQayJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfDEXEV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 19:04:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36519 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEXEV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 19:04:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so3796743plb.3
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 16:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mDqfo6SYRTeuwiQOk4mtiNpOpC2lEJsJOCaMWlTg2pA=;
        b=Y7wQayJZ4mUqdDgTOxDmpnCT/YLY28lGVQE2am11EedKr72HewfE2otEEtPxPZO5zG
         gFKNfT1VBkEf70ftfBm8PrW33PCaxSvbrf63Rz9p8BD2o62iPWAHiMiqVB9HfnmG95zR
         MxdEeTE1mZAz84MAMKXe1XTG6cQNTmiTUw1Y+MPOylL4CYRSGdlB8LNmQhGn6K9XtxIM
         MHpYM+8affWH9M9stue1Rlm9QIsLmN+9TKKMwYp60qAbgK4rkuZ7b/m/ijaUz+TQussh
         jMBiJhq9q+ORLkFKcrkbIovGz23opjieBeEiLlZGXmnDjgd+Gk/zS5qo+cvDBlb2kvl6
         0eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mDqfo6SYRTeuwiQOk4mtiNpOpC2lEJsJOCaMWlTg2pA=;
        b=QXd1Eq4rrTqaTFJdzi6HQ+srYGStiMJsn7d+1HUWY+Isu82oZSO+BMCvJNy+cRXny/
         vb47fOcgiATOGgqS1kq8yd/QSAHPtcddhqoEoQo8UbEFU7zBFyJikgi04kGy/Zy9x9lF
         zT53IHgPD8GJbVOfDwIcuVC1yMGUUtYxRVu8DY0UpDadsfrXYrGsbccxzE93hDNj48/M
         PZKEWfZEpxicZe5ZoalWF+Nm84x+oJA1sAic+L0GCk+SCzTwTkIs//ypoDbisyZlZEwH
         WTDF3cZge8VZ8eKiGxqkopHTIIZinL7Vqu6RyzHrbsNTRlmmbapOimuV0zabT1jWH8+6
         lLoQ==
X-Gm-Message-State: APjAAAUB5kixScRjd3/Vp7bLsp14+8vJx/6PE4gGDgmBeDiFCw9WFcPY
        e5+BrWai5ilsP7KP8/G8Z6s9g0qGQ7K2Iw==
X-Google-Smtp-Source: APXvYqziEqcmB/DKph59eb+dlbVnnQxxdWh/eYJKOdKVNDLCUWTaKiTOG61ggV+NAHG8C4rFCG+sFw==
X-Received: by 2002:a17:902:361:: with SMTP id 88mr15747615pld.78.1554505460588;
        Fri, 05 Apr 2019 16:04:20 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 6sm778899pfp.143.2019.04.05.16.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 16:04:19 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
Date:   Fri, 5 Apr 2019 17:04:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405223719.GC25081@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/19 4:37 PM, Keith Busch wrote:
> On Fri, Apr 05, 2019 at 04:23:27PM -0600, Jens Axboe wrote:
>> On 4/5/19 3:59 PM, Keith Busch wrote:
>>> Managed interrupts can not migrate affinity when their CPUs are offline.
>>> If the CPU is allowed to shutdown before they're returned, commands
>>> dispatched to managed queues won't be able to complete through their
>>> irq handlers.
>>>
>>> Introduce per-hctx reference counting so we can block the CPU dead
>>> notification for all allocated requests to complete if an hctx's last
>>> CPU is being taken offline.
>>
>> What does this do to performance? We're doing a map per request...
> 
> It should be the same cost as the blk_queue_enter/blk_queue_exit that's
> also done per request, which is pretty cheap way to count users. I
> don't think I'm measuring a difference, but my test sample size so far
> is just one over-powered machine.

Looking at current peak testing, I've got around 1.2% in queue enter
and exit. It's definitely not free, hence my question. Probably safe
to assume that we'll double that cycle counter, per IO.

-- 
Jens Axboe

