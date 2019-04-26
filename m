Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC08C43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 22:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C9A2084F
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 22:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfDZWQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfDZWQn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 18:16:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9F4C30A9961;
        Fri, 26 Apr 2019 22:16:42 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D2BA1001E6F;
        Fri, 26 Apr 2019 22:16:36 +0000 (UTC)
Date:   Sat, 27 Apr 2019 06:16:32 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block/028: check if T10 verification fails
Message-ID: <20190426221630.GB31470@ming.t460p>
References: <20190426023937.19584-1-ming.lei@redhat.com>
 <20190426145711.GA12338@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426145711.GA12338@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 26 Apr 2019 22:16:42 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 07:57:11AM -0700, Christoph Hellwig wrote:
> On Fri, Apr 26, 2019 at 10:39:37AM +0800, Ming Lei wrote:
> > When T10 verification fails, the error code of BLK_STS_PROTECTION
> > may not be propagated to user space, see mpage_end_io().
> 
> Well, we should probably fix that instead of papering over it..

That might be a big change, and not sure when they can be fixed
completely.

This patch at least can expose the issue to user first.

Anyway, CC filesystem guys.

Thanks, 
Ming
