Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756187AbcIOMUL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:20:11 -0400
Date: Thu, 15 Sep 2016 05:20:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wouter Verhelst <w@uter.be>
Cc: Christoph Hellwig <hch@infradead.org>,
        Alex Bligh <alex@alex.org.uk>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Markus Pargmann <mpa@pengutronix.de>, kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915122008.GB1155@infradead.org>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
 <20160915112936.vb7zxe7k6rvczosg@grep.be>
 <20160915114005.GC23259@infradead.org>
 <C38C69BC-CA2F-4F73-A762-CDAEA5C94702@alex.org.uk>
 <20160915115217.GB6411@infradead.org>
 <20160915120159.2o5lb7rvkjndzayh@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160915120159.2o5lb7rvkjndzayh@grep.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 02:01:59PM +0200, Wouter Verhelst wrote:
> Yes. There was some discussion on that part, and we decided that setting
> the flag doesn't hurt, but the spec also clarifies that using it on READ
> does nothing, semantically.
>
> 
> The problem is that there are clients in the wild which do set it on
> READ, so it's just a matter of "be liberal in what you accept".

Note that FUA on READ in SCSI and NVMe does have a meaning - it
requires you to bypass any sort of cache on the target.  I think it's an
wrong defintion because it mandates implementation details that aren't
observable by the initiator, but it's still the spec wording and nbd
diverges from it.  That's not nessecarily a bad thing, but a caveat to
look out for.
