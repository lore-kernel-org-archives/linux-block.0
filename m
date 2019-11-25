Return-Path: <SRS0=vXr6=ZR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A69C432C0
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 19:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4A2071E
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 19:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfKYTlx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:41:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36743 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfKYTlw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 14:41:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so7870500pfd.3;
        Mon, 25 Nov 2019 11:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42S2SQ4poaCqsC6y0USRopdPGs/iLjn//hI75VsW/20=;
        b=NNiTz/N/jn3ECok0ZBNk3dM9uZjJ9fxSurv0c3tnygJwrnfEwIxDsXwBCGiaPTMuJH
         VN9BqrpzT4Y7y6/oGR/gofidm0pEeb2uZmx2EsBAWcJ/nxPHd2jjZ/ytek5mpB4tAdAc
         PZwxxS4R2/3kR1dsYvLWrMe6wOre/gkc2jhiacLulnq4CnqhA9kB2H0RJ+F7mzMS8T+x
         M20oW8/OjjZOdBlVOjmOjH94HRVCUnDYWDdXQVISn6QUsWPjgxnMOc2qsyuQ32wJUdsR
         gSGEWuN4CjubN5YxfZJdkJJ4NMcOrAPIUyqkRCBGR5NofohbyZvzKmE3pjnYxkB+q3R9
         4uNw==
X-Gm-Message-State: APjAAAUPq0iFfhBUtIwilfBKgsbEZSWgKkmk/8QJO+45as9KAJIjsDT8
        6OSp8yFX7/exOAJp9FrnJuImkgwi
X-Google-Smtp-Source: APXvYqwdQYkz+o5leZlnK7ZcW9MZs/t4kmmvK7Y8obAlwUG16DQsWhXBgHy6kz+uCDoeegQX6aE9Cw==
X-Received: by 2002:a65:4ccf:: with SMTP id n15mr35051760pgt.248.1574710911337;
        Mon, 25 Nov 2019 11:41:51 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s2sm9668983pfb.109.2019.11.25.11.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 11:41:50 -0800 (PST)
Subject: Re: [PATCH v2] loop: avoid EAGAIN, if offset or block_size are
 changed
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20190518004751.18962-1-jaegeuk@kernel.org>
 <20190518005304.GA19446@jaegeuk-macbookpro.roam.corp.google.com>
 <1e1aae74-bd6b-dddb-0c88-660aac33872c@acm.org>
 <20191125175913.GC71634@jaegeuk-macbookpro.roam.corp.google.com>
 <a4e5d6bd-3685-379a-c388-cd2871827b21@acm.org>
 <20191125192251.GA76721@jaegeuk-macbookpro.roam.corp.google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <baaf9725-09b4-3f2d-1408-ead415f5c20d@acm.org>
Date:   Mon, 25 Nov 2019 11:41:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125192251.GA76721@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/25/19 11:22 AM, Jaegeuk Kim wrote:
> On 11/25, Bart Van Assche wrote:
>> Thank you for the additional and very helpful clarification. Can you have a look at the (totally untested) patch below? I prefer that version because it prevents concurrent processing of requests and syncing/killing the bdev.
> 
> Yeah, I thought this was much cleaner way, but wasn't sure it could be doable
> to sync|kill block device after freezing the queue. Is it okay?

Hi Jaegeuk,

That patch was based on an incorrect interpretation of the meaning of 
lo_device. After having taken another loop at the block driver, I don't 
think that calling sync after freezing the queue is OK. How about using 
the following call sequence:
* sync_blockdev()
* blk_mq_freeze_queue()
* kill_bdev()

Thanks,

Bart.
