Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55305C6786C
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 12:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA0A208E7
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 12:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lu4y4Anm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA0A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeLNMnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:43:50 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48988 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeLNMnt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 07:43:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBECdk3Z085165;
        Fri, 14 Dec 2018 12:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=dHmoQPPon9bNfNzdl/6W/AG4Q6Kguj2nHJ4oWxjK6+k=;
 b=Lu4y4Anme2K6x1Ts884ARj11T3ZtSjscHCNDzsRMiiWV6ZtO9UZT39XQt2Q8v31v9CPG
 vENC4S2Cp8AMS28Et45IosEMMbFB86kNkVwI7zq7hUepwa7ruaRD8Mp4TQWJIV+dBySH
 xQfkw4bDzDewu9aP0ybSqGlvHFxXXi3fDbd7LadTnlojqwnMJYl0iI/iDge9I48XyK8a
 P3ytNnjHt35Nq8pKtIO7twDVjkn4AN84jYldnE5zIfpv4HC2LZ3y4T6x5BSg56arVkXJ
 Z4BSCrT0Y1yT3I6bhgAPqi8EKBSetz1yLihFnDzlKYuOuUjhDOqe3QsVQ9m21t7iyAKk GQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pb3n7b5t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 12:43:24 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBEChIYE030498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Dec 2018 12:43:18 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBEChIsf026092;
        Fri, 14 Dec 2018 12:43:18 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Dec 2018 04:43:17 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
Subject: Re: Question on t10_pi_ref_tag()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <0336fcc8-cfc5-ab51-b2cd-3ad6b971cc8a@huawei.com>
Date:   Fri, 14 Dec 2018 07:43:15 -0500
In-Reply-To: <0336fcc8-cfc5-ab51-b2cd-3ad6b971cc8a@huawei.com> (John Garry's
        message of "Fri, 14 Dec 2018 12:04:54 +0000")
Message-ID: <yq11s6kmg7w.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9106 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=530
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812140114
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


John,

> What would we be missing that this is unset?

60a89a3ce0cc scsi: t10-pi: Return correct ref tag when queue has no integrity profile

-- 
Martin K. Petersen	Oracle Linux Engineering
