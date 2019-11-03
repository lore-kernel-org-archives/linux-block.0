Return-Path: <SRS0=L9ug=Y3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84870CA9EB0
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 15:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5287C20842
	for <linux-block@archiver.kernel.org>; Sun,  3 Nov 2019 15:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2OiIuqhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfKCPCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Nov 2019 10:02:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44732 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfKCPCn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Nov 2019 10:02:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id f19so496522pgk.11
        for <linux-block@vger.kernel.org>; Sun, 03 Nov 2019 07:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fchTg0ZF2EgzHs8aQuXBULT6R3fTKmf78yUFFGY6FjE=;
        b=2OiIuqhy93xoklj6Mtq5AKJBSKAqDjV4RX7ccnbbPiiUMVO6PlBG2Gpl1tbFMIRJQS
         htr9QK4uG6VhZO/mqeaQXl2uKVZ614qbU5PPZgv/OpRnegfWjHmD6ZPiPSlKlCDvrlyj
         QPi4AQ6SEnu/+IZJLChJn6gu8ygXvMsIgeSL2++ac0nHi6iLK03/U4h/LZNraqRoJkR6
         PqYsC4Ws3FZEUsV4Jaghw+0lvcw6fkybA7lfXbGUA3ytGbfPSizlzLzxGNQixz3YxTPB
         Rb2oWBdfbGslgdPPS2h9h8q4+UOTEUEKSlUTkaCviEG2hgiHkGuYHnrEmK+o22x0kl7y
         zLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fchTg0ZF2EgzHs8aQuXBULT6R3fTKmf78yUFFGY6FjE=;
        b=DwCJ39QP5onKLfqNG8f5tVAjR0rwtZcFS0G0uC/5oNs1taId69/w/B0pLmegYIJUds
         1bMtT4VUTUq+zQecSikdjmG2f+pKj1bbFaNcV0awUB5yqEr0p/YEUOEcHDkfvgHFNI02
         Ct5yDBxEZ4CCe//IKY4L7857FyLG7lDclP91OKkLRLjNQXElcuLQn0BHabEDMYzWAnb6
         +TTYsKZf7EtgeWgen072LN4rlyid2G5Zng4YxRU4SPOIwLdqL76q9lBctvPAQEAks0Fz
         toz2CEthxLomHdy7HogtLyfSWN9P/7RHcoyCHFjtfIqtTBrjyGHCMf41w2BvTzF0MzSX
         sr3g==
X-Gm-Message-State: APjAAAWcfyl7O+VxzXHvU4fCEiobUPfiBAE4ILz4nSq1k/TAAQObA74F
        /DRTZ2/Tej67tEmx86haC0LdTqjb+iFvIA==
X-Google-Smtp-Source: APXvYqxZnTEOug8mRPTpGHiie28q2GJCzCbwagZgqqoYoxlLx54egE1dcX8uDgm6JdblPwc5AXB+1w==
X-Received: by 2002:a63:5d06:: with SMTP id r6mr25252544pgb.216.1572793360668;
        Sun, 03 Nov 2019 07:02:40 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z63sm12160335pgb.75.2019.11.03.07.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Nov 2019 07:02:39 -0800 (PST)
Subject: Re: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20191102080215.20223-1-ming.lei@redhat.com>
 <BYAPR04MB574951ACBF23CBDA280282A0867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <900885b8-108e-6da6-b565-acf9a813d5df@kernel.dk>
Date:   Sun, 3 Nov 2019 08:02:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB574951ACBF23CBDA280282A0867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/19 6:25 PM, Chaitanya Kulkarni wrote:
> Ming,
> 
> On 11/02/2019 01:02 AM, Ming Lei wrote:
>> It is reported that sysfs buffer overflow can be triggered in case
>> of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs of
>> hctx via/sys/block/$DEV/mq/$N/cpu_list.
>>
>> So use snprintf for avoiding the potential buffer overflow.
>>
>> This version doesn't change the attribute format, and simply stop
>> to show CPU number if the buffer is to be overflow.
> 
> Does it make sense to also add a print or WARN_ON in case of overflow ?

Just more noise I think, really wouldn't serve any purpose.


-- 
Jens Axboe

