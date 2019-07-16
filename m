Return-Path: <SRS0=S2CA=VN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E17C76192
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 14:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1EB2173B
	for <linux-block@archiver.kernel.org>; Tue, 16 Jul 2019 14:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mq44+sD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfGPOeg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jul 2019 10:34:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59340 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPOef (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jul 2019 10:34:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GEXc6X118762;
        Tue, 16 Jul 2019 14:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=wcok+3RTtJX2p3OrX5xAg1cYhVxypBr1vogRy8E1pFU=;
 b=mq44+sD1nwkd3jR7BkAOlS4XfhvqilkKUszGGdvUSTOZs5ifDo2PYykJXYHa+4OHXGr/
 6WOpQPK2bTNgjXvCfIUdYAq4hqIQ3wuhCaWvzJMSJELtAc/XlPCgZhCxQaGDmxtEcZic
 DWwKqQ7V7XSvoJ1nowjh9GvnHH299E1LNsvUNGrTV8Fx5GnfGF2qpaWjnUO0b/dmrJY0
 a6UIxVHTOTsX8yHhI5QnQMTWHjR0Uo34y433Q5Xq34FwtR7BB/H3jvSHf1f/wD8dx2Od
 c4l1phk7BaAWalKy8RtzLfjz7yr9XQM5mqtK7ZrH+4xY+n8Rtmdf3uusDgD1MBEZjIU5 wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tq7xqvv27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:34:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GEXI60002180;
        Tue, 16 Jul 2019 14:34:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tq5bcexm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:34:29 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GEYQWp001569;
        Tue, 16 Jul 2019 14:34:27 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 14:34:25 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] scsi: sd_zbc: Fix compilation warning
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190715053833.5973-1-damien.lemoal@wdc.com>
        <f4812ac1-dfae-73d7-4722-4158c38d2382@kernel.dk>
Date:   Tue, 16 Jul 2019 10:34:23 -0400
In-Reply-To: <f4812ac1-dfae-73d7-4722-4158c38d2382@kernel.dk> (Jens Axboe's
        message of "Tue, 16 Jul 2019 08:05:18 -0600")
Message-ID: <yq1ftn6121c.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=808
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160179
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=875 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160179
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

> Otherwise obviously looks fine to me. Martin, do you want to pick this
> one up?

Yep, I'll merge it.

-- 
Martin K. Petersen	Oracle Linux Engineering
