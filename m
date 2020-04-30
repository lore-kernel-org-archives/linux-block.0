Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD716C8300A
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 13:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B0E208C3
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 13:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="QTdi5E1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgD3NKv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726577AbgD3NKu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 09:10:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DABFC035494
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 06:10:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a31so678879pje.1
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W7wychmgxkV+WrYJzKau1rOq4M9b3oS+ubAckA+E/WE=;
        b=QTdi5E1tHXcigIHeDMqjKzaoSyKN1kwvmRMMKhwstgmuSmuti+Wlo9Voa6Hol8zRzR
         ul85amgCDl2wwYTSm4RvwAKuECGMLEt75bCeGFF7DiFCLEGeUnExo+WDItpJqDza0X3j
         r4V03pA+f3Uo+8AQCHYE+29nQNDN/Y+YqiEBOYn1+Z+5wW3CVIKmLC4QOJcHu8anUg41
         Vu0/R/FVr3r3gWMtAiFYdVOM/0dSLv49OsLst/NVx/k+/UPQ0NwwcaiJKp06s71LNQch
         3/m+8F3YQBZpVCXWhaddUlsNIhfXGDT7NtCyFeAQU98Kw2MnF5o9e/eWfLOvJ/lIXm1X
         a9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W7wychmgxkV+WrYJzKau1rOq4M9b3oS+ubAckA+E/WE=;
        b=ou6cVJuDJfjMS8/7+09bzKv8Zt/O2h6HpQcOk1W02y4mtSbyNCKq0YtncV5ETs05/d
         Kp9xE9EdGlN41gLcLb8qwF4DzxyNHjaUBeeWHgQPw7fgI+61JfeczR0tU+cpNp070iRW
         +sPAo5p8nMYpSi4X1Ji76nL0owwnUFR9UbhzqlwjZQzAAK65ld0QlGdBcN1jm3ALKjYN
         CFPpEEh4/D0xvE7pnuEbnybB3T0mRMMgbIoZH/EDfhAKMSPvEiPa3nri9GNhnhrroHhO
         MJC17oZjPiRe9b3p3ykFKV3nwZ/DipFDfnqKLWTlbpjBP6FNMBKYxFsDWPthk5HbdD9+
         9OQA==
X-Gm-Message-State: AGi0PuYdy5UVgNEtsYZ+DoDF/ZpfdQTXfQJW5wcCTjAYAyGCsoXYFiw/
        fKH194TJJ12sg7+1PwZxTCh4IopAYlnZmg==
X-Google-Smtp-Source: APiQypLHuJM8ql4hBVuONZI614Db6gsH8rJdSMv4RlQmiEjd541xmdjhUHrx4UYJ4sVs/Vt3NeVaHQ==
X-Received: by 2002:a17:90a:270d:: with SMTP id o13mr2932076pje.34.1588252249437;
        Thu, 30 Apr 2020 06:10:49 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y10sm3473797pfb.53.2020.04.30.06.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 06:10:48 -0700 (PDT)
Subject: Re: Commit 35fe6d7632 breaks blktrace API
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org
References: <20200430114711.GA6576@quack2.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ae4a13a-2f03-a902-5bb5-3dcd20cf1fad@kernel.dk>
Date:   Thu, 30 Apr 2020 07:10:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430114711.GA6576@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/30/20 5:47 AM, Jan Kara wrote:
> Hello,
> 
> I was investigating a performance issue with BFQ IO scheduler and I was
> pondering why I'm not seeing informational messages from BFQ. After quite
> some debugging I have found out that commit 35fe6d763229 "block: use
> standard blktrace API to output cgroup info for debug notes" broke standard
> blktrace API - namely the informational messages logged by bfq_log_bfqq()
> are no longer displayed by blkparse(8) tool. This is because these messages
> have now __BLK_TA_CGROUP bit set and that breaks flags checking in
> blkparse(8). It isn't that hard to fix blkparse once you know what the
> problem is but I've wasted couple hours on this...
> 
> Also apparently nobody tested the patch with blkparse(8) since 4.14
> days? Admittedly this requires CONFIG_BFQ_GROUP_IOSCHED and having cgroups
> set up for the cgroup info to get emitted which probably is not that common
> with non-production machines.
> 
> Anyway, what to do now? Update blkparse(8) and hope nobody else is using
> the blktrace API (likely I'd say)? Revert the change?

It's been this long and nobody has complained, I think we should just update
blkparse.

-- 
Jens Axboe

