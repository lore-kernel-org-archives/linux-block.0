Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8B5C432C3
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1933F217F9
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 15:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XYuX4dAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfKRPg5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:36:57 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42659 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKRPg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 10:36:57 -0500
Received: by mail-io1-f65.google.com with SMTP id k13so19218736ioa.9
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 07:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=axG2J8Vd9JteC233+G11QXt2NAIDbiPNvZ0s1xYczH4=;
        b=XYuX4dAGrsegOBWUGMOp97anFvvyWeFsXCB6MYoiAqVQrWv/A53gIRR8o49+BGK5bk
         pOiEHwdd4DAnIVqe+U4TOL7mYClae+fzOOqMssLNRq5GpwCFxuMVlXL6IBYHxFcn2INL
         6w1qK8q0vExG+oFW/XEq/N16UeAGvLu20I5t7wEWqqX8AN92AXeK/4nEgoAABJyay7Pw
         +/9OgYzVsgAe2DocqCxGqTdn7je4adZ1W4ZAmUgGczN+9zNoVxL9gYeKRcHh1bgK19+e
         pUpyUGVCVR3VsGJEDyzftFpuaBYKvtjmJ9LdMb/Qk66qqCLNCykzEg0rhSfRLCvcxbAB
         bLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=axG2J8Vd9JteC233+G11QXt2NAIDbiPNvZ0s1xYczH4=;
        b=W6xnV3h7wTXchemxPOujbx1TxpHCi81s3lQJRyz/4azRPAZyYPNVWZou8lhe2GVjVQ
         iTQ+6AWZDEZmkmTNKtalPYS0bdgY1XjaPBqwnBlbnsO72eif8f5WlYcdxyxdGtPa9KWb
         8djYwfPZOfo1MfbkJfOc8veMzWa07IXD7LsaYhVJC5YjXSaeI0GSbDc4RYrh6wV+0QG8
         d5/bech6fXJYuK4zgRe5sN4zj1IRDsam8DY6vtpfJcESzuCqS7iL0LfpG95kaSbYXgQ0
         zlgvJzDl8gK6/QF45djLU1NFAYsWB6twofzeyQh5cEN5Ad0YDhtWzoUv4ZGDB1qnkCpf
         WwyQ==
X-Gm-Message-State: APjAAAWJ/b7FKKpg7r2GI7Hlf+iGveTp+gNahPXjUfKOFydRVd64kF42
        CTCz9T39M66BQQepMc7UUMGRy8w943k=
X-Google-Smtp-Source: APXvYqz+57nsmYT3HILMcMbUWLSqQ1/ysylhcNc1aqBf1BbnuIdxQdLr/k4/2rpuWqkDaih9ypomXQ==
X-Received: by 2002:a05:6602:228e:: with SMTP id d14mr13037522iod.122.1574091416043;
        Mon, 18 Nov 2019 07:36:56 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z24sm3580348ioc.47.2019.11.18.07.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 07:36:55 -0800 (PST)
Subject: Re: [PATCH 01/12] bcache: fix fifo index swapping condition in
 journal_pin_cmp()
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20191113080326.69989-1-colyli@suse.de>
 <20191113080326.69989-2-colyli@suse.de>
 <44e5bf57-4ff1-ed65-d198-722c925cee5d@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae40ece0-b0d2-9fd1-7d9a-0ee7063d4322@kernel.dk>
Date:   Mon, 18 Nov 2019 08:36:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <44e5bf57-4ff1-ed65-d198-722c925cee5d@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/18/19 8:28 AM, Coly Li wrote:
> On 2019/11/13 4:03 下午, Coly Li wrote:
>> Fifo structure journal.pin is implemented by a cycle buffer, if the back
>> index reaches highest location of the cycle buffer, it will be swapped
>> to 0. Once the swapping happens, it means a smaller fifo index might be
>> associated to a newer journal entry. So the btree node with oldest
>> journal entry won't be selected in bch_btree_leaf_dirty() to reference
>> the dirty B+tree leaf node. This problem may cause bcache journal won't
>> protect unflushed oldest B+tree dirty leaf node in power failure, and
>> this B+tree leaf node is possible to beinconsistent after reboot from
>> power failure.
>>
>> This patch fixes the fifo index comparing logic in journal_pin_cmp(),
>> to avoid potential corrupted B+tree leaf node when the back index of
>> journal pin is swapped.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
> 
> Hi Jens,
> 
> Guoju Fang talked to me today, he told me this change was unnecessary
> and I was over-thought.
> 
> Then I realize fifo_idx() uses a mask to handle the array index overflow
> condition, so the index swap in journal_pin_cmp() won't happen. And yes,
> Guoju and Kent are correct.
> 
> Since you already applied this patch, can you please to remove this
> patch from your for-next branch ? This single patch does not break
> thing, but it is unecessary at this moment.

Sure, done.

-- 
Jens Axboe

