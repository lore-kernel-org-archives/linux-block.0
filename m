Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A760C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 13:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbiCON12 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348639AbiCON11 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 09:27:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07138527DB
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 06:26:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so1495062wmb.3
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BhTnxrKXxwIzOivMLyYyiocB380XwPrJVwK0V4KaKJ0=;
        b=QV/gWOCYoWrMoBJcYfpBGe54prDHlxa+0euMtD4N2+cwzyMStwoQERhwvRiXCjNdou
         BDQNGEi2IpIJos2ESa8fc3KhrAt6SbnCgfJbJbBPFotcTTDAISxVz82TwImC9DoA28rO
         gUmWlVVTs1P0cS0k/gFxhT9DfcJPG3BJJd2+fnnkDJRdQs4rm+xdXEtSF/C5vdfVhuI9
         teLUItw3WbRqgY9GSo6eRfqyfsw1QW5FgdjC7OCbN6AjR3tbdSyOIdqlgrX9ta2KVuYD
         YXFJIYuarUGv4f321aqyB5sr0Cdsq3tA5WZrC++oYVVRv5d17vv10cCpG4uB200nRzGN
         wSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BhTnxrKXxwIzOivMLyYyiocB380XwPrJVwK0V4KaKJ0=;
        b=L7NnQO9PdVuP9/Kp2vuM42Xt1cKdHa/Wkyn5gQVpJ7s7X8t4cYKJ4oHEbXdYu174gb
         ThkriN1jECEDqUbkuRZuhsnLB4Ma5we5kAV+qFn8JBKNBvqmpNWC4gstBev5I42cL+FV
         ZjBNgyl8USpwSalF2dHTY7RSlAW+mr9zem2nT2z3pbXE+HKlA+5SCmeEdQlcbfv9uono
         7lF4AlZxhtjEzLZ+yR3ZJeK31nVuwH5T3Lzh5XbCy7IbshwV1bOEa1lp7YacZa3mrBbJ
         2Yx6TEyv9tnEmeJZqRA19HrUjTIncOSPslvw8SbCxtuMPsGlkH9o3pdSwHSaR/+TxCrt
         WoJg==
X-Gm-Message-State: AOAM533nf7oKVmWClzQqxrzVeaA7Yr7LwDUwQazUg76SxKwQ8SgYg+rH
        kHmEHUhVkp7Cvn/K6t85izACQQ==
X-Google-Smtp-Source: ABdhPJyLlpiR2j3yUnnI7OzHMusJ9BT0By1PChmGXclvdmPTMhcxI1XppgjAZoQTI6LfgCyQcP08fg==
X-Received: by 2002:a1c:4e15:0:b0:387:3661:e857 with SMTP id g21-20020a1c4e15000000b003873661e857mr3314789wmh.94.1647350772502;
        Tue, 15 Mar 2022 06:26:12 -0700 (PDT)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b00389a1a68b95sm4801873wmq.27.2022.03.15.06.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 06:26:11 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:26:11 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220315132611.g5ert4tzuxgi7qd5@unifi>
References: <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15.03.2022 13:14, Matias Bjørling wrote:
>> >
>> >All that said - if there are people willing to do the work and it doesn't have a
>> negative impact on performance, code quality, maintenance complexity, etc.
>> then there isn't anything saying support can't be added - but it does seem like
>> it’s a lot of work, for little overall benefits to applications and the host users.
>>
>> Exactly.
>>
>> Patches in the block layer are trivial. This is running in production loads without
>> issues. I have tried to highlight the benefits in previous benefits and I believe
>> you understand them.
>>
>> Support for ZoneFS seems easy too. We have an early POC for btrfs and it
>> seems it can be done. We sign up for these 2.
>>
>> As for F2FS and dm-zoned, I do not think these are targets at the moment. If
>> this is the path we follow, these will bail out at mkfs time.
>>
>> If we can agree on the above, I believe we can start with the code that enables
>> the existing customers and build support for butrfs and ZoneFS in the next few
>> months.
>>
>> What do you think?
>
>I would suggest to do it in a single shot, i.e., a single patchset, which enables all the internal users in the kernel (including f2fs and others). That way end-users do not have to worry about the difference of PO2/NPO2 zones and it'll help reduce the burden on long-term maintenance.

Thanks for the suggestion Matias. Happy to see that you are open to
support this. I understand why a patchseries fixing all is attracgive,
but we do not see a usage for ZNS in F2FS, as it is a mobile
file-system. As other interfaces arrive, this work will become natural.

ZoneFS and butrfs are good targets for ZNS and these we can do. I would
still do the work in phases to make sure we have enough early feedback
from the community.

Since this thread has been very active, I will wait some time for
Christoph and others to catch up before we start sending code.

