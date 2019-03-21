Return-Path: <SRS0=o3qj=RY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394E8C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 01:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D75218D3
	for <linux-block@archiver.kernel.org>; Thu, 21 Mar 2019 01:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sDTBq/Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfCUBbL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:31:11 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60842 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfCUBbL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 21:31:11 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2L1NbbX014048;
        Thu, 21 Mar 2019 01:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=tHqaXZAUo6StWTKwDVBLWpvAhmFJGq957ch/0cuFhIc=;
 b=sDTBq/SxzOO3LKORzHmbieurenqD7aky+gYKqalj7CRJ9YmHYWF9h30PPSjavJcTfoBS
 aD9eN7Nm0RHiCBAQgNtEmU28/otcLl9LvKcglMdA8oghnni4G50Mj97IkxVpRCWe24lE
 ChD3G4Vxf5rZ9d1croNQ4dLLzUE78i1u2NxZwPdtuS4XSoPcDJ908188wJ41C9yVdTJw
 rM8/JBL62SscIebLrx+HUZt50S/R1eanEEHre78///T/PJEA+Yn6gCnbcNXFTfaGiaAN
 SWcZoAqGwErwI48yhpASZmjnXi0xoFVnNtKqGUIRY/lJDYWQ5vJwKOqufTDQwfq+jE6/ xg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2r8pnex5vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 01:30:49 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2L1Umb5013151
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 01:30:48 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2L1UlDH020203;
        Thu, 21 Mar 2019 01:30:47 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Mar 2019 18:30:47 -0700
Subject: Re: [PATCH 2/8] blk-mq: change the method of iterating busy tags of a
 request_queue
To:     Sagi Grimberg <sagi@grimberg.me>, axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, keith.busch@intel.com, jsmart2021@gmail.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552640264-26101-3-git-send-email-jianchao.w.wang@oracle.com>
 <bf563d09-c243-5bf5-ab3e-0fa2bd583edd@grimberg.me>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a3ee391b-1815-9c15-a8d8-d0d16f930460@oracle.com>
Date:   Thu, 21 Mar 2019 09:33:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <bf563d09-c243-5bf5-ab3e-0fa2bd583edd@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9201 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903210008
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi

Thanks for your kindly response.

On 3/21/19 2:52 AM, Sagi Grimberg wrote:
> 
> 
> On 3/15/19 1:57 AM, Jianchao Wang wrote:
>> tags->rqs[] will not been cleaned when free driver tag and there
>> is a window between get driver tag and write tags->rqs[], so we
>> may see stale rq in tags->rqs[] which may have been freed, as
>> following case,
>> blk_mq_get_request         blk_mq_queue_tag_busy_iter
>>    -> blk_mq_get_tag
>>                               -> bt_for_each
>>                                 -> bt_iter
>>                                   -> rq = taags->rqs[]
>>                                   -> rq->q
>>    -> blk_mq_rq_ctx_init
>>      -> data->hctx->tags->rqs[rq->tag] = rq;
>>
>> To fix this, the blk_mq_queue_tag_busy_iter is changed in this
>> patch to use tags->static_rqs[] instead of tags->rqs[]. We have
>> to identify whether there is a io scheduler attached to decide
>> to use hctx->tags or hctx->sched_tags. And we will try to get a
>> non-zero q_usage_counter before that, so it is safe to access
>> them. Add 'inflight' parameter to determine to iterate in-flight
>> requests or just busy tags. A correction here is that
>> part_in_flight should count the busy tags instead of rqs that
>> have got driver tags.
> 
> IMO, instead of this parameter, add a wrapper like
> blk_mq_queue_tag_inflight_iter() or keep the parameter out until
> we actually have a user that calls it for busy and not inflight.

Using a wrapper instead of exporting the parameter to user is indeed better.
I will change it in next version.

When the 'inflight' parameter is true, we iterate the inflight requests,
otherwise, we iterate the all the busy requests no matter they are in-flight
or not. The latter would be useful for part_in_flight. Currently, we only
account the requests with driver tags, it is inconsistent for the io-scheduler
and non-io-scheduler case.

> 
> Other than that, I think that iterating over static_rqs is a good
> solution to the problem described.
> 

Sincerely
Jianchao
