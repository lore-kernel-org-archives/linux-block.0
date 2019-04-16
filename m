Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D1C10F0E
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 02:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE4520652
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 02:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JFqHYFpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfDPCMT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:12:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47874 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbfDPCMT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 22:12:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3G29Odf130284;
        Tue, 16 Apr 2019 02:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=bhRnco9VI6wuxPVZ3Jcg05UXTBexEYy01kJAz5iP4a8=;
 b=JFqHYFpDYcz+DceEwA1Hf05yfUG5u1KN2rR6U7YqB+7pBCheri9lqY3Q022IiyGeJvZ7
 LLj1AWBWA5/08XYVj90s+gsnxPUn+jjSm54jx7VSReCUrXBv0KSQ5i0KjQXth92RG2Ui
 DWRm0WnAX487xs5R2LSEAHStTK0wlKLbWVI406umFvJSmj4d3LbF9NfvId368KGbI5Cu
 Z96x/i+goVSenIe/jV5WPqUOm4AktOKFthhJP4tg7bENxx0fq5Klf1pwll7FCe/woR5O
 ExB/WZA5PG7KfVKQFvdr9MzY4zpw/DLd/10/Qm+N3JARoJswfA4Jx1+3uP64UKXyltr5 hQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rusnequxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 02:12:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3G2B3Id039331;
        Tue, 16 Apr 2019 02:12:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ru4vsx7d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 02:12:10 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3G2C8dV003429;
        Tue, 16 Apr 2019 02:12:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 19:12:08 -0700
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V5 9/9] SCSI: don't hold device refcount in IO path
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190412033032.10418-1-ming.lei@redhat.com>
        <20190412033032.10418-10-ming.lei@redhat.com>
        <yq1o95akbxj.fsf@oracle.com> <20190413065608.GA9108@ming.t460p>
Date:   Mon, 15 Apr 2019 22:12:04 -0400
In-Reply-To: <20190413065608.GA9108@ming.t460p> (Ming Lei's message of "Sat,
        13 Apr 2019 14:56:09 +0800")
Message-ID: <yq1imvehf63.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=598
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904160013
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=627 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904160013
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming,

> This patch doesn't depend on patch 1~8, so please take it via scsi
> tree if you are fine.

Applied, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
