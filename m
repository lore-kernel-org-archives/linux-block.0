Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:42330 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754934AbcIOLwV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 07:52:21 -0400
Date: Thu, 15 Sep 2016 04:52:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alex Bligh <alex@alex.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Wouter Verhelst <w@uter.be>,
        Josef Bacik <jbacik@fb.com>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>,
        kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915115217.GB6411@infradead.org>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
 <20160915112936.vb7zxe7k6rvczosg@grep.be>
 <20160915114005.GC23259@infradead.org>
 <C38C69BC-CA2F-4F73-A762-CDAEA5C94702@alex.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C38C69BC-CA2F-4F73-A762-CDAEA5C94702@alex.org.uk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 12:46:07PM +0100, Alex Bligh wrote:
> Essentially NBD does supports FLUSH/FUA like this:
> 
> https://www.kernel.org/doc/Documentation/block/writeback_cache_control.txt
> 
> IE supports the same FLUSH/FUA primitives as other block drivers (AIUI).
> 
> Link to protocol (per last email) here:
> 
> https://github.com/yoe/nbd/blob/master/doc/proto.md#ordering-of-messages-and-writes

Flush as defined by the Linux block layer (and supported that way in
SCSI, ATA, NVMe) only requires to flush all already completed writes
to non-volatile media.  It does not impose any ordering unlike the
nbd spec.

FUA as defined by the Linux block layer (and supported that way in SCSI,
ATA, NVMe) only requires the write operation the FUA bit is set on to be
on non-volatile media before completing the write operation.  It does
not impose any ordering, which seems to match the nbd spec.  Unlike the
NBD spec Linux does not allow FUA to be set on anything by WRITE
commands.  Some other storage protocols allow a FUA bit on READ
commands or other commands that write data to the device, though.
