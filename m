Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6C1C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 14:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027BA214F1
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 14:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027BA214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbeKNAgj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:36:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727677AbeKNAgj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Nov 2018 19:36:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wADEc3Dq053587
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 09:38:11 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nqxafex6g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 13 Nov 2018 09:38:07 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <bblock@linux.ibm.com>;
        Tue, 13 Nov 2018 14:35:26 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 13 Nov 2018 14:35:22 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wADEZMDN60358798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 14:35:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA19911C064;
        Tue, 13 Nov 2018 14:35:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFBC411C04A;
        Tue, 13 Nov 2018 14:35:21 +0000 (GMT)
Received: from w530-pk1mzal (unknown [9.145.42.26])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 13 Nov 2018 14:35:21 +0000 (GMT)
Received: from bblock by w530-pk1mzal with local (Exim 4.91)
        (envelope-from <bblock@linux.ibm.com>)
        id 1gMZmj-0007AV-49; Tue, 13 Nov 2018 15:35:21 +0100
Date:   Tue, 13 Nov 2018 15:35:20 +0100
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] bsg-lib: handle bidi requests without block layer
 help
References: <20181111133211.13926-1-hch@lst.de>
 <20181111133211.13926-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181111133211.13926-7-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18111314-0028-0000-0000-000003194A93
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111314-0029-0000-0000-000023D5B16A
Message-Id: <20181113143520.GB7222@w530-pk1mzal>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811130134
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Nov 11, 2018 at 02:32:09PM +0100, Christoph Hellwig wrote:
> We can just stash away the second request in struct bsg_job instead
> of using the block layer req->next_rq field, allowing for the eventual
> removal of the latter.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bsg-lib.c                   | 44 +++++++++++++++++++---
>  block/bsg.c                       | 62 ++++++-------------------------
>  drivers/scsi/scsi_transport_sas.c |  1 -
>  include/linux/bsg-lib.h           |  4 ++
>  4 files changed, 54 insertions(+), 57 deletions(-)
> 
> diff --git a/block/bsg-lib.c b/block/bsg-lib.c
> index 192129856342..005e2b75d775 100644
> --- a/block/bsg-lib.c
> +++ b/block/bsg-lib.c
> @@ -74,6 +74,9 @@ static int bsg_scsi_fill_hdr(struct request *rq, struct sg_io_v4 *hdr,
>  {
>  	struct scsi_request *sreq = scsi_req(rq);
> 
> +	if (hdr->dout_xfer_len && hdr->din_xfer_len)
> +		return -EOPNOTSUPP;
> +

This seems like a non-obvious user-breakage. So apart from removing the
in-kernel stuff that uses bidirectional commands you also forbid
userspace from every using them? That seems wrong to me.

There is other SCSI Command Sets than OSD that provide bidirectional
commands, even SBC has some (i.e.  X*WRITE*, COMPARE AND WRITE).



-- 
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Development
IBM Systems & Technology Group   /  IBM Deutschland Research & Development GmbH
Vorsitz. AufsR.: Martina Koederitz       /      Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294

