Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B45C433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 14:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47CCE207C4
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 14:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgETOgp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 10:36:45 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726443AbgETOgp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 10:36:45 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 792C887BBEDE40A15C6B;
        Wed, 20 May 2020 15:36:43 +0100 (IST)
Received: from [127.0.0.1] (10.210.167.247) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 20 May
 2020 15:36:42 +0100
Subject: Re: blk-mq: improvement CPU hotplug (simplified version) v2
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20200518063937.757218-1-hch@lst.de>
 <6241656e-0bf7-b32d-493e-e3f870a4d031@huawei.com>
 <20200519153034.GC22286@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <28e4b835-14d8-a82c-24e8-a895b645484a@huawei.com>
Date:   Wed, 20 May 2020 15:35:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200519153034.GC22286@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.247]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/05/2020 16:30, Christoph Hellwig wrote:
> On Mon, May 18, 2020 at 12:49:14PM +0100, John Garry wrote:
>>> A git tree is available here:
>>>
>>>       git://git.infradead.org/users/hch/block.git blk-mq-hotplug
>>>
>>> Gitweb:
>>>
>>>       http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug
>>> .
>>>
>>
>> FWIW, I tested this series for cpu hotplug and it looked ok.
> 
> Can you also test the blk-mq-hotplug.2 branch?
> .
> 

Yeah, it looks ok. No timeouts for CPU hotplug.

Cheers,
John
