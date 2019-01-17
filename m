Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EBBC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C7E20578
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 23:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qtq4Z6pY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfAPX6z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:58:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55852 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbfAPX6z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 18:58:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0GNmx4K128574;
        Wed, 16 Jan 2019 23:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=etc5YvJqwGSZnbtw4kuSRfxGnElE/rSPICQSIL85AVs=;
 b=Qtq4Z6pYE6Ovkgt2VGUjrUqIDYpheLqmgG/5RMlCPvquBWAZTgBlMrZUZOR/h6gprzZw
 bHXs/VmJRCTYed0/yWkKIoWiqacWNoOhsGFoHN9ZX8ee3qMTIM8BgWpE6nlUyxbn41NV
 JLpOIpaix9ztqJ5QKEgBeD1E5sED4QYZbX0ylr4wdI2t8UHslo/giOUxAwD2rD0GCfis
 HcQrCS73NjNb0p+tA/P212uDoXJtoRn8robanm7Ld+bnVg+wzgrZSnd9rbg57yKkAKJ6
 BPh0CVqu2x/hACkRwb98jnPQ54RZV5sRHc6uiIs5lMG2YFmD8HxLEIdC+sQyhTLabSmq zw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pybkcn0wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 23:58:47 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0GNwlmQ026587
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 23:58:47 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0GNwks4028994;
        Wed, 16 Jan 2019 23:58:47 GMT
Received: from [10.182.71.41] (/10.182.71.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jan 2019 15:58:46 -0800
Subject: Re: [Xen-devel] [PATCH v5 2/2] xen/blkback: rework connect_ring() to
 avoid inconsistent xenstore 'ring-page-order' set by malicious blkfront
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, paul.durrant@citrix.com,
        xen-devel@lists.xenproject.org, roger.pau@citrix.com
References: <1546935350-20957-1-git-send-email-dongli.zhang@oracle.com>
 <1546935350-20957-2-git-send-email-dongli.zhang@oracle.com>
 <5c3760a1-4f45-a67b-3b70-80fa68ee4358@oracle.com>
 <20190116163227.GC7892@char.us.oracle.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <982c7ac4-132f-739c-e296-bf874828c79c@oracle.com>
Date:   Thu, 17 Jan 2019 08:01:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116163227.GC7892@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901160190
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/1/17 上午12:32, Konrad Rzeszutek Wilk wrote:
> On Tue, Jan 08, 2019 at 04:24:32PM +0800, Dongli Zhang wrote:
>> oops. Please ignore this v5 patch.
>>
>> I just realized Linus suggested in an old email not use BUG()/BUG_ON() in the code.
>>
>> I will switch to the WARN() solution and resend again.
> 
> OK. Did I miss it?

Hi Konrad,

If you are talking about the new patch set:

https://lists.xenproject.org/archives/html/xen-devel/2019-01/msg00977.html
https://lists.xenproject.org/archives/html/xen-devel/2019-01/msg00978.html

About Linus' suggestion:

http://lkml.iu.edu/hypermail/linux/kernel/1610.0/00878.html

Dongli Zhang

> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 
