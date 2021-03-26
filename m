Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38231C433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 02:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E774261A2B
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 02:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhCZCOp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Mar 2021 22:14:45 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:45052 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCZCO2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 22:14:28 -0400
Received: by mail-pl1-f182.google.com with SMTP id d8so170521plh.11
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 19:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QXIrJDoPhRKihINB7ipPZYfimulfr+WPlw7qkN0obZo=;
        b=Ml6b12pA8rmGVdqsiQYSaJ+X1dTkMwWNlYmPR/7L0otjFfVN4tTsrSuCzKITCZUC5E
         LeErnLCfwMVxEKTIPaeeaL57cu2Lwih+dm7oILnC72e2qrIGun1hAVJpUe6pZmRDtHE+
         aU6DZDK6xs5HqqCmCKimQcX0Ko5NFgXPjIcrDfLk79/QTo0+5PDQ/wSKs+FURg1zXeyI
         NnvayUq1FULCY/oFnIr1996Ta3GZawUEajvxKY7csZugfYPSNIiOfeR/FVUPLpNYbDXt
         5Tb1euHShNdEGVe51ymzjgwt3e3h1/uaGi/3ycXkH53a1Kbwmek43eB71CAjhfVGnaAa
         vQhg==
X-Gm-Message-State: AOAM533vy+xuuLgnh0PX8ShbQuW8XHrzvaQsPPM6plhX6quU06Ah/UuB
        C5QXoU5lsRDZnYQoMM77h90LBQ7MCRQ=
X-Google-Smtp-Source: ABdhPJyY4B+zct4/Msw6dRjcHs9Lv6853JDVdHTNqrmN2KXob/fWjsuAxXLDxuKq88zP4vfwUS84TA==
X-Received: by 2002:a17:90a:17c3:: with SMTP id q61mr11179060pja.58.1616724868159;
        Thu, 25 Mar 2021 19:14:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:c5af:7b7c:edac:ee67? ([2601:647:4000:d7:c5af:7b7c:edac:ee67])
        by smtp.gmail.com with ESMTPSA id x19sm7087539pfi.220.2021.03.25.19.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 19:14:27 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Fix races between iterating over requests and
 freeing requests
To:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20210319010009.10041-1-bvanassche@acm.org>
 <721c833d-7dc6-30a5-371e-c8c6388fb852@huawei.com>
 <ecab7c5c-53b8-61e4-800e-b9c368e4b8b4@kernel.dk>
 <6a2a5558-6413-bbe7-b2fe-61b89629495a@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e441b617-a012-4f1c-4d4e-55c167d9bdee@acm.org>
Date:   Thu, 25 Mar 2021 19:14:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6a2a5558-6413-bbe7-b2fe-61b89629495a@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/21 9:26 AM, John Garry wrote:
> The first patch in my series solves the issues reported by community also:
> https://lore.kernel.org/linux-block/1614957294-188540-2-git-send-email-john.garry@huawei.com/
> 
> And that patch should give no throughput performance hit.
> 
> The other two patches in that series are to solve more theoretical
> issues of iterator interactions, but their approach is unacceptable.
> 
> Obviously your call. IMHO, Bart's solution would make more sense.

Hi John,

In case this would not be clear, I really appreciate your work and the
time you have spent on analyzing this issue and preparing a solution.
Personally I prefer the solution to clear request pointers immediately
after these have been freed since that approach results in simpler code
and (hopefully) in code that will be easier to maintain.

Bart.

