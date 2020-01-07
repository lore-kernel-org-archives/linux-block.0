Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9713C33C99
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 03:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD588207E0
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 03:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgAGD6N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jan 2020 22:58:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727452AbgAGD6N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Jan 2020 22:58:13 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0073vLiG040204;
        Mon, 6 Jan 2020 22:58:03 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb8um7r5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 22:58:03 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0073w2mo043338;
        Mon, 6 Jan 2020 22:58:02 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb8um7r5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 22:58:02 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0073vJ5E004441;
        Tue, 7 Jan 2020 03:58:01 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 2xajb6dtf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 03:58:01 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0073w1R714418312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jan 2020 03:58:01 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2153AAE05C;
        Tue,  7 Jan 2020 03:58:01 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2BECAE062;
        Tue,  7 Jan 2020 03:57:59 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.172.186])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jan 2020 03:57:59 +0000 (GMT)
Message-ID: <1578369479.3251.31.camel@linux.ibm.com>
Subject: Re: [resend v1 5/5] drivers/scsi/sd.c: Convert to use
 disk_set_capacity
From:   James Bottomley <jejb@linux.ibm.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Balbir Singh <sblbir@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        ssomesh@amazon.com, hch@lst.de, mst@redhat.com,
        Chaitanya.Kulkarni@wdc.com
Date:   Mon, 06 Jan 2020 19:57:59 -0800
In-Reply-To: <yq1blrg2agh.fsf@oracle.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
         <20200102075315.22652-6-sblbir@amazon.com> <yq1blrg2agh.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_08:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=733
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001070030
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2020-01-06 at 22:48 -0500, Martin K. Petersen wrote:
> Balbir,
> 
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index 5afb0046b12a..1a3be30b6b78 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -3184,7 +3184,7 @@ static int sd_revalidate_disk(struct gendisk
> > *disk)
> >  
> >  	sdkp->first_scan = 0;
> >  
> > -	set_capacity(disk, logical_to_sectors(sdp, sdkp-
> > >capacity));
> > +	disk_set_capacity(disk, logical_to_sectors(sdp, sdkp-
> > >capacity));
> >  	sd_config_write_same(sdkp);
> >  	kfree(buffer);
> 
> We already emit an SDEV_EVT_CAPACITY_CHANGE_REPORTED event if device
> capacity changes. However, this event does not automatically cause
> revalidation.

Which I seem to remember was a deliberate choice: some change
capacities occur because the path goes passive and default values get
installed.

James

