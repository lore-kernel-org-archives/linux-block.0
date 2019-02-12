Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E397C282CA
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D257217D9
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="33F7zegl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbfBLQuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:50:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:44696 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731252AbfBLQuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Feb 2019 11:50:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1CGhpg1152882;
        Tue, 12 Feb 2019 16:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=aOrGLdAhytHF474pfkdlibpNnOtBxI3ZYvnPr+5AHJo=;
 b=33F7zeglViIYIQj+V6d5vtolUQg0Yr8+euFLQ3/jzyyBW/SZ60nUJbU+P/uJsKL1B+ep
 IzqY/8EnZ1fE0RuinzKUTXUbTcGRICbBORct6IcMt3vzU6KAZAD/b8OX4zUSGjzAXo2O
 7/NynO5/3pYRrfSEVrR/YOKjGgcc7AwW4+TDbrq1JsZrkG+AhpcxdUq9RW2llWafgIcC
 voSsY2gNYxEMgJaeqClVVE/P4j6tQ8JSk9E3Yvx0JrWSkpTP6tR0VfoGZHcCUUc0O4ew
 07wQIjkYy623dIrEVcvIrmmMqcPCjSZWkDmap63+bw1lf5PqFHEhhZlluEup5842FM82 mg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qhre5d4eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 16:50:12 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1CGoCWg025215
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Feb 2019 16:50:12 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1CGoBKG013788;
        Tue, 12 Feb 2019 16:50:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Feb 2019 08:50:10 -0800
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>,
        Oleksii Kurochko <olkuroch@cisco.com>, stable@vger.kernel.org
Subject: Re: [PATCH] scsi: sd: block: Handle cases where devices come online read-only
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190208233831.31377-1-martin.petersen@oracle.com>
        <20190212080319.GA10547@infradead.org>
        <6121a378-d92f-3acb-8932-433c777205c3@suse.de>
Date:   Tue, 12 Feb 2019 11:50:06 -0500
In-Reply-To: <6121a378-d92f-3acb-8932-433c777205c3@suse.de> (Hannes Reinecke's
        message of "Tue, 12 Feb 2019 09:08:40 +0100")
Message-ID: <yq18syluf29.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=628 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120119
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hannes,

> And once we stop sending I/O to it we'll lose the ability to figure
> out that the device switched back to R/W mode.
>
> (Always assuming that we'll be getting a sense code in the first
> place).

FWIW, I did get correct sense on all the drives I tested and verified
that the code does the right thing.

But obviously I have my doubts about $RANDOM_USB_GIZMO.

-- 
Martin K. Petersen	Oracle Linux Engineering
