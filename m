Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71614C31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C782080A
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IbN9MD6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfFMQyg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:54:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54494 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730049AbfFMQyf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 12:54:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DGrps7137385;
        Thu, 13 Jun 2019 16:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=2qr3ZS03b7Do2yKuhnLF64PDdLnxqHZgHAUieuykJHo=;
 b=IbN9MD6Uc+pM4AJaFQvHKcmX/NLzHDwmBJ3HURu2IkSBQGP9xP8mUrbd6glBhlEpGJ75
 zu2XdO9nNxRIIdi4c/FFBD6myvsGBcWMecCf36nvnYFFxIBbAVcBU+dMnSy8zOmOXFSq
 5jogM/f2XkoiSmUjFDHCrrGWyJidD9b++U2TpRmGF0GVjjd6QgGDamoAMxdbCp5xhq+T
 jW7YZsAjH0FEQDRT1TTt8m7vH94vFT/qsHmdP9ADVRoYqqdePsZkaJpWibqHIIgMrgnI
 hMvVyvXu7nL1mcwITWoCQ8Na0aKOfeZl9h5Df7V3NZKA5b6+87EaB3W0faJlU6zhqx9g /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t04eu2wv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 16:54:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5DGqs4J158972;
        Thu, 13 Jun 2019 16:54:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2t1jpjnqv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jun 2019 16:54:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5DGs03L001109;
        Thu, 13 Jun 2019 16:54:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 13 Jun 2019 09:54:00 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, hch@lst.de, hare@suse.com
Subject: Re: [PATCH V2 2/2] block: add more debug data to print_req_err
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190613141629.2893-1-chaitanya.kulkarni@wdc.com>
        <20190613141629.2893-3-chaitanya.kulkarni@wdc.com>
        <d369fbbd-0d98-b804-619b-23049ee12398@acm.org>
Date:   Thu, 13 Jun 2019 12:53:57 -0400
In-Reply-To: <d369fbbd-0d98-b804-619b-23049ee12398@acm.org> (Bart Van Assche's
        message of "Thu, 13 Jun 2019 08:17:34 -0700")
Message-ID: <yq1d0jhtoii.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=863
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906130122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9287 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=907 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906130123
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Bart,

> If this patch gets applied there will be three copies in the upstream
> code that convert a REQ_OP_* constant into a string: one in
> blk-core.c, one in blk-mq-debugfs.c and one in
> include/trace/events/f2fs.h. Is it possible to avoid that duplication
> and have only one function that does the number-to-string conversion?

People often have a hard time correlating SCSI and block error messages
with tracing output. So in general I'd like to see us not just trying to
standardize the helper functions, but the actual output.

I.e. I think it would be great to print exactly the same string for both
error log messages and tracepoints. Since Chaitanya is doing a lot of
work in this area anyway, that may be worth looking into?

-- 
Martin K. Petersen	Oracle Linux Engineering
