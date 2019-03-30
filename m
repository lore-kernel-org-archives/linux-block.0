Return-Path: <SRS0=7fUu=SB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E79DC4360F
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 02:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3656218D9
	for <linux-block@archiver.kernel.org>; Sat, 30 Mar 2019 02:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aGExxa4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfC3CRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 22:17:45 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49842 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbfC3CRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 22:17:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2U2F9aF169089;
        Sat, 30 Mar 2019 02:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=YLx/EyDULt8jFC0kooQ/Icu4Sr96cI4UQiIE+WeD9rc=;
 b=aGExxa4NcRvLFAHBi+ijxYK7Ia95PDh7Z4sO8nuwPjnIPsgKB8X+kb5v8DxzhA+GHgHs
 2+AeT4u2ZBZ3mWcNVmJDYNFEA29/Q5nxwXdIeB99HueqWRqGwLVe/ToQsqc7dg7kAgjV
 xX1u/5anQiPySM6YNS0NQUlgQe+ICCpIEJjs+Ma61JyTDBbokTSDSj4iq+0xS9VpG3nX
 dpgx6D6QZ7wy09ujbb6mFQWELnX9P/kFV7eeD1hQR2DkwkNGrUBl+eildBsuXtvopVZy
 +7i3dsXy3fqGmjRuXRdJziLrgab8AJ8nBGgfaA3gLOQskHb7JFCa8TjoSxsFEskatulS /w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2rhwycr46t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Mar 2019 02:17:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2U2HT1q007769
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Mar 2019 02:17:30 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2U2HQBs027812;
        Sat, 30 Mar 2019 02:17:26 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 19:17:25 -0700
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bob Liu <bob.liu@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        tytso@mit.edu
Subject: Re: [PATCH v3 2/3] block: verify data when endio
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190329142346.1677-1-bob.liu@oracle.com>
        <20190329142346.1677-3-bob.liu@oracle.com>
        <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk>
        <yq1ftr5rbq1.fsf@oracle.com>
        <f65d6a7b-9e69-ae1e-b8b8-8769dc650311@kernel.dk>
        <yq1bm1trb4y.fsf@oracle.com>
        <feefa611-b744-326c-29d5-c64bcda45d9f@kernel.dk>
        <yq17echrax1.fsf@oracle.com>
        <1b638dc2-56fd-6ab4-dcca-ad2adb9931bb@kernel.dk>
        <c9adb48c-7b6e-2017-9480-aa2342b3523b@oracle.com>
        <7599b239-46f4-9799-a87a-3ca3891d4a08@kernel.dk>
Date:   Fri, 29 Mar 2019 22:17:22 -0400
In-Reply-To: <7599b239-46f4-9799-a87a-3ca3891d4a08@kernel.dk> (Jens Axboe's
        message of "Fri, 29 Mar 2019 09:03:47 -0600")
Message-ID: <yq1imw1p0lp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9211 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903300014
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

> You will not need a callback in the bio, you will just have a private
> end_io function for that particular bio that does the verification.

The saving grace for the integrity stuff is that once all the child bios
complete, we no longer care about their completion context and we have
the parent bio submitted by the filesystem we can use to verify the PI
against.

For the redundant copy use case, however, I am guessing that the
filesystem folks would want the same thing. I.e. verify the structure of
the data received once the parent bio completes. However, at that point
all the slicing and dicing completion state is lost. And thus there is
no way to know that the failure was due to mirror B two layers down the
stack. Nor is there any way to retry the I/O without having recorded a
completion breadcrumb trail for every child bio.

The other approach is the callback where each stacking layer--which
knows about redundancy--can do verification of a bio upon completion.
However, that suffers from another headache in that the I/O can get
arbitrarily sliced and diced in units of 512 bytes. And thus the
filesystem verification function would have to be able to verify an
arbitrary multiple of 512 bytes at any 512-byte offset inside a
submitted bio. That would work, but I don't think that's the pony the
filesystem were wishing for?

-- 
Martin K. Petersen	Oracle Linux Engineering
