Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6984DC31E4A
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AAE20665
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pVaEVNnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfFMQy6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:54:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36544 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfFMQy6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 12:54:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DGrgUt146687;
        Thu, 13 Jun 2019 16:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=q9ZaA3ByF1gQosAyZKZDMom7ko5ovc0h/XE7p+nG8GA=;
 b=pVaEVNnbL+c6NkDZ2A6lOaGZGZ39xoORuGvzaKGx/bihTcK54K5n8qqF9urwaEb9SLdn
 K+SQyYGWOZsaqZTcunFN7P6DrMP5OIP+8fhjAL+8fPZUcRlG8gF5fM+KWaaschlShJYp
 CtwJ++2FicV65AF9KnLys/S6DEL1YdV8KPVuBzz0chYQnyCRn19Qe8nr1YUakd6Gw8n9
 qtyD/zMYRsm31sR41St13S77afqOG9GmK1JOlYv+Ei152nIDYvVCcFGKQUTUTrk5yWns
 OyUXiloSJ5SLD0zSOOa/JAZ+JOmdPzFHSS7j35wC8NBa4abXd0vEPhJVKR2krfniejK1 eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t05nr2tnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 16:54:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DGrMmk086707;
        Thu, 13 Jun 2019 16:54:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2t024vmexg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 16:54:57 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5DGsuju006443;
        Thu, 13 Jun 2019 16:54:56 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Jun 2019 09:54:56 -0700
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] block: use req_op() to maintain consistency
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
References: <20190613141421.2698-1-chaitanya.kulkarni@wdc.com>
Date:   Thu, 13 Jun 2019 12:54:54 -0400
In-Reply-To: <20190613141421.2698-1-chaitanya.kulkarni@wdc.com> (Chaitanya
        Kulkarni's message of "Thu, 13 Jun 2019 07:14:21 -0700")
Message-ID: <yq18su5togx.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=566
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=629 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130123
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Chaitanya,

> This is a pure code cleanup patch and doesn't change any functionality.
> In block layer to identify the request operation req_op() macro is
> used, so change the open coding the req_op() in the blk-mq-debugfs.c.

Looks good.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
