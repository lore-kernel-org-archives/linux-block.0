Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B884C64EB1
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626E020850
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XqZb+n7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626E020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeLGDUt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:20:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42466 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeLGDUt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 22:20:49 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB73J1se193758;
        Fri, 7 Dec 2018 03:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Lfi8uh8OcguhtcEC8sbpaGRiUyvEMtwcKTyA1Iku7ME=;
 b=XqZb+n7ryDEqn8cqxuSAoty/CQKri7Yo4j1s8QJC6fl7i8PFTZq6yAXqDaxr4pRJgOPP
 aqUGKLit3a8k43mwUYukR7n5pO8De0nv/4nNA9ImiYnAGLEa94Dy5GZ8XlUuG2PD7R6I
 OvXZkXkfc/GVzZDg/ImntGBz/kDxHf5Gf7+yo5+4d7dsPPUXgUDL9Kw6iHXD/k+NbFT1
 mZwtREbtKmshmNEaUInJ3fX3EC1Ww0K5sb/ydsX6JMLpmcnXmiQN+D2CfIL+0CR2sDgZ
 I+C+XaJkUPpLDPi8g7Gay+anBdWtKDYszz60Ee/nHm2qksAB6BRH54t2tt3l6A42CsUv rw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2p3ftffh78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Dec 2018 03:20:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB73Kaui002695
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Dec 2018 03:20:37 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB73KYbD004822;
        Fri, 7 Dec 2018 03:20:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 19:20:34 -0800
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
        <yq1ftvcsoes.fsf@oracle.com>
        <fe72aef6-d313-5f02-7c0e-0eea28e86582@huawei.com>
        <yq1efavp9md.fsf@oracle.com>
        <6324d4a1-a41e-4322-718c-f6c91099f508@huawei.com>
Date:   Thu, 06 Dec 2018 22:20:31 -0500
In-Reply-To: <6324d4a1-a41e-4322-718c-f6c91099f508@huawei.com> (John Garry's
        message of "Thu, 6 Dec 2018 17:33:15 +0000")
Message-ID: <yq1sgzanhts.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9099 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=958
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812070026
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


John,

> "DIX is supported in mpt3sas , but not by default and hence while
> loading mpt3sas driver set module parameter "prot_mask=0x7F" to enable
> DIX support. "

The plumbing is there but it doesn't work. I tried earlier today and I
still can't get a single I/O to complete. I'll try to hack away at it
tomorrow.

> BTW, on a loosely related topic, in drivers/scsi/sd.h, I noticed that
> the arrays in sd_prot_op() and sd_prot_flag_mask() could be made
> static. In doing so I found sd.o object code shrunk by ~100B.

Will fix, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
