Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB35C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 03:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4992075C
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 03:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kBbnCu6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfCZDG0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 23:06:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59218 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfCZDGZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 23:06:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q2sEqo096804;
        Tue, 26 Mar 2019 03:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=AikLAY3/yF5f7CFUPqFi56k+5aRsUE/ZO0XGmUjmvdA=;
 b=kBbnCu6JrcJnIh+dMyMS0YRoV57YCFIdC0+Prn94Ye/BvzAZ7pySB8FGu85xX8YjmwQ/
 BsfwITBnZKsLrKplhxRlOYla3MHJEyOL6sZQOWx9Gf9/d045QYAaduxDuJPg0X5fmVJh
 /S9s5vuQQ/1MNgHSmTOlqfzc+nv7PVwfweEDYIqsUCnyfkbVx9+2XTjZgWMIfZ/0708Y
 ccv7DKHhjIRUBnsxIzjYu1UZT78LDtNTOlPWn4AagFnTJazWPB2+sBD3swqodtF3dRkf
 oUQHzj43/u2GbOQSPNV7fG9+H58djp98ZOgWUXr1j3ftvPDJJHBbJspRsrAnXxmsb21P 2w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2re6dj7reu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 03:06:03 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q35ust024426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 03:05:56 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2Q35snL019610;
        Tue, 26 Mar 2019 03:05:54 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 20:05:53 -0700
Subject: Re: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
Date:   Tue, 26 Mar 2019 11:05:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260021
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/26/19 10:41 AM, Ming Lei wrote:
> On Tue, Mar 26, 2019 at 9:18 AM jianchao.wang
> <jianchao.w.wang@oracle.com> wrote:
>>
>> Hi Keith
>>
>> On 3/25/19 9:49 PM, Keith Busch wrote:
>>> On Mon, Mar 25, 2019 at 01:38:37PM +0800, Jianchao Wang wrote:
>>>> blk_mq_tagset_inflight_iter is not safe that it could get stale request
>>>> in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here. A new helper
>>>> interface nvme_iterate_inflight_rqs is introduced to iterate
>>>> all of the ns under a ctrl.
>>>
>>> Nak, NVMe only iterates tags when new requests can't enter, allocated
>>> requests can't dispatch, and dispatched commands can't complete. So
>>> it is perfectly safe to iterate if the driver takes reasonable steps
>>> beforehand.
>>
>> nvme_dev_disable just quiesce and freeze the request_queue, but not drain the enters.
>> So there still could be someone escapes the queue freeze checking and tries to allocate
>> request.
> 
> The rq->state is just IDLE for these allocated request, so there
> shouldn't be issue
> in NVMe's case.

What if there used to be a io scheduler and leave some stale requests of sched tags ?
Or the nr_hw_queues was decreased and leave the hctx->fq->flush_rq ?

The stable request could be some tings freed and used
by others and the state field happen to be overwritten to non-zero...

Thanks
Jianchao
