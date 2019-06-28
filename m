Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DB8C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863E120828
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F8E/p0Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfF1UW0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:22:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47056 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfF1UWZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 16:22:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SKK2wd103215;
        Fri, 28 Jun 2019 20:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=xsGpN473e05pBRrONXnDBGQ3cVxZcV+vMPGTxlOXRLg=;
 b=F8E/p0JfweHEBOxT2Ql7vQbSF21j7Egp6Gk+7eGJ0q7ma9ChsxdVLkJJZSRvqnejVUgo
 VTHFprCIdIWp+34VwLhOJ5yb35UD9fQSwS17mgsrGJMFzQWuYkGgVR4+0vroGnYGPDdw
 LZB/9DRuxI2tcT1BMeyoRWmwvnSSo1IkUsG4XOEi+DxWma5QuQttoEb3ygI4uj+P6G7x
 g1z/u5/EWhOM7dPZLG7Hz2vxdzr0R5TdotQVkxsJ1WPy4GOWy7tT4YdQpSCX+wvaWCtx
 QcEfHvpmQyIQKTaX4VpFCht3f4pUWKRMqd+k1CFHnb7ItVMjbZNCfQ1yeatqQcQQyBFY sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t9c9q7e1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 20:22:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SKKq9r189614;
        Fri, 28 Jun 2019 20:22:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2t9p6w3e4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 20:22:19 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5SKMIEA029464;
        Fri, 28 Jun 2019 20:22:19 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 13:22:17 -0700
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] block, documentation: Fix wbt_lat_usec documentation
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190628200745.206110-1-bvanassche@acm.org>
        <20190628200745.206110-2-bvanassche@acm.org>
Date:   Fri, 28 Jun 2019 16:22:15 -0400
In-Reply-To: <20190628200745.206110-2-bvanassche@acm.org> (Bart Van Assche's
        message of "Fri, 28 Jun 2019 13:07:42 -0700")
Message-ID: <yq1h889h348.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=894
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280232
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=947 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280232
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Bart,

> Fix the spelling of the wbt_lat_usec sysfs attribute.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
