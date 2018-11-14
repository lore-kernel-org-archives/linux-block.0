Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50717C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 09:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1078D22419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 09:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kMc6VbfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1078D22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeKNTcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:32:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46820 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbeKNTcN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 14:32:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAE9TL3L120264;
        Wed, 14 Nov 2018 09:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=vNrY9tI47lTIlmVDHIGKklx7RP60grLln/gl9StFW5Y=;
 b=kMc6VbfLmTIAlmS5RVnoGrPn36cvy1yyFn3AfbS/yv7BLd/o3ghMaqyFoub0utISVzgz
 iDFe2AFO7XSnQh/UlFY3FOBJj0zSNy0lko/lyVx4yGig5hyduC4TrHHN6sWtx8wq5oKY
 C0i/kVLXUp3AEcUmauUaQowXb782hs0+c3lDYuFzq9LTfc4VwrILS/hZBGmOxW5HeDEX
 Zmcn8SQPgRMsupF75uMhzlQ+x7SbwiZtVE2uwmWh9jO1yoejk9Dl8/A0GOOx6iAd0Pj8
 +8tG02v32m795stKUitfPz9sZiq2gvpnZTjdJWx85hfbWLX84tgwBLTtcAG0QwvOZ+yk 4w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nr7cs24xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 09:29:43 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAE9Tgn2015542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 09:29:42 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAE9Tgno022806;
        Wed, 14 Nov 2018 09:29:42 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 01:29:42 -0800
Subject: Re: [PATCH V7 2/4] blk-mq: fix issue directly case when q is stopped
 or quiesced
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542185131-15029-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542185131-15029-3-git-send-email-jianchao.w.wang@oracle.com>
 <20181114092022.GC20550@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <6b29fb1a-31bc-ac3e-cdbd-80b2a9c95e11@oracle.com>
Date:   Wed, 14 Nov 2018 17:29:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114092022.GC20550@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=957
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140087
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

On 11/14/18 5:20 PM, Ming Lei wrote:
> On Wed, Nov 14, 2018 at 04:45:29PM +0800, Jianchao Wang wrote:
>> When try to issue request directly, if the queue is stopped or
>> quiesced, 'bypass' will be ignored and return BLK_STS_OK to caller
>> to avoid it dispatch request again. Then the request will be
>> inserted with blk_mq_sched_insert_request. This is not correct
>> for dm-rq case where we should avoid to pass through the underlying
>> path's io scheduler.
>>
>> To fix it, use blk_mq_request_bypass_insert to insert the request
>> to hctx->dispatch when we cannot pass through io scheduler but have
>> to insert.
> 
> Not sure if the current behaviour is wrong, or worth of a fix.
> 
> Bypassing io scheduler for dm-rq is only for sake of performance
> because there has been io scheduler for dm device already, and we
> just don't want to schedule these requests twice.

As comment of commit 157f377beb710e84bd8bc7a3c4475c0674ebebd7
(block: directly insert blk-mq request from blk_insert_cloned_request())

    All said, a request-based DM multipath device's IO scheduler should be
    the only one used -- when the original requests are issued to the
    underlying paths as cloned requests they are inserted directly in the
    underlying dispatch queue(s) rather than through an additional elevator.
    
    But commit bd166ef18 ("blk-mq-sched: add framework for MQ capable IO
    schedulers") switched blk_insert_cloned_request() from using
    blk_mq_insert_request() to blk_mq_sched_insert_request().  Which
    incorrectly added elevator machinery into a call chain that isn't
    supposed to have any.

It sounds like a wrong action.

Thanks
Jianchao

> 
> thanks,
> Ming
> 
