Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8111EC54EE9
	for <linux-block@archiver.kernel.org>; Tue, 13 Sep 2022 14:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiIMOUM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Sep 2022 10:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbiIMOSx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2022 10:18:53 -0400
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1275B27FC2
        for <linux-block@vger.kernel.org>; Tue, 13 Sep 2022 07:13:31 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd7cb4.dip0.t-ipconnect.de [93.221.124.180])
        by mail.itouring.de (Postfix) with ESMTPSA id 870F3103762;
        Tue, 13 Sep 2022 16:12:13 +0200 (CEST)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 2F256F01609;
        Tue, 13 Sep 2022 16:12:13 +0200 (CEST)
Subject: Re: wbt_lat_usec still set despite wbt disabled by BFQ
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        linux-block <linux-block@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <a5041479-f417-2b95-b645-56e665a7e557@applied-asynchrony.com>
 <17e0e889-e848-0bd3-3203-cb4e9b801462@huaweicloud.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <f731dab6-7f55-42d1-53fd-b656d75e5620@applied-asynchrony.com>
Date:   Tue, 13 Sep 2022 16:12:13 +0200
MIME-Version: 1.0
In-Reply-To: <17e0e889-e848-0bd3-3203-cb4e9b801462@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022-09-13 15:39, Yu Kuai wrote:
> Hi, Holger
> 
> 在 2022/08/18 1:12, Holger Hoffstätte 写道:
>>
>> I just noticed that my device configured with BFQ still shows wbt_lat_usec
>> as configured, despite the fact that BFQ disables WBT in bfq_init_queue [1]:
>>
>> $cat /sys/block/sdc/queue/scheduler
>> mq-deadline [bfq] none
>> $cat /sys/block/sdc/queue/wbt_lat_usec
>> 75000
>>
>> Is this supposed to be 0 (since it's disabled) or is sysfs confused?
>>
>> Thanks,
>> Holger
> 
> I'm reviewing wbt codes recently, and I found that this problem will
> happen if the default elevator is bfq. I'll try to fix this, do you mind
> if I add reported-by tag?

Do not mind at all - thank you for looking into it!
Let me know if I can test a patch or help in some other way.

Btw not sure what "default scheduler" means here, I set my schedulers via
udev rules. In this case:

ACTION=="add", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"

cheers
Holger
