Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E47CC32771
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 03:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D187C2064C
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 03:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c5EvVJD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgAGD1e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:27:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53176 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgAGD1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 22:27:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0073EwKZ034820;
        Tue, 7 Jan 2020 03:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=B1fEfXcmudzYDpycB2sHvLevj9JrFyQgfYJLfDNSU98=;
 b=c5EvVJD7gPBw/CSXI8l7nc/f+4Au9HC/nriKUDKL2HIYhYuckEuDGh+JxBHKeTSQ2It2
 557QXhvuugfbM8NAZPQSh6Z/jEc0qrmNsZpJXiTGPgrrS6TXUVb1oEC0cCCDs+uwh1hP
 Ly9MsUJEEGsr39/30ellO9GN9fEah+des6MSJJxgtl9Oqk3wz11CCPJnMFrEOikY+hZV
 Q+93RnBSH/wmUpz6WVdlOW0frIGRtjwO7qKNhBCqPFe+rJkRtfudWTfur1qsyi47j8pA
 hAiK/TPB9kmo1hjoXH487PgJYh8U1FM6h5QACwaEBwZmNWgoLoAlCP/m1MPIYoFdmfVc dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xakbqjqen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 03:27:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0073EN5i106084;
        Tue, 7 Jan 2020 03:25:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xb4v26rst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 03:25:23 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0073PKOh019431;
        Tue, 7 Jan 2020 03:25:21 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 06 Jan 2020 19:25:20 -0800
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Allow t10-pi to be modular
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20191223081351.gsunwl6zwcltfdy6@gondor.apana.org.au>
Date:   Mon, 06 Jan 2020 22:25:18 -0500
In-Reply-To: <20191223081351.gsunwl6zwcltfdy6@gondor.apana.org.au> (Herbert
        Xu's message of "Mon, 23 Dec 2019 16:13:51 +0800")
Message-ID: <yq1k1642bj5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=924
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070025
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070025
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Herbert,

> Currently t10-pi can only be built into the block layer which via
> crc-t10dif pulls in a whole chunk of the Crypto API.  In fact all
> users of t10-pi work as modules and there is no reason for it to
> always be built-in.
>
> This patch adds a new hidden option for t10-pi that is selected
> automatically based on BLK_DEV_INTEGRITY and whether the users of
> t10-pi are built-in or not.

Looks fine to me.

-- 
Martin K. Petersen	Oracle Linux Engineering
