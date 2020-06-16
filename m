Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA97C433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B681621702
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 16:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SpmbKSlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgFPQFx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:05:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48580 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731655AbgFPQFw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 12:05:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GG1hmt013067;
        Tue, 16 Jun 2020 16:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=nsFoKpUEwfivYFVz1rBvvdyVotoG///kd8J7Jfssht4=;
 b=SpmbKSlDFUjZzgCzRywtmfUjNvYuQHOdnlp60y/2HoGDD3oLYgE69bxDw5f+WPFNEcCE
 wIq5Mg4w/usZaKeu44BHuhzCVRGeFeQgy3SvO2Zs6a55nnPeVK1jm5Z6sjaMPusPSBcE
 YGAQ//GvEWACeunR5Xyn5M70tdkxVJ2rBktNQqGOHrZEOHJ3jIsjhxRYnn0S/YvzVFpl
 y0oFds5OwBeJk1b7BOyJ3Kz2OghxnbQk5E0rux2X8Kc7/PCs6Ty7T2/uQIoV7xq7XDIo
 83G26Po5zSxT3BTx05UCA2X4ZtYB7mxR37cV0i3nwZiBuzl1P4I80iCFZVC75GXXpKAN bQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31p6s27me0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 16:05:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05GG33Qg057664;
        Tue, 16 Jun 2020 16:03:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31p6dh0ehc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 16:03:27 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05GG3QJF031906;
        Tue, 16 Jun 2020 16:03:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jun 2020 09:03:26 -0700
To:     Keith Busch <keith.busch@wdc.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias =?utf-8?Q?Bj=C3=B8rling?= <matias.bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/5] nvme: support for multi-command set effects
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq18sgnm20o.fsf@ca-mkp.ca.oracle.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
        <20200615233424.13458-5-keith.busch@wdc.com>
Date:   Tue, 16 Jun 2020 12:03:23 -0400
In-Reply-To: <20200615233424.13458-5-keith.busch@wdc.com> (Keith Busch's
        message of "Tue, 16 Jun 2020 08:34:23 +0900")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9654 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=1 spamscore=0 cotscore=-2147483648 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160113
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Keith,

> The Commands Supported and Effects log page was extended with a CSI
> field that enables the host to query the log page for each command set
> supported. Retrieve this log page for each command set that an attached
> namespace supports, and save a pointer to that log in the namespace head.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
