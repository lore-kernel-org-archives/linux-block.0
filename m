Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3004FC282D8
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 02:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F158820881
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 02:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vu9HuRzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfAaCXX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:23:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56184 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaCXX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 21:23:23 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0V2Jgw9009621;
        Thu, 31 Jan 2019 02:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=aGtrZn0EILekuIJeJHqdOoFOilaDVVKAR66NGrEiwTw=;
 b=Vu9HuRzwFvTpEp26eLeoJJgAzoHWO9WTHMYBDRzAI6gKilXQfKhU/srg8d2cflU5xHQ3
 KMMlYU4lBUl1qS2EDCqChJxKvd6NPS8kAcsMPSkojnZqOtmGHTkLzKKHtnbxe91bIQVD
 W3wgJzCeK5puNYFS8leOKwB9jIFER7A1qebR28Syq12ImTlz6QvoktSTMoWLhshQp5jd
 vpGTuK99ZiHkIgmJjZV9sB/4F0U5WXoQQCkUoczl3HQevLcGo5QM2SMiOU5ZawYz5ibZ
 GfI4RLqxB2Jy2DuyD6YlvUkL2N0uMHlBh5NwSA1aT5mUjg6My27t5LoUCDBiBroMEdNy TA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2q8d2ee780-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 02:23:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0V2ND9B023079
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Jan 2019 02:23:13 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0V2NDWn021872;
        Thu, 31 Jan 2019 02:23:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jan 2019 18:23:12 -0800
To:     John Dorminy <jdorminy@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>
Subject: Re: block: Fix a WRITE SAME BUG_ON
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190125021107.4595-1-zhangxiaoxu5@huawei.com>
        <CAMeeMh_=UVGwo-=9WtBXRmiHTXnLAswqis97bM-aiuwnzPU0QQ@mail.gmail.com>
        <20190128221441.GA24102@redhat.com> <yq1lg34f4i7.fsf@oracle.com>
        <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
Date:   Wed, 30 Jan 2019 21:23:09 -0500
In-Reply-To: <CAMeeMh85T_qui=LWd0u=b_oMN5XLqowqkvLuYGBM2Ae6tS-mzg@mail.gmail.com>
        (John Dorminy's message of "Wed, 30 Jan 2019 09:08:50 -0500")
Message-ID: <yq1ftt9bm5u.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9152 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901310016
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


John,

>> So disallowing WRITE SAME unless all component devices have the same LBS
>> is the correct fix.
>
> Alternately, could possibly WRITE_SAME bios be accepted with the
> minimum sector size of the stack rather than the max, e.g. 512 in this
> example rather than 4k? They'd need to have a granularity of the
> larger sector size, though, presumabily necessitating new queue limits
> write_same_{granularity,block_size}, which might be too much work.

I don't have a problem restricting the buffer contents to be consistent
within a page. Or even change the upper layer semantics to specify the
buffer contents using a single byte (0x00..0xff).

But the issue of head and tail remains if there is a block size mismatch
so it's important that we keep scaling the logical block size up when
stacking and reject any bio that can't be honored on a 4Kn device.

> (I use WRITE_SAME to fill devices with a particular pattern in order
> to catch failures to initialize disk structures appropriately,
> personally, but it's just for convenience/speed.)

The intent was for stuff like MD to use it to initialize parity disks,
etc. But adoption has been pretty slow.

I don't have any problems keeping WRITE_SAME around if people are
actually using it. It just seemed like most active users only cared
about writing zeroes.

-- 
Martin K. Petersen	Oracle Linux Engineering
