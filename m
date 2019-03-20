Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35F7C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 12:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E70C2075C
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 12:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfCTMxv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:53:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727661AbfCTMxv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 08:53:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E75E230820DD;
        Wed, 20 Mar 2019 12:53:50 +0000 (UTC)
Received: from [10.72.12.117] (ovpn-12-117.pek2.redhat.com [10.72.12.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25D3F60606;
        Wed, 20 Mar 2019 12:53:37 +0000 (UTC)
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
 <20190312183351.74764f4f.cohuck@redhat.com>
 <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
 <20190313103900.1ea7f996.cohuck@redhat.com>
 <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
 <537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
 <20190315134112.7d63348c.cohuck@redhat.com>
 <1df52766-88fb-6b23-d160-b891c3017133@redhat.com>
 <0fbdcfa6-cbd7-4f09-93b1-40898d5f77d1@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f92a5ef9-04b9-d6fa-a7f8-c855a87cd0fb@redhat.com>
Date:   Wed, 20 Mar 2019 20:53:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <0fbdcfa6-cbd7-4f09-93b1-40898d5f77d1@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 20 Mar 2019 12:53:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2019/3/19 上午10:22, Dongli Zhang wrote:
> Hi Jason,
>
> On 3/18/19 3:47 PM, Jason Wang wrote:
>> On 2019/3/15 下午8:41, Cornelia Huck wrote:
>>> On Fri, 15 Mar 2019 12:50:11 +0800
>>> Jason Wang <jasowang@redhat.com> wrote:
>>>
>>>> Or something like I proposed several years ago?
>>>> https://do-db2.lkml.org/lkml/2014/12/25/169
>>>>
>>>> Btw, for virtio-net, I think we actually want to go for having a maximum
>>>> number of supported queues like what hardware did. This would be useful
>>>> for e.g cpu hotplug or XDP (requires per cpu TX queue). But the current
>>>> vector allocation doesn't support this which will results all virtqueues
>>>> to share a single vector. We may indeed need more flexible policy here.
>>> I think it should be possible for the driver to give the transport
>>> hints how to set up their queues/interrupt structures. (The driver
>>> probably knows best about its requirements.) Perhaps whether a queue is
>>> high or low frequency, or whether it should be low latency, or even
>>> whether two queues could share a notification mechanism without
>>> drawbacks. It's up to the transport to make use of that information, if
>>> possible.
>>
>> Exactly and it was what the above series tried to do by providing hints of e.g
>> which queues want to share a notification.
>>
> I read about your patch set on providing more flexibility of queue-to-vector
> mapping.
>
> One use case of the patch set is we would be able to enable more queues when
> there is limited number of vectors.
>
> Another use case we may classify queues as hight priority or low priority as
> mentioned by Cornelia.
>
> For virtio-blk, we may extend virtio-blk based on this patch set to enable
> something similar to write_queues/poll_queues in nvme, when (set->nr_maps != 1).
>
>
> Yet, the question I am asking in this email thread is for a difference scenario.
>
> The issue is not we are not having enough vectors (although this is why only 1
> vector is allocated for all virtio-blk queues). As so far virtio-blk has
> (set->nr_maps == 1), block layer would limit the number of hw queues by
> nr_cpu_ids, we indeed do not need more than nr_cpu_ids hw queues in virtio-blk.
>
> That's why I ask why not change the flow as below options when the number of
> supported hw queues is more than nr_cpu_ids (and set->nr_maps == 1. virtio-blk
> does not set nr_maps and block layer would set it to 1 when the driver does not
> specify with a value):
>
> option 1:
> As what nvme and xen-netfront do, limit the hw queue number by nr_cpu_ids.


How do they limit the hw queue number? A command?


>
> option 2:
> If the vectors is not enough, use the max number vector (indeed nr_cpu_ids) as
> number of hw queues.


We can share vectors in this case.


>
> option 3:
> We should allow more vectors even the block layer would support at most
> nr_cpu_ids queues.
>
>
> I understand a new policy for queue-vector mapping is very helpful. I am just
> asking the question from block layer's point of view.
>
> Thank you very much!
>
> Dongli Zhang


Don't know much for block, cc Stefan for more idea.

Thanks

