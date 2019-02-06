Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC38C169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 13:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B223D20B1F
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 13:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfBFNel (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:34:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727350AbfBFNek (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Feb 2019 08:34:40 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16DTlxj183689
        for <linux-block@vger.kernel.org>; Wed, 6 Feb 2019 08:34:39 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qfxsp6h1j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 06 Feb 2019 08:34:39 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <bblock@linux.ibm.com>;
        Wed, 6 Feb 2019 13:34:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Feb 2019 13:34:34 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x16DYXml1769828
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 13:34:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F001D4C04E;
        Wed,  6 Feb 2019 13:34:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D871D4C040;
        Wed,  6 Feb 2019 13:34:32 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.152.212.148])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Feb 2019 13:34:32 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.91)
        (envelope-from <bblock@linux.ibm.com>)
        id 1grNLU-0006JD-FE; Wed, 06 Feb 2019 14:34:32 +0100
Date:   Wed, 6 Feb 2019 14:34:32 +0100
From:   Benjamin Block <bblock@linux.ibm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Question on handling managed IRQs when hotplugging CPUs
References: <alpine.DEB.2.21.1901301338170.5537@nanos.tec.linutronix.de>
 <86d5028d-44ab-3696-f7fe-828d7655faa9@huawei.com>
 <745609be-b215-dd2d-c31f-0bd84572f49f@suse.de>
 <alpine.DEB.2.21.1902012255550.8200@nanos.tec.linutronix.de>
 <d93ff049-e96d-36ce-7e58-ec97cbb27ed0@suse.de>
 <42d149c5-0380-c357-8811-81015159ac04@huawei.com>
 <20190205145244.GB28023@localhost.localdomain>
 <d4a04c13-b7db-84df-b1d3-90022905c084@huawei.com>
 <20190205182325.GA3302@lst.de>
 <3413b0b1-cb3f-3b09-106d-89cf8be30178@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3413b0b1-cb3f-3b09-106d-89cf8be30178@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19020613-4275-0000-0000-0000030C2A7D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020613-4276-0000-0000-0000381A2FF2
Message-Id: <20190206133432.GB14106@t480-pf1aa2c2>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=908 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060107
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 06, 2019 at 09:21:40AM +0000, John Garry wrote:
> On 05/02/2019 18:23, Christoph Hellwig wrote:
> > On Tue, Feb 05, 2019 at 03:09:28PM +0000, John Garry wrote:
> > > For SCSI devices, unfortunately not all IO sent to the HW originates from
> > > blk-mq or any other single entity.
> > 
> > Where else would SCSI I/O originate from?
> 
> Please note that I was referring to other management IO, like SAS SMP, TMFs,
> and other proprietary commands which the driver may generate for the HBA -
> https://marc.info/?l=linux-scsi&m=154831889001973&w=2 discusses some of them
> also.
> 

Especially the TMFs send via SCSI EH are a bit of a pain I guess,
because they are entirely managed by the device drivers, but depending
on the device driver they might not even qualify for the problem Hannes
is seeing.

-- 
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Development
IBM Systems & Technology Group   /  IBM Deutschland Research & Development GmbH
Vorsitz. AufsR.: Matthias Hartmann       /      Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294

