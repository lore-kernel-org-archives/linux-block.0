Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC4EC28CC5
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 13:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA8A20693
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 13:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfFEN5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 09:57:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727904AbfFEN5t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jun 2019 09:57:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x55DlXIT134053
        for <linux-block@vger.kernel.org>; Wed, 5 Jun 2019 09:57:48 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sxemyh8b1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 05 Jun 2019 09:57:47 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <sebott@linux.ibm.com>;
        Wed, 5 Jun 2019 14:57:46 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 5 Jun 2019 14:57:43 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x55DvgnK60358766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jun 2019 13:57:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39AADA405B;
        Wed,  5 Jun 2019 13:57:42 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEA1FA4054;
        Wed,  5 Jun 2019 13:57:41 +0000 (GMT)
Received: from dyn-9-152-212-90.boeblingen.de.ibm.com (unknown [9.152.212.90])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Jun 2019 13:57:41 +0000 (GMT)
Date:   Wed, 5 Jun 2019 15:57:41 +0200 (CEST)
From:   Sebastian Ott <sebott@linux.ibm.com>
X-X-Sender: sebott@schleppi
To:     Christoph Hellwig <hch@lst.de>
cc:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: too large sg segments with commit 09324d32d2a08
In-Reply-To: <20190605133002.GA13368@lst.de>
References: <alpine.LFD.2.21.1906051057200.2118@schleppi> <20190605100928.GA9828@lst.de> <20190605133002.GA13368@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
Organization: =?ISO-8859-15?Q?=22IBM_Deutschland_Research_&_Development_GmbH?=
 =?ISO-8859-15?Q?_=2F_Vorsitzende_des_Aufsichtsrats=3A_Matthias?=
 =?ISO-8859-15?Q?_Hartmann_Gesch=E4ftsf=FChrung=3A_Dirk_Wittkopp?=
 =?ISO-8859-15?Q?_Sitz_der_Gesellschaft=3A_B=F6blingen_=2F_Reg?=
 =?ISO-8859-15?Q?istergericht=3A_Amtsgericht_Stuttgart=2C_HRB_2432?=
 =?ISO-8859-15?Q?94=22?=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
x-cbid: 19060513-0028-0000-0000-000003765F67
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060513-0029-0000-0000-000024363B7C
Message-Id: <alpine.LFD.2.21.1906051557060.2118@schleppi>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=873 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050088
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 5 Jun 2019, Christoph Hellwig wrote:
> Actually, it looks like something completely general isn't
> easily doable, not without some major dma API work.  Here is what
> should fix nvme, but a few other drivers will need fixes as well:
> 
> ---
> From 745541130409bc837a3416300f529b16eded8513 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Wed, 5 Jun 2019 14:55:26 +0200
> Subject: nvme-pci: don't limit DMA segement size
> 
> NVMe uses PRPs (or optionally unlimited SGLs) for data transfers and
> has no specific limit for a single DMA segement.  Limiting the size
> will cause problems because the block layer assumes PRP-ish devices
> using a virt boundary mask don't have a segment limit.  And while this
> is true, we also really need to tell the DMA mapping layer about it,
> otherwise dma-debug will trip over it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Sebastian Ott <sebott@linux.ibm.com>

Works for me. Thanks!

