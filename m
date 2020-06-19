Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B4BC433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10F22073E
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="hz+PQhL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbgFSSSK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389232AbgFSSSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 14:18:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C85FC06174E
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 11:18:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l10so10571640wrr.10
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uSHyt+KgUL6oeZLDkopz6kV5K86NXo1Z0JT3bWX80Sk=;
        b=hz+PQhL1kg7yhiBjKzV/pzggk3f78kbitti7zEDgzXMHlHn/0MVzv1u0y+JpkQz0St
         mov2LRpX1C18LR69WVFcFF79bPOuuWULbN2NjzkGjWHpwkwGqD6S1trHIT1EMnsv4ZnZ
         9YLQ7iTDMaA5AAdgmlu92ds0pb0x7JFA9Oi6OQK0SgOBREoc2wH63hxMOZOleDNmpTmW
         AfQF7x053LHHU3pEg7DVTdHK53GI6Mivj2TcNm7XcMHSzzTgDhPm4hp5o8se0jb/JUA+
         DRoQ1PJZmm43V3GI1VK+Sf61Z3Yryzpp+G8iQlVdyDh1P400XqE8JenEzZldDy2k6+R2
         HiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uSHyt+KgUL6oeZLDkopz6kV5K86NXo1Z0JT3bWX80Sk=;
        b=TQlzkt2XGLZxB5JrFGBr2GSXixweRvNCvKFFyMV7Sb4e/XTfjbcWXyed1V+xcZxOYi
         G/xllMrOi4WTtE7ftpBzj0KQQRAItdvrxAEYDuLddNKQc13hShN3Kpin1y40TFBMb0Sy
         Kz7Ese6FAF7EmODGUUFT9pgTGi3Um26qeJ19btab+P1e3bJfR1rN0wlAwfosMHFHscma
         ryj1I9c4b5d3cs0oMmYUZu1rWsAUSzv0k/Blu3AiDSINfqi3zc2uDixXUDruMzgz82Rw
         Wsx+vDeyR5J+IOgA3a2IPAAAEZkkTncq5IegIeHW83jYGm4DTJytraSPYIorjZOl5KfV
         4Yiw==
X-Gm-Message-State: AOAM5332UiY36nruL2bXvWnNCj5J4P/F36om8KfcoZQ9c6m2lcr1i6UM
        N7jvUNmTdoPnVYDy+PiIMyed2g==
X-Google-Smtp-Source: ABdhPJxEwzbXT40sCVi2vQr63v9sKxYr7ssYfouZwmT+qG/Zp8dBu0I32P+75PsfRmPLlCumkY8sBA==
X-Received: by 2002:adf:f507:: with SMTP id q7mr5297216wro.353.1592590687910;
        Fri, 19 Jun 2020 11:18:07 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id e5sm5803237wrs.33.2020.06.19.11.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 11:18:07 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     Heiner Litz <hlitz@ucsc.edu>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>
References: <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
 <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
 <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <da284d55-dea6-b51c-4bd0-40e119b5a733@lightnvm.io>
Date:   Fri, 19 Jun 2020 20:18:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/06/2020 20.08, Heiner Litz wrote:
> Hi Matias,
> no, I am rather saying that the Linux kernel has a deficit or at least
> is not a good fit for ZNS because it cannot enforce in-order delivery.
> The requirement of sequential writes basically imposes this
> requirement. Append essentially a Linux specific fix on the ZNS level
> and that enforcing ordering would be a cleaner way to enable QD>1.

Ah, I am not sure I agree with that statement. As Keith points out, 
there is not even in-order delivery in NVMe. Any system where high 
performance is required, has out of order mechanisms that improves 
parallelism and performance. If one wants to issue I/Os in order, it is 
as easy as supplying a write-back cache. Linux and any other systems are 
able to do that.

> On Fri, Jun 19, 2020 at 3:29 AM Matias Bjorling <Matias.Bjorling@wdc.com> wrote:
>>> -----Original Message-----
>>> From: Heiner Litz <hlitz@ucsc.edu>
>>> Sent: Friday, 19 June 2020 00.05
>>> To: Keith Busch <kbusch@kernel.org>
>>> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>; Javier González
>>> <javier@javigon.com>; Matias Bjørling <mb@lightnvm.io>; Matias Bjorling
>>> <Matias.Bjorling@wdc.com>; Christoph Hellwig <hch@lst.de>; Keith Busch
>>> <Keith.Busch@wdc.com>; linux-nvme@lists.infradead.org; linux-
>>> block@vger.kernel.org; Sagi Grimberg <sagi@grimberg.me>; Jens Axboe
>>> <axboe@kernel.dk>; Hans Holmberg <Hans.Holmberg@wdc.com>; Dmitry
>>> Fomichev <Dmitry.Fomichev@wdc.com>; Ajay Joshi <Ajay.Joshi@wdc.com>;
>>> Aravind Ramesh <Aravind.Ramesh@wdc.com>; Niklas Cassel
>>> <Niklas.Cassel@wdc.com>; Judy Brock <judy.brock@samsung.com>
>>> Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
>>>
>>> Matias, Keith,
>>> thanks, this all sounds good and it makes total sense to hide striping from the
>>> user.
>>>
>>> In the end, the real problem really seems to be that ZNS effectively requires in-
>>> order IO delivery which the kernel cannot guarantee. I think fixing this problem
>>> in the ZNS specification instead of in the communication substrate (kernel) is
>>> problematic, especially as out-of-order delivery absolutely has no benefit in the
>>> case of ZNS.
>>> But I guess this has been discussed before..
>> I'm a bit dense, by the above, is your conclusion that ZNS has a deficit/feature, which OCSSD didn't already have? They both had the same requirement that a chunk/zone must be written sequentially. It's the name of the game when deploying NAND-based media, I am not sure how ZNS should be able to help with this. The goal of ZNS is to align with the media (and OCSSD), which makes writes required to be sequential, and one thereby gets a bunch of benefits.
>>
>> If there was an understanding that ZNS would allow one to write randomly, I must probably disappoint. For random writes, typical implementations either use a write-back scheme, that stores data in random write media first, and then later write it out sequentially, or write a host-side FTL (with its usual overheads).


