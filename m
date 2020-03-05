Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD37C3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 20:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985D82072D
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 20:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QO00FYAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgCEUnJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:43:09 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33316 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCEUnJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 15:43:09 -0500
Received: by mail-io1-f66.google.com with SMTP id r15so8012612iog.0
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2020 12:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K+E8Uy+fBw/gh0nu1wLPFsLlAAWTt9S6/ny9LuQwDCk=;
        b=QO00FYAP80gFlnAl/2izdrLs57u2D9HT6jeMy2jT8IJZ00MvsCRpYMrR8GU7doHvUI
         6eTb+gVBX2QOOZOZE6/JRJOsscpRzWVzHoz5rbfegXEmZFRBLrs535y23DRBwzYpzKRs
         yYISl+wAUCrtJHIv1OArKmUbI6XKyFB0hK4WqTeLu5SAdChBAk4eLwCN5E9Hq/1B96SE
         aX4nzpp1eL0MeuF3Xxlufcvnn2Cz+opeQ61syEiQ9bsHv0LcNsJjSniFOxUF+kiarlpH
         dp6RgdLzUypkBgWAfDoqyehybF1hN2UowVmdvdwQdP9/1lqSk2YqiAaOecvpB7MqHSYQ
         5oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K+E8Uy+fBw/gh0nu1wLPFsLlAAWTt9S6/ny9LuQwDCk=;
        b=GV0kKEZASAv3GSxR8QAE58oPPBNYU4ReJ6O3XPZoR4KiLahAxCvrZhrEaP+wnf8ivY
         RYWUX9F85fuWMre7aN26/43dROGUhhG0X47ee8h0nEjbfFXMI5+zMPXOkoXL8xflvQeG
         9ncN2ArGH1V10tN0EMKGHK9KNebICRrk0CuPhxyoFXUDpuLYhSlA5D6jdJK59LNom7Rt
         DYEHYZxxGrEQGySFrLYPwry1V6x/7Gr6z2GV9v6BEVj6gpzIJKR2xf2wH8wAncJg4DBC
         AvBb2y7Ckmr+zGvtuJDmPjyzWDUVa0+2ixTKK8NCNQwbd05kOrIY1dGohFvCvMZMHvdd
         T6ww==
X-Gm-Message-State: ANhLgQ2cOu0QazqTOHl4ySthfIOAhJzDeGS1hKf5EJ7luhecmzInju7/
        JgEbIJXsbqvLRvUPrXURzCO0rQ==
X-Google-Smtp-Source: ADFU+vsg6Vx5j+mQUD7KDzZWDaDV9fBiG168AJM8hU2Ibf4OZYImC2B1YX0K/3FJt5xcZ/NuarDTEg==
X-Received: by 2002:a6b:7f01:: with SMTP id l1mr208223ioq.146.1583440986476;
        Thu, 05 Mar 2020 12:43:06 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g3sm1074323ilb.53.2020.03.05.12.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 12:43:05 -0800 (PST)
Subject: Re: [PATCH v2] blktrace: fix dereference after null check
To:     Cengiz Can <cengiz@kernel.wtf>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200304105818.11781-1-cengiz@kernel.wtf>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e6fe9883-2f51-a249-c5d2-ce11f6b449da@kernel.dk>
Date:   Thu, 5 Mar 2020 13:43:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304105818.11781-1-cengiz@kernel.wtf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/20 3:58 AM, Cengiz Can wrote:
> There was a recent change in blktrace.c that added a RCU protection to
> `q->blk_trace` in order to fix a use-after-free issue during access.
> 
> However the change missed an edge case that can lead to dereferencing of
> `bt` pointer even when it's NULL:
> 
> Coverity static analyzer marked this as a FORWARD_NULL issue with CID
> 1460458.
> 
> ```
> /kernel/trace/blktrace.c: 1904 in sysfs_blk_trace_attr_store()
> 1898            ret = 0;
> 1899            if (bt == NULL)
> 1900                    ret = blk_trace_setup_queue(q, bdev);
> 1901
> 1902            if (ret == 0) {
> 1903                    if (attr == &dev_attr_act_mask)
>>>>     CID 1460458:  Null pointer dereferences  (FORWARD_NULL)
>>>>     Dereferencing null pointer "bt".
> 1904                            bt->act_mask = value;
> 1905                    else if (attr == &dev_attr_pid)
> 1906                            bt->pid = value;
> 1907                    else if (attr == &dev_attr_start_lba)
> 1908                            bt->start_lba = value;
> 1909                    else if (attr == &dev_attr_end_lba)
> ```
> 
> Added a reassignment with RCU annotation to fix the issue.

Applied, thanks.

-- 
Jens Axboe

