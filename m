Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCD9C33CB2
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A227C20707
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgAaKYS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:24:18 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2335 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728071AbgAaKYS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 05:24:18 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 80F9BF5241C2970A8448;
        Fri, 31 Jan 2020 10:24:15 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 31 Jan 2020 10:24:15 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 10:24:14 +0000
Subject: Re: [PATCH V5 0/6] blk-mq: improvement CPU hotplug
To:     Ming Lei <tom.leiming@gmail.com>
CC:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hannes Reinecke" <hare@suse.com>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
 <929dbfac-de46-a947-6a2c-f4d8d504c631@huawei.com>
 <6dbe8c9f-af4e-3157-b6e9-6bbf43efb1e1@huawei.com>
 <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b1f67efb-585d-e0c1-460f-52be0041b37a@huawei.com>
Date:   Fri, 31 Jan 2020 10:24:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CACVXFVN8io2Pj1HZWLy=z1dbDrE3h9Q6B0DA4gdGOdK3+bRRPg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> [  141.976109] Call trace:
>> [  141.978550]  __switch_to+0xbc/0x218
>> [  141.982029]  blk_mq_run_work_fn+0x1c/0x28
>> [  141.986027]  process_one_work+0x1e0/0x358
>> [  141.990025]  worker_thread+0x40/0x488
>> [  141.993678]  kthread+0x118/0x120
>> [  141.996897]  ret_from_fork+0x10/0x18
> 
> Hi John,
> 
> Thanks for your test!
> 

Hi Ming,

> Could you test the following patchset and only the last one is changed?
> 
> https://github.com/ming1/linux/commits/my_for_5.6_block

For SCSI testing, I will ask my colleague Xiang Chen to test when he 
returns to work. So I did not see this issue for my SCSI testing for 
your original v5, but I was only using 1x as opposed to maybe 20x SAS disks.

BTW, did you test NVMe? For some reason I could not trigger a scenario 
where we're draining the outstanding requests for a queue which is being 
deactivated - I mean, the queues were always already quiesced.

Thanks,
John
