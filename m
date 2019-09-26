Return-Path: <SRS0=S7xR=XV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69318C432C2
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 06:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A235206B7
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 06:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pimXOWEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403865AbfIZGqV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Sep 2019 02:46:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37950 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfIZGqO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 02:46:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so1217364wmi.3
        for <linux-block@vger.kernel.org>; Wed, 25 Sep 2019 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UfmRPwIXEAPW984j6NghYiGBpw2V6XoVUMDoIf6xrDM=;
        b=pimXOWEmq5O1CQHrDiHUzYHV6CgYJA8fuuEVOyIU5coou+gsu+YBnrPLc0UPHWQr7e
         CesaZ5ej/gEth0mhDrQCXvoZBJ1qPbcoxKDaF5ZY9HHuK++eufaIwqOD+8xrbo40+gLy
         ZMKccVpwSiuzFSNtsWsE/yyp2fPIaTtvEfCr6toSmRCIvzGB8YKYao9h+TY3ecRhK00h
         4gGFPB9cx0lAEXREPvLzqjJeE7Rq3WDDhviqizYD8S9uVx/RSJCEVm8B8hEEccEtWZoJ
         cu8tLupMgCbat0sDqB8K2AM1Jtg2vPhnPhuBMUfZMBkaDf1aMSMxIC5l1MKlI6ArRWWU
         mBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UfmRPwIXEAPW984j6NghYiGBpw2V6XoVUMDoIf6xrDM=;
        b=r+BPdBAsIsQL78P1x64kd7he18Ht033h9RT2ZQmgX+R3WSxntmYZVbGKg829f07JKh
         h6081IxMjo0KoRWwzYpwhX4QYkLJW47u+uIPjLjT7xm/09ZPp75a2iU4PC0PWxyx0qKb
         G+/3fmM60C2WFS/U1q/Fki5yGEHSDB1lbo64nvuxnIJeRWJ1q1Jan3xKDhCnLIiUiyfk
         ZbAb+hKhnsN1utQerskaPK2nrgqJcrWVzJu2r7yN/VDoCkkohrHK3OS32qylXkdGtD4K
         3RNU3APbTaGjae0VpXEdzEmieuuEVHp1Vlav559nHQw7qng42WDKDOxJcb4rtoWUUjxM
         /WJw==
X-Gm-Message-State: APjAAAW4IzAk3HeC3Q0YBHiOXQmxN8ZFp4c9ky5FJK20mT8bZDY5uX6Q
        51VB+6ZTdk83i0gGxnO5kCcojQ==
X-Google-Smtp-Source: APXvYqxXip4vqQcPhIB6hCFG1VQmvv8j8l4gGusiO0Sj/8SKAcsK3PqM4PNvSWWu3oyWlhBZXwcTAQ==
X-Received: by 2002:a7b:ce08:: with SMTP id m8mr1504605wmc.106.1569480371999;
        Wed, 25 Sep 2019 23:46:11 -0700 (PDT)
Received: from [172.20.9.27] ([83.167.33.93])
        by smtp.gmail.com with ESMTPSA id c18sm1895882wrv.10.2019.09.25.23.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 23:46:11 -0700 (PDT)
Subject: Re: [PATCH] block: don't release queue's sysfs lock during switching
 elevator
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190923151209.7466-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <34390039-1f05-e66f-e99c-7cacf50d40a0@kernel.dk>
Date:   Thu, 26 Sep 2019 08:46:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923151209.7466-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/19 5:12 PM, Ming Lei wrote:
> cecf5d87ff20 ("block: split .sysfs_lock into two locks") starts to
> release & acquire sysfs_lock before registering/un-registering elevator
> queue during switching elevator for avoiding potential deadlock from
> showing & storing 'queue/iosched' attributes and removing elevator's
> kobject.
> 
> Turns out there isn't such deadlock because 'q->sysfs_lock' isn't
> required in .show & .store of queue/iosched's attributes, and just
> elevator's sysfs lock is acquired in elv_iosched_store() and
> elv_iosched_show(). So it is safe to hold queue's sysfs lock when
> registering/un-registering elevator queue.
> 
> The biggest issue is that commit cecf5d87ff20 assumes that concurrent
> write on 'queue/scheduler' can't happen. However, this assumption isn't
> true, because kernfs_fop_write() only guarantees that concurrent write
> aren't called on the same open file, but the write could be from
> different open on the file. So we can't release & re-acquire queue's
> sysfs lock during switching elevator, otherwise use-after-free on
> elevator could be triggered.
> 
> Fixes the issue by not releasing queue's sysfs lock during switching
> elevator.

Applied, thanks Ming.

-- 
Jens Axboe

