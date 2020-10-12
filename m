Return-Path: <SRS0=jKGj=DT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69464C43457
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 19:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A66214DB
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 19:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nbuE09t5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390936AbgJLTHN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:07:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391168AbgJLTGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Oct 2020 15:06:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CJ3g8F109474;
        Mon, 12 Oct 2020 15:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=gqGNTRsi7oN6FIWvtwD5GKOM5T7beKDYWCtrptL5Xik=;
 b=nbuE09t5A/aR+i8sRzObYspqyG1n0XuucAljDJsbozair6HXn3cYRXlltqTTI1p/tdH1
 Ew0b47VM+FkDmLbU5IzrOCw6RnzBfzZLJoghbHvOfMXXMnta5wpqdOwj23Ux/Torss3O
 naFYwY4/y1yuZT/FiGesj9Z88NhokYXdZdHrwtfKnAYur1l1gNukWZjpqZ5Es3qaZYYv
 JAvuqTq7Z7mgr4i+3TJNcfKcisGNtBjX/RACkSwuXuMnkEKlJcJ6cckwH3GqdBIyZyws
 AtbJqVB+ThL/Hw6IK3tmmwfAlnXvvHxUGCFotINN/Sn2Wzb2v28XOQbzBT66aML5Lrk1 TQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 344v7y94hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 15:06:46 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09CJ34ZN003723;
        Mon, 12 Oct 2020 19:06:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 34347gtatx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 19:06:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09CJ6fI724248650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 19:06:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF69852051;
        Mon, 12 Oct 2020 19:06:41 +0000 (GMT)
Received: from imap.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 690665204F;
        Mon, 12 Oct 2020 19:06:41 +0000 (GMT)
Date:   Mon, 12 Oct 2020 21:06:37 +0200
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 00/10] DASD FC endpoint security
Message-ID: <20201012183550.GA12341@imap.linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_15:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010120141
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

quick ping. Are you going to apply this for 5.10?

Best regards,
Stefan

Stefan Haberland <sth@linux.ibm.com> schrieb am Thu, 08. Oct 15:13:
> Hi Jens,
>=20
> please apply the following patches that add a new DASD feature to show
> fibre channel endpoint security.
>=20
> The patches apply on you for-next branch and are intended for 5.10.
>=20
> The s390/cio patches should also go upstream through your tree this time
> since they are required for the DASD patches to build.
>=20
> Best regards,
> Stefan
>=20
> v1->v2:
>  - fix memleak in "s390/dasd: Fix operational path inconsistency"
>  - add comment suggested by Cornelia Huck
>=20
> Jan H=F6ppner (7):
>   s390/dasd: Remove unused parameter from dasd_generic_probe()
>   s390/dasd: Move duplicate code to separate function
>   s390/dasd: Store path configuration data during path handling
>   s390/dasd: Fix operational path inconsistency
>   s390/dasd: Display FC Endpoint Security information via sysfs
>   s390/dasd: Prepare for additional path event handling
>   s390/dasd: Process FCES path event notification
>=20
> Sebastian Ott (1):
>   s390/cio: Export information about Endpoint-Security Capability
>=20
> Vineeth Vijayan (2):
>   s390/cio: Provide Endpoint-Security Mode per CU
>   s390/cio: Add support for FCES status notification
>=20
>  arch/s390/include/asm/ccwdev.h   |   2 +
>  arch/s390/include/asm/cio.h      |   1 +
>  drivers/s390/block/dasd.c        |  22 ++--
>  drivers/s390/block/dasd_devmap.c | 109 +++++++++++++++++++
>  drivers/s390/block/dasd_eckd.c   | 175 +++++++++++++++++++++----------
>  drivers/s390/block/dasd_fba.c    |   2 +-
>  drivers/s390/block/dasd_int.h    | 111 +++++++++++++++++++-
>  drivers/s390/cio/chp.c           |  15 +++
>  drivers/s390/cio/chp.h           |   1 +
>  drivers/s390/cio/chsc.c          | 145 +++++++++++++++++++++++--
>  drivers/s390/cio/chsc.h          |   3 +-
>  drivers/s390/cio/device.c        |  15 ++-
>  12 files changed, 523 insertions(+), 78 deletions(-)
>=20
> --=20
> 2.17.1
>=20
