Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A18C10F0E
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 00:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78F7218C3
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 00:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zIRM5q93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfDMAE7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:04:59 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45646 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDMAE6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 20:04:58 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3D048XT068856;
        Sat, 13 Apr 2019 00:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=cgZIvkDZ77yg9SvwpZSCfx3oA3KFmAar6EesdHF3ezQ=;
 b=zIRM5q932BlVEB7/i0Xjb8UiWii7cq1TgWYAY/sizxwboFRMCbiTLnRgF0WWtiRX08B2
 d/AbypLFeaRM5I+av0/h68zKPsGzE5dxppbdIfgEPpNIiXBv6TrVoYUPd+/umKzb8wk/
 vq7SejZl/NJMmqKdp6lPiXMGn8NvL8AaKnJi65mFrd9fhNMU5Npn413UYzX9F2AiTDGO
 z3+vYAGbF51QDdj00CrtKNJEd++t8oWR5IW7E5bLFxZJkV/k8G8nkOj90GDCse3ZTnb1
 2BfQ1TQEe3HCCX6M8myxkeDG1NgkSk0JKULBOTmvJW52KGerWOO5rxna5IFaUyw01fTg cA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2rphmf13me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Apr 2019 00:04:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3D03j78061908;
        Sat, 13 Apr 2019 00:04:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2rt9uqddw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Apr 2019 00:04:47 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3D04hH7004121;
        Sat, 13 Apr 2019 00:04:44 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Apr 2019 17:04:43 -0700
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V5 9/9] SCSI: don't hold device refcount in IO path
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190412033032.10418-1-ming.lei@redhat.com>
        <20190412033032.10418-10-ming.lei@redhat.com>
Date:   Fri, 12 Apr 2019 20:04:40 -0400
In-Reply-To: <20190412033032.10418-10-ming.lei@redhat.com> (Ming Lei's message
        of "Fri, 12 Apr 2019 11:30:32 +0800")
Message-ID: <yq1o95akbxj.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9225 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=731
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904120158
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9225 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=754 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904120159
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Ming,

> scsi_device's refcount is always grabbed in IO path.
>
> Turns out it isn't necessary, because blk_queue_cleanup() will
> drain any in-flight IOs, then cancel timeout/requeue work, and
> SCSI's requeue_work is canceled too in __scsi_remove_device().
>
> Also scsi_device won't go away until blk_cleanup_queue() is done.
>
> So don't hold the refcount in IO path, especially the refcount isn't
> required in IO path since blk_queue_enter() / blk_queue_exit()
> is introduced in the legacy block layer.

This all looks good to me. I assume it will go through Jens' tree?

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
