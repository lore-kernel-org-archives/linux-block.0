Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752164AbdDLKzp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2017 06:55:45 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v3CAsDdd110171
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2017 06:55:44 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 29rxx3uk69-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2017 06:55:44 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <bblock@linux.vnet.ibm.com>;
        Wed, 12 Apr 2017 11:55:42 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v3CAtdjP13304264
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2017 10:55:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C855611C058
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2017 11:54:56 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD00911C06E
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2017 11:54:56 +0100 (BST)
Received: from bblock-ThinkPad-W530 (unknown [9.152.212.79])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2017 11:54:56 +0100 (BST)
Date: Wed, 12 Apr 2017 12:55:38 +0200
From: Benjamin Block <bblock@linux.vnet.ibm.com>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Avoid that scsi-mq and dm-mq queue processing
 stalls sporadically
References: <20170407181654.27836-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170407181654.27836-1-bart.vanassche@sandisk.com>
Message-Id: <20170412105538.GB22576@bblock-ThinkPad-W530>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Apr 07, 2017 at 11:16:48AM -0700, Bart Van Assche wrote:
> Hello Jens,
> 
> The six patches in this patch series fix the queue lockup I reported
> recently on the linux-block mailing list. Please consider these patches
> for inclusion in the upstream kernel.
> 

Hey Bart,

just out of curiosity. Is this maybe related to similar stuff happening
when CPUs are hot plugged - at least in that the stack gets stuck? Like
in this thread here:
https://www.mail-archive.com/linux-block@vger.kernel.org/msg06057.html

Would be interesting, because we recently saw similar stuff happening.


                                                    Beste Gr��e / Best regards,
                                                      - Benjamin Block
-- 
Linux on z Systems Development         /         IBM Systems & Technology Group
		  IBM Deutschland Research & Development GmbH 
Vorsitz. AufsR.: Martina Koederitz     /        Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: AmtsG Stuttgart, HRB 243294
