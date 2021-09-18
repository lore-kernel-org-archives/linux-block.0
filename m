Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A6C433F5
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 11:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CC460F9C
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 11:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbhIRLC4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 18 Sep 2021 07:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhIRLCz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Sep 2021 07:02:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115DCC061574
        for <linux-block@vger.kernel.org>; Sat, 18 Sep 2021 04:01:32 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c21so39650616edj.0
        for <linux-block@vger.kernel.org>; Sat, 18 Sep 2021 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t+35fRnh6CrzJgelWPX4a2Ax0K8SwqEWJc/pj+VOlmo=;
        b=ZouRqLUooth2Qvs6vG9+ofMgCRQzrn5y2tfHwz0u4oIdupdrrUArrZs0jUiznlb4/n
         GjP1vvHFtOPeEHnkOUu141Yx4eRqSmue8NsGChW5gtxKHFxYhljBSTHYyP+PaSMY0hx5
         PBB/gYOyEQY81C9DeKHpB+HfK7d6W+jXRbGuUEgn7sWrvMg3/5rKfrqxzDcitQZps51b
         f2N4kJzKTDlxus4SAe1KcCz7nIA2dsE73xjz+XFT9W+YWA6b617AtWQH5HozYOsjzh22
         ki6oDzFUddXBhJhbFiCaExj5lHHy1awTfv1gifvuLONO3Vz/qHnlAqZU8mNkxOuwzuZ7
         l46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t+35fRnh6CrzJgelWPX4a2Ax0K8SwqEWJc/pj+VOlmo=;
        b=zN3J0AFddZWGabGJ+DBGvVUWnU7cuAMNkcft624PfQt0GoldzHQnYQdxfeEgDeDw7+
         5VHvW9JirMdlIu7eYRIFoc75Afdl1EVuU86KMWfPdBnv57qCmKhmrcZGK6QyPpCrbnQp
         4NC1KPcHiTXblu+YL3MbsjzWS3Ckv1bpzz7yaKopnIr8zqNceS5IZo1329X13N38/rkj
         MXfiSJo1EJELuhXL8lF/mzKp9UUnRwQCK+2tE1lIPPFn7OYMWFnXFhquY2b5HJn8SzCp
         do+6MRA16OjQXZ01tRUY3X6R4m2P4iwfMzRU1xzmcBIvsFKoS8aouiizjQQLCSqesO3P
         mOhw==
X-Gm-Message-State: AOAM5304hPrTPe12Uho4NNswafW0l/n/VtAT4ZAwSfUhVfrfYgDJMKSX
        K+16PIEXrUQxYkO9AjGXwXOfCw==
X-Google-Smtp-Source: ABdhPJyj9J6pwW7HIdn7coFmME/qUfp1LyHO0/PW+vZkvw5xiRodFLjQQhUgeEkbQQFn1YxUWIq+lg==
X-Received: by 2002:a17:906:1f49:: with SMTP id d9mr18174125ejk.150.1631962889604;
        Sat, 18 Sep 2021 04:01:29 -0700 (PDT)
Received: from [192.168.136.233] ([37.160.169.152])
        by smtp.gmail.com with ESMTPSA id r22sm3479061ejj.91.2021.09.18.04.01.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Sep 2021 04:01:29 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: bfq - suspected memory leaks
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <38fc74a9-f748-54b9-d072-d3fa88a3d7d8@kernel.dk>
Date:   Sat, 18 Sep 2021 13:01:27 +0200
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B36A80BD-B3FD-4C05-AF27-618C50664CAE@linaro.org>
References: <72691728-304b-a80b-5850-92879fffc61a@linux.dev>
 <38fc74a9-f748-54b9-d072-d3fa88a3d7d8@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 15 set 2021, alle ore 14:56, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 9/8/21 10:07 PM, Guoqing Jiang wrote:
>> Hi,
>>=20
>> With latest kernel (commit 4ac6d90867a4 "Merge tag 'docs-5.15' of=20
>> git://git.lwn.net/linux"),
>> I got lots of kmemleak reports during compile kernel source code.
>>=20
>> # dmesg |grep kmemleak
>> [18234.655491] kmemleak: 1 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>> [18890.247552] kmemleak: 2 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>> [19745.602271] kmemleak: 2 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>> [20390.965851] kmemleak: 4 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>> [21150.173950] kmemleak: 4 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>> [21929.951448] kmemleak: 15 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>> [23589.726859] kmemleak: 2 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>> [24416.441263] kmemleak: 1 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>> [30400.835853] kmemleak: 10 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>> [68673.737862] kmemleak: 2 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>> [72770.498898] kmemleak: 1 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>> [77046.434369] kmemleak: 7 new suspected memory leaks (see=20
>> /sys/kernel/debug/kmemleak)
>>=20
>> All of them  have similar trace as follows.
>>=20
>>   comm "sh", pid 27054, jiffies 4302241171 (age 47562.964s)
>>   hex dump (first 32 bytes):
>>     01 00 00 00 00 00 00 00 00 b0 20 02 80 88 ff ff  .......... .....
>>     04 00 02 00 04 00 02 00 00 00 00 00 00 00 00 00 ................
>>   backtrace:
>>     [<000000004fa2550b>] bfq_get_queue+0x2a8/0xfd0
>>     [<00000000b1757a70>] bfq_get_bfqq_handle_split+0xa4/0x240
>>     [<00000000ac263274>] bfq_init_rq+0x1f7/0x1d10
>>     [<00000000110283e1>] bfq_insert_requests+0xf7/0x5f0
>>     [<000000002ed06e79>] blk_mq_sched_insert_requests+0xfe/0x350
>>     [<000000000ebf38ac>] blk_mq_flush_plug_list+0x256/0x3e0
>>     [<00000000bc647b2b>] blk_flush_plug_list+0x1ff/0x240
>>     [<000000004e7e49f8>] blk_finish_plug+0x3c/0x60
>>     [<000000008802f1e4>] read_pages+0x28f/0x580
>>     [<000000009986d1f4>] page_cache_ra_unbounded+0x266/0x3a0
>>     [<00000000492c494f>] filemap_fault+0x8a8/0xfe0
>>     [<000000009cbd8d38>] __do_fault+0x70/0x150
>>     [<000000002740a35f>] do_fault+0x112/0x670
>>     [<00000000a74facab>] __handle_mm_fault+0x57e/0xcc0
>>     [<0000000024009667>] handle_mm_fault+0xd6/0x330
>>     [<00000000fb1e0780>] do_user_addr_fault+0x2a9/0x8b0
>> unreferenced object 0xffff888021e5dd90 (size 560):
>=20
> Paolo, are you on top of this one?
>=20

Thanks Guoqing for reporting this.  I'm overloaded at the moment,
please give me a little time and I'll have a look.

Paolo

> --=20
> Jens Axboe

