Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D8BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Feb 2022 02:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiBWC7V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 21:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiBWC7U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 21:59:20 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFE753E18
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 18:58:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id q1so8854450plx.4
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 18:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1567fYwxI4tryC/xWcsF1QNbWPN7NYlTHOj4HWm+k1k=;
        b=TAycsUjIaOEf1V67VLYWCG5RgA5CgB1AclRHX2XZo9vmENKPqMlTyUOg2KsaZ57sFB
         yxmq7g2YvkEF6kaN4xqWd998z9ErQOiEiMIt90Ndnt2FtzqfLRguKpQmhNONqNiK7roL
         NUFoFEmP4W8La3YmvDkoRuFpVIbtHJFwc/C8YCv/YOla14g8DnhJYMgKF7Axdb2Pq+RQ
         /B/Whue592cn+rRz3Z9OrHjrWuOaEm3Lj5lpwA4yeqO8GRBEkPVXxlI6hCSFZRRI/XhE
         b8A0uvmQaiA2cVPGh2FL6DU+q5N1ZWyR/HRtTLtw7Pd6IrrarOOJfEu7Z64NzqsWds2L
         ce6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1567fYwxI4tryC/xWcsF1QNbWPN7NYlTHOj4HWm+k1k=;
        b=BQoXyo78L2wAI4jN7RE/37DOruddvd1MbeMBlU332Ywx7eYrwIBjhMj3hPwSaPDVKo
         fQhJK7BsiLwsctw4XqsoncHZW2nf9boWdqgYQEoa/TzFKeuUWqyGQDG6jHdnycOP5aNi
         FltQgj6dOEAM3vJHX2q9CUQIVL9Q7m2y+y0iWHeR3KhgIymg+Ep4+cdgviQiJztdICxR
         +vZfbzQoU7kRVxJly5SAxRD62mndilWjt94BoZ7JDe1TM/rS5ky8UBXseXpjIK3YrP7J
         qZKqLO+m7uTPxkP+uijG8kv7z8R6oOlFrNAWjzvPrNKWypllNmLyDQulZxrQBpr2S1CV
         IIoQ==
X-Gm-Message-State: AOAM533dd27WeQa8kUHj0Qm27gkgNT7sxAsubNAf9IfOJnoM7d1aKgeF
        7dqCmuVNhya4s9XSHzAp3FHVsmvfvEjj9w==
X-Google-Smtp-Source: ABdhPJz4iNjbljYqBnoACp5ZoA4dw7EcInnVqjC0Hj/rdriAEWal5gfOiWRbuZyVSxwui7rBfd2MBA==
X-Received: by 2002:a17:902:e742:b0:14f:fd2f:c8bb with SMTP id p2-20020a170902e74200b0014ffd2fc8bbmr169677plf.43.1645585132833;
        Tue, 22 Feb 2022 18:58:52 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s24sm1025944pjp.23.2022.02.22.18.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 18:58:52 -0800 (PST)
Message-ID: <3610d58a-ef1d-a460-4bb7-de3d0297dae2@kernel.dk>
Date:   Tue, 22 Feb 2022 19:58:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: block: potential bug on linux-block/for-next
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <ecc72e5f-dd71-d940-d50d-0347631a7933@nvidia.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ecc72e5f-dd71-d940-d50d-0347631a7933@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/22 7:49 PM, Chaitanya Kulkarni wrote:
> Hi,
> 
> After today's pull on linux-block/for-next test QEMU is not able to
> boot, any information about how to solve this will be helpful as
> it is blocking blktest testing, here is dmsg :-
> 
> [    1.304698] ata1.00: Read log 0x00 page 0x00 failed, Emask 0x1
> [    1.305587] ata1.01: Read log 0x00 page 0x00 failed, Emask 0x1
> [    1.455959] systemd[1]: Cannot be run in a chroot() environment.
> [    1.456743] systemd[1]: Freezing execution.

What was the previous one you tried? What are the changes between the
two?

-- 
Jens Axboe

