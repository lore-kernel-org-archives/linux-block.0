Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F304C433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 22:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA5164DBA
	for <linux-block@archiver.kernel.org>; Wed, 10 Feb 2021 22:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhBJWHZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Feb 2021 17:07:25 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:46870 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhBJWHQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Feb 2021 17:07:16 -0500
Received: by mail-pl1-f178.google.com with SMTP id u11so1976092plg.13
        for <linux-block@vger.kernel.org>; Wed, 10 Feb 2021 14:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9/1yz6Sj+nYzo9QwRx9drCzv7Ae9nz8CKKb4s5zl1oY=;
        b=M7DWWtTNJAkAb6XSY2zcC+csv7wl5oCVONQ12HVW1y4XkMY4WH7K+p0X7KBx7Bby+8
         hVZI92NK2by1C8G3TI4qDhg48532qkHvqBlvwNVeT6PifRtSKLfQIF9I5sVwZJskutUW
         C1Bh9fvsj8qIP79/OzVJHcIfLZ29lvabPK+Ps6TGD4xKWxQ4Hd7ZuV+j/NOa0KC3BisZ
         Ikodw6mjsnGKNsWjF5FOYkfBCPiY9YYB0wSYWbCVFS768UsFdqYYXEq6S5xD4ZuTJQGV
         cAJpF5iJWD/8segZG2K0ff8BGOOpAxE0xrWDTUrcSddBf8CXdqpjG2Qmz28dV/q7n05/
         2cHA==
X-Gm-Message-State: AOAM531TuxWzlaaQRjcJAqCguM6hrzxxvjBAq2gzmq1SnvEOO3hsETuV
        HoG60fIWpy6xWyrY+Azhl+o=
X-Google-Smtp-Source: ABdhPJzDqxibWtlOB1Zf6iGCyu2PvpDL8llJIbwLF1crP/c64SHaCgt4cMW01Ev5LGy2lrup5OrqAg==
X-Received: by 2002:a17:90a:4548:: with SMTP id r8mr1031910pjm.16.1612994793688;
        Wed, 10 Feb 2021 14:06:33 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:d52b:e830:d3b2:ec6f? ([2601:647:4802:9070:d52b:e830:d3b2:ec6f])
        by smtp.gmail.com with ESMTPSA id h10sm1287682pfq.97.2021.02.10.14.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 14:06:32 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
 <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
 <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
 <1a520912-ac7c-1a3c-c432-b382a5da6177@redhat.com>
 <BYAPR04MB49652279710E99EBB6F8AC67868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <502e8d85-90cf-9533-0f83-364bee2fd34b@grimberg.me>
Date:   Wed, 10 Feb 2021 14:06:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49652279710E99EBB6F8AC67868D9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> So it's nvme_admin_abort_cmd here
>>
>> [   74.017450] run blktests nvme/012 at 2021-02-09 21:41:55
>> [   74.111311] loop: module loaded
>> [   74.125717] loop0: detected capacity change from 2097152 to 0
>> [   74.141026] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>> [   74.149395] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>> [   74.158298] nvmet: creating controller 1 for subsystem
>> blktests-subsystem-1 for NQN
>> nqn.2014-08.org.nvmexpress:uuid:41131d88-02ca-4ccc-87b3-6ca3f28b13a4.
>> [   74.158742] nvme nvme0: creating 48 I/O queues.
>> [   74.163391] nvme nvme0: mapped 48/0/0 default/read/poll queues.
>> [   74.184623] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
>> 127.0.0.1:4420
>> [   75.235059] nvme_tcp: rq 38 opcode 8
>> [   75.238653] blk_update_request: I/O error, dev nvme0c0n1, sector
>> 1048624 op 0x9:(WRITE_ZEROES) flags 0x2800800 phys_seg 0 prio class 0
>> [   75.380179] XFS (nvme0n1): Mounting V5 Filesystem
>> [   75.387457] XFS (nvme0n1): Ending clean mount
>> [   75.388555] xfs filesystem being mounted at /mnt/blktests supports
>> timestamps until 2038 (0x7fffffff)
>> [   91.035659] XFS (nvme0n1): Unmounting Filesystem
>> [   91.043334] nvme nvme0: Removing ctrl: NQN "blktests-subsystem-1"
> 
> But write-zeores is also data less command and should not fail.

And it has a bio, which means that nvme-tcp tries to init an iter
for it when it shouldn't. So the actual offending commit is:
cb9b870fba3e, which cleaned up how the iter is initialized but 
introduced this issue.
