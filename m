Return-Path: <SRS0=2cC7=AA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93998C433DF
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DA72100A
	for <linux-block@archiver.kernel.org>; Fri, 19 Jun 2020 18:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="fr0xb02J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbgFSSZp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgFSSZp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 14:25:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C85DC06174E
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 11:25:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id r15so9935486wmh.5
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=V51fa+JnxcBTxEQyN+hbyfp/TDZpfijc/JikllL3zuA=;
        b=fr0xb02JTxNqgcy7gLvuFHwJ5HbOjTSbskCgotnroFgAZ++YVS74HA5gl3vQdHtzxZ
         Cf8vruM3RitqaJHomEJoHV2TW2dpevtnYFITcIgRC70M9xACuQdordLUl6B2gxGIUFkQ
         Tiun0fIECyhTR+bjmpK4KCK+cof/hcdO24DW3h2OqHQJYZ2eSlg95bMMZp8zdBH0+HNY
         rYjRmCsOUIeVmtCzpFZhtUsJ5cJbIeSXZuGCLyybmlE675cCIxKxe+jwCLQpcczCnwEM
         ruIyddu6BWri9YVFEa+ODf7Zh0giW1Rpt9qZjcwQuoGA1qTXvSqetkQlksqcbhaWwldE
         9E0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V51fa+JnxcBTxEQyN+hbyfp/TDZpfijc/JikllL3zuA=;
        b=eIW1faEKpyxFrTDZrqG6hmNky5FL6tz0EWWXxLa4iMvkS7S0TMrl98OO8VRejGhQDj
         +2SA/jGCbtFxFhka9nNGCs/jcLtKyUcVUyijA6kNOWLPhI/e6Fy+bbJRWZ+VR0bukLEn
         CCPGxHReX7bKxwyhe7adHvypPwYtBh9+uyI9HisfCinVXUiehvCk4srDpReWQL4VcMJx
         gF48JEJaYOg/UwiloEEjL4HvSHB31l3bFy+BFcNJZX/N+TFQhQkmwdW7M1e15hrCrCHL
         y996/isrh9v4Xxy5YtU/MnPWIOJnfiX01pOOo+dznSjGRpm+jFoj8PBwQjhfGRSJem0w
         bevw==
X-Gm-Message-State: AOAM5329V+wH6jZpgHgtsU8SZ9/T9qibARa+dHPi8wTOtYmy2C35Lnzb
        V3qgOUH0CKBz6/lyyaOi/Snglg==
X-Google-Smtp-Source: ABdhPJz36QKLxdCCqVrkY2TQQ2V6wXtUPnO2kQPIUoA09WguDWNX0Exc+Fm/5JnHpWq7O9v1EIo9Fg==
X-Received: by 2002:a7b:c0d9:: with SMTP id s25mr5271639wmh.175.1592591143836;
        Fri, 19 Jun 2020 11:25:43 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id o15sm7588292wmm.31.2020.06.19.11.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 11:25:43 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To:     Heiner Litz <hlitz@ucsc.edu>, Keith Busch <kbusch@kernel.org>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>,
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
References: <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
 <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
 <20200619181024.GA1284046@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <61101beb-de48-7556-160f-cfd45bf72868@lightnvm.io>
Date:   Fri, 19 Jun 2020 20:25:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/06/2020 20.17, Heiner Litz wrote:
>> On Fri, Jun 19, 2020 at 11:08:26AM -0700, Heiner Litz wrote:
>>> Hi Matias,
>>> no, I am rather saying that the Linux kernel has a deficit or at least
>>> is not a good fit for ZNS because it cannot enforce in-order delivery.
>> FYI, the nvme protocol can't even enforce in-order delivery, so calling
>> out linux for this is a moot point.
> How does it work in SPDK then? I had understood that SPDK supported
> QD>1 for ZNS devices.
It doesn't. Out of order delivery is not guaranteed in NVMe.
> I am not saying that Linux is the only problem. The fact remains that
> out of order delivery is not a good fit for an interface that requires
> sequential writes.

That why zone append was introduced in ZNS. It removes this constraint, 
and makes it such that any process (or host) can write to a specific 
zone. It's neat! That is why the command was introduced.

It is not only Linux specific - it applies to everyone that wants to use 
it. It is solving a fundamental distributed system problem, as it 
removes the need for fine-grained coordinating between process or host. 
It allows the SSD to coordinate data placement, which historically has 
been done by the host. It is awesome!

>
>>> The requirement of sequential writes basically imposes this
>>> requirement. Append essentially a Linux specific fix on the ZNS level
>>> and that enforcing ordering would be a cleaner way to enable QD>1.


