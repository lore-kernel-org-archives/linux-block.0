Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52397 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932483AbdIFOPO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Sep 2017 10:15:14 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v86EEt47083513
        for <linux-block@vger.kernel.org>; Wed, 6 Sep 2017 10:15:14 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ctjg6rmc3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2017 10:15:13 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <bblock@linux.vnet.ibm.com>;
        Wed, 6 Sep 2017 15:15:11 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v86EFA3516253064
        for <linux-block@vger.kernel.org>; Wed, 6 Sep 2017 14:15:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18F4242047
        for <linux-block@vger.kernel.org>; Wed,  6 Sep 2017 15:11:40 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1F4942042
        for <linux-block@vger.kernel.org>; Wed,  6 Sep 2017 15:11:39 +0100 (BST)
Received: from bblock-ThinkPad-W530 (unknown [9.152.98.219])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-block@vger.kernel.org>; Wed,  6 Sep 2017 15:11:39 +0100 (BST)
Date: Wed, 6 Sep 2017 16:15:09 +0200
From: Benjamin Block <bblock@linux.vnet.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, "#4 . 11+" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] bsg-lib: fix kernel panic resulting from missing
 allocation of reply-buffer
References: <20170906134416.19980-1-hch@lst.de>
 <20170906134416.19980-2-hch@lst.de>
 <42e9ef4d-6981-2b0c-bdc3-afb5b1750666@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <42e9ef4d-6981-2b0c-bdc3-afb5b1750666@kernel.dk>
Message-Id: <20170906141509.GB8702@bblock-ThinkPad-W530>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 06, 2017 at 08:07:43AM -0600, Jens Axboe wrote:
> On 09/06/2017 07:44 AM, Christoph Hellwig wrote:
> > From: Benjamin Block <bblock@linux.vnet.ibm.com>
> > 
> > Since we split the scsi_request out of struct request bsg fails to
> > provide a reply-buffer for the drivers. This was done via the pointer
> > for sense-data, that is not preallocated anymore.
> 
> Confused, this is already in master, was included before 4.13 was
> finalized.
> 

I think this is the backport for 4.11 and 4.12 as requested by Greg. I
just send a mail as answer that I would do it, but I guess Christoph
already had something in the pipe.

Or? I'll take a look.


                                                    Beste Gr��e / Best regards,
                                                      - Benjamin Block
-- 
Linux on z Systems Development         /         IBM Systems & Technology Group
		  IBM Deutschland Research & Development GmbH 
Vorsitz. AufsR.: Martina Koederitz     /        Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: AmtsG Stuttgart, HRB 243294
