Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.avalus.com ([89.16.176.221]:56821 "EHLO mail.avalus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754450AbcIOM2Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 08:28:25 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20160915121818.GA1155@infradead.org>
Date: Thu, 15 Sep 2016 13:28:21 +0100
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>,
        "nbd-general@lists.sourceforge.net"
        <nbd-general@lists.sourceforge.net>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Markus Pargmann <mpa@pengutronix.de>, kernel-team@fb.com
Message-Id: <3B56A4C8-1796-40CA-8BD9-432CA929ABE2@alex.org.uk>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com> <20160909200203.phhvodsfs7ymukfp@grep.be> <20160915104935.ohuwgq2chsedz6fl@grep.be> <20160915113807.GA23259@infradead.org> <20160915115514.7hba23nqvvwfhb5z@grep.be> <20160915120125.GA31044@infradead.org> <30DE0D1A-FAB1-43EE-A88E-ED6565719166@alex.org.uk> <20160915121818.GA1155@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


> On 15 Sep 2016, at 13:18, Christoph Hellwig <hch@infradead.org> wrote:
> 
> Yes, please do that.  A "barrier" implies draining of the queue.

Done

-- 
Alex Bligh




