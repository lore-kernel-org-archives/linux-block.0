Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48760C10F14
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 00:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB4F21920
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 00:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfJKAje (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:39:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbfJKAje (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 20:39:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 274492CD7E5;
        Fri, 11 Oct 2019 00:39:34 +0000 (UTC)
Received: from [10.72.12.80] (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06F215C6CE;
        Fri, 11 Oct 2019 00:39:29 +0000 (UTC)
Subject: Re: [PATCH] nbd: fix possible sysfs duplicate warning
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     axboe@kernel.dk, mchristi@redhat.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
References: <20190919061427.3990-1-xiubli@redhat.com>
 <20191010135654.lvdawtrzk7df6id3@macbook-pro-91.dhcp.thefacebook.com>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <d6a76e7f-0e98-ffaa-6543-9684719cc257@redhat.com>
Date:   Fri, 11 Oct 2019 08:39:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010135654.lvdawtrzk7df6id3@macbook-pro-91.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 11 Oct 2019 00:39:34 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/10/10 21:56, Josef Bacik wrote:
> On Thu, Sep 19, 2019 at 11:44:27AM +0530, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> 1. nbd_put takes the mutex and drops nbd->ref to 0. It then does
>> idr_remove and drops the mutex.
>>
>> 2. nbd_genl_connect takes the mutex. idr_find/idr_for_each fails
>> to find an existing device, so it does nbd_dev_add.
>>
>> 3. just before the nbd_put could call nbd_dev_remove or not finished
>> totally, but if nbd_dev_add try to add_disk, we can hit:
>>
>> debugfs: Directory 'nbd1' with parent 'block' already present!
>>
>> This patch will make sure all the disk add/remove stuff are done
>> by holding the nbd_index_mutex lock.
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> Reported-by: Mike Christie <mchristi@redhat.com>
> Sorry, don't know how I missed this.

Many thanks.

Xiubo

> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef


