Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521ECC433F5
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 12:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2462C60FE8
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 12:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhKAMn5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 08:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhKAMn4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 08:43:56 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9F4C061714
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 05:41:23 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j28so11882257ila.1
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R78X8Q6kqKTZC2lxB/WageNTOQ4TP8APn0wan3Xy1BA=;
        b=xqkOoExzLngwd4LLPBV51vfxN7yD2yNFMK1sClba0NHsV8AB3OaM0pO2GdD+XjXylL
         rSkdTUUri73g8YeUxNVGXufOpsUP87TDP2roC8lYxnrtt/+lzqFfyfp1kgb6V7g353FV
         KFn6cMNCG2JruC1PYHsy9JAxp74Pig+yP3tbs9RdZLzoqgOzxkuQULz6ygH/hS8tCru6
         hE0uLGfljsTwWLH8dKi328UxBnsHboACzCFb8CbkzosoLW5kj8RwwY/aICKOoKe7fKbv
         nQHJEXkk6gksMqwljf/TxOXuxdiRst6iQvazfExoPm7Ud4/Ux5yoo7sR1/hS67s3NcJH
         TsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R78X8Q6kqKTZC2lxB/WageNTOQ4TP8APn0wan3Xy1BA=;
        b=XquSoJX0tFt7EdVlBkM3iiN+mrznSOIYWY9VsQy3jSpwACBdZbxQF8F/ni8rksaNjZ
         nnqLhaP+JLlTYG4nG7ZkNtSHAtL1Hz63u/cJrUd0S/zUizEwTv9n/Yfgg5Pp4SmMQ1R9
         1OzKYPznFAUBE40/SWB8kiTbGTxfipPAef7pZhd1WrivsSBkwMWxqPFnuvo3ymhLnzdv
         hBsyFeyiLjRyBTyIt44me5HNdi+UeFlaH8FBic8Fp7B4upzpq/+PBzaE7BP1XGbVodQd
         L+kqJP9C7WkufQB0KddQCGCXOG+y7zgokEjXuc4ImOkzhcu3Jdu9PKdwjX0HfXOWQxXE
         dNdA==
X-Gm-Message-State: AOAM531BmzSljUDfV6ZlZWCiIfshRHs96O+PPKN+Zet900qqMhQYYXr7
        v6+hjkBHg7sD/AetxHfDNGjAsUirWZuZpQ==
X-Google-Smtp-Source: ABdhPJzUyv1b1s0FMIdvov8KBFSLDiRjOBHJX7m0duljGjfh8/qq2Sy+TUuYvMk7gziq7+6gsT4hfA==
X-Received: by 2002:a05:6e02:1402:: with SMTP id n2mr20053166ilo.208.1635770483020;
        Mon, 01 Nov 2021 05:41:23 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t2sm7746592ilg.1.2021.11.01.05.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 05:41:22 -0700 (PDT)
Subject: Re: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20211101083417.fcttizyxpahrcgov@shindev>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
Date:   Mon, 1 Nov 2021 06:41:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211101083417.fcttizyxpahrcgov@shindev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/21 2:34 AM, Shinichiro Kawasaki wrote:
> I tried the latest linux-block/for-next branch tip (git hash b43fadb6631f and
> observed a process hang during blktests block/005 run on a NVMe device.
> Kernel message reported "INFO: task check:1224 blocked for more than 122
> seconds." with call trace [1]. So far, the hang is 100% reproducible with my
> system. This hang is not observed with HDDs or null_blk devices.
> 
> I bisected and found the commit 4f5022453acd ("nvme: wire up completion batching
> for the IRQ path") triggers the hang. When I revert this commit from the
> for-next branch tip, the hang disappears. The block/005 test case does IO
> scheduler switch during IO, and the completion path change by the commit looks
> affecting the scheduler switch. Comments for solution will be appreciated.

I'll take a look at this.

-- 
Jens Axboe

