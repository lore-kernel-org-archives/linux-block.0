Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62380C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C5120828
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 07:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCRHrd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 03:47:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfCRHrd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 03:47:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72DE3308FBAF;
        Mon, 18 Mar 2019 07:47:33 +0000 (UTC)
Received: from [10.72.12.98] (ovpn-12-98.pek2.redhat.com [10.72.12.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBDD55D705;
        Mon, 18 Mar 2019 07:47:27 +0000 (UTC)
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
 <20190312183351.74764f4f.cohuck@redhat.com>
 <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
 <20190313103900.1ea7f996.cohuck@redhat.com>
 <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
 <537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
 <20190315134112.7d63348c.cohuck@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <1df52766-88fb-6b23-d160-b891c3017133@redhat.com>
Date:   Mon, 18 Mar 2019 15:47:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315134112.7d63348c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 18 Mar 2019 07:47:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2019/3/15 下午8:41, Cornelia Huck wrote:
> On Fri, 15 Mar 2019 12:50:11 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>
>> Or something like I proposed several years ago?
>> https://do-db2.lkml.org/lkml/2014/12/25/169
>>
>> Btw, for virtio-net, I think we actually want to go for having a maximum
>> number of supported queues like what hardware did. This would be useful
>> for e.g cpu hotplug or XDP (requires per cpu TX queue). But the current
>> vector allocation doesn't support this which will results all virtqueues
>> to share a single vector. We may indeed need more flexible policy here.
> I think it should be possible for the driver to give the transport
> hints how to set up their queues/interrupt structures. (The driver
> probably knows best about its requirements.) Perhaps whether a queue is
> high or low frequency, or whether it should be low latency, or even
> whether two queues could share a notification mechanism without
> drawbacks. It's up to the transport to make use of that information, if
> possible.


Exactly and it was what the above series tried to do by providing hints 
of e.g which queues want to share a notification.

Thanks

