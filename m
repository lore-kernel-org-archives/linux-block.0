Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE76BC33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940A92081E
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G53Qfp10"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgAHDPw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:15:52 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33328 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAHDPv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 22:15:51 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0083E1FP187934;
        Wed, 8 Jan 2020 03:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=fWjv7W6k2+dbFZ/7a6f3esspeWDYpJX7nXT009RTOvI=;
 b=G53Qfp10vGM8/bgVs2w0ED7QJQc/yKQNPcSKtEXsNlpy8AG9Ax+eAgYg9vpQNixMwfKa
 MWHahQhTmqfq9MYF0lZwf5nLFvUglvGEmL/xzuTgTx09dE+DGOUo9ubZ5WGgom0IRfbs
 S/W0tjYn9zx8GnfTUsY3uU8Rr83YGVqlGd5fDBJSJVCk4lMSmja7lGMiTO83hb2bmbb5
 ad1DEEwJsnLyteEcX5UtOUUfT0I9GQoQdpqWu6AvEyHRy0rH3+rBODK8bt+WqomGDia2
 5bZ21rRy0VMb5Igc2OZd7Jzr/BaaPdGpPYnjcgAoET1YGvBVD4+fP9aK1Cgy26cmPjMC Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xakbqs72p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 03:15:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0083DYEn143964;
        Wed, 8 Jan 2020 03:15:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2xcjvek8j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 03:15:39 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0083FbOr022903;
        Wed, 8 Jan 2020 03:15:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 19:15:37 -0800
To:     "Singh\, Balbir" <sblbir@amazon.com>
Cc:     "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Sangaraju\, Someswarudu" <ssomesh@amazon.com>,
        "jejb\@linux.ibm.com" <jejb@linux.ibm.com>,
        "hch\@lst.de" <hch@lst.de>, "axboe\@kernel.dk" <axboe@kernel.dk>,
        "mst\@redhat.com" <mst@redhat.com>,
        "linux-nvme\@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Chaitanya.Kulkarni\@wdc.com" <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [resend v1 1/5] block/genhd: Notify udev about capacity change
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200102075315.22652-1-sblbir@amazon.com>
        <20200102075315.22652-2-sblbir@amazon.com>
        <yq1ftgs2b6g.fsf@oracle.com>
        <d1635bae908b59fb4fd7de7c90ffbd5b73de7542.camel@amazon.com>
Date:   Tue, 07 Jan 2020 22:15:34 -0500
In-Reply-To: <d1635bae908b59fb4fd7de7c90ffbd5b73de7542.camel@amazon.com>
        (Balbir Singh's message of "Tue, 7 Jan 2020 22:30:30 +0000")
Message-ID: <yq17e221vvt.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=774
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=835 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080026
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Balbir,

> I did this to avoid having to enforce that set_capacity() implied a
> notification. Largely to control the impact of the change by default.

What I thought. I'm OK with set_capacity_and_notify(), btw.

-- 
Martin K. Petersen	Oracle Linux Engineering
