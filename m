Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A3C33C9E
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9C92080A
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OjmOVJRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgAHDA1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:00:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51018 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHDA1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 22:00:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0082xHKT168312;
        Wed, 8 Jan 2020 03:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=iLcFPVcqitIXvWo+HRVRWkQ4v6leUp47ykxd+ax2Jj0=;
 b=OjmOVJRU/nmW3pgl8b5slYJ/Hu0cbI4Yrgr5zTbQMY0I0rMWBHXsTSH+0cdhrYuqraPw
 E3xGpH4eQD+3Qh/KjVSA/fX1ZL+5L/T5MGOWIkpmENcHS/+LBUz6XgAP+kL90yRte3kL
 ZA7/oQ9EcKLwgTx1QXxpuHqeTk2Jkm9rtNeBg4YBrvP6mOJn/R9/W2g276/O70pe9RAK
 jKh/outQJAFAIk0yn8kwk9cLDAKxLjSB/D3sVSsED+Fs89CMZgu9Y3dSpm6xNv68i2iz
 ZfJuJkrSWJKeYXf+vEqhuGHvZ20Ke5Y4EnnlUBROdH+kWqy57e0l14F8YaamhqnyVHuv Cw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xajnq17bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 03:00:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0082wO3v188385;
        Wed, 8 Jan 2020 03:00:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2xcpanv9wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 03:00:09 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 008301Dn024609;
        Wed, 8 Jan 2020 03:00:01 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 19:00:01 -0800
To:     "Ewan D. Milne" <emilne@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.ibm.com>, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com, mst@redhat.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, ssomesh@amazon.com,
        Balbir Singh <sblbir@amazon.com>, hch@lst.de
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use disk_set_capacity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200102075315.22652-1-sblbir@amazon.com>
        <20200102075315.22652-6-sblbir@amazon.com>
        <yq1blrg2agh.fsf@oracle.com> <1578369479.3251.31.camel@linux.ibm.com>
        <yq1y2uj283m.fsf@oracle.com>
        <1eb9d796f81fffbb0bfe90bff8460bcda34cb04d.camel@redhat.com>
Date:   Tue, 07 Jan 2020 21:59:58 -0500
In-Reply-To: <1eb9d796f81fffbb0bfe90bff8460bcda34cb04d.camel@redhat.com> (Ewan
        D. Milne's message of "Tue, 07 Jan 2020 16:37:43 -0500")
Message-ID: <yq1ftgq1wlt.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=920
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=981 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080024
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ewan,

> Yes, there are some storage arrays that refuse a READ CAPACITY
> command in certain ALUA states so you can't get the new capacity
> anyway.

Yep. And some devices will temporarily return a capacity of
0xFFFFFFFF... If we were to trigger a filesystem resize, the results
would be disastrous.

> It might be nice to improve this, though, there are some cases now
> where we set the capacity to zero when we revalidate and can't get the
> value.

If you have a test case, let's fix it.

-- 
Martin K. Petersen	Oracle Linux Engineering
