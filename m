Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69885C4332B
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 14:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DCC2074D
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 14:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgCWOLD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:11:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728542AbgCWOLD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 10:11:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D609D158747E4ECA8909;
        Mon, 23 Mar 2020 22:11:00 +0800 (CST)
Received: from [10.173.220.74] (10.173.220.74) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 23 Mar 2020 22:10:57 +0800
Subject: Re: [PATCH v3 4/4] bdi: protect bdi->dev with spinlock
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <tj@kernel.org>,
        <jack@suse.cz>, <bvanassche@acm.org>, <tytso@mit.edu>
References: <20200323132254.47157-1-yuyufen@huawei.com>
 <20200323132254.47157-5-yuyufen@huawei.com> <20200323140421.GA7976@kroah.com>
From:   Yufen Yu <yuyufen@huawei.com>
Message-ID: <7ce0918c-aa5d-2542-f74a-39e95762d4b3@huawei.com>
Date:   Mon, 23 Mar 2020 22:10:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200323140421.GA7976@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.74]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/3/23 22:04, Greg KH wrote:
> On Mon, Mar 23, 2020 at 09:22:54PM +0800, Yufen Yu wrote:
>> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
>> index 82d2401fec37..1c0e2d0d6236 100644
>> --- a/include/linux/backing-dev.h
>> +++ b/include/linux/backing-dev.h
>> @@ -525,12 +525,16 @@ static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
>>   static inline char *bdi_get_dev_name(struct backing_dev_info *bdi,
>>   			char *dname, int len)
>>   {
>> +	spin_lock_irq(&bdi->lock);
>>   	if (!bdi || !bdi->dev) {
>> +		spin_unlock_irq(&bdi->lock);
> 
> You can't test for (!bdi) right after you accessed bdi->lock :(

Sorry for this coding error.

Thanks,
Yufen
