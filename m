Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752142AbdJTQrc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2017 12:47:32 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9KGiV93136736
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2017 12:47:32 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dqme8sf94-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2017 12:47:32 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <bblock@linux.vnet.ibm.com>;
        Fri, 20 Oct 2017 17:47:30 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9KGlSBY25690268
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2017 16:47:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D97752047
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2017 16:41:45 +0100 (BST)
Received: from bblock-ThinkPad-W530 (unknown [9.145.16.234])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 03EA752041
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2017 16:41:44 +0100 (BST)
Date: Fri, 20 Oct 2017 18:47:27 +0200
From: Benjamin Block <bblock@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 9/9] bsg: split handling of SCSI CDBs vs transport
 requeues
References: <20171003104845.10417-1-hch@lst.de>
 <20171003104845.10417-10-hch@lst.de>
 <20171019155933.GE26185@bblock-ThinkPad-W530>
 <20171020162630.GA14277@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171020162630.GA14277@lst.de>
Message-Id: <20171020164727.GA26380@bblock-ThinkPad-W530>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Oct 20, 2017 at 06:26:30PM +0200, Christoph Hellwig wrote:
> On Thu, Oct 19, 2017 at 05:59:33PM +0200, Benjamin Block wrote:
> > > +#define ptr64(val) ((void __user *)(uintptr_t)(val))
> > 
> > Better to reflect the special property, that it is a user pointer, in
> > the name of the macro. Maybe something like user_ptr(64). The same
> > comment for the same macro in bsg.c.
> 
> Not sure it's worth it especially now that Martin has merged the patch.

He did? I only saw a mail that he picked patches 2-5. So all the bsg
changes are still open I think.

(Maybe I just missed that, I haven't exactly followed the list very
closely as of late)

> But given how many interface we have all over the kernel that use a u64
> to store a user pointer in ioctls and similar it might make sense to
> lift a helper like this to a generic header.  In that case we'll need
> a more descriptive name for sure.
> 
> > > +static int bsg_transport_check_proto(struct sg_io_v4 *hdr)
> > > +{
> > > +	if (hdr->protocol != BSG_PROTOCOL_SCSI  ||
> > > +	    hdr->subprotocol != BSG_SUB_PROTOCOL_SCSI_TRANSPORT)
> > > +		return -EINVAL;
> > > +	if (!capable(CAP_SYS_RAWIO))
> > > +		return -EPERM;
> > 
> > Any particular reason why this is not symmetric with bsg_scsi? IOW
> > permission checking done in bsg_transport_fill_hdr(), like it is done in
> > bsg_scsi_fill_hdr()?
> > 
> > We might save some time copying memory with this (we also only talk
> > about ~20 bytes here), but on the other hand the interface would be more
> > clean otherwise IMO (if we already do restructure the interface) -
> > similar callbacks have similar responsibilities.
> 
> I could move the capable check around, no sure why I had done it that
> way, it's been a while.  Probably because blk_verify_command needs the
> CDB while a simple capable() check does not.

That was my guess, too. I just though it would be more consistent otherwise.
Its not a big thing, really.


                                                    Beste Gr��e / Best regards,
                                                      - Benjamin Block
-- 
Linux on z Systems Development         /         IBM Systems & Technology Group
		  IBM Deutschland Research & Development GmbH 
Vorsitz. AufsR.: Martina Koederitz     /        Gesch�ftsf�hrung: Dirk Wittkopp
Sitz der Gesellschaft: B�blingen / Registergericht: AmtsG Stuttgart, HRB 243294
