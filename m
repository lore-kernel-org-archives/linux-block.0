Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45974C49ED7
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190C020692
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 22:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nN6VaWvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404042AbfIMW0f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:26:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35902 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404021AbfIMW0f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 18:26:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DMNsWp160207;
        Fri, 13 Sep 2019 22:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=OZnRhPBFkRNdQEDSDNufHHb1pX04L97xZA72gxBrre8=;
 b=nN6VaWvATXow0wgKJZr7b/vAlW05otgsmT3jGRaluSdvMiH4MxlL/Wcz7/eLyuGvdMXO
 YCTmiDs/tb/tguJLwkmQtgQl6SJEWC+xv+tsrtg1FyzhjTXF4JcismyeUQVcFVyaxUvw
 YVHIpgYfDFdyPvIqdainaXNzFP/EWETXRRFGUVRgmOG8fVCHU9JiQhVKPWNlnxEQRKWy
 UDH7EZdzhQZ2osDEIbGnqSqAyXPjhDnWLsIN3rdkIn4eGTmQIzQ0oWQdDxIIz5CGOwQg
 VeYH97+u3Rv8hRKxyztDVy2SwsfTH0NLp6Ms56fIlq8C2i2WyOJZcmrqaiM0Niu1nGZr uA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uytd37act-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 22:26:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8DMNMLV049347;
        Fri, 13 Sep 2019 22:26:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2uytdjutm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Sep 2019 22:26:12 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8DMQB9D030409;
        Fri, 13 Sep 2019 22:26:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Sep 2019 15:26:10 -0700
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH v5 2/2] block: centralize PI remapping logic to the block layer
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1568215397-15496-1-git-send-email-maxg@mellanox.com>
        <1568215397-15496-2-git-send-email-maxg@mellanox.com>
Date:   Fri, 13 Sep 2019 18:26:07 -0400
In-Reply-To: <1568215397-15496-2-git-send-email-maxg@mellanox.com> (Max
        Gurtovoy's message of "Wed, 11 Sep 2019 18:23:17 +0300")
Message-ID: <yq1d0g3de9s.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=673
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909130219
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9379 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=743 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909130219
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Max,

> Currently t10_pi_prepare/t10_pi_complete functions are called during
> the NVMe and SCSi layers command preparetion/completion, but their
> actual place should be the block layer since T10-PI is a general data
> integrity feature that is used by block storage protocols. Introduce
> .prepare_fn and .complete_fn callbacks within the integrity profile
> that each type can implement according to its needs.

LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
