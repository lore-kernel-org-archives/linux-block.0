Return-Path: <SRS0=aQmj=Q2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C0C43381
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711B42147A
	for <linux-block@archiver.kernel.org>; Tue, 19 Feb 2019 23:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d43isa+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfBSX0g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:26:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56274 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBSX0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Feb 2019 18:26:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1JNEQpb048206;
        Tue, 19 Feb 2019 23:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=A4GsdpQi/NmjSiAwkgFYWnN1QdnBsK00MyLvt6+uEtA=;
 b=d43isa+mk+Mc5TC7h12DbFWixiYz+pzknXloEL5UiKxs3lA7puyHiyRkVjrHoaifvhDe
 m5Kr5TqYrhWpE1OUSeQVK417hbO7/GlJNe8A6RUhQcmwvO2VpHYNstLJgb2BKUerV1zr
 UxU6NzU5F2ppxnSv7VuwGx9BMNZ/qTLpNvmXurPDQWgzNDAJOW4ZI5nT+Twa1alDlGhX
 2EAhZi6/q02HTxc8Z+MESIJu/majcnbtHa1pPZVjtcWeIV+0D32SqvkhrVP1/+h0lJMk
 L9/BOjwmAsV3u0JCB5ICd0MRwb12/xL4RhLVTwgdugP9vF/Xn020P10ShVJQqSSUvPTT Sg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2qpb5re9pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 23:26:29 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1JNQOpK004931
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 23:26:24 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1JNQN4c028461;
        Tue, 19 Feb 2019 23:26:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Feb 2019 15:26:22 -0800
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jeremy Cline <jeremy@jcline.org>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        stable <stable@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2] scsi: sd: block: Fix regressions in read-only block device handling
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <yq1d0nxuf73.fsf@oracle.com>
        <20190213025717.20057-1-martin.petersen@oracle.com>
        <CACVXFVN9LXodRP8+T_Vd8+5g9K=+hke7ik7N21=heb3csFhh=w@mail.gmail.com>
Date:   Tue, 19 Feb 2019 18:26:20 -0500
In-Reply-To: <CACVXFVN9LXodRP8+T_Vd8+5g9K=+hke7ik7N21=heb3csFhh=w@mail.gmail.com>
        (Ming Lei's message of "Tue, 19 Feb 2019 09:36:54 +0800")
Message-ID: <yq1h8czl5r7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=815 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902190158
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Ming,

> From the Bugzilla, looks it is only reported on the "Kingston DT
> Ultimate G3" USB flash drive.

There are several bug reports as a result of the change. It's not at all
uncommon for a device to switch at runtime. Before Jeremy's change we
just didn't see it because the device setting always took precedence and
voided any user setting.

-- 
Martin K. Petersen	Oracle Linux Engineering
