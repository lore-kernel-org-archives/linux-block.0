Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8565C433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 02:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F3220707
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 02:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fACpV1lG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgFPCZr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:25:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43346 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgFPCZp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 22:25:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05G2M3UG064702;
        Tue, 16 Jun 2020 02:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=VlICDy7edvgzVgA+O0X0Ww8RKymsFN+Ai0i5tfOaRa8=;
 b=fACpV1lG+HEmDBx7BgF48E5lH3PruiGloSqoMHAfh1KBV9X9fELRCkceLtMOViXKLR7k
 niXtB7JY4jz4SU6NPetTt7d9qT0xMz4ZN7DpSopeuWLk08TLUB1/SjE/ZcJf19+lwgbD
 JnLvx80wZuTk4zwpDOAgophWMz0OyPllK+M8W0anQKQak8/oT6vbX+Eyo/FELnqHFlJT
 g/ffMObppU2mqCqq09DDBKAp7GmU0vs26ZYb5ECqJJEMR0IfkFe8RzGrV7dpffoQEpeK
 hbWGlfNPI2/l0zy6UWaLpyLPz1rD1QbBLAA5JYM5qb5e10wvg7GOGIMB+8yhYqHSKEaI FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31p6s241qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jun 2020 02:25:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05G2N2FB009258;
        Tue, 16 Jun 2020 02:25:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31p6s6f286-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 02:25:32 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05G2PVYx015589;
        Tue, 16 Jun 2020 02:25:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jun 2020 19:25:30 -0700
To:     John Dorminy <jdorminy@redhat.com>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-block@vger.kernel.org, tytso@mit.edu,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: add split_alignment for request queue
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lfknoio7.fsf@ca-mkp.ca.oracle.com>
References: <20200616005633.172804-1-harshadshirwadkar@gmail.com>
        <CAMeeMh9X0zNSmyxaHCJCXT0m3eaeTzdJ=NZREXUgRmsfM1crsQ@mail.gmail.com>
Date:   Mon, 15 Jun 2020 22:25:27 -0400
In-Reply-To: <CAMeeMh9X0zNSmyxaHCJCXT0m3eaeTzdJ=NZREXUgRmsfM1crsQ@mail.gmail.com>
        (John Dorminy's message of "Mon, 15 Jun 2020 22:14:05 -0400")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=1 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9653 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 malwarescore=0 suspectscore=1 spamscore=0 cotscore=-2147483648 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006160015
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


John,

> Reading through this change, split_alignment appears similar in my
> mind to limits->io_opt.

io_opt is a hint which requests that the submitter does not issue any
I/Os that are larger than this size. io_opt is smaller than or equal to
the device's hard limit for I/O size. In the standards space it's
described as "issuing an I/O larger than this value may incur a
processing penalty". So not quite what you're looking for.

However, we have chunk_sectors queue limit which is honored for splits.

-- 
Martin K. Petersen	Oracle Linux Engineering
