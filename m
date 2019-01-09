Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37818C43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 03:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32162146F
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 03:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jN9rpB0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfAID33 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:29:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:59672 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfAID33 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 22:29:29 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x093O7mr002323;
        Wed, 9 Jan 2019 03:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=spBBlpVZSRLbv+Z/s2zdbrGS08E8MQ1eEGTk1+x01YY=;
 b=jN9rpB0Ne/DqaqzdTf90Eeb5P6UOUHulsKbay3FQJf1RyuXicdfjoGodd0Ys8YXlWR/J
 0fPy/xB5STylVg4egzlDik0Z5y+rOA3h6G5TZMbvQEyyV365kmjtdJfU+ceY4ZztZCmH
 ZWFs5ZboeSG2to8pTdjuS3JKmSq9+Kb6r/fzEy5H0gSVKs+QNNM1GAx7lSlOKRtTcwc/
 V02VdPmXSoYcgv+B4j4fn14rYesJMbc8gDoOHyXaWYQJYrp7KlM8mOGT1QiFRxZiB28m
 BezQL/GiVW72y+Df+m9npT2qLbU18JQ0sfWj1B7AT9YYsmou9hLx7vCd2gpdbY7Deuje ag== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2ptj3dy8wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Jan 2019 03:29:15 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x093TE8v025019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jan 2019 03:29:14 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x093TCdS023074;
        Wed, 9 Jan 2019 03:29:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Jan 2019 19:29:12 -0800
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] scsi: isci: initialize shost fully before calling scsi_add_host()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190108205043.3122-1-logang@deltatee.com>
Date:   Tue, 08 Jan 2019 22:29:09 -0500
In-Reply-To: <20190108205043.3122-1-logang@deltatee.com> (Logan Gunthorpe's
        message of "Tue, 8 Jan 2019 13:50:43 -0700")
Message-ID: <yq1d0p64igq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9130 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=566
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901090026
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Logan,

> To prevent this, the calls to scsi_host_set_prot() are moved into
> isci_host_alloc() before the call to scsi_add_host(). Out of caution,
> also move the similar call to scsi_host_set_guard().

Applied to 5.0/scsi-fixes. Thanks much!

-- 
Martin K. Petersen	Oracle Linux Engineering
