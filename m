Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3184C433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 18:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD0F120786
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 18:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHRSWU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:22:20 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgHRSWT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 14:22:19 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id F3AF752DAF59DFAAC3F4;
        Tue, 18 Aug 2020 19:22:17 +0100 (IST)
Received: from [127.0.0.1] (10.210.172.123) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Tue, 18 Aug
 2020 19:22:17 +0100
From:   John Garry <john.garry@huawei.com>
Subject: Re: [REPORT] BUG: KASAN: use-after-free in bt_iter+0x80/0xf8
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Message-ID: <a68379af-48e7-da2b-812c-ff0fa24a41bb@huawei.com>
Date:   Tue, 18 Aug 2020 19:19:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.123]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/08/2020 13:03, John Garry wrote:
> Hi guys,
> 
> JFYI, While doing some testing on v5.9-rc1, I stumbled across this:

I bisected to here (hopefully without mistake):

commit 37f4a24c2469a10a4c16c641671bd766e276cf9f
Author: Ming Lei <ming.lei@redhat.com>
Date:Tue Jun 30 22:03:57 2020 +0800

  blk-mq: centralise related handling into blk_mq_get_driver_tag

  Move .nr_active update and request assignment into 
blk_mq_get_driver_tag(),
  all are good to do during getting driver tag.

  Meantime blk-flush related code is simplified and flush request needn't
  to update the request table manually any more.

  Signed-off-by: Ming Lei <ming.lei@redhat.com>
  Cc: Christoph Hellwig <hch@infradead.org>
  Signed-off-by: Jens Axboe <axboe@kernel.dk>


I'll verify that tomorrow. I see that there is a fix for that patch 
included in v5.9-rc1. Bisect log below:

git bisect start
# bad: [9123e3a74ec7b934a4a099e98af6a61c2f80bbf5] Linux 5.9-rc1
git bisect bad 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
# good: [bcf876870b95592b52519ed4aafcf9d95999bc9c] Linux 5.8
git bisect good bcf876870b95592b52519ed4aafcf9d95999bc9c
# good: [bcf876870b95592b52519ed4aafcf9d95999bc9c] Linux 5.8
git bisect good bcf876870b95592b52519ed4aafcf9d95999bc9c
# bad: [8186749621ed6b8fc42644c399e8c755a2b6f630] Merge tag 
'drm-next-2020-08-06' of git://anongit.freedesktop.org/drm/drm
git bisect bad 8186749621ed6b8fc42644c399e8c755a2b6f630
# bad: [2324d50d051ec0f14a548e78554fb02513d6dcef] Merge tag 'docs-5.9' 
of git://git.lwn.net/linux
git bisect bad 2324d50d051ec0f14a548e78554fb02513d6dcef
# bad: [92c59e126b21fd212195358a0d296e787e444087] Merge tag 
'arm-defconfig-5.9' of 
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad 92c59e126b21fd212195358a0d296e787e444087
# bad: [cdc8fcb49905c0b67e355e027cb462ee168ffaa3] Merge tag 
'for-5.9/io_uring-20200802' of git://git.kernel.dk/linux-block
git bisect bad cdc8fcb49905c0b67e355e027cb462ee168ffaa3
# good: [ab5c60b79ab6cc50b39bbb21b2f9fb55af900b84] Merge branch 'linus' 
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect good ab5c60b79ab6cc50b39bbb21b2f9fb55af900b84
# bad: [d958e343bdc3de2643ce25225bed082dc222858d] block: blk-timeout: 
delete duplicated word
git bisect bad d958e343bdc3de2643ce25225bed082dc222858d
# bad: [53042f3cc411adc79811ba3cfbca5d7a42a7b806] ps3vram: stop using 
->queuedata
git bisect bad 53042f3cc411adc79811ba3cfbca5d7a42a7b806
# good: [621c1f42945e76015c3a585e7a9fe6e71665eba0] block: move struct 
block_device to blk_types.h
git bisect good 621c1f42945e76015c3a585e7a9fe6e71665eba0
# good: [36a3df5a4574d5ddf59804fcd0c4e9654c514d9a] blk-mq: put driver 
tag when this request is completed
git bisect good 36a3df5a4574d5ddf59804fcd0c4e9654c514d9a
# good: [570e9b73b0af2e5381ca5343759779b8c1ed20e3] blk-mq: move 
blk_mq_get_driver_tag into blk-mq.c
git bisect good 570e9b73b0af2e5381ca5343759779b8c1ed20e3
# bad: [b5fc1e8bedf8ad2c6381e0df6331ad5686aca425] blk-mq: remove 
pointless call of list_entry_rq() in hctx_show_busy_rq()
git bisect bad b5fc1e8bedf8ad2c6381e0df6331ad5686aca425
# bad: [37f4a24c2469a10a4c16c641671bd766e276cf9f] blk-mq: centralise 
related handling into blk_mq_get_driver_tag
git bisect bad 37f4a24c2469a10a4c16c641671bd766e276cf9f
# good: [723bf178f158abd1ce6069cb049581b3cb003aab] blk-mq: move 
blk_mq_put_driver_tag() into blk-mq.c
git bisect good 723bf178f158abd1ce6069cb049581b3cb003aab
# first bad commit: [37f4a24c2469a10a4c16c641671bd766e276cf9f] blk-mq: 
centralise related handling into blk_mq_get_driver_tag

BTW, only need to change scheduler and not change nr_requests to trigger 
this.

Thanks,
John
