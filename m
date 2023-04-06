Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3730C77B6C
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 22:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjDFW3t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 18:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjDFW3r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 18:29:47 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1BD8A7D
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 15:29:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-242cb01a788so357102a91.1
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 15:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680820186; x=1683412186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7k4qsFqiHaAzNp6afujXpgmsXu2FPMDvZlLtZE20tc4=;
        b=1y4uhP9vs2w603pMlq/oT5QHMF+3601WSDLcMR0D0p5ucvKWV5W9ltQHO+vzcccDcb
         Mv7gaJO/9eNxKNzE85QCG+3tYiTxdLOrHbtJ91h4fKrPZMlYFBDTN5EUKdQBOoq70Wyz
         USEXLDfHilRgWN1P+9DDPgA+Ynp5i89CS7nyjO0C/CsXJNMiiDVbWQzGSKMuZoaLyPo/
         FKABeF/ywAFSgZmHct5AbaxeShHCVxXewaaSFQ5sdHb8kyiw2Jk6Do9a8fg5kY96Li2a
         Io9111MNXsldf+UePoNHDy5t5xmU54/Kp3PBsdGrjy/CmCF3aPOjhe8slqkrjd1yScOq
         DgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680820186; x=1683412186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7k4qsFqiHaAzNp6afujXpgmsXu2FPMDvZlLtZE20tc4=;
        b=sR7l2XB3bgKIM6AP/usiWKjvAQOJTYIOC0QyQAZdI8jCXds5cCKVbRo8/3zBXb1gwP
         HWAH0YpmSzur+bvS8y5T4nFhIzBFGZvkSaneWAEXxNZjYQ0EqHyO7ilfryZphBtkxld7
         3VjCxS6BWs0bRxXbOUdBi+h8dcsA9Y/AurFwwvAvzJadwjqSJBGth6cWSYq6CpxBU/s0
         qaFinSOjCtAJHYXsNZ75AwdHKqqnNgil7FupNLWHmMt7iAoX5WTTc0XouLRzUqb9hxnT
         s83fMuBpqrlbk1fEoxpKrTmNesHG+tBmFAkudVYEcrsKXOG0Oya9Ks1sr/hwFFXCLvbN
         6OAQ==
X-Gm-Message-State: AAQBX9dmWy/OS3Bz9lSFW9jhuqg3cpVAaTve/G9Tm+85HCh2o4OBb11H
        0bjX7MopoSXwuBWzQTqIc9nVqg==
X-Google-Smtp-Source: AKy350bN+48xlZ2wTnEU3QC1ywsQFykc+qHdijNBklHvZGPnhieRd9+bURJ8OZdfBNF65SQ1jcC2RQ==
X-Received: by 2002:a17:90a:e386:b0:240:cf04:c997 with SMTP id b6-20020a17090ae38600b00240cf04c997mr159190pjz.2.1680820185747;
        Thu, 06 Apr 2023 15:29:45 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ji2-20020a170903324200b001a21a593008sm1807328plb.306.2023.04.06.15.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 15:29:45 -0700 (PDT)
Message-ID: <b3817e92-80ca-8eea-ebdd-f2172f3390c8@kernel.dk>
Date:   Thu, 6 Apr 2023 16:29:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] block: don't set GD_NEED_PART_SCAN if scan partition
 failed
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
        jack@suse.cz, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <ZBmYcuVzpDDTiaP+@ovpn-8-18.pek2.redhat.com>
 <20230322035926.1791317-1-yukuai1@huaweicloud.com>
 <42cfedca-f233-4d7e-f43b-4b5dd0c97e9e@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <42cfedca-f233-4d7e-f43b-4b5dd0c97e9e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/23 9:42 PM, Yu Kuai wrote:
> Hi, Jens!
> 
> 在 2023/03/22 11:59, Yu Kuai 写道:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently if disk_scan_partitions() failed, GD_NEED_PART_SCAN will still
>> set, and partition scan will be proceed again when blkdev_get_by_dev()
>> is called. However, this will cause a problem that re-assemble partitioned
>> raid device will creat partition for underlying disk.
>>
>> Test procedure:
>>
>> mdadm -CR /dev/md0 -l 1 -n 2 /dev/sda /dev/sdb -e 1.0
>> sgdisk -n 0:0:+100MiB /dev/md0
>> blockdev --rereadpt /dev/sda
>> blockdev --rereadpt /dev/sdb
>> mdadm -S /dev/md0
>> mdadm -A /dev/md0 /dev/sda /dev/sdb
>>
>> Test result: underlying disk partition and raid partition can be
>> observed at the same time
>>
>> Note that this can still happen in come corner cases that
>> GD_NEED_PART_SCAN can be set for underlying disk while re-assemble raid
>> device.
>>
> 
> Can you apply this patch?

None of them apply to my for-6.4/block branch...

-- 
Jens Axboe


