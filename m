Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D295BC433DB
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 04:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED4A20867
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 04:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbhASEGy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 23:06:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730144AbhASEGC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 23:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611029064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06PtBYn0LQuzQkFBF6fgOmSrDr0QFcSFZEJebEBQ7c4=;
        b=jA4PUziMhQsEpNskF1qaIZFtO+TqBCNd/YlM68bR+QRB8ceVyMJ23oo59NolM9BmPREKgo
        0cAvepNROjMfKbKQ7NoA6NO5DhSxJKRYuN+xATEgh4Uun1M5Ml7XblpkRb17LiPhd2Qasb
        vvp2++kM+aq+8Z0hTYgutjQmjRUOTzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-6Quo4kc8PtKdLji77ZRl7w-1; Mon, 18 Jan 2021 23:04:22 -0500
X-MC-Unique: 6Quo4kc8PtKdLji77ZRl7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D05F10054FF;
        Tue, 19 Jan 2021 04:04:21 +0000 (UTC)
Received: from [10.72.13.139] (ovpn-13-139.pek2.redhat.com [10.72.13.139])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DEAC5D9CD;
        Tue, 19 Jan 2021 04:04:16 +0000 (UTC)
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
 <9a736867-d420-26eb-3ee2-42869a069640@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <814df55b-68cf-189c-66e3-29f02f3d6b62@redhat.com>
Date:   Tue, 19 Jan 2021 12:04:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9a736867-d420-26eb-3ee2-42869a069640@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2021/1/18 下午2:06, Joseph Qi wrote:
> Hi Jason,
>
> On 1/18/21 1:25 PM, Jason Wang wrote:
>> On 2021/1/18 上午11:58, Joseph Qi wrote:
>>> module parameter 'virtblk_queue_depth' was firstly introduced for
>>> testing/benchmarking purposes described in commit fc4324b4597c
>>> ("virtio-blk: base queue-depth on virtqueue ringsize or module param").
>>> Since we have different virtio-blk devices which have different
>>> capabilities, it requires that we support per-device queue depth instead
>>> of per-module. So defaultly use vq free elements if module parameter
>>> 'virtblk_queue_depth' is not set.
>>
>> I wonder if it's better to use sysfs instead (or whether it has already had something like this in the blocker layer).
>>
> Thanks for quick response.
> Do you mean adjust /sys/block/vdX/queue/nr_requests?
> But current logic in virtblk_probe() is, virtblk_queue_depth is
> used as a saved value for first probed vdev, not purely module
> parameter.


Right, I see. So I think the patch is fine.

Thanks


>
> Thanks,
> Joseph
>

