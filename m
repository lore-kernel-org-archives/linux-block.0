Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0FCC433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 14:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CE7207D8
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 14:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgFDOMz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:12:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2278 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728496AbgFDOMz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jun 2020 10:12:55 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id CD43950DD02F9FDC527A;
        Thu,  4 Jun 2020 15:12:53 +0100 (IST)
Received: from [127.0.0.1] (10.210.172.107) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 4 Jun 2020
 15:12:52 +0100
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
To:     Ming Lei <ming.lei@redhat.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de> <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590>
 <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
 <20200604120747.GB2336493@T590>
 <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
 <20200604130058.GC2336493@T590>
From:   John Garry <john.garry@huawei.com>
Message-ID: <83c37a8f-abfa-c1d1-e9d6-ccfdd344edb3@huawei.com>
Date:   Thu, 4 Jun 2020 15:11:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200604130058.GC2336493@T590>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.107]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> 
> It isn't related with request->tag, what I meant is that you use
> out-of-tree patch to enable multiple hw queue on hisi_sas, you have
> to make the queue mapping correct, that said the exact queue mapping
> from blk-mq's mapping has to be used, which is built from managed
> interrupt affinity.
> 
> Please collect the following log:
> 
> 1) ./dump-io-irq-affinity $PCI_ID_OF_HBA
> http://people.redhat.com/minlei/tests/tools/dump-io-irq-affinity
> 

I had to hack this a bit for SAS HBA:

kernel version:
Linux ubuntu 5.7.0-next-20200603-16498-gbfbfcda762d5 #405 SMP PREEMPT 
Thu Jun 4 14:19:49 BST 2020 aarch64 aarch64 aarch64 GNU/Linux
-e 	irq 137, cpu list 16-19, effective list 16
-e 	irq 138, cpu list 20-23, effective list 20
-e 	irq 139, cpu list 24-27, effective list 24
-e 	irq 140, cpu list 28-31, effective list 28
-e 	irq 141, cpu list 32-35, effective list 32
-e 	irq 142, cpu list 36-39, effective list 36
-e 	irq 143, cpu list 40-43, effective list 40
-e 	irq 144, cpu list 44-47, effective list 44
-e 	irq 145, cpu list 48-51, effective list 48
-e 	irq 146, cpu list 52-55, effective list 52
-e 	irq 147, cpu list 56-59, effective list 56
-e 	irq 148, cpu list 60-63, effective list 60
-e 	irq 149, cpu list 0-3, effective list 0
-e 	irq 150, cpu list 4-7, effective list 4
-e 	irq 151, cpu list 8-11, effective list 8
-e 	irq 152, cpu list 12-15, effective list 12

> 2) ./dump-qmap /dev/sdN
> http://people.redhat.com/minlei/tests/tools/dump-qmap


queue mapping for /dev/sda
	hctx0: default 16 17 18 19
	hctx1: default 20 21 22 23
	hctx2: default 24 25 26 27
	hctx3: default 28 29 30 31
	hctx4: default 32 33 34 35
	hctx5: default 36 37 38 39
	hctx6: default 40 41 42 43
	hctx7: default 44 45 46 47
	hctx8: default 48 49 50 51
	hctx9: default 52 53 54 55
	hctx10: default 56 57 58 59
	hctx11: default 60 61 62 63
	hctx12: default 0 1 2 3
	hctx13: default 4 5 6 7
	hctx14: default 8 9 10 11
	hctx15: default 12 13 14 15
queue mapping for /dev/sdb
	hctx0: default 16 17 18 19
	hctx1: default 20 21 22 23
	hctx2: default 24 25 26 27
	hctx3: default 28 29 30 31
	hctx4: default 32 33 34 35
	hctx5: default 36 37 38 39
	hctx6: default 40 41 42 43
	hctx7: default 44 45 46 47
	hctx8: default 48 49 50 51
	hctx9: default 52 53 54 55
	hctx10: default 56 57 58 59
	hctx11: default 60 61 62 63
	hctx12: default 0 1 2 3
	hctx13: default 4 5 6 7
	hctx14: default 8 9 10 11
	hctx15: default 12 13 14 15
queue mapping for /dev/sdc
	hctx0: default 16 17 18 19
	hctx1: default 20 21 22 23
	hctx2: default 24 25 26 27
	hctx3: default 28 29 30 31
	hctx4: default 32 33 34 35
	hctx5: default 36 37 38 39
	hctx6: default 40 41 42 43
	hctx7: default 44 45 46 47
	hctx8: default 48 49 50 51
	hctx9: default 52 53 54 55
	hctx10: default 56 57 58 59
	hctx11: default 60 61 62 63
	hctx12: default 0 1 2 3
	hctx13: default 4 5 6 7
	hctx14: default 8 9 10 11
	hctx15: default 12 13 14 15
