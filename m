Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87DDC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 06:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822FB21934
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 06:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wMDkkJ2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405683AbfBNGLQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:11:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34040 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfBNGLQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 01:11:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E68uD1148476;
        Thu, 14 Feb 2019 06:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=JAwGCDa/FytnAAK9i7vQbVmcnLT9K2uA3zcE7frWmck=;
 b=wMDkkJ2KUAiI4uM+TtupMkGbrLCUkiXa0dKHFLI1k9XLJjyJhyM3e8FblXrsUOgjApF3
 PKJRkBN0nn9h95qTB46zR3QohBuF5V6hAyC2bab41DSy+3NW17C2megkNkR81dr5ZNDT
 ohM7e5+TRZjBPPXAYoAtd9uf1zLfYuLFhG7N07TzonirqWZle+vUjgZyBAqpvk111n0J
 4Hqec77qRNcMrqRS71Zc48DzFtxHY0LBXWKBN42OsQs1c21DQR7rZEVY89wbk7Pgs8QA
 EQTsLrZoAeabO2Y9+tCtPCOdU9mWalMKaETjNTbvLxnwJ3RAyR83xKPj1fDWTojtVlyi Pw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qhrekp17q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 06:11:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E6B7nf029043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 06:11:07 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1E6B5Jh004329;
        Thu, 14 Feb 2019 06:11:05 GMT
Received: from [172.20.10.5] (/223.104.212.152)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 22:11:05 -0800
Subject: Re: [RFC PATCH v2 2/9] block: add rd_hint to bio and request
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca
References: <20190213095044.29628-1-bob.liu@oracle.com>
 <20190213095044.29628-3-bob.liu@oracle.com>
 <f2aceac4-7626-0aa9-ec15-eeca50aac442@kernel.dk>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <f3072df4-b439-faff-3661-89f15025c1a7@oracle.com>
Date:   Thu, 14 Feb 2019 14:10:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f2aceac4-7626-0aa9-ec15-eeca50aac442@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=964 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140046
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/14/19 12:18 AM, Jens Axboe wrote:
> On 2/13/19 2:50 AM, Bob Liu wrote:
>> rd_hint is a bitmap for stacked layer support(see patch 4/9),
>> set a bit to 1 means already read from the corresponding mirror device.
>>
>> rd_hint will be set properly recording read i/o went to which real device
>> during end_bio().
>> If the upper layer want to retry other mirrors, just preserve the returned
>> bi_rd_hint and resubmit bio.
>>
>> The upper layer e.g fs can set bitmap_zero(rd_hint) if don't care about alt
>> mirror device retry feature which is also the default setting.
> 
> You just made the bio 16 bytes bigger on my build, which is an increase
> of 12.5% and spills it into a third cacheline. That's not going to work
> at all. At least look at where you are placing this thing. That goes
> for the request as well, you can just toss members in there at random.
> 

Are you fine with an union like?
-       unsigned short          bi_write_hint;
-       DECLARE_BITMAP(bi_rd_hint, BLKDEV_MAX_MIRRORS);
+       union {
+           unsigned short              bi_write_hint;
+           unsigned long               bi_rd_hint;
+       };

But rd_hint need to be "unsigned long" which would still make bio/request bigger.

For sure can add KCONFIG option around if necessary.

> Also, why is BLKDEV_MAX_MIRRORS in types.h? That makes very little sense.
> 

Indeed, so I plan to switch back "unsigned long bi_rd_hint".
But bi_rd_hint is still a bitmap(for stacked layer support) which means this feature can not
work if more than BITS_PER_LONG copies.

> Look into options of carrying this elsewhere, or (at the very least)
> making it dependent on whoever needs it. This is NOT a negligible
> amount of wasted space.
> 
