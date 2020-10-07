Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D4DC41604
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 12:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A8320789
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 12:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vew8JAut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgJGMZ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 08:25:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52456 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgJGMZ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 08:25:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097CDRqH027911;
        Wed, 7 Oct 2020 12:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=JGR8vC/uBe2LDGQv6LyrmOF57YCCp0PyfzrndC+qryU=;
 b=Vew8JAuthTMwaEWpyDymHGn13+Nujnw9wfonF0J7j8wxOnIhbBrmFpwuz/gaR9fI97FQ
 QAq5y+1iElwIY7+zdclimFpOK8ROJn3ovna/syO0roE4Mxm5ijuCaBz/6yLT0jjDLhzs
 AkusK5htcRUu9aqSconRTQ8EUZjRh86wPC7CsjNzyh1LGgLywmH3yNiHUkPMyoUdSavm
 A2ZVJ1vQaFBJMWlniZjznp4eg29ufeIZ/eGDglsbOJRDPjPgO3NQHqdhhSJOjTjvxDjG
 BP9cpGDEuEsLtznVo4CmjfKZSuaoLQkXPBD7on2szhzv3hCkxu5cMnvi4uKIjz8xyj6Z 2A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33xhxn1bep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 12:25:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 097CFC1n151035;
        Wed, 7 Oct 2020 12:25:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33yyjh50at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 12:25:24 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 097CPL9G008261;
        Wed, 7 Oct 2020 12:25:22 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 05:25:21 -0700
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: soft limit zone-append sectors as well
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y2ki4431.fsf@ca-mkp.ca.oracle.com>
References: <2358a1f93c2c2f9f7564eb77334a7ea679453deb.1602062387.git.johannes.thumshirn@wdc.com>
Date:   Wed, 07 Oct 2020 08:25:19 -0400
In-Reply-To: <2358a1f93c2c2f9f7564eb77334a7ea679453deb.1602062387.git.johannes.thumshirn@wdc.com>
        (Johannes Thumshirn's message of "Wed, 7 Oct 2020 18:20:05 +0900")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=877 mlxscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=1 phishscore=0
 mlxlogscore=909 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070085
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Johannes,

> Cap the max sectors we submit via zone-append to the maximal number of
> sectors if the second limit is lower.

Yep, that's good. Nice and simple.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
