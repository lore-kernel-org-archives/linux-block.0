Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A861CC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 09:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6B22419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 09:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h76ljEgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED6B22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbeKNT0G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:26:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41628 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeKNT0G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 14:26:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAE9JIuk112351;
        Wed, 14 Nov 2018 09:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=IK33j/cjJDM6Bqqq1sMY/uKXJH5fF4J2KBtaga5auPg=;
 b=h76ljEgKi7CBlQ1SqC01szZskUICsN0WJyI1cNThU9dDsY8qmkSQ8fVLpZPFPk2n4JIJ
 KWJ7rc168vMhAPXjs0HdC+tlvU41UdQr458J/IA14MFNFxo74uIo1b+0N4O26FRLkfvB
 EPJ+llF+YwNRs2OJAKWtvQrT3wTSqCpsX4yHSX5O1AUIteFIICyRvDbJtdOTZzegdVnn
 rdmNOch1QvijqctRBtZGGlnomocImsqYkgg8vSqpXfl9oD9r0a+Z5clwUoY2kioB4Tf7
 E9zqp15/R5Dn3eo2rqWm4YxElebYqSEUxRLFbHue+BbSa2iA6R8ih2OxV/CJfKT6FjAm oA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nr7cs23ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 09:23:37 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAE9NawZ017938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Nov 2018 09:23:37 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAE9NakT019453;
        Wed, 14 Nov 2018 09:23:36 GMT
Received: from [10.182.71.8] (/10.182.71.8)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Nov 2018 01:23:36 -0800
Subject: Re: [PATCH V7 1/4] blk-mq: refactor the code of issue request
 directly
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542185131-15029-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542185131-15029-2-git-send-email-jianchao.w.wang@oracle.com>
 <20181114091153.GB20550@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <17b51550-d45b-9861-b172-74ee0e256d98@oracle.com>
Date:   Wed, 14 Nov 2018 17:23:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114091153.GB20550@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9076 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=897
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811140086
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming

On 11/14/18 5:11 PM, Ming Lei wrote:
>>  
>> -	if (!blk_mq_get_dispatch_budget(hctx))
>> -		goto insert;
>> +	if (unlikely(!blk_mq_get_dispatch_budget(hctx)))
>> +		goto out_unlock;
> The unlikely annotation is a bit misleading, since out-of-budget can
> happen frequently in case of low queue depth, and there are lots of
> such examples.
> 

This could be good for the case for no .get_budget and getting budget success.
In case of out-of-budget, we insert the request which is slow path.
It should be OK. Maybe some comment should be added for this.

Thanks
Jianchao


