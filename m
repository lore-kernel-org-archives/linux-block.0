Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DD6C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE7820896
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 02:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ceLdSB8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE7820896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeKNMQQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:16:16 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40830 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeKNMQQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 07:16:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAE2EJtS011870;
        Wed, 14 Nov 2018 02:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xFg0ogTKUzTjT9zvZrh6LPPUCJ/zsSJKdiBbuq5BnU4=;
 b=ceLdSB8aacuAt8uhNa15QHxaTYgNFVn3psp9iJ0hGcoa3eYjj1kz51Vv7lWA1dvGbCNQ
 5Tswp3BRHauDtyfyGPvSvL+10dTvnul3RXOquDZlLITtgKQG6XVD5BHjTZnt00M+saDN
 GEN/m9ZdGOFYBlgpRuz9YKdCACQmq8yDzO6923qvWG+HhcABLtqixYMQLfVn8FIfXowY
 NxB8QaVI8RgNcbPXSpsdIP0GkZwl5fEFL79YKuFqVW0IdVNBWBsICPcptr3ISMGKH2Sd
 3vFMxg4eYX+xLHfNJvgmDZ8VHB+RA1xAu0X5PxktlvUmnQeSquOmwU15du/23LqhwGhn BA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2nr7cs0ncu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 02:15:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAE2F6LD030599
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 02:15:06 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAE2F5jV031962;
        Wed, 14 Nov 2018 02:15:06 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Nov 2018 18:15:05 -0800
Subject: Re: [PATCH V6 3/5] blk-mq: ensure hctx to be ran on mapped cpu when
 issue directly
To:     Jens Axboe <axboe@kernel.dk>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542103016-21037-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542103016-21037-4-git-send-email-jianchao.w.wang@oracle.com>
 <d8d88eff-e3eb-542d-d4fa-06b6aff97ba0@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <94ec3d97-f75f-645d-94f1-24d3fd476940@oracle.com>
Date:   Wed, 14 Nov 2018 10:15:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d8d88eff-e3eb-542d-d4fa-06b6aff97ba0@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140019
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens

Thanks for your kindly response.

On 11/13/18 9:44 PM, Jens Axboe wrote:
> On 11/13/18 2:56 AM, Jianchao Wang wrote:
>> When issue request directly and the task is migrated out of the
>> original cpu where it allocates request, hctx could be ran on
>> the cpu where it is not mapped.
>> To fix this,
>>  - insert the request forcibly if BLK_MQ_F_BLOCKING is set.
>>  - check whether the current is mapped to the hctx, if not, insert
>>    forcibly.
>>  - invoke __blk_mq_issue_directly under preemption disabled.
> 
> I'm not too crazy about this one, adding a get/put_cpu() in the hot
> path, and a cpumask test. The fact is that most/no drivers care
> about strict placement. We always try to do so, if convenient,
> since it's faster, but this seems to be doing the opposite.
> 
> I'd be more inclined to have a driver flag if it needs guaranteed
> placement, using one an ops BLK_MQ_F_STRICT_CPU flag or similar.
> 
> What do you think?
> 

I'd inclined blk-mq should comply with a unified rule, no matter the
issuing directly path or inserting one. Then blk-mq would have a simpler
model. And also this guarantee could be a little good for drivers,
especially the case where cpu and hw queue mapping is 1:1.

Regarding with hot path, do you concern about the nvme device ?
If so, how about split a standalone path for it ?

Thanks
Jianchao