queue mapping for /dev/sdd
	hctx0: default 16 17 18 19
	hctx1: default 20 21 22 23
	hctx2: default 24 25 26 27
	hctx3: default 28 29 30 31
	hctx4: default 32 33 34 35
	hctx5: default 36 37 38 39
	hctx6: default 40 41 42 43
	hctx7: default 44 45 46 47
	hctx8: default 48 49 50 51
	hctx9: default 52 53 54 55
	hctx10: default 56 57 58 59
	hctx11: default 60 61 62 63
	hctx12: default 0 1 2 3
	hctx13: default 4 5 6 7
	hctx14: default 8 9 10 11
	hctx15: default 12 13 14 15
queue mapping for /dev/sde
	hctx0: default 16 17 18 19
	hctx1: default 20 21 22 23
	hctx2: default 24 25 26 27
	hctx3: default 28 29 30 31
	hctx4: default 32 33 34 35
	hctx5: default 36 37 38 39
	hctx6: default 40 41 42 43
	hctx7: default 44 45 46 47
	hctx8: default 48 49 50 51
	hctx9: default 52 53 54 55
	hctx10: default 56 57 58 59
	hctx11: default 60 61 62 63
	hctx12: default 0 1 2 3
	hctx13: default 4 5 6 7
	hctx14: default 8 9 10 11
	hctx15: default 12 13 14 15
queue mapping for /dev/sdf
	hctx0: default 16 17 18 19
	hctx1: default 20 21 22 23
	hctx2: default 24 25 26 27
	hctx3: default 28 29 30 31
	hctx4: default 32 33 34 35
	hctx5: default 36 37 38 39
	hctx6: default 40 41 42 43
	hctx7: default 44 45 46 47
	hctx8: default 48 49 50 51
	hctx9: default 52 53 54 55
	hctx10: default 56 57 58 59
	hctx11: default 60 61 62 63
	hctx12: default 0 1 2 3
	hctx13: default 4 5 6 7
	hctx14: default 8 9 10 11
	hctx15: default 12 13 14 15
queue mapping for /dev/sdg
	hctx0: default 16 17 18 19
	hctx1: default 20 21 22 23
	hctx2: default 24 25 26 27
	hctx3: default 28 29 30 31
	hctx4: default 32 33 34 35
	hctx5: default 36 37 38 39
	hctx6: default 40 41 42 43
	hctx7: default 44 45 46 47
	hctx8: default 48 49 50 51
	hctx9: default 52 53 54 55
	hctx10: default 56 57 58 59
	hctx11: default 60 61 62 63
	hctx12: default 0 1 2 3
	hctx13: default 4 5 6 7
	hctx14: default 8 9 10 11
	hctx15: default 12 13 14 15
queue mapping for /dev/sdh
	hctx0: default 16 17 18 19
	hctx1: default 20 21 22 23
	hctx2: default 24 25 26 27
	hctx3: default 28 29 30 31
	hctx4: default 32 33 34 35
	hctx5: default 36 37 38 39
	hctx6: default 40 41 42 43
	hctx7: default 44 45 46 47
	hctx8: default 48 49 50 51
	hctx9: default 52 53 54 55
	hctx10: default 56 57 58 59
	hctx11: default 60 61 62 63
	hctx12: default 0 1 2 3
	hctx13: default 4 5 6 7
	hctx14: default 8 9 10 11
	hctx15: default 12 13 14 15

> 
> 
>>
>>   and suggest you to double check
>>> hisi_sas's queue mapping which has to be exactly same with blk-mq's
>>> mapping.
>>>
>>
>> scheduler=none is ok, so I am skeptical of a problem there.
>>
>>>>
>>>>>
>>>>> If yes, can you collect debugfs log after the timeout is triggered?
>>>>
>>>> Same limitation as before - once SCSI timeout happens, SCSI error handling
>>>> kicks in and the shost no longer accepts commands, and, since that same
>>>> shost provides rootfs, becomes unresponsive. But I can try.
>>>
>>> Just wondering why not install two disks in your test machine, :-)
>>
>> The shost becomes unresponsive for all disks. So I could try nfs, but I'm
>> not a fan :)
> 
> Then it will take you extra effort in collecting log, and NFS root
> should have been quite easy to setup, :-)
> 

Should be ...

 >> No, but the LLDD does not use request->tag - it generates its own.
 >
 > Except for wrong queue mapping,  another reason is that the generated
 > tag may not
 > be unique. Either of two may cause such timeout issue when the managed
 > interrupt is
 > active.
 >

Right, but the tag should be unique - it needs to be in the LLDD.

Anyway, I'll continue to debug.

BTW, I'm using linux-next 0306 as baseline. I don't like using next, but 
Linus' master branch yesterday was crashing while booting for me. I need 
to check that again for where master is now.

Thanks

