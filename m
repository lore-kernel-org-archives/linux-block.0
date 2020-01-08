Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DE7C33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3B22077B
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jsk8wxeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgAHDPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:15:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33570 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAHDPR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 22:15:17 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0083E0SP178705;
        Wed, 8 Jan 2020 03:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=+X7244jpapKxrqPEWzosk7cJiMl5l1y/5kwgs4R54Jg=;
 b=Jsk8wxeSumG4zqIRod6RF1QmCjb6BdUEd9yI38DdyjQo5/s6AUvzSDJnJ2Nc/fAUizlu
 33/NgFhb1O1vBcg4FuX+WoAtNC36NUB4BRfyoHyHrW1WqnLjswyfoKBZravL6TdbYsEK
 qjoXOPXp5Pbhxh6U0c/Sqaha374DcxSFkC5pHrl8Rcc6APpM3sBrsnQ0tKHdVrhfOl+c
 nBcpWapTiU+TIfW779hxJFYifh6WChtrTPh7SQwtlRzhGY7hBRipTcgRspmjyEYI0d9B
 YwwJAPCTtpqPXTx5wc2HVQG228CXEmJZjkR1gWzbAL+KVz9JQeGpBBPpSw75pR+pUI6J HA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xajnq193a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 03:15:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0083DqJD025975;
        Wed, 8 Jan 2020 03:15:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xcpanw421-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 03:15:05 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0083F3Gf025536;
        Wed, 8 Jan 2020 03:15:03 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 19:15:03 -0800
To:     "Singh\, Balbir" <sblbir@amazon.com>
Cc:     "martin.petersen\@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Sangaraju\, Someswarudu" <ssomesh@amazon.com>,
        "jejb\@linux.ibm.com" <jejb@linux.ibm.com>,
        "hch\@lst.de" <hch@lst.de>, "axboe\@kernel.dk" <axboe@kernel.dk>,
        "mst\@redhat.com" <mst@redhat.com>,
        "linux-nvme\@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Chaitanya.Kulkarni\@wdc.com" <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use disk_set_capacity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200102075315.22652-1-sblbir@amazon.com>
        <20200102075315.22652-6-sblbir@amazon.com>
        <yq1blrg2agh.fsf@oracle.com>
        <bc0575f1bb565f3955a411032f97163b2a5bd832.camel@amazon.com>
Date:   Tue, 07 Jan 2020 22:15:00 -0500
In-Reply-To: <bc0575f1bb565f3955a411032f97163b2a5bd832.camel@amazon.com>
        (Balbir Singh's message of "Tue, 7 Jan 2020 22:28:29 +0000")
Message-ID: <yq1blre1vwr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=933
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080026
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=994 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080026
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Balbir,

>> We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
>> capacity changes. However, this event does not automatically cause
>> revalidation.
>
> The proposed idea is to not reinforce revalidation, unless explictly
> specified (in the thread before Bob Liu had suggestions). The goal is
> to notify user space of changes via RESIZE. SCSI sd can opt out of
> this IOW, I can remove this if you feel
> SDEV_EVT_CAPACITY_CHANGE_REPORTED is sufficient for current use cases.

I have no particular objection to the code change. I was just observing
that in the context of sd.c, RESIZE=1 is more of a "your request to
resize was successful" notification due to the requirement of an
explicit userland action in case a device reports a capacity change.

-- 
Martin K. Petersen	Oracle Linux Engineering
