Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6826FC742A2
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 01:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3835C214AF
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 01:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s5I2SykH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfGLBKc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 21:10:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49122 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfGLBKc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 21:10:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C190T8103427;
        Fri, 12 Jul 2019 01:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=MyqDzkjr6SgCOR0LE/p7Ro+E9veAx/FsFO0PJBP+zok=;
 b=s5I2SykHMCXqEKOJBy+AJJiVoPi4G/NP6r2DM0Eq2+GncPYd8f7rzXC+Bqz2b/0Rv+z6
 q+kB9aAHxHogHjX+SxApdt4Gh0ZHq8tuaVp5gMWUCH6iCa/XyjOLZ/Q+MfYtcP3sGxns
 1tPTaWWPCynTX6hKISSVVtmB6bVxSPSihvUVvN7mQn9I+3+8wLalStvf0lNZ7GjVz+Cw
 rse1LMOx+srzvzC4E7Bdfdt6f5xtsiMi+7BwwwK99NdLoLzmK2R5M5XV+oU1DgBzJIvz
 CavZxOTXPAM/nv20+yD9Jq68Nm36y1uPN8LT775qaQV1O48pEYmJuUgbuvuLhtMwwlDA DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tjk2u30a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:10:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C17qkn178549;
        Fri, 12 Jul 2019 01:10:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tnc8tv0d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:10:24 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C1AMmt001737;
        Fri, 12 Jul 2019 01:10:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 18:10:22 -0700
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Wenwen Wang <wenwen@cs.uga.edu>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] block/bio-integrity: fix a memory leak bug
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1562872923-2463-1-git-send-email-wang6495@umn.edu>
Date:   Thu, 11 Jul 2019 21:10:20 -0400
In-Reply-To: <1562872923-2463-1-git-send-email-wang6495@umn.edu> (Wenwen
        Wang's message of "Thu, 11 Jul 2019 14:22:02 -0500")
Message-ID: <yq1lfx46osj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=779
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=846 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120013
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Wenwen,

> To fix this issue, free the allocated buffer before returning from
> bio_integrity_prep().

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
