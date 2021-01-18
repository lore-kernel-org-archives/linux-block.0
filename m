Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6623C433E0
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 06:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18C522512
	for <linux-block@archiver.kernel.org>; Mon, 18 Jan 2021 06:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbhARGHv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 01:07:51 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46214 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732060AbhARGHu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 01:07:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UM1RH7l_1610949976;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UM1RH7l_1610949976)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Jan 2021 14:06:17 +0800
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <9a736867-d420-26eb-3ee2-42869a069640@linux.alibaba.com>
Date:   Mon, 18 Jan 2021 14:06:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jason,

On 1/18/21 1:25 PM, Jason Wang wrote:
> 
> On 2021/1/18 上午11:58, Joseph Qi wrote:
>> module parameter 'virtblk_queue_depth' was firstly introduced for
>> testing/benchmarking purposes described in commit fc4324b4597c
>> ("virtio-blk: base queue-depth on virtqueue ringsize or module param").
>> Since we have different virtio-blk devices which have different
>> capabilities, it requires that we support per-device queue depth instead
>> of per-module. So defaultly use vq free elements if module parameter
>> 'virtblk_queue_depth' is not set.
> 
> 
> I wonder if it's better to use sysfs instead (or whether it has already had something like this in the blocker layer).
> 
Thanks for quick response.
Do you mean adjust /sys/block/vdX/queue/nr_requests?
But current logic in virtblk_probe() is, virtblk_queue_depth is
used as a saved value for first probed vdev, not purely module
parameter.

Thanks,
Joseph   
