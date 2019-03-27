Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B9DC43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 07:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582F22082F
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 07:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YqbRobZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfC0HTE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 03:19:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45314 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbfC0HTE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 03:19:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2R7DNog080891;
        Wed, 27 Mar 2019 07:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=fEd/5/j1o8UV4YxTZu3OsHpfyvxSMWVXPu13SXIp65c=;
 b=YqbRobZMosGXtVwJ/HPimIizr345kIw334yu4hW96IK9EvlZQ6zBMq7nqQuGZNQlB6QC
 SSZtjmmXJ2WLUMyj/CeeKCQWIVP4EH67tcpD2Wif3aCNPFzeSAgjvg+3+ftOqx1ple76
 lzfQRFRUYRQ6njGD2tu7iVXCultBQfAnOeVO2FVWQiS4feASPZQjscJIHvX20tLwfBiq
 jCd+xQmNQvOB+K5nvUY8AksaGYl1Q+PUkUXqZhIdjopJR++GAGNLve666HYftLb7UAuh
 qV5A7IEJPnMOtoTOsIjj1ArZvaSAc8LgSN5d+9vXtsEO83ArS2jzuDTjnZlT8ZuuvMxh mA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g16p84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 07:18:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2R7IS2v028036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 07:18:30 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2R7IPue004652;
        Wed, 27 Mar 2019 07:18:25 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 00:18:25 -0700
Subject: Re: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
References: <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
 <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
 <20190326235726.GC4328@localhost.localdomain>
 <c0d65c3c-bf2e-ff84-caac-e64b30e4e79f@oracle.com>
 <20190327021521.GA7389@localhost.localdomain>
 <1bbe1b5c-3564-55e8-6824-f679b3c5dd3f@oracle.com>
 <20190327023354.GB7389@localhost.localdomain>
 <9f3a574d-d2ea-3fd0-472c-85ad0bae4daf@oracle.com>
 <20190327065156.GC7389@localhost.localdomain>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c756aab1-b546-c345-4299-205205ca4cb4@oracle.com>
Date:   Wed, 27 Mar 2019 15:18:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190327065156.GC7389@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903270052
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Keith

On 3/27/19 2:51 PM, Keith Busch wrote:
> On Wed, Mar 27, 2019 at 10:45:33AM +0800, jianchao.wang wrote:
>> 1. a hctx->fq.flush_rq of dead request_queue that shares the same tagset
>>    The whole request_queue is cleaned up and freed, so the hctx->fq.flush is freed back to a slab
>>
>> 2. a removed io scheduler's sched request
>>    The io scheduled is detached and all of the structures are freed, including the pages where sched
>>    requests locates.
>>
>> So the pointers in tags->rqs[] may point to memory that is not used as a blk layer request.
> 
> Oh, free as in kfree'd, not blk_mq_free_request. So it's a read-after-
> free that you're concerned about, not that anyone explicitly changed a
> request->state.

Yes ;)

> 
> We at least can't free the flush_queue until the queue is frozen. If the
> queue is frozen, we've completed the special fq->flush_rq where its end_io
> replaces tags->rqs[tag] back to the fq->orig_rq from the static_rqs,
> so nvme's iterator couldn't see the fq->flush_rq address if it's invalid.
> 

This is true for the non io-scheduler case in which the flush_rq would steal the driver tag.
But for io-scheduler case, flush_rq would acquire a driver tag itself.


> The sched_tags concern, though, appears theoretically possible.
> 

Thanks
Jianchao
