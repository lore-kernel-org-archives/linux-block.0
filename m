Return-Path: <SRS0=12de=XQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BF3C4360D
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 22:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4217620C01
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 22:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UKbhBn4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfIUW5S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Sep 2019 18:57:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43838 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfIUW5S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Sep 2019 18:57:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8LMv6uE146248;
        Sat, 21 Sep 2019 22:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=S9Nb5pSjLqpieBDXKKEf5OjlQR1BdT5jvKDTWKH25vg=;
 b=UKbhBn4uUxXwwXeCTwRoZ/YPWfjtBiEmP6bEqiDv02RslkKRfAFZKMzQe8eSvOJXUxyE
 g2EEoKKAfrJqWBiGiqBM4qULGmL4MSDOPZsYt1mLIGUUKNIPu9rj0qyzLzRTYtZpKlaI
 8B8P8yOK58B5livPsSvqFYqUiEXEWUJc/zlIxBOwpaoMRtPVEneluhIOpck8QbGa6XRB
 9c19tc0ygDl/lS/nWaGaTR08ED3YIMaxeYT/NrL9l7lExIu+NSvZ3f+MyQ4TJ3T0RFS2
 m8ZX+083a620I1wb8m2ttWNzUvLGMLgN2WgC6vXaAObbguRWJ3QMlt/+hlvMTUdqlIYP 0A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2v5cgqht2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Sep 2019 22:57:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8LMric5084325;
        Sat, 21 Sep 2019 22:55:06 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2v5b75vnfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Sep 2019 22:55:05 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8LMsxhs020822;
        Sat, 21 Sep 2019 22:54:59 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 21 Sep 2019 22:54:59 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        martin.petersen@oracle.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] block: add default clause for unsupported T10_PI types
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1569103249-24018-1-git-send-email-maxg@mellanox.com>
        <6e99fefd-ff7c-e3ee-087c-ed42baa7f4f5@kernel.dk>
Date:   Sat, 21 Sep 2019 18:54:57 -0400
In-Reply-To: <6e99fefd-ff7c-e3ee-087c-ed42baa7f4f5@kernel.dk> (Jens Axboe's
        message of "Sat, 21 Sep 2019 16:12:20 -0600")
Message-ID: <yq1tv955kfy.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9387 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=759
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909210255
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9387 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=839 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909210255
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

>> block/t10-pi.c: In function 't10_pi_verify':
>> block/t10-pi.c:62:3: warning: enumeration value 'T10_PI_TYPE0_PROTECTION'
>>                       not handled in switch [-Wswitch]
>>        switch (type) {
>>        ^~~~~~
>
> This commit message is woefully lacking. It doesn't explain
> anything...?  Why aren't we just flagging this as an error? Seems a
> lot saner than adding a BUG().

The fundamental issue is that T10_PI_TYPE0_PROTECTION means "no attached
protection information". So it's a block layer bug if we ever end up in
this function and the protection type is 0.

My main beef with all this is that I don't particularly like introducing
a nonsensical switch case to quiesce a compiler warning. We never call
t10_pi_verify() with a type of 0 and there are lots of safeguards
further up the stack preventing that from ever happening. Adding a Type
0 here gives the reader the false impression that it's valid input to
the function. Which it really isn't.

Arnd: Any ideas how to handle this?

-- 
Martin K. Petersen	Oracle Linux Engineering
