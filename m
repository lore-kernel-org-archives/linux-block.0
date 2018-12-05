Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2674C04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 02:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50092082B
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 02:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ndab/PzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50092082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeLECWv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:22:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40000 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLECWu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 21:22:50 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB52J16K138504;
        Wed, 5 Dec 2018 02:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=wlMM0S8WIstEElTRJorHK3KNzOCsapAWWW51RB70w4I=;
 b=ndab/PzJ2tOEdK07SQY7hpAHZyNkzMynoCOaUO7nvsoPMHR9oQU3iLa6s9lzkFhRXMjZ
 3+Thas4wQwh/M1ribk+mgwLWIPbCyTIvJs6z3ttIm7HwEDP3NtY9AoGsA5wVWRxE/IA3
 2536XDZ2QV8eOOnD5RrI4ZVJy2SSG7DkMC42XyvW/BJ4gnM9xVE3l1qauLjyeavV+ntc
 1faGEIZFvL6Kh3JBPIdzTdYZCkFsfdl/YGYyzh7/Tch4nvifXGnBHRXpIn+mAI0cL2iq
 SRE77DN9GrKjCAlV0wwocH47aF8tstZyPMg167HO567Kk0hTOCR+CZzAMUUTTEH/E7Rh Kg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2p3hqtyv8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Dec 2018 02:22:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB52MduS029887
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Dec 2018 02:22:39 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB52McI9021350;
        Wed, 5 Dec 2018 02:22:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 18:22:38 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        "chenxiang \(M\)" <chenxiang66@hisilicon.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Steffen Maier <maier@linux.ibm.com>
Subject: Re: DIF/DIX issue related to config CONFIG_SCSI_MQ_DEFAULT
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <5d9bf51d-1ef9-b948-2168-9e7526d77225@hisilicon.com>
        <20181127130811.GA2780@ming.t460p>
        <6c573f36-60d8-0631-e9ac-dacd72f6c8ad@hisilicon.com>
        <20181130011935.GA7573@ming.t460p>
        <e0e07583-98ca-4fc5-e60d-055e5474c084@huawei.com>
        <yq1k1kqt07m.fsf@oracle.com>
        <45193ec6-6398-3953-4833-88ca2057971a@huawei.com>
Date:   Tue, 04 Dec 2018 21:22:35 -0500
In-Reply-To: <45193ec6-6398-3953-4833-88ca2057971a@huawei.com> (John Garry's
        message of "Tue, 4 Dec 2018 12:33:37 +0000")
Message-ID: <yq1ftvcsoes.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=821
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812050020
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


John,

> OK, great. Happy to help. So far we have hisi_sas fio issue to go on
> plus knowledge that this issue seems to be exposed/triggered by
> enabling SCSI MQ.

I'll have to go revisit the archives for your exact fio bits.

But I successfully ran our DIX/T10 PI qualification tooling without any
errors on the latest SCSI tree. On both scsi_debug and FC hardware.

> My colleague chenxiang also tried DIF on 3008 with our same platform,
> and we are seeing an issue there also; here's a snippet:

Reproduced this. Turns out to be a recently introduced bug that
exclusively affects DIF-only setups (so primarily mpt3sas due to lack of
DIX support). It's a regression caused by a commit that went in through
block a few months ago. I'll send a patch...

-- 
Martin K. Petersen	Oracle Linux Engineering
