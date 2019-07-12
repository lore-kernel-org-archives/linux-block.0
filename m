Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6920BC742A1
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 00:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390B9208E4
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 00:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3NRufK/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfGLA2d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 20:28:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46232 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfGLA2d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 20:28:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0PpU8076404;
        Fri, 12 Jul 2019 00:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=MhocDkjZbIggx8U9U8vvBLlYm4zvgD6O5M+9P0cqzBs=;
 b=3NRufK/fF1sOhF7KPVo2t6eOdyLDVH+lIqaC+YhvSqAJfR2hFDctFRalwh0Bm1frkusW
 NrnIPp0q6gKPYATEzzJNPZPuuHIpHYnfnRBLxJCRmNxx8AGGwvipoZUnyKzlDsnlg2PE
 8aw4+rTeY5EdDqGoBGnMC2H8rHklUy9xvQfULZzKAxlu/qsMoC04o1blg0MWh0FJ9xhl
 PIdvLul9JlLLT1sk8NVAYM1CfugxZS/KO7/lYS4R3upy0PNC2dWFXO80JK93jhi9EGep
 SYPuI/px/eG97NoH1D872b8sbnhkN9zeDmGbRkhWlALvJU1iGMQRpfOHqBdZik9G+E60 Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tjk2u2wgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:27:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0RWMH057569;
        Fri, 12 Jul 2019 00:27:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tnc8tu5x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:27:42 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6C0Re3P001187;
        Fri, 12 Jul 2019 00:27:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 17:27:40 -0700
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V6 3/4] sd_zbc: Fix report zones buffer allocation
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
        <20190701050918.27511-4-damien.lemoal@wdc.com>
Date:   Thu, 11 Jul 2019 20:27:37 -0400
In-Reply-To: <20190701050918.27511-4-damien.lemoal@wdc.com> (Damien Le Moal's
        message of "Mon, 1 Jul 2019 14:09:17 +0900")
Message-ID: <yq1wogo85c6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=793
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=843 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120003
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Damien,

> During disk scan and revalidation done with sd_revalidate(), the zones
> of a zoned disk are checked using the helper function
> blk_revalidate_disk_zones() if a configuration change is detected
> (change in the number of zones or zone size). The function
> blk_revalidate_disk_zones() issues report_zones calls that are very
> large, that is, to obtain zone information for all zones of the disk
> with a single command. The size of the report zones command buffer
> necessary for such large request generally is lower than the disk
> max_hw_sectors and KMALLOC_MAX_SIZE (4MB) and succeeds on boot (no
> memory fragmentation), but often fail at run time (e.g. hot-plug
> event). This causes the disk revalidation to fail and the disk
> capacity to be changed to 0.

Probably easiest to funnel this through block with the rest of the
series.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
