Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C50C32750
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 03:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7049206A3
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 03:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rqxUXr2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbfHBD5p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 23:57:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42310 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730934AbfHBD5o (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 23:57:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so35346270pgb.9
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 20:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hpB9ww8EWgTbKIu/vDphodNz7BlPJgOXt0hZXWNaRRE=;
        b=rqxUXr2AbstRYuUvajB6bOEJxqpauI7Wev9AXFL/UefXKQKpwQ+KArinQC8fgu2O66
         Mkc8+c5wld6D5fkMJkHCq5OS/fUdU5bjm9+phFV0lUCszmuaVj73vgmFIaWdpamWIEoh
         80Vhrv/J7/wZgVK0syEdhhx6q0qm1BzzqiqHFVfLxmLkBs20i9T2zTwy86wezFMIbhF7
         YyMhmUxhcbUcJSpBflL3ssq6dPdb42Y/yAdNEOFqW40wQH6x+xM6V2+IDO3JdURkEsny
         jsi5AICQYL/2is5iaSsVlCwJdFxAwRYX7yJwyL4JaCU3/frnItwYPR8VjjQb6C6JDA+9
         kv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hpB9ww8EWgTbKIu/vDphodNz7BlPJgOXt0hZXWNaRRE=;
        b=BJx6OxxznRlO0D7UmAofvN2sI5mQm/gDyqv96DPD+xYmGHAo+8Q2QzIwVg+FPMgl8T
         qLKrRyWlPk5mpbjZ7NWFdiZRkbzbqNxI06YrAY1PH8UYioFlcCX6jfwKhPQGYYXoO+b7
         cuj+TFN/ETTWQbZ+/tFJz49YkTEaZafAdo+jnYYfwBfbOJ9hI33v3pJiksl9xTA56SHd
         6k/g708+tTlVvCtW0foqts4IgcFH0ddkVXxPe/4KOdrrUmqJH3G5au10zDADEdGdmJ0z
         bVoyQPmg1p4V8eCgsNzMvKLawCCvu2KEfWWT0maOlNZvmzJOGDOds5E1P0kIjmCEUcSf
         Nijw==
X-Gm-Message-State: APjAAAVJXWmzoswMG3t2qMmtGfBZ52WevUjlS4Pzfrw9bhGs7ItNK0LX
        /U1E2IS+MF4Nb5Lnxa1XARk=
X-Google-Smtp-Source: APXvYqzsAK2DkGhbGk/xxPqvstYt28+Pouzz3w4xrGwXAelEj9NooEyyB7/H+rwwOxlT6nCOJCyLhg==
X-Received: by 2002:a63:7b4d:: with SMTP id k13mr119736915pgn.182.1564718264104;
        Thu, 01 Aug 2019 20:57:44 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1134::11cc? ([2620:10d:c090:180::1:d9b1])
        by smtp.gmail.com with ESMTPSA id 131sm6216660pge.37.2019.08.01.20.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 20:57:42 -0700 (PDT)
Subject: Re: [PATCH] block: Fix __blkdev_direct_IO()
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Masato Suzuki <masato.suzuki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <20190801102151.7846-1-damien.lemoal@wdc.com>
 <19115dcc-8a4b-8bb7-f8db-e2474196a5d0@kernel.dk>
 <BYAPR04MB581699C381CE35C34DE45EBCE7D90@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0bf921d3-162b-8e51-63fa-5da757ccbbd2@kernel.dk>
Date:   Thu, 1 Aug 2019 21:57:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB581699C381CE35C34DE45EBCE7D90@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/19 7:05 PM, Damien Le Moal wrote:
> On 2019/08/02 4:51, Jens Axboe wrote:
>> On 8/1/19 4:21 AM, Damien Le Moal wrote:
>>> The recent fix to properly handle IOCB_NOWAIT for async O_DIRECT IO
>>> (patch 6a43074e2f46) introduced two problems with BIO fragment handling
>>> for direct IOs:
>>> 1) The dio size processed is claculated by incrementing the ret variable
>>> by the size of the bio fragment issued for the dio. However, this size
>>> is obtained directly from bio->bi_iter.bi_size AFTER the bio submission
>>> which may result in referencing the bi_size value after the bio
>>> completed, resulting in an incorrect value use.
>>> 2) The ret variable is not incremented by the size of the last bio
>>> fragment issued for the bio, leading to an invalid IO size being
>>> returned to the user.
>>>
>>> Fix both problem by using dio->size (which is incremented before the bio
>>> submission) to update the value of ret after bio submissions, including
>>> for the last bio fragment issued.
>>
>> Thanks, applied. Do you have a test case? I ran this through the usual
>> xfstests and block bits, but didn't catch anything.
>>
> 
> The problem was detected with our weekly RC test runs for zoned block
> devices.  RC1 last week was OK, but failures happen on RC2 Monday. We
> never hit a oops for the BIO reference after submission but we were
> getting a lot of unaligned write errors for all types of zoned drive
> tested (real SMR disks, tcmu-runner ZBC handler disks and nullblk in
> zoned mode) using various applications (fio, dd, ...)
> 
> Masato isolated the problem to very large direct writes and could
> reliably recreate the problem with a dd doing a single 8MB write to a
> sequential zone.  With this case, blktrace showed that the 8MB write
> was split into multiple BIOs (expected) and the whole 8MB being
> cleanly written sequentially. But this was followed by a stream of
> small 4K writes starting around the end of the 8MB chunk, but within
> it, causing unaligned write errors (overwrite in sequential zones not
> being possible).
> 
> dd if=/dev/zero of=/dev/nullb0 bs=8M oflag=direct count=1
> 
> On a nullblk disk in zoned mode should recreate the problem, and
> blktrace revealing that dd sees a short write for the 8M IO and issues
> remaining as 4K requests.
> 
> Using a regular disk, this however does not generate any error at all,
> which may explain why you did not see any problem. I think we can
> create a blktest case for this using nullblk in zoned mode. Would you
> like us to send one ?

Thanks for the detailed explanation. I think we should absolutely have a
blktests case for this, even if O_DIRECT isn't strictly block level,
it's definitely in a grey zone that I think we should cover.

-- 
Jens Axboe

