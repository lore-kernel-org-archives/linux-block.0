Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270E0C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56262173C
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KylpRb8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfC2Oek (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:34:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40446 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfC2Oek (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:34:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2TEY6ZD027901;
        Fri, 29 Mar 2019 14:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=EbupV4QSUXAVQsyhVndp2Sv5sCXiR2sgYQhgjoSdwb0=;
 b=KylpRb8Fr8RyGs3grkHyHwdmjBYUv8l+1ZRvxiZpgN5mK9yHTIVD5jSV4llmUTzbHXnJ
 epor6B+yRyfBjIIr2IjlZydwW73JI8RSPcAVn2uxzFznXx4sE2v/SKBXkNNfPTNnQez2
 ZRCQyCLs/gbBSOVDM/7/wVa5I508FNRzYfETQ9WDSm7tKbPxPo4iJ7U3bxdAN8CqyhPL
 vUCJrQbZLfPsaUdumCkzjpPs5QWXDUDmCxUHyk9U40QggQJc2xeee6VidcOomSmQmbP7
 pAZEaF2qnSMzoCEraEl7vUkbA7VyGa6qrIDHOBwNV/G4Ew9AnvHrzD7L8+l4I0EAgOpy qQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2re6djvub2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:34:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEYKJG027942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 14:34:20 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2TEYJqB024577;
        Fri, 29 Mar 2019 14:34:19 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Mar 2019 07:34:19 -0700
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bob Liu <bob.liu@oracle.com>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca,
        tytso@mit.edu
Subject: Re: [PATCH v3 2/3] block: verify data when endio
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190329142346.1677-1-bob.liu@oracle.com>
        <20190329142346.1677-3-bob.liu@oracle.com>
        <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk>
Date:   Fri, 29 Mar 2019 10:34:14 -0400
In-Reply-To: <41c8688a-65bd-96ac-9b23-4facd0ade4a7@kernel.dk> (Jens Axboe's
        message of "Fri, 29 Mar 2019 08:28:23 -0600")
Message-ID: <yq1ftr5rbq1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9210 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=881 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903290104
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

> I told you this for the initial posting, and the objection still
> stands.  Adding 40 bytes to struct bio is a no-go.
>
> So that's a big NAK on that series.

I think you missed Bob's comment that this will go in the existing
bio_integrity field. I believe the main purpose of the series is to
solicit feedback on the callback approach.

-- 
Martin K. Petersen	Oracle Linux Engineering
