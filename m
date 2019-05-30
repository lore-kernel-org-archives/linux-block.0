Return-Path: <SRS0=WD2t=T6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79190C28CC0
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 01:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4534D242DA
	for <linux-block@archiver.kernel.org>; Thu, 30 May 2019 01:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfE3BWl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 21:22:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfE3BWl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 21:22:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 463B8C004BEB;
        Thu, 30 May 2019 01:22:41 +0000 (UTC)
Received: from [10.72.12.96] (ovpn-12-96.pek2.redhat.com [10.72.12.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE5A11001E80;
        Thu, 30 May 2019 01:22:38 +0000 (UTC)
Subject: Re: [RFC PATCH] nbd: set the default nbds_max to 0
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, nbd@other.debian.org, mchristi@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        atumball@redhat.com
References: <20190529080836.13031-1-xiubli@redhat.com>
 <20190529134834.t6qjq2nkut37zpsf@MacBook-Pro-91.local>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <63658620-7d1f-f626-b637-8f551ca07f95@redhat.com>
Date:   Thu, 30 May 2019 09:22:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529134834.t6qjq2nkut37zpsf@MacBook-Pro-91.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 30 May 2019 01:22:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/5/29 21:48, Josef Bacik wrote:
> On Wed, May 29, 2019 at 04:08:36PM +0800, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> There is one problem that when trying to check the nbd device
>> NBD_CMD_STATUS and at the same time insert the nbd.ko module,
>> we can randomly get some of the 16 /dev/nbd{0~15} are connected,
>> but they are not. This is because that the udev service in user
>> space will try to open /dev/nbd{0~15} devices to do some sanity
>> check when they are added in "__init nbd_init()" and then close
>> it asynchronousely.
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>
>> Not sure whether this patch make sense here, coz this issue can be
>> avoided by setting the "nbds_max=0" when inserting the nbd.ko modules.
>>
> Yeah I'd rather not make this the default, as of right now most people still
> probably use the old method of configuration and it may surprise them to
> suddenly have to do nbds_max=16 to make their stuff work.  Thanks,

Sure, make sense to me :-)

So this patch here in the mail list will as one note and reminder to 
other who may hit the same issue in future.

Thanks.
BRs
Xiubo


> Josef
>

