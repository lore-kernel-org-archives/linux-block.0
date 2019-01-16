Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A07C43444
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 02:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1196B20859
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 02:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EauE9qCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfAPCyc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:54:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33580 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfAPCyb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 21:54:31 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0G2n0IT059256;
        Wed, 16 Jan 2019 02:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Zz8m98MU4N2uGF+u5jyRhPDg9Shkpx1mVlDyrwF/fPU=;
 b=EauE9qCQc/LfVXMrB0SGFs93iQKmdYvqsRs9whM3rkzcBPZJ5wxtJ3OMBYOzbDnfCCRe
 3mE+WKv9R5MwZvXLVrv2xZoTkooIA7C71OAknT93HTkQj6vKvpHji30ksq8LbCFdLzLR
 Z35WZSjQHQXFJO/sO9qdosriPAxYr90NlNWElbK+LSCPHn5sBKa2SOttNr6KguO4MlMT
 nYC6PTj//bxZvDyzExwKH6R4NV4Z5pMV5e4q7Ih33kQyiUFl8m+jFY8JeEaYQM7+tXCw
 VDOQfBetBbpD5/apmJ1aw9lR5MxJF2UNv4xCmhhLc46aCwFO4z+AwTuymrE2khH/VL6A cg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2pybjs7buh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 02:54:12 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0G2s6fI012763
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jan 2019 02:54:06 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0G2s4Tc025392;
        Wed, 16 Jan 2019 02:54:05 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Jan 2019 18:54:04 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        <linux-scsi@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Intel SCU Linux support <intel-linux-scu@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Jeff Moyer <jmoyer@redhat.com>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] scsi: isci: initialize shost fully before calling scsi_add_host()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190108205043.3122-1-logang@deltatee.com>
        <20190109184105.GB22070@lst.de>
        <8d96b40d-fc83-9218-9479-3de423594ddb@huawei.com>
        <yq1lg3qy578.fsf@oracle.com>
        <0ffaf166-c7e5-b135-fdc5-bcac24148e62@huawei.com>
Date:   Tue, 15 Jan 2019 21:54:01 -0500
In-Reply-To: <0ffaf166-c7e5-b135-fdc5-bcac24148e62@huawei.com> (John Garry's
        message of "Mon, 14 Jan 2019 12:10:23 +0000")
Message-ID: <yq1sgxts46u.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9137 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=886
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901160020
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi John,

>> So in this case I think that accessor functions are actually better
>> because they allow us to print a big fat warning when you twiddle
>> something you shouldn't post-initialization. So that's something I think
>> we could--and should--improve.
>>
> Sure, this is an alternative, but I would rather make it obvious when
> these parameters should be set so that this would not be required.

I would like to have a mechanism in place that warns if you twiddle
things that break assumptions made at host registration time. That's not
a scenario the old registration interface was designed to handle.

I am not sure I agree with your assertion that setting these masks in
the struct prior to scsi_add_host() makes this ordering requirement much
more obvious. It is not like you are passing in a list of parameters and
then receiving a separately instantiated immutable scsi_host object. You
are performing an operation on something you already have and own.

That's why I commented that the current intersection between
compile-time static host template, dynamically discovered
pre-registration scsi_host parameters, and the registered runtime
scsi_host struct is somewhat messy.

Btw. I have no attachment to the prot wrappers whatsoever. The reason
they exist is that the SCSI integrity support was optional. And
therefore we had stub functions so things could be compiled without any
of the integrity fields being present in the various SCSI structs. So I
don't have any problem killing the wrappers except they may actually be
handy for regressions like this one where you could #error if the driver
writer violates the ordering requirement.

-- 
Martin K. Petersen	Oracle Linux Engineering
