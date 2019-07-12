Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC0CC742C8
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 15:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CA521019
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 15:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BMS+LBZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfGLPPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:15:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34736 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfGLPPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jul 2019 11:15:32 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so21139258iot.1
        for <linux-block@vger.kernel.org>; Fri, 12 Jul 2019 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2opEnBuVBF2b4E5QanZT3B1PxQTl1jpFqVeaeD4Jvac=;
        b=BMS+LBZ1HOJ+oPmT+jj9cCB2CMuhLD9hOgL1EGxhXgjcCFU+uRhdlTEHJctcvcAfAC
         93xCyhVww0XoYzbRJRJbpZBsYO3Bm1q/MlPGVvrNSmWS6qfkXQz8BXXUjRJsSG2wkg1B
         oUhykgoEyU+U5WMY8pngtLd8pQv2pIfwtfSV3MVO+kJRkbbD+jxi3cwlmNKFU6maqscI
         iIz0r5umTAoC5x9daY2n1PVhdWCYjSYP5JjtzczVfPEaIuMScEe303uYSFPRxEjPxbTY
         wo2uvzLdn+ynMMpp8KKHkC8MInm7bHAk0Gz2dmFjF6xGUKzzWIe57apPN0x9lMRWIqqQ
         wFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2opEnBuVBF2b4E5QanZT3B1PxQTl1jpFqVeaeD4Jvac=;
        b=Svpal6WNkwvvOJEAqgTnhoNj5quBOk/4/Y4UmfzNI1ayvsVWiYTnwi7t5mBZIR8KcR
         1gbH1Vh2QcJFv5eAsjba0qIi44DzZHi47bwfnnTO8f/IJ4CE8J76JK7B1EiVCiTBc5eO
         UDfouOhpL+LwggmpZjjwBoWYsEzkD2cxjwgR/Z02I9LtwiECMqBBiKrI23uBugRWn3gR
         KE7rzqFFwI1QwIO6jAy/yMdBYibN7edGUqIAPpWgvFLNcaVURTBghujAqLOU24cKxXSK
         CiF4VdXbIRRmm+OkyG/zagUZd5UfHGolOkqBrysUSk6eq3/sZYgoMUeCNRYJnI+qM9V6
         pIJg==
X-Gm-Message-State: APjAAAVQZafuOF+nlpgUg0Zx8RVo0vVNT5lUWUgfv+GI0qiqyPiEC3VX
        QTiq4ZEcGPk4Jm2eLJKxwVs=
X-Google-Smtp-Source: APXvYqxNzK45erpGagcbIG8GrfCOqm46U/1e0qdgZFVftYMWqnRGnTZfkMPl7UYDH4Wj4yMq6IdAPw==
X-Received: by 2002:a02:b812:: with SMTP id o18mr1716469jam.64.1562944530468;
        Fri, 12 Jul 2019 08:15:30 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e22sm6692139iob.66.2019.07.12.08.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:15:29 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: add entry for block io cgroup
To:     Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <156284038698.3851.6531328622774377848.stgit@buzz>
 <20190712142502.GA680549@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82bc7337-c48f-7559-bd9b-6a21ccbfceb0@kernel.dk>
Date:   Fri, 12 Jul 2019 09:15:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712142502.GA680549@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/12/19 8:25 AM, Tejun Heo wrote:
> Hello, Konstantin.
> 
> On Thu, Jul 11, 2019 at 01:19:47PM +0300, Konstantin Khlebnikov wrote:
>> +CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)
>> +L:	cgroups@vger.kernel.org
>> +F:	Documentation/cgroup-v1/blkio-controller.rst
>> +F:	block/blk-cgroup.c
>> +F:	include/linux/blk-cgroup.h
>> +F:	block/blk-throttle.c
>> +F:	block/blk-iolatency.c
>> +F:	block/bfq-cgroup.c
> 
> Given that blkcg changes are often entangled with generic block
> changes and best routed through block tree, I think it'd be useful to
> add the followings.
> 
> M:      Tejun Heo <tj@kernel.org>
> M:      Jens Axboe <axboe@kernel.dk>
> L:      linux-block@vger.kernel.org
> T:      git git://git.kernel.dk/linux-block

I applied the patch with these additions.

-- 
Jens Axboe

