Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61564C2D0E2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 19:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE22723600
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 19:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vuiZ0qMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIVTan (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 15:30:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34886 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVTan (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 15:30:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MJTLAh037210;
        Tue, 22 Sep 2020 19:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Hu9Gzbb5ENODYaMqbCOGcOYHiVcqPmnDxe8ZihVzAzE=;
 b=vuiZ0qMHRdJVlEYEY21x8n7vbHaSX5yDImuVNlT831MwjKrLdzZF/MLiqRxpk4ZSJbXA
 gZey8R/F1+isWHvffVfQrWjtzldKb3HhP5vSkgSZNCDbDvaUdAfMAzFJ0INbpe0aD+5n
 avelCw2ThToeouRrsSTdBiwPPBRpLzFxZS7qt/a0rMTjSvaEW+Cr5S5wa5eI8nzHvhCd
 ooTpzvgfD06GmODpqNvZNBXPJ3s7X8n6649Kf4uVWGl9zMcMUmfi8Kmcihews8fSKILM
 dRaJ8bMkfdAG9pszBzNDGxRdtXbVS/RpeHaHwcoG+bNoh6LEpS+R7njm8tUJVRZ4HgBo rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33q5rgd3wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 19:30:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MJPPm7154691;
        Tue, 22 Sep 2020 19:30:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33nuwyvnbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 19:30:38 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08MJUanE025084;
        Tue, 22 Sep 2020 19:30:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 12:30:36 -0700
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 4/6] block: allow 'chunk_sectors' to be non-power-of-2
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wo0lpq2d.fsf@ca-mkp.ca.oracle.com>
References: <20200922023251.47712-1-snitzer@redhat.com>
        <20200922023251.47712-5-snitzer@redhat.com>
Date:   Tue, 22 Sep 2020 15:30:34 -0400
In-Reply-To: <20200922023251.47712-5-snitzer@redhat.com> (Mike Snitzer's
        message of "Mon, 21 Sep 2020 22:32:49 -0400")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=1 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1011 suspectscore=1 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220151
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Mike,

> It is possible, albeit more unlikely, for a block device to have a non
> power-of-2 for chunk_sectors (e.g. 10+2 RAID6 with 128K chunk_sectors,
> which results in a full-stripe size of 1280K. This causes the RAID6's
> io_opt to be advertised as 1280K, and a stacked device _could_ then be
> made to use a blocksize, aka chunk_sectors, that matches non
> power-of-2 io_opt of underlying RAID6 -- resulting in stacked device's
> chunk_sectors being a non power-of-2).
>
> Update blk_queue_chunk_sectors() and blk_max_size_offset() to
> accommodate drivers that need a non power-of-2 chunk_sectors.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
