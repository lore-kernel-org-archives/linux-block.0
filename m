Return-Path: <SRS0=SzsG=WD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D6C32751
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 16:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F279721BE6
	for <linux-block@archiver.kernel.org>; Wed,  7 Aug 2019 16:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tHivpiIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfHGQJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:09:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47120 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGQJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 12:09:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77G4FDP083468;
        Wed, 7 Aug 2019 16:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=S+9K2lIF+033jPwHdL6JaebTLAXp/BEK2P9DPkT2MB4=;
 b=tHivpiIw1bNgysYk0lyNW8KsRzDfiquxPencLz+RSs1EIqtMyhCEm6eBxlqC4vDx3gqI
 HB5UgtsU7Wo87+l4M1hlO9evOPc9TMJ8GSUOP5oVehuY+MSKEst7PasLUHRrF8yNhd0f
 Gjw13sUlFM8NmVfpdp2YHEsJxPG4kGamdrD0oAPhmRjIzkQYvF8UfieJm66w+YgvhMRt
 FYPMQDl3rg56GYcDHRG+LHzMCnVbmcaKHaRG69/rD4cmKHhgXAUas1g7ff7f0jRtpWuA
 vBmdTgqRDRjhRGWoA2Drl9ZfJyLAtOuRMuLWxozYMiqB9Uxifmn++c8sKExWbJO230TP WQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u527pwafp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 16:09:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x77G3JFB158155;
        Wed, 7 Aug 2019 16:09:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2u7578359n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 16:09:05 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x77G94WD021390;
        Wed, 7 Aug 2019 16:09:04 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 09:09:04 -0700
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, martin.petersen@oracle.com
Subject: Re: [PATCH] block: fix RO partition with RW disk
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190805200138.28098-1-junxiao.bi@oracle.com>
        <b191908b-cc67-660a-468e-2f4164f430ba@oracle.com>
Date:   Wed, 07 Aug 2019 12:09:02 -0400
In-Reply-To: <b191908b-cc67-660a-468e-2f4164f430ba@oracle.com> (Junxiao Bi's
        message of "Wed, 7 Aug 2019 08:59:27 -0700")
Message-ID: <yq1v9v9ez4x.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=731
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=798 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070163
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Junxiao,

> Anybody could help review this bug?

It's on my list. However, your patch is clashing with my general
read-only handling changes so I'll probably need to roll your changes
into mine.

I'll try to look at this today.

-- 
Martin K. Petersen	Oracle Linux Engineering
