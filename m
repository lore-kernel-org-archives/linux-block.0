Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D31AC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 06:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2192077B
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 06:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VN0couvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfCRG6D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 02:58:03 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59268 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfCRG6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 02:58:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2I6sZX4080941;
        Mon, 18 Mar 2019 06:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=3gX8cKTbyoZG3L+QNNnAaLKgQc7So5R3/tqK9Oa6rDQ=;
 b=VN0couvw8PSJFliV65Q6a6hkKT3q2lCQS+gGYyRtKwkJDP1DmYMByNzIrkDCZ9yG3auZ
 Bw8YmlAmea0g91sQnZxOnLi8LExXvgtfyvQ6Wr2DiZ70kYLMaG8WnFQ0j1qaV/WMoNLK
 1p7V+y4EoAC6sWh8/Ob2OwLsCe6qTycmS37s4XfVOyBNrGAdT6q/3eEOpt4gYxaOiuLp
 luB8VWTE9DtjZNajfKK2eMxbuUd8LHy77aQJRAiKDYoiXpgeWnWOXP2Tr9kla9bMmNcu
 tCXbpjqhR4guSOqdxOPFC3ZYTP7oxa+/+sKRUamKNIF4FMXmGyL9B96rz1gQT04zeho2 Ng== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2r8pnecsk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 06:57:39 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2I6vbMP031557
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 06:57:37 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2I6vWjF024292;
        Mon, 18 Mar 2019 06:57:32 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 17 Mar 2019 23:57:32 -0700
Subject: Re: [PATCH 7/8] nvme: use blk_mq_queue_tag_busy_iter
To:     James Smart <jsmart2021@gmail.com>, axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-8-git-send-email-jianchao.w.wang@oracle.com>
 <62de99e8-0d8d-910a-bfdc-649f734b152c@gmail.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3ce02cf8-f310-4a79-18d4-1ac2e1ef823a@oracle.com>
Date:   Mon, 18 Mar 2019 15:00:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <62de99e8-0d8d-910a-bfdc-649f734b152c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9198 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903180053
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi James

On 3/16/19 12:33 AM, James Smart wrote:
> On 3/15/2019 1:57 AM, Jianchao Wang wrote:
>> blk_mq_tagset_busy_iter is not safe that it could get stale request
>> in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here. A new helper
>> interface nvme_iterate_inflight_rqs is introduced to iterate
>> all of the ns under a ctrl.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>   drivers/nvme/host/core.c   | 12 ++++++++++++
>>   drivers/nvme/host/fc.c     | 12 ++++++------
>>   drivers/nvme/host/nvme.h   |  2 ++
>>   drivers/nvme/host/pci.c    |  5 +++--
>>   drivers/nvme/host/rdma.c   |  6 +++---
>>   drivers/nvme/host/tcp.c    |  5 +++--
>>   drivers/nvme/target/loop.c |  6 +++---
>>   7 files changed, 32 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 6a9dd68..5760fad 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -3816,6 +3816,18 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_start_queues);
>>   +void nvme_iterate_inflight_rqs(struct nvme_ctrl *ctrl,
>> +        busy_iter_fn *fn, void *data)
>> +{
>> +    struct nvme_ns *ns;
>> +
>> +    down_read(&ctrl->namespaces_rwsem);
>> +    list_for_each_entry(ns, &ctrl->namespaces, list)
>> +        blk_mq_queue_tag_busy_iter(ns->queue, fn, data, true);
>> +    up_read(&ctrl->namespaces_rwsem);
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_iterate_inflight_rqs);
> 
> Hmm... so this aborts ios for namespaces. How about ios that aren't for a namespace but rather for the controller itself.  For example, anything on the admin queue ?   Rather critical for those ios be terminated as well.
> 

The blk_mq_tagset_busy_iter which is currently used by nvme is iterating the in-flight ios for the controller.
But due to blk_mq_tagset_busy_iter is not safe which is talked in the patch 0/8,
so change it to blk_mq_queue_busy_tag_iter which is for a namespace/request_queue.

Thanks
Jianchao
