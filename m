Return-Path: <SRS0=1fuv=XR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76888C3A5A2
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 17:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4363520820
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 17:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LjLexqsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfIVRb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Sep 2019 13:31:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35570 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfIVRb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Sep 2019 13:31:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8MHTMX3005106;
        Sun, 22 Sep 2019 17:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=7XSu8t6qSHHoAAM+YeOLuimzL3lhIqqGnOZU6z3aQGU=;
 b=LjLexqsXiqcsLEBI8Lte386w0xYftcFIo4j8UnBw3nztZuGozHblODeWmJN/cBccu2vg
 xGrOvcAY72LEf/rZNO0A6APGtXaYeXK6zObe6dhoECDG61H0Fr5FYu2W6IpkZHEEaRLv
 +i3H+dKR/PDJUtP7nNgHypBJ88al678ip+YFfAUJ4ACo8O3Hb2JX+mt/ou9Grea2LgGo
 nrV+LPaTn3a60FAq6S4pUkTMNAgcSdWowKiXjjqr247bYZ9uD+1XYRwOgeiK/bWrcfd5
 E5PIQjSFL3V71ytcXDtea2TqK6W/irytfxsnnjNRwjUDaQkbqxx1p+SaESeQI7n4i1K3 uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2v5cgqk7tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Sep 2019 17:31:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8MHSXaV028242;
        Sun, 22 Sep 2019 17:31:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2v5bpen0d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Sep 2019 17:31:18 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8MHVBNh017262;
        Sun, 22 Sep 2019 17:31:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 22 Sep 2019 10:31:11 -0700
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] block: add default clause for unsupported T10_PI types
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1569103249-24018-1-git-send-email-maxg@mellanox.com>
        <6e99fefd-ff7c-e3ee-087c-ed42baa7f4f5@kernel.dk>
        <yq1tv955kfy.fsf@oracle.com>
        <a0505439-2bf3-3297-2e8d-5cc0b24cafee@kernel.dk>
        <423a031c-a016-96c6-97ee-fb4e49a0f247@mellanox.com>
        <ddd909c8-1309-5830-0669-371d2ae839fc@kernel.dk>
Date:   Sun, 22 Sep 2019 13:31:09 -0400
In-Reply-To: <ddd909c8-1309-5830-0669-371d2ae839fc@kernel.dk> (Jens Axboe's
        message of "Sun, 22 Sep 2019 10:25:14 -0600")
Message-ID: <yq1o8zc5jc2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9388 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909220184
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9388 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909220185
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

> It's effectively the same thing, I really don't think we need (or should
> have) a BUG/BUG_ON for this condition. Just return an error?

> Just include a T10_PI_TYPE0_PROTECTION case in the switch, have it log
> and return an error. Add a comment on how it's impossible, if need be.
> I don't think it has to be more complicated than that.

The additional case statement is inside an iterator loop which would
bomb for Type 0 since there is no protection buffer to iterate
over. We'd presumably never reach that default: case before
dereferencing something bad.

t10_pi_verify() is a static function exclusively called by helpers that
pass in either 1 or 3 as argument. It seems kind of silly that we have
to jump through hoops to silence a compiler warning for this. I would
prefer a BUILD_BUG_ON(type == T10_PI_TYPE0_PROTECTION) at the top of the
function but that does not satisfy the -Wswitch logic either.

Anyway. Enough energy wasted on this. I'm OK with either the default:
case or Max' if statement approach. My objection is purely
wrt. introducing semantically incorrect and/or unreachable code to
silence compiler warnings. Seems backwards.

-- 
Martin K. Petersen	Oracle Linux Engineering
