Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA9C64E7B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 18:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D962151B
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 18:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ekYiuwCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392141AbgLASD0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 13:03:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:57622 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388050AbgLASD0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 13:03:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1HwvRR040439;
        Tue, 1 Dec 2020 18:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=P1mpOfu4mqqg0yBaXHt3rgr3kLQQe6sgixGPHZmgsiU=;
 b=ekYiuwCt3VTE/+8aispeJXJ1hgyXSs/mwRUbdluiQBmaXlT4n2fEzLM333S87QJsJWxd
 /Io3nec13MMFcTWuQahWBeGgVfEb1mwyMixV5JcEovPd94071GRcx9s+04sknu8DNLuh
 sOiGRtfYUB4c5bp2FxBcRHL1KjY8yuCH6Uz0+Zou4VJ7vIIMQFddTZPJfXkQQCtJLSeG
 ECjDmFT1eR1a3bOCgA9uXBZVVooVeOM0Cax3UNdkQvrJMdsic81dRKPNvlt6V4Ro54Nj
 HOeOqLzaCxei6uvObABAlvaEb6mt1Ypgzvf1qQuHvyFlTubwJoBQlOx+HvC4StBFRHer 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 353egkkyqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 01 Dec 2020 18:02:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B1I0KYF069497;
        Tue, 1 Dec 2020 18:02:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3540asrwys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Dec 2020 18:02:38 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B1I2a10032557;
        Tue, 1 Dec 2020 18:02:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Dec 2020 10:02:36 -0800
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        jdorminy@redhat.com, bjohnsto@redhat.com
Subject: Re: [PATCH v2] block: use gcd() to fix chunk_sectors limit stacking
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czztfls9.fsf@ca-mkp.ca.oracle.com>
References: <20201130171805.77712-1-snitzer@redhat.com>
        <20201201160709.31748-1-snitzer@redhat.com>
Date:   Tue, 01 Dec 2020 13:02:34 -0500
In-Reply-To: <20201201160709.31748-1-snitzer@redhat.com> (Mike Snitzer's
        message of "Tue, 1 Dec 2020 11:07:09 -0500")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9822 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010110
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Mike,

> And since commit 07d098e6bbad ("block: allow 'chunk_sectors' to be
> non-power-of-2") care must be taken to properly stack chunk_sectors to
> be compatible with the possibility that a non-power-of-2 chunk_sectors
> may be stacked. This is why gcd() is used instead of reverting back
> to using min_not_zero().

This approach looks fine to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
