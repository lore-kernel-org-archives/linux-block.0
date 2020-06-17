Return-Path: <SRS0=NzS0=76=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD12C433E0
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 12:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F2220720
	for <linux-block@archiver.kernel.org>; Wed, 17 Jun 2020 12:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HGvInCli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgFQMGN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:06:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46790 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQMGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 08:06:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05HBvR5V032179;
        Wed, 17 Jun 2020 12:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=olGnmPODMTISYB7O5NdW1iJB91rNe+9YnXruLIPV6mM=;
 b=HGvInCliu7GXH43s3/EU/tg0m6miKIozPdwwMDaqhYUHU0MmR+hETsZKzNgNXPTLuCRd
 rymMo6974rJxsKa+v/B/AVHp6rC0frBdDKt9OBsrxuv5YVSsDteywIBUYlQxdei1ceKA
 8jt4LprgW/tXHdXHTVwtzVyURR4tKi3Usb7n5v/5OwxDuh2Mu9Vp/RHdClbAAIVEbLcE
 TCaCCC2yDKoYL1sBz2qeo63u35hqrVTjitcPhT/uNkjxYyF3vup2nEMAJbLd4/vhlX+Q
 ZfG80YvmxtNsUnHYDKKSUJ+NTZ9OudzbXarzzgmC6wdfCNwmYqt8uBZ+cMXXzclid6dD 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31qg350qy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Jun 2020 12:03:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05HBvd9l093547;
        Wed, 17 Jun 2020 12:01:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31q65xdnnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jun 2020 12:01:43 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05HC1bmp013213;
        Wed, 17 Jun 2020 12:01:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jun 2020 05:01:37 -0700
To:     Christoph Hellwig <hch@lst.de>
Cc:     Javier =?utf-8?Q?Gonz=C3=A1lez?= <javier@javigon.com>,
        Keith Busch <keith.busch@wdc.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Ajay Joshi <ajay.joshi@wdc.com>,
        Aravind Ramesh <aravind.ramesh@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r1uej7j6.fsf@ca-mkp.ca.oracle.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
        <20200615233424.13458-6-keith.busch@wdc.com>
        <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
        <20200617074328.GA13474@lst.de>
Date:   Wed, 17 Jun 2020 08:01:31 -0400
In-Reply-To: <20200617074328.GA13474@lst.de> (Christoph Hellwig's message of
        "Wed, 17 Jun 2020 09:43:28 +0200")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 clxscore=1011 malwarescore=0 impostorscore=0 adultscore=0
 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 suspectscore=1 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170093
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Because Append is the way to go and we've moved the Linux zoned block
> I/O stack to required it,

Just to add some historical context: The first discussions about how to
support block devices with a non-random write model in Linux happened
maybe a decade ago.

Drive vendors came to LSF/MM to solicit feedback on how Linux could
support impending SMR devices. We spent a long time going over various
approaches, including some that are similar to what is now being
entertained as alternative to Append. The conclusion back then was that
an Append-like model (tell-us-where-you-put-it) was the only reasonable
way to accommodate these devices in Linux given how our filesystems and
I/O stack worked.

Consequently, I don't think it is at all unreasonable for us to focus on
devices that implement that mode of operation in the kernel. This is
exactly the that we as a community asked the storage industry to
provide!

-- 
Martin K. Petersen	Oracle Linux Engineering
