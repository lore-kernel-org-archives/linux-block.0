Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927CEC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 02:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F675222A4
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 02:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wYJW99JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbfBNCkB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:40:01 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40564 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfBNCkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 21:40:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1E2dMSs010721;
        Thu, 14 Feb 2019 02:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=LwB5hh0FheSm+snXyf4ObgxM0IXBXnHxQeNUTE7dtwg=;
 b=wYJW99JVLOT7YemNn7uv6TIwDciYMsOedRfM5B0+cceNOzS3/23inAX4J6fZVDpWLrM7
 sUX2eKdfuyYm9UFaIuSZ/NpYPIOQylclnmWCHSmf6YsBqMU3sgf7opyLUJ5JN0tiQy8/
 SmRY7PFoonkYh2mHsvjgV86zWkMtlyf1njkyq3OcjfPJ4gpM8AXFF5MbsK9Eu4TK602J
 ByE+lqV7OPVN7lKS/gxkrCFKBavhtgQs/+Jmhkt4qNcG9Qm5aP4emwmJcp0zpHtQSGqe
 9Hbrkl714jnjkwNCfG4eVtcwWGpqd54IC9A5XhmQFTHL9e290fKW5BdyjOawfsD73dc1 4w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2qhre5neu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 02:39:54 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1E2dsd0031412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Feb 2019 02:39:54 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1E2drIB008945;
        Thu, 14 Feb 2019 02:39:53 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 18:39:53 -0800
To:     Evan Green <evgreen@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Martin K Petersen <martin.petersen@oracle.com>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] loop: Better discard support for block devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190207205730.199332-1-evgreen@chromium.org>
        <20190207205730.199332-3-evgreen@chromium.org>
Date:   Wed, 13 Feb 2019 21:39:50 -0500
In-Reply-To: <20190207205730.199332-3-evgreen@chromium.org> (Evan Green's
        message of "Thu, 7 Feb 2019 12:57:29 -0800")
Message-ID: <yq1d0nvqeix.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=725 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902140018
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Evan,

> If the backing device for a loop device is a block device, then mirror
> the discard properties of the underlying block device into the loop
> device. While in there, differentiate between REQ_OP_DISCARD and
> REQ_OP_WRITE_ZEROES, which are different for block devices, but which
> the loop device had just been lumping together.

Bubbling up the queue limits from the backing device is fine. However,
I'm not sure why you are requiring a filesystem to be on a
discard-capable device for REQ_OP_DISCARD to have an effect? Punching a
hole in a file is semantically the same as discarding.

-- 
Martin K. Petersen	Oracle Linux Engineering
