Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3632C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 03:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A945B20659
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 03:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lpom3LPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgENDaH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 23:30:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35132 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENDaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 23:30:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04E3RniY121517;
        Thu, 14 May 2020 03:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=ExNKJ+f6NajhWUB4NZWx+2XrlFD5RgtoRSDdDcmVt2c=;
 b=Lpom3LPKAxvX19Cq5IcJm5bdBiUxlenoP5910y/eufIrYQainA9Oz+3jm13UI9UIB/cg
 VaDYZNYYjkt1UG04idYuNkfUbswDxJl5KaU0a+YxwuhJtLjdPvZ5Kd3K+zqoUDKS+6kn
 4qFUsdIj/WxHCvE2pj/zuw5zJc9NAVJfbaBaE+TgqPPS0cUJGprIAwir9rPwSURR3Hp0
 uKjkNB5rpGA97ygi76YnoqiHE5HolVscFovyZTaVHMoF2OaxC41dL1g1IErS0IoHOGex
 Pg8h5zIcs+XnFK89Qce1S6FBhX0awyYPB/qMpO7327J3OSzg3q7kJm/9NVNocfXFrFrs Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3100xwg36d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 03:29:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04E3Rxkh158763;
        Thu, 14 May 2020 03:29:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3100ybth03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 03:29:57 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04E3TuSQ022053;
        Thu, 14 May 2020 03:29:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 May 2020 20:29:55 -0700
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme: Fix io_opt limit setting
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200514015452.1055278-1-damien.lemoal@wdc.com>
Date:   Wed, 13 May 2020 23:29:53 -0400
In-Reply-To: <20200514015452.1055278-1-damien.lemoal@wdc.com> (Damien Le
        Moal's message of "Thu, 14 May 2020 10:54:52 +0900")
Message-ID: <yq1a72bw5vy.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140029
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Damien,

> results in blk_stack_limits() to return an error when the combined
> devices have different but compatible physical sector sizes (e.g. 512B
> sector SSD with 4KB sector disks).

We'll need to get that stacking logic fixed up to take io_opt into
account when scaling pbs/min. Just as a safety measure in case we don't
catch devices reporting crazy values in the LLDs.

> Fix this by not setting the optiomal IO size limit if the namespace

optimal

> does not report an optimal write size value.

Setting io_opt to the logical block size in the NVMe driver is
equivalent to telling the filesystems that they should not submit I/Os
larger than one sector. That makes no sense. This change is correct.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
