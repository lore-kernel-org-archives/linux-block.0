Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF06C282CE
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F325217D9
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P56MdWZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbfBLQ0y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:26:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36136 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbfBLQ0y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 11:26:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1CGO2iU126696;
        Tue, 12 Feb 2019 16:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=qa/Mcl3P4LGjsDxxDtc2qexHPPaqUDmPqz22lvZtFPI=;
 b=P56MdWZs+UsXXPTXHAgX1vJdg/BF80uLz5Ahcye0yj2/FnrCPOYnBS7VQPAZ9Mrdzzoy
 nXXPeyvvQYJSa2giDdN2TMAgcC8XtXIttVvBN4daOhuJ4Ey9josCqy+oKXRe/KwmHswL
 bGTlPPf+H9R3qQCgjyVP+FGcC6ZQxXngCyo3ivbUBuE/XB14Ss/YgeWxACevaSTcwnqM
 Z0kFZB1rXZtO/KE6ElZKPH9ICITBEnFi+uHzlYgFkF33wOgdnoqtESr8CraMIUCrG2cN
 dv+w1Aix/qC/8Pv2WW9ou8cMW1UDayTZjYLO+XgLN5vVIQYI+bvjyjSKR0vl9WwbZEDm wg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2qhrekd0a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 16:26:50 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1CGQnfP019060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 16:26:49 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1CGQmd5004977;
        Tue, 12 Feb 2019 16:26:48 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Feb 2019 08:26:48 -0800
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Oleksii Kurochko <olkuroch@cisco.com>, stable@vger.kernel.org
Subject: Re: [PATCH] scsi: sd: block: Handle cases where devices come online read-only
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190208233831.31377-1-martin.petersen@oracle.com>
        <01000168dd40a901-e418f724-3fe3-47e3-bbea-05fea79f169e-000000@email.amazonses.com>
Date:   Tue, 12 Feb 2019 11:26:46 -0500
In-Reply-To: <01000168dd40a901-e418f724-3fe3-47e3-bbea-05fea79f169e-000000@email.amazonses.com>
        (Jeremy Cline's message of "Mon, 11 Feb 2019 15:50:28 +0000")
Message-ID: <yq1h8d9ug55.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120116
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jeremy,

> I noticed drivers/s390/block/dasd_ioctl.c calls set_disk_ro() to set the
> policy, where-as the policy is set with set_device_ro() in the generic
> ioctl.

There's a subtle distinction here:

 - set_disk_ro() sets the policy for a whole disk

 - set_device_ro() sets the policy for a block_device (typically
   partition)

> It's not setting the policy to DISK_POLICY_USER_WRITE_PROTECT so I
> think it would only be a problem if the user set it to 2 instead of 1
> assuming any truthy value is acceptable. Then the user wouldn't be
> able to mark the disk as writable again since this would be
> true. Perhaps it's a somewhat far-fetched scenario.

OK, I missed that particular entry point. Will fix.

-- 
Martin K. Petersen	Oracle Linux Engineering
