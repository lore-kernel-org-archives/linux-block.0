Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DECEC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D62E22360
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 16:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D62E22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeKOCvl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:51:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728085AbeKOCvl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 21:51:41 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAEGjuAx129677
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 11:47:43 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nrmqvhrpg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 11:46:29 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <bblock@linux.ibm.com>;
        Wed, 14 Nov 2018 16:44:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 14 Nov 2018 16:44:31 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAEGiUtl56164552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Nov 2018 16:44:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A13125204F;
        Wed, 14 Nov 2018 16:44:30 +0000 (GMT)
Received: from w530-pk1mzal (unknown [9.152.212.21])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 8D51F52059;
        Wed, 14 Nov 2018 16:44:30 +0000 (GMT)
Received: from bblock by w530-pk1mzal with local (Exim 4.91)
        (envelope-from <bblock@linux.ibm.com>)
        id 1gMyHG-0001sV-A2; Wed, 14 Nov 2018 17:44:30 +0100
Date:   Wed, 14 Nov 2018 17:44:30 +0100
From:   Benjamin Block <bblock@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] bsg-lib: handle bidi requests without block layer
 help
References: <20181111133211.13926-1-hch@lst.de>
 <20181111133211.13926-7-hch@lst.de>
 <20181113143520.GB7222@w530-pk1mzal>
 <20181114154857.GA28985@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181114154857.GA28985@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18111416-0012-0000-0000-000002CA7AC0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111416-0013-0000-0000-000020FF8E03
Message-Id: <20181114164430.GC7222@w530-pk1mzal>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-14_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=916 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811140151
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 04:48:57PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 13, 2018 at 03:35:20PM +0100, Benjamin Block wrote:
> > This seems like a non-obvious user-breakage. So apart from removing the
> > in-kernel stuff that uses bidirectional commands you also forbid
> > userspace from every using them? That seems wrong to me.
> > 
> > There is other SCSI Command Sets than OSD that provide bidirectional
> > commands, even SBC has some (i.e.  X*WRITE*, COMPARE AND WRITE).
> 
> Yes, there are a few.  But the only driver that even supports them
> right now is iscsi_tcp to start with, and we have to drag a significant
> amount of code around just to support this corner case.
> 

But we are not talking about kernel-support here, this interface is
user-facing, and for an interfaces that was made so people could send
arbitrary SCSI commands, that the kernel doesn't support.

Its probably also more complicated to make sure that no one is using
that, in contrast to the OSD stuff that - as state in the patch-letter -
never made it out of academia. Its not like anyone has to release
anything open if they use BSG/SG, its just syscalls after all.

-- 
With Best Regards, Benjamin Block      /      Linux on IBM Z Kernel Development
IBM Systems & Technology Group   /  IBM Deutschland Research & Development GmbH
Vorsitz. AufsR.: Martina Koederitz       /      Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: AmtsG Stuttgart, HRB 243294

