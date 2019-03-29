Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB29EC4360F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3BE2183F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iwfo32a1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfC2OrJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:47:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32868 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfC2OrJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:47:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TEhrCu029197;
        Fri, 29 Mar 2019 14:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=NMr4oHOwP3T4qWks3AQa3MiIb3cwCzxFKAWkqrKiPpE=;
 b=Iwfo32a1B9uIEBywtWMi1BfEn7R/Z3VoR1+n4Y45ThRpDnXZpy90EEMtKKEHYsBeJeTC
 5ZaNWEZBeUWne5X5q/Xnf2G5O+8dBK2j327vpJRXXmQE7VlVH6LsZAIbXvQiDAOzujA7
 ub3IV+aMappZ4WmZ/eT7YzKQgcPGzkEb1qt4x9tcoxHE9q7cKbkVsjC5SmNdu789qZyS
 HCEa2lkVIhOXoyrXciacPzqV/G5VIlgicqs1PFHeqBHH4OG8NW7G8x8YEJPM/F27qhw9
 Cz7+zqTYME9WMmbXyTQYKhXvAFpPdSB104QJ2PMdGxktxLlQyPfAXy1AtOQMhWqqYiBC bQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2re6g1mumu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:46:58 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEkvha011090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:46:57 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEkv83000697;
        Fri, 29 Mar 2019 14:46:57 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 07:46:56 -0700
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        shirley.ma@oracle.com, allison.henderson@oracle.com,
        david@fromorbit.com, darrick.wong@oracle.com, hch@infradead.org,
        adilger@dilger.ca, tytso@mit.edu
Subject: Re: [PATCH v3 2/3] block: verify data when endio
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190329142346.1677-1-bob.liu@oracle.com>
        <20190329142346.1677-3-bob.liu@oracle.com>
        <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk>
        <yq1ftr5rbq1.fsf@oracle.com>
        <f65d6a7b-9e69-ae1e-b8b8-8769dc650311@kernel.dk>
Date:   Fri, 29 Mar 2019 10:46:53 -0400
In-Reply-To: <f65d6a7b-9e69-ae1e-b8b8-8769dc650311@kernel.dk> (Jens Axboe's
        message of "Fri, 29 Mar 2019 08:38:04 -0600")
Message-ID: <yq1bm1trb4y.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=433 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290105
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

> I didn't miss that, but it fixes nothing. That will unify the 40 bytes
> with 8 bytes, we're still growing the bio by a LOT. And we can't even
> nicely hide this behind some ifdef, sine distros enable everything and
> hence we're solving nothing by doing that.

We'll just need to handle it exactly like the integrity stuff. We only
allocate the extra bits when the underlying device indicates that it's
required and desired.

-- 
Martin K. Petersen	Oracle Linux Engineering
