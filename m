Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7ABC433F5
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A972861407
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 15:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbhKPPqO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbhKPPpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 10:45:47 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2E3C061225
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 07:42:41 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id x10so26671229ioj.9
        for <linux-block@vger.kernel.org>; Tue, 16 Nov 2021 07:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=qZTHx1FvTHabhubW5uLJTFw9g14LfOUphosZneheXs4=;
        b=w3QG6GtaZbgUU/+dtPJdAPWmz2QGCSQsvGWcNOjVgJzNUtppuN3BuL6C793MwPsZco
         vmpfKXeKJF5z9hGpGvKNH8qXEqsKBJa//YA7/NsmjWcI7ePjzc707vdTSfxUa5RRaze5
         3toFmyOzFAODOhoRXNXy8XE81gD/Au+qO9TNc22HyPGVBXVWCATQQdOuwc6p5jiP16Is
         FP5Ce9W3ANlg3rjI9JLET3UWo2rETlyvy6UcENgodYMRaZHNJWlwtdwsfmXl3uDpZN13
         8Ed7vKFVvUydjzwgPptOkIz5BNiPjJ1+CwafmBa/wPySHb5HrIHRnpnmEkmI0ZDscVCv
         lU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZTHx1FvTHabhubW5uLJTFw9g14LfOUphosZneheXs4=;
        b=BVfaiDjeqWJJW4xr7EHIC2tuO9nhKAnnMy0+Fh/O8jbneHp+xxop87sLiK7SJJd+zS
         jCuL0h2LtoM3bOlMU4RyNQHIExNHNQjLzkt366uQFGUPmVsLzg3A40o6RY1TspMOZIQ8
         /OYRJJfB4W52vaFi5u1JC2XJw4NrH2XF5SPZaGLBdmL7Kd45T7pkLQkgYl+iIyS7LAXF
         tWL7sRZU+b0rUrEMiwKnu6x9pX2/4/haND1RmCllCG7C1hCHeGe4MLytgY2qQ3D8Heb9
         Myn5H2idHziTG7mF3p5t9xEuxZSJN3FvrVBfEuakGbUAE5snzq7JDxc0mbwDhvISUO7y
         mZPw==
X-Gm-Message-State: AOAM532CT9EzNKvF0aIaBaH8NsYvXm9u4uLixodnmNynd3+nwPsmotwR
        LuoLPno+i9nClQwhRz6THmRAx582uK1wZvZ3
X-Google-Smtp-Source: ABdhPJyrpIfc2UW9Rx72NBiL5cdgp4TrZ59GyNqn8h8b6TcBQy++Dv52FlJE6Vv7QfaAlwnjezgwfQ==
X-Received: by 2002:a02:a601:: with SMTP id c1mr6313123jam.114.1637077361081;
        Tue, 16 Nov 2021 07:42:41 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o10sm9609624ioa.26.2021.11.16.07.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 07:42:40 -0800 (PST)
Subject: Re: [syzbot] INFO: rcu detected stall in __hrtimer_run_queues
To:     syzbot <syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com>,
        fweisbec@gmail.com, hch@lst.de, hdanton@sina.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, paulmck@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
References: <0000000000007ee63e05d0e9c172@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <097631ea-d781-c4e1-aa0e-d921a7a2e69e@kernel.dk>
Date:   Tue, 16 Nov 2021 08:42:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000007ee63e05d0e9c172@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/16/21 8:41 AM, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit b60876296847e6cd7f1da4b8b7f0f31399d59aa1
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri Oct 15 21:03:52 2021 +0000
> 
>     block: improve layout of struct request

No functional changes in that patch, so looks like a fluky bisection.

-- 
Jens Axboe

