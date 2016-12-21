Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758786AbcLUXLV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Dec 2016 18:11:21 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBLN8XTP078237
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2016 18:11:20 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 27g1uu2w7t-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 21 Dec 2016 18:11:20 -0500
Received: from localhost
        by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <mauricfo@linux.vnet.ibm.com>;
        Wed, 21 Dec 2016 21:11:18 -0200
Subject: Re: [PATCH] scsi: do not requeue requests unaligned with device
 sector size
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>
References: <1482199347-9128-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <yq1fulh1ivs.fsf@sermon.lab.mkp.net>
Cc: jejb@linux.vnet.ibm.com, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        gpiccoli@linux.vnet.ibm.com
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Wed, 21 Dec 2016 21:11:09 -0200
MIME-Version: 1.0
In-Reply-To: <yq1fulh1ivs.fsf@sermon.lab.mkp.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c7a174fc-aec4-e8bb-b7ad-8c53a87046de@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/21/2016 05:50 AM, Christoph Hellwig wrote:
 > How do you even get an unaligned residual count?  Except for SES
 > processor devices (which will only issue BLOCK_PC commands) this is
 > not allowed by SPC:
 >
 > "The residual count shall be reported in bytes if the peripheral device
 >  type in the destination target descriptor is 03h (i.e., processor 
device),
 >  and in destination device blocks for all other device type codes.

On 12/21/2016 06:09 AM, Hannes Reinecke wrote:
 > Which actually would be pretty much my objection, too.
 >
 > This would only be applicable for 512e drives, where we _might_ end up
 > with a residual smaller than the physical sector size.
 > But that should be handled by firmware; after all, that's what the 'e'
 > implies, right?

On 12/21/2016 12:01 PM, Martin K. Petersen wrote:
> I agree with Christoph and Hannes. Some of this falls into the gray area
> that's outside of the T10 spec (HBA programming interface guarantees)
> but it seems like a deficiency in the HBA to report a byte count that's
> not a multiple of the logical block size. A block can't be partially
> written. Either it made it or it didn't. Regardless of how the I/O is
> being broken up into frames at the transport level and at which offset
> the transfer was interrupted.

Christoph, Hannes, Martin,

Thank you all for your comments and pointers to the documentation/spec.
I'll carry it on with the HBA and storage folks.

cheers,

-- 
Mauricio Faria de Oliveira
IBM Linux Technology Center

