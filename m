Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB0FC4360F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 15:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5102184C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 15:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0eD3oaWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfC2PBb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:01:31 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46568 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfC2PBb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 11:01:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TEwtPH047649;
        Fri, 29 Mar 2019 15:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=OQCrPKs2Zc0B/DzFfUCNHmA9OsVNLr2L4zaeyQcKxVk=;
 b=0eD3oaWIzuH8b9IyBA6p31QCOzPbPIYbDg1i13QTI9mPOTNwkUPyuQed3WRATkpBZFK5
 1ge+v4nRMjM1WTIQlTCH1V/mvyBNvmQt7xDoJFrmIpNDXvqKjRw769Z0F4DVqQuYzAH8
 GYe6qJ5LUwR6JSOrchYxc7FusL8TG0Ye00b+ORp2WaxYAzXjaoxScMzPNsWkU+KqUY35
 SlqJTusNVTIVLg4VXSvNw4ypQH+HPuvylXOL/j8cJ2mwcUZlntb3x96SyoC4v8/rJ/od
 p96XiUqOh0SNUZ0mE2IXeESdPMCzpeWkuJA9ZPYhObI05r6Teb1hp5XOdgTKX3UTjHqf Ig== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2re6g1cyvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:01:19 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2TF1IiJ029065
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 15:01:18 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TF1HvP011574;
        Fri, 29 Mar 2019 15:01:17 GMT
Received: from [192.168.1.12] (/180.165.90.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 08:01:17 -0700
Subject: Re: [PATCH v3 2/3] block: verify data when endio
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        tytso@mit.edu
References: <20190329142346.1677-1-bob.liu@oracle.com>
 <20190329142346.1677-3-bob.liu@oracle.com>
 <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk> <yq1ftr5rbq1.fsf@oracle.com>
 <f65d6a7b-9e69-ae1e-b8b8-8769dc650311@kernel.dk> <yq1bm1trb4y.fsf@oracle.com>
 <feefa611-b744-326c-29d5-c64bcda45d9f@kernel.dk> <yq17echrax1.fsf@oracle.com>
 <1b638dc2-56fd-6ab4-dcca-ad2adb9931bb@kernel.dk>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <c9adb48c-7b6e-2017-9480-aa2342b3523b@oracle.com>
Date:   Fri, 29 Mar 2019 23:00:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1b638dc2-56fd-6ab4-dcca-ad2adb9931bb@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9211 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290107
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 10:52 PM, Jens Axboe wrote:
> On 3/29/19 8:51 AM, Martin K. Petersen wrote:
>>
>> Jens,
>>
>>> The integrity stuff still has that nasty pointer in there. It'd be
>>> nice to get rid of that as well, and hide it all in a parent container
>>> of the bio.
>>
>> That's fine with me. We really didn't have that option a decade ago.
> 
> Right, but now we do. Hence trying to nudge things in that direction,
> instead of adding another pointer to struct bio for a new use case. I'd
> much rather go that route, instead of unionizing with another pointer
> that should be going away instead.
> 

No problem, will update in next version.
Let me wait a while for feedback about the verify callback.
Thank you!
