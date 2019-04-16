Return-Path: <SRS0=7JUc=SS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB7DC10F0E
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 02:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1872070D
	for <linux-block@archiver.kernel.org>; Tue, 16 Apr 2019 02:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IN+BgtoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfDPCgn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:36:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48412 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDPCgm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 22:36:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3G2Xw6x137399;
        Tue, 16 Apr 2019 02:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=8n11Tuf4RkTcALnFh7kM8bD3LdM0kx1H6Sfn7yYleOQ=;
 b=IN+BgtoLp2IhEuW8jp3N/YF5sAefICzSV3wQxN7+Bk3QB1XAxk+rmn8Bx/pX+sUfQyBm
 us1wk9F3ImUMIjWqJQnxe8pbuAZ5fvGC2gZAerneV4RU3B57+uTHHdLInFyifbFhy2On
 zG2Dajco3Q64626ELPmZ7binv24ct60eruzw0b7oag2da3FD+IooBvCu1LjRSiIF4IbZ
 +bGrXqluVIgwsowtKEB+amb0IkLv7fh03aZhrsnh9jpf4l2viWDEQlii/rZ2uD7Lee9p
 edKTxMkPWFdNkf1zHOAd1tAj2btXoFEc5kC20s2oK4FVIXiwF1FfuNrwnW6j5etwai8r hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2ru59d1ysr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 02:36:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3G2Z4RM081248;
        Tue, 16 Apr 2019 02:36:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ru4vsxeed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Apr 2019 02:36:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3G2aTVx015853;
        Tue, 16 Apr 2019 02:36:30 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Apr 2019 19:36:29 -0700
To:     Jaesoo Lee <jalee@purestorage.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>
Subject: Re: [PATCHv2] scsi: core: set result when the command cannot be dispatched
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1554854375-7708-1-git-send-email-jalee@purestorage.com>
        <CAJX3CtgE5oN=uw2rAWS8hsqkEZHCgfy5r=McFTj0rhRd490HhQ@mail.gmail.com>
Date:   Mon, 15 Apr 2019 22:36:27 -0400
In-Reply-To: <CAJX3CtgE5oN=uw2rAWS8hsqkEZHCgfy5r=McFTj0rhRd490HhQ@mail.gmail.com>
        (Jaesoo Lee's message of "Tue, 9 Apr 2019 17:02:22 -0700")
Message-ID: <yq1o956fzh0.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904160017
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904160017
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jaesoo,

> When SCSI blk-mq is enabled, there is a bug in handling errors in
> scsi_queue_rq.  Specifically, the bug is not setting result field of
> scsi_request correctly when the dispatch of the command has been
> failed. Since the upper layer code including the sg_io ioctl expects
> to receive any error status from result field of scsi_request, the
> error is silently ignored and this could cause data corruptions for
> some applications.

Applied to 5.1/scsi-fixes, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
