Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830A7C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB6520880
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0koYTBda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfCYHhf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:37:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39478 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbfCYHhf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 03:37:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P7Y2ol101899;
        Mon, 25 Mar 2019 07:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=2VlQBHb5HwLShox7N890bgyUAQsYFewwS6A/Xh3YKjk=;
 b=0koYTBdahgG8L+HkuugwPUluQjoLt0aFjAM5h1EnoaZP9abJND3f9QCtv+2ft3u4ISLF
 3q4s1ttzknR+h2BSdFW733ro/g66YzFfNRM6HaDcYeq23jud8Cwn4p+oXLSSsd1tnNmW
 fjn0U14M8PHpYxSom2mzktmicJGEZ9wgKVCJwttxB5/RssP0iXUyuPkgrTSs3WCX+8CC
 n8G2J48RDDLE9w8/2PYzwK7/SEKer/yItAjQg3ekPcWeJ627KpIaz3zqPa0Vy6sq1l8E
 iKXr9tDBlsJfoZs0JyzoSTot3+bjqRmilLLFnPsC+KyVIGf/7WxLjAJjsFqMk6JBE4X+ gw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2re6dj2aky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 07:37:11 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2P7b6Da000665
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 07:37:06 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2P7b5iw027258;
        Mon, 25 Mar 2019 07:37:05 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 00:37:05 -0700
Subject: Re: [PATCH V2 8/8] blk-mq: remove blk_mq_tagset_busy_iter
To:     Hannes Reinecke <hare@suse.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, jthumshirn@suse.de, hch@lst.de,
        bvanassche@acm.org
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-9-git-send-email-jianchao.w.wang@oracle.com>
 <47fe0e2a-f427-0e3e-e15b-a9e2bffb502f@suse.de>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <f9d22543-65d1-e473-e3ab-deefa2d6e884@oracle.com>
Date:   Mon, 25 Mar 2019 15:37:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <47fe0e2a-f427-0e3e-e15b-a9e2bffb502f@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=950 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250057
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Hannes

On 3/25/19 3:18 PM, Hannes Reinecke wrote:
> On 3/25/19 6:38 AM, Jianchao Wang wrote:
>> As nobody uses blk_mq_tagset_busy_iter, remove it.
>>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
>> ---
>>   block/blk-mq-tag.c     | 95 --------------------------------------------------
>>   include/linux/blk-mq.h |  2 --
>>   2 files changed, 97 deletions(-)
>>
> Please, don't.
> 
> I'm currently implementing reserved commands for SCSI and reworking the SCSI error handling where I rely on this interface quite heavily.


blk_mq_tagset_busy_iter could access some stale requests which maybe freed due to io scheduler switching, request_queue cleanup (shared tagset)
when there is someone submits io and gets driver tag. When io scheduler attached, even quiesce request_queue won't work.

If this patchset is accepted, blk_mq_tagset_busy_iter could be replaced with blk_mq_queue_inflight_tag_iter which needs
to be invoked by every request_queue that shares the tagset.

Please go ahead your work.

Thanks
Jianchao

> 
> Cheers,
> 
> Hannes
