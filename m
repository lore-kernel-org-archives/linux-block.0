Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6207AC3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 18:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3991A2087E
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 18:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vyg75nXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfHTSoq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 14:44:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43001 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbfHTSoq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 14:44:46 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so14336000iob.9
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=POIUFIUo+mTSLygBJlv/hquyjDRWa/g6KaVlpKSjnEg=;
        b=vyg75nXCa8XnlCUAVGElNqg0MWtHFhdo70nCA41hZzHck7ScYi0UkNGnxuXX9X6rM0
         UTDkQZ9WZ4AQ4VBV2pU51DfE+Ntv6U1M2Nc5yXUF81VswIX6jhgFvV/LMWM/T/aie/XY
         SP2yTXseloIhte5vFxyd4Yj1or8sXK7EoDjqPxxphEkQY63t19ZeJTlfqWtMtZzV+VqH
         w4iHCLwf5AC+UfGPWABPC3xBCi6EREjVCrb06zUANHwp7GEQjqT/VCvvQBkkzSOA5OcA
         JccRUQ9oDIooqecurFyCinCfj+sIIn1h/4C6metoJjsMAJD2uEe+/X2wc/hTDczdUW40
         4nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=POIUFIUo+mTSLygBJlv/hquyjDRWa/g6KaVlpKSjnEg=;
        b=rBSQbtWJEJ6neTyGFQGscrAr4syMJu67lExfL7Ofw8SEAmBr0mLvhdD5aQ0+oZmMvS
         mTXDuhqYdRW2h+E0fWxwnXwce40F9Fv/UFLZwM1VDlKhiRXJ5XIGKZSMkKfP/X7XsrF2
         AdvSVWQcYuVxnEfAC9G1NLmr4/vMRtzFQd2c3bAw2ispDVG9bDkIJwhD8Vid/KGKJ3bp
         8Jt2f5gdOMnNQXFSjkAKTtGrcQDyXom90aCccr7+ySpjBgTI5HjrKwEwNX8glY1aI2rU
         uFAY+8vU/Pb/GcEIZqKzXz8uA7Po+asAcrny0FwC72420J9APwwiRn11Jd5NSaZ8MNdf
         nyZQ==
X-Gm-Message-State: APjAAAVA12pZ7tmQYyvZeZAl1pN6/zud9CKcpcCiJeK6IqgD9b+GqHRc
        GU72rlqscO/jP+BWQtIF8wLtPg==
X-Google-Smtp-Source: APXvYqwEo2JqgTZoCXiXHwNt2ciu74IZ6pL+6qZCv/8VbQLBuB58YasfhLm7GbTfj/fi2hY/3+UtUg==
X-Received: by 2002:a6b:2cc7:: with SMTP id s190mr24697839ios.164.1566326685906;
        Tue, 20 Aug 2019 11:44:45 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l2sm23612078ioq.83.2019.08.20.11.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 11:44:45 -0700 (PDT)
Subject: Re: [PATCH 1/1] nbd: fix max number of supported devs
To:     Mike Christie <mchristi@redhat.com>, josef@toxicpanda.com,
        linux-block@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20190804191006.5359-1-mchristi@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2c9a0b27-6761-f973-8e49-82e23b105e46@kernel.dk>
Date:   Tue, 20 Aug 2019 12:44:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190804191006.5359-1-mchristi@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/4/19 1:10 PM, Mike Christie wrote:
> This fixes a bug added in 4.10 with commit:
> 
> commit 9561a7ade0c205bc2ee035a2ac880478dcc1a024
> Author: Josef Bacik <jbacik@fb.com>
> Date:   Tue Nov 22 14:04:40 2016 -0500
> 
>      nbd: add multi-connection support
> 
> that limited the number of devices to 256. Before the patch we could
> create 1000s of devices, but the patch switched us from using our
> own thread to using a work queue which has a default limit of 256
> active works.
> 
> The problem is that our recv_work function sits in a loop until
> disconnection but only handles IO for one connection. The work is
> started when the connection is started/restarted, but if we end up
> creating 257 or more connections, the queue_work call just queues
> connection257+'s recv_work and that waits for connection 1 - 256's
> recv_work to be disconnected and that work instance completing.
> 
> Instead of reverting back to kthreads, this has us allocate a
> workqueue_struct per device, so we can block in the work.

Applied for 5.4, thanks Mike.

-- 
Jens Axboe

