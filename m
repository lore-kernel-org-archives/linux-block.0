Return-Path: <SRS0=YHP0=RW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCDFC43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 02:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F6D2146E
	for <linux-block@archiver.kernel.org>; Tue, 19 Mar 2019 02:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xU5toR2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCSCSi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:18:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57636 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCSCSh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 22:18:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2J2FIvG034487;
        Tue, 19 Mar 2019 02:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=8WOjIZ8HA0PmsIsu84PFWpwUD/WhnweLtaNZQdrhu2w=;
 b=xU5toR2ln97pPrhT5DPhATOICwbv9havXoGA7cg/P2rjjeEaVp+Ji+AHyopxYu5iDArs
 Ske3JzYLVKG7+aujcUqW4SvCwMAv6OdS+lYyN0bktSNyLincA6wjaO6zGGKcdERflWrO
 mcO7KV4DiLvqyFP5YK1XKHqNk4SBUVLE8od8rwzge7CbVfBl5iU3n8yNZE29maKbnXYy
 6c3c/5aJVg8K/7oQo6rhzFUwKcBNIBhygZcdnpaE+CZCJnfk0enD/7hZnKhR8yhfA+UY
 H1krMMmEfpK/3mYxoFyMLETbU8YKg2Ez5fgusC759jDbuaEw6k1KZNRCivby9mzCIJpH KA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r8ssr9sqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 02:18:31 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2J2IPQh003715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 02:18:25 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2J2IOjM016507;
        Tue, 19 Mar 2019 02:18:24 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Mar 2019 19:18:24 -0700
Subject: Re: virtio-blk: should num_vqs be limited by num_possible_cpus()?
To:     Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <e4afe4c5-0262-4500-aeec-60f30734b4fc@default>
 <20190312183351.74764f4f.cohuck@redhat.com>
 <173d19c9-24db-35f2-269f-0b9b83bd0ad6@oracle.com>
 <20190313103900.1ea7f996.cohuck@redhat.com>
 <a3f24cfa-5160-0ccc-decc-a48362c8de19@oracle.com>
 <537e6420-8994-43d6-1d4d-ccb6e0fafa0b@redhat.com>
 <20190315134112.7d63348c.cohuck@redhat.com>
 <1df52766-88fb-6b23-d160-b891c3017133@redhat.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <0fbdcfa6-cbd7-4f09-93b1-40898d5f77d1@oracle.com>
Date:   Tue, 19 Mar 2019 10:22:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1df52766-88fb-6b23-d160-b891c3017133@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9199 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903190015
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jason,

On 3/18/19 3:47 PM, Jason Wang wrote:
> 
> On 2019/3/15 下午8:41, Cornelia Huck wrote:
>> On Fri, 15 Mar 2019 12:50:11 +0800
>> Jason Wang <jasowang@redhat.com> wrote:
>>
>>> Or something like I proposed several years ago?
>>> https://do-db2.lkml.org/lkml/2014/12/25/169
>>>
>>> Btw, for virtio-net, I think we actually want to go for having a maximum
>>> number of supported queues like what hardware did. This would be useful
>>> for e.g cpu hotplug or XDP (requires per cpu TX queue). But the current
>>> vector allocation doesn't support this which will results all virtqueues
>>> to share a single vector. We may indeed need more flexible policy here.
>> I think it should be possible for the driver to give the transport
>> hints how to set up their queues/interrupt structures. (The driver
>> probably knows best about its requirements.) Perhaps whether a queue is
>> high or low frequency, or whether it should be low latency, or even
>> whether two queues could share a notification mechanism without
>> drawbacks. It's up to the transport to make use of that information, if
>> possible.
> 
> 
> Exactly and it was what the above series tried to do by providing hints of e.g
> which queues want to share a notification.
> 

I read about your patch set on providing more flexibility of queue-to-vector
mapping.

One use case of the patch set is we would be able to enable more queues when
there is limited number of vectors.

Another use case we may classify queues as hight priority or low priority as
mentioned by Cornelia.

For virtio-blk, we may extend virtio-blk based on this patch set to enable
something similar to write_queues/poll_queues in nvme, when (set->nr_maps != 1).


Yet, the question I am asking in this email thread is for a difference scenario.

The issue is not we are not having enough vectors (although this is why only 1
vector is allocated for all virtio-blk queues). As so far virtio-blk has
(set->nr_maps == 1), block layer would limit the number of hw queues by
nr_cpu_ids, we indeed do not need more than nr_cpu_ids hw queues in virtio-blk.

That's why I ask why not change the flow as below options when the number of
supported hw queues is more than nr_cpu_ids (and set->nr_maps == 1. virtio-blk
does not set nr_maps and block layer would set it to 1 when the driver does not
specify with a value):

option 1:
As what nvme and xen-netfront do, limit the hw queue number by nr_cpu_ids.

option 2:
If the vectors is not enough, use the max number vector (indeed nr_cpu_ids) as
number of hw queues.

option 3:
We should allow more vectors even the block layer would support at most
nr_cpu_ids queues.


I understand a new policy for queue-vector mapping is very helpful. I am just
asking the question from block layer's point of view.

Thank you very much!

Dongli Zhang
