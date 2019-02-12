Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A50C282C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8401206A3
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mguxkzXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfBLQ7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:59:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45774 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfBLQ7j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 11:59:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1CGsNl4155634;
        Tue, 12 Feb 2019 16:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=3d7aRkfIc/8qoA7b3ZFbgX2IeFUVd3mE9T+3hDqpLOg=;
 b=mguxkzXo46FaMgMUbG0+fSF9fAGJe7NoUNaQU5u2JYzHcHPIaUtLqiVrGzmr4euXzP+4
 ypTZqRyhscztpShps2C9QrzeD15hxUbhURuOLtMjhxu3mA50SwEU/4VaGf1WBYjMRsy9
 EvFa77+AXXur7sERvPsTYks+a/aRrHmJT0Bmru0Uz3ak8E45ZhA9PA4LWfhx8bm9OgVN
 TlGjbevX7HDVLSSd8Zx0rg2iCzlrFIKMB6hu8HPBF+Udw7sycZ/WVMEgKr9C7SaVFgwh
 PMgVDmF49hp75F6bbGhYccoHzUxSGNES+nWyZsC5iqVtY05tJMaxATVLOsQJxik75mp4 0Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qhrekd728-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 16:59:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1CGxVwL012693
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 16:59:31 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1CGxU7M030199;
        Tue, 12 Feb 2019 16:59:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Feb 2019 08:59:30 -0800
To:     Jens Axboe <axboe@kernel.dk>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Xuewei Zhang <xueweiz@google.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mikael Pettersson <mikpelinux@gmail.com>
Subject: Re: [PATCH] scsi: sd: fix entropy gathering for most rotational disks
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1549987525.3173.17.camel@HansenPartnership.com>
        <e9a411a2-49e2-4897-4e02-1cf790465cbd@kernel.dk>
Date:   Tue, 12 Feb 2019 11:59:27 -0500
In-Reply-To: <e9a411a2-49e2-4897-4e02-1cf790465cbd@kernel.dk> (Jens Axboe's
        message of "Tue, 12 Feb 2019 09:06:29 -0700")
Message-ID: <yq1zhr1t028.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=581 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120120
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

>> The fix is to set the non-rotational and add-randomness flags
>> unconditionally early on in the disk initialization path, so they can
>> be reset only if the device actually reports being non-rotational via
>> the VPD page.
>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Yeah, this looks good to me. I'll queue it up for fixes.

-- 
Martin K. Petersen	Oracle Linux Engineering
