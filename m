Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EA6C433FF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 20:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F43520659
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 20:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S0AuQAcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfG3UDB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:03:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42254 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfG3UDB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 16:03:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UJwTu3003829;
        Tue, 30 Jul 2019 20:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=PRuifwtBdlMAtrPrUPTDS6ONh/DQGdobk5Ch65KcSmo=;
 b=S0AuQAcR4+/LS+GqDZF/Kz+HLGXGn1dGVHhYKZ+ZDb15xSE7vhFvLLu16rcbRcrOwyOm
 ZkH5EKJDaEsKSK7lPSByt8mfiUZF2szLKpyjGTp/B36DzVjnUa2pSuFCT4VAyW1fsz70
 kRh/zRj8ySK8woBrP9ALZAaNPXNaxCptnmNzAITAU3iZhWGvHQRhdqiePnNm/G/VZO22
 f1ZwBdwPzZz79rF1r10CSj0oHMY6zFC1hawqSiL02vkJAGd/Ie6aRVr7HeINZ2WSKfIa
 rVEor7rZm7OMnvo4wE/BcVc1qQ1KQr1iFRJ9f9Dq3HQoV7ZAyiHBSPTb3SaavlK95AJ8 gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u0e1trwjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 20:02:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UK2qnY165614;
        Tue, 30 Jul 2019 20:02:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2u0xv8e5xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 20:02:52 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6UK2mD0030873;
        Tue, 30 Jul 2019 20:02:48 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jul 2019 13:02:47 -0700
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Euihyeok Kwon <eh81.kwon@samsung.com>,
        Sarah Cho <sohyeon.jo@samsung.com>,
        Sanggwan Lee <sanggwan.lee@samsung.com>,
        Gyeongmin Nam <gm.nam@samsung.com>,
        Sungjun Park <sj1228.park@samsung.com>,
        Minwoo Im <minwoo.im@samsung.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [RESEND PATCH] mpt3sas: support target smid for [abort|query] task
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190727185337.19299-1-minwoo.im.dev@gmail.com>
Date:   Tue, 30 Jul 2019 16:02:44 -0400
In-Reply-To: <20190727185337.19299-1-minwoo.im.dev@gmail.com> (Minwoo Im's
        message of "Sun, 28 Jul 2019 03:53:37 +0900")
Message-ID: <yq1sgqnl28r.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300204
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300203
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Minwoo,

> We can request task management IOCTL
> command(MPI2_FUNCTION_SCSI_TASK_MGMT) to /dev/mpt3ctl.  If the given
> task_type is either abort task or query task, it may need a field
> named "Initiator Port Transfer Tag to Manage" in the IU.

Applied to 5.4/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
