Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33175 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933940AbcIOM14 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:27:56 -0400
Date: Thu, 15 Sep 2016 05:27:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wouter Verhelst <w@uter.be>
Cc: Christoph Hellwig <hch@infradead.org>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Markus Pargmann <mpa@pengutronix.de>, kernel-team@fb.com
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
Message-ID: <20160915122753.GA26310@infradead.org>
References: <20160909200203.phhvodsfs7ymukfp@grep.be>
 <20160915104935.ohuwgq2chsedz6fl@grep.be>
 <27B346AF-F144-4770-BE38-446A66E71326@alex.org.uk>
 <20160915112936.vb7zxe7k6rvczosg@grep.be>
 <20160915114005.GC23259@infradead.org>
 <C38C69BC-CA2F-4F73-A762-CDAEA5C94702@alex.org.uk>
 <20160915115217.GB6411@infradead.org>
 <20160915120159.2o5lb7rvkjndzayh@grep.be>
 <20160915122008.GB1155@infradead.org>
 <20160915122631.7wus5o6qin6o7uz5@grep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160915122631.7wus5o6qin6o7uz5@grep.be>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 02:26:31PM +0200, Wouter Verhelst wrote:
> Yes. I think the kernel nbd driver should probably filter out FUA on
> READ. It has no meaning in the case of nbd, and whatever expectations
> the kernel may have cannot be provided for by nbd anyway.

The kernel never sets FUA on reads - I just pointed out that other
protocols have defined (although horrible) semantics for it.
