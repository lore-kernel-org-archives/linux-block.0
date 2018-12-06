Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F62EC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 04:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7E620878
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 04:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RVh6iITC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7E620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeLFEWz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:22:55 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45532 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeLFEWz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 23:22:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB64JNoP155513;
        Thu, 6 Dec 2018 04:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=TQdksy3wE2iK0qdFBKMNS57sw+PrZEuhzxGqX+R0/J0=;
 b=RVh6iITCvH/4n0agI2slwyB4vRMokmwx5byPIQWh1r2xT1CLI3inNpQ2VVpq8op70sdF
 n61x3yCGYThE88iRtb7SDabFmmo3aaXWT+xjgmg5cnghNTNbzqek8jvqSS4sFMZDzrIO
 RgDljOmhfZs497U3fhjaRIW3BfoA/dQZTJDJBDmJyg7jSjHvEmwMfGDJwzfw8YtrKCl8
 mPSbNZm6vpskemilfDoMv3hK3ab/veXJTLNtQobnjsUVNdwvRfEc5VbkUYi0vl6g+eDo
 MTGsnho1yt6aJezsS6pk6tDU291GS4Bcn0MBDbZowSPcG9SwPPgvG7vodZraEuVyjdQn cQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2p3hqu63ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 04:22:44 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB64McUK016189
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 04:22:38 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB64Mbo7018035;
        Thu, 6 Dec 2018 04:22:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Dec 2018 04:22:37 +0000
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
Date:   Wed, 05 Dec 2018 23:22:34 -0500
In-Reply-To: <fe72aef6-d313-5f02-7c0e-0eea28e86582@huawei.com> (John Garry's
        message of "Wed, 5 Dec 2018 15:27:09 +0000")
Message-ID: <yq1efavp9md.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=342
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060038
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


John,

>> I'll have to go revisit the archives for your exact fio bits.

Your fio test case ran to completion on all my test systems.

>> But I successfully ran our DIX/T10 PI qualification tooling without any
>> errors on the latest SCSI tree. On both scsi_debug and FC hardware.
>
> I'm not fimilar with this tooling. Is it internal to your company?

Sadly, yes :( We have not had much luck upstreaming the necessary aio
integrity passthrough enhancements.

> Unfortunately it seems that no other SAS HBA kernel driver supports
> DIX, so we have nothing to test against for this transport.

We did a preliminary qual of LSISAS3008 many moons ago. But we had no
immediate use for it in our offerings so it never went beyond that. I
know other companies are using it, though.

-- 
Martin K. Petersen	Oracle Linux Engineering
