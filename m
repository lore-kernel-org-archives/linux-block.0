Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FA0C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 01:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ED82075C
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 01:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GsqNnHre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCRBrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 21:47:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49070 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfCRBrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 21:47:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2I1ieuS033126;
        Mon, 18 Mar 2019 01:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=W13ViHroDyNOovUGQfhK8z1oAhd0ebEkpUkZ7DZ2D70=;
 b=GsqNnHrel18unqwfC9y2Bet3+EX8lP5NMzHe2jXLDUqFwez9Ffy5VGx+xD9RI9be2EK6
 Nzn8ZKBYdsBHeT0SatwIbqfTJG9qw4UVp9iMDRjxQ0cBggXi6YrpYuNUrExRo9BHhwZu
 Pnt5C3SKieQHUCx4qlzQ2l+GBhZv4jTWVOrh1C729bHGNaLBUMNXUAyqWXYQFO0LclYu
 kLibDjxhqHJDRMDCvbbwx/BsuJmpsWNZeJ7JY9MbDWM314cKhU0jO46C3dXl524r5yQM
 7yUedWR6qnKwJvCf6kG0lzIUGaBocmSbOk7D17gr7ZAYKxHn+0tA1bqw0dSKUh+47PQq Zw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r8ssr3mn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 01:46:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2I1kUNG026009
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Mar 2019 01:46:31 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2I1kRjV015488;
        Mon, 18 Mar 2019 01:46:27 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 17 Mar 2019 18:46:27 -0700
Subject: Re: [PATCH 2/8] blk-mq: change the method of iterating busy tags of a
 request_queue
To:     Keith Busch <kbusch@kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jsmart2021@gmail.com" <jsmart2021@gmail.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "hare@suse.de" <hare@suse.de>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
 <20190315161608.GB15153@localhost.localdomain>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e17f86f0-98ca-5c79-0d9b-43c628b72413@oracle.com>
Date:   Mon, 18 Mar 2019 09:49:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315161608.GB15153@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9198 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903180012
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Keith

On 3/16/19 12:16 AM, Keith Busch wrote:
> There is still a window where the check may succeed, but the request is
> being assigned to a completely different request_queue. The callback
> then operates on a request it doesn't own.
> 
> Tag iteration from a driver can be safe only if the driver initiates a
> freeze and quiesced all queues sharing the same tagset first. The nvme
> driver does that, but I think there may need to be an additional grace
> period to wait for the allocation's queue_enter to call queue_exit to
> ensure the request is initialized through blk_mq_rq_ctx_init().

This patch is to avoid the use-after-free case in the comment.
The helper interface is used in following cases,
1. in flight request account
   this case should not require so much accuracy

2. timeout check
   a extra reference will be held there to avoid the request recycle

3. if it is used by driver, it should be enough that quiesce the request_queue
   the driver usually wants to handle the in-flight ones, quiesce request_queue
   could ensure all of tasks quit the hctx_lock and no one issue request any
   more.

Thanks
Jianchao
