Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5541EC433E2
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 18:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A2D20855
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 18:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OXbHXnd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKSpz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgIKSpw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 14:45:52 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F86C061573
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 11:45:52 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d190so12142855iof.3
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xyQ7zrDADsTXTn2G9ynbikp72rRDgB7MUq83lLFTFQc=;
        b=OXbHXnd4qKFws/nWdgIV0rv+tUIeDRV5lf731S4EVMivAPrhYsBgoOnhNc1wWxCvxW
         wj9OIEazSlzsY9CJuqMdpmwQL3VWTPsXMNbfv6wOCTmYopbFmu5C/FhMBMxUEiDIUYAc
         m/u6FtMLQKkCsQJYW+zqzH6i0kBtQHY3MQR4TdDCkBGWl2fsQvv6SORsJ3NuEz9wXrhM
         MAgi38a5MvoQXD1TKSwascFAeweJaHbfZcombE3qnozjUoL3qXBohZXnxdCtg6xqJiUf
         BsczppLa6JoVPO7KtdWzbejGmn3YYEPpkwJctoumVXNzJE+Gx6/9Id6aCVweCXNol7HZ
         yKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xyQ7zrDADsTXTn2G9ynbikp72rRDgB7MUq83lLFTFQc=;
        b=f45fGh9Xd7466xzOzb6XhG8xFbnbJCfwKrGSPNy3zv6NueJzNEYDXHjtlKXDw8WyY1
         37RKM/Np18VgQuINRObqWg6UA/ltKG46celhsSC88STmTyJ9P9E66LL/I35VUn3PJJZV
         31m4EF/LNQgtCNx3/R1HQEW9cGEHScm7utnZ1qz5P+cDVEIM/12/WWBnqmGufLgBBJR+
         xkaAR7Fyg8Mps6Y2mnHhq6s+EWEgq2/UtjANr0kPmR9ZcONQcsKJb9wdBMlQgCmjmhpY
         w7mkj+myJs3eZvdV7/r+ayS+VVVNUbF7SBZlCEulGq6S0ON+ToGI5TL+gAoiNrVFUQqm
         wNdw==
X-Gm-Message-State: AOAM530tIeuiPumxBpANh9xPp0piiAbMtcq5TaPLcgAoKA6NUb/55cHG
        z2PK7RFL1KMM2nRy4xKRFsMzYg==
X-Google-Smtp-Source: ABdhPJzXO49c4GwGv9VXTp1j3gA7hErb4TCnTKvXuvwYnI1tL1rPTPPLXPYI0Y8uJWVTgOiWw1WAcw==
X-Received: by 2002:a6b:ba89:: with SMTP id k131mr2840584iof.141.1599849951525;
        Fri, 11 Sep 2020 11:45:51 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z4sm1484794iol.52.2020.09.11.11.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 11:45:50 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
References: <20200911024117.62480-1-ming.lei@redhat.com>
 <4fb604fd-c081-5eb1-cb3a-860746b6952a@grimberg.me>
 <09d5cb96-b442-6965-96b3-d884c95a3ca7@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bbce9d82-2a59-7918-ec27-2b1bea4e015d@kernel.dk>
Date:   Fri, 11 Sep 2020 12:45:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <09d5cb96-b442-6965-96b3-d884c95a3ca7@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/11/20 12:34 PM, Sagi Grimberg wrote:
> 
>>> Hi Jens,
>>>
>>> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
>>> and prepares for replacing srcu with percpu_ref.
>>>
>>> The 2nd patch replaces srcu with percpu_ref.
>>>
>>> The 3rd patch adds tagset quiesce interface.
>>>
>>> The 4th patch applies tagset quiesce interface for NVMe subsystem.
>>
>> Tested some reset storms and target restarts during traffic with
>> nvme-tcp.
>>
>> Seems that no apparent breakage.
>>
>> So:
>>
>> Tested-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Probably unrelated to this patches, but I do see new
> kmemleak complaints in the form of:
> --
> unreferenced object 0xffff9440dbf3c240 (size 64):
>    comm "systemd", pid 1, jiffies 4306444056 (age 25034.440s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 b0 fe 13 99 ff ff ff ff  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000f1d0b20e>] percpu_ref_init+0x5f/0xf0
>      [<000000009598103f>] cgroup_mkdir+0xe9/0x440
>      [<0000000001b93c19>] kernfs_iop_mkdir+0x57/0x80
>      [<000000001ed0f985>] vfs_mkdir+0x10e/0x1d0
>      [<00000000cac65f7e>] do_mkdirat+0xec/0x120
>      [<00000000956db630>] do_syscall_64+0x33/0x80
>      [<000000001c2b0e1a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Looks more related to the percpu_ref changes that allocate it
dynamically, causing issues on cases that forget to exit the ref.

-- 
Jens Axboe

