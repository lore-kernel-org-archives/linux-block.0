Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04166C10F03
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 01:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C757E206DF
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 01:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A2+sc/nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfCZBSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:18:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50632 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfCZBSF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 21:18:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2Q1FvgT022959;
        Tue, 26 Mar 2019 01:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=/Kl0K4H2oLqA9ZCxH7NCR8HsssQuahLQEpvi0trC9h8=;
 b=A2+sc/nzx/vW4i55Lyyr6ggK/XnrmAe+8sjda7zqYwQ5sr5MXYdqLX0EN1bPoacnn/mq
 f7+0mE9BTh3TdW5TOdXBYTalXlRapkUm9roIf/LGkI/TKLkQb79ySlwmDrKJ4tO2IT1K
 Hqd1cPk3mHkqYmp9jJ5MxJct8RmMDEwjo6esTLMJsS6d+2WxuqpoGEROqrwuBDVE3bSb
 roQLVlvgdSJu+iHF16m6xhOD5YGxpgFtL8P9r7ThYneZRzzhk20/KGTxiW0q/KMUdNFS
 SspYMvT1hfXeaxAcJ9alFCNeaKO/W4sRKwD/S5sp7P3eJZleiT/WwJCVG6mphhyMydN7 ag== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2re6g0qeas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 01:17:31 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2Q1HTh8000458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 01:17:30 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2Q1HOFl021687;
        Tue, 26 Mar 2019 01:17:25 GMT
Received: from [10.182.69.118] (/10.182.69.118)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 18:17:24 -0700
Subject: Re: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
To:     Keith Busch <kbusch@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
        bvanassche@acm.org, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, hare@suse.de, jthumshirn@suse.de,
        hch@lst.de, sagi@grimberg.me
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-8-git-send-email-jianchao.w.wang@oracle.com>
 <20190325134917.GA4328@localhost.localdomain>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
Date:   Tue, 26 Mar 2019 09:17:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325134917.GA4328@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9206 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903260007
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Keith

On 3/25/19 9:49 PM, Keith Busch wrote:
> On Mon, Mar 25, 2019 at 01:38:37PM +0800, Jianchao Wang wrote:
>> blk_mq_tagset_inflight_iter is not safe that it could get stale request
>> in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here. A new helper
>> interface nvme_iterate_inflight_rqs is introduced to iterate
>> all of the ns under a ctrl.
> 
> Nak, NVMe only iterates tags when new requests can't enter, allocated
> requests can't dispatch, and dispatched commands can't complete. So
> it is perfectly safe to iterate if the driver takes reasonable steps
> beforehand.

nvme_dev_disable just quiesce and freeze the request_queue, but not drain the enters.
So there still could be someone escapes the queue freeze checking and tries to allocate
request.

> Further, for M tags and N namespaces, we complete teardown
> in O(M) time, but this makes in O(M*N) without gaining anything.
> 

Yes, it is indeed inefficient.

Thanks
Jianchao
