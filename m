Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEDFC49ED6
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 02:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61BC2085B
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 02:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfILCYL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:24:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfILCYL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 22:24:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8AD318980F3;
        Thu, 12 Sep 2019 02:24:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2377460852;
        Thu, 12 Sep 2019 02:24:06 +0000 (UTC)
Date:   Thu, 12 Sep 2019 10:24:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     development@manuel-bentele.de
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 0/5] block: loop: add file format subsystem and QCOW2
 file format driver
Message-ID: <20190912022359.GD2731@ming.t460p>
References: <20190823225619.15530-1-development@manuel-bentele.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823225619.15530-1-development@manuel-bentele.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Thu, 12 Sep 2019 02:24:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 24, 2019 at 12:56:14AM +0200, development@manuel-bentele.de wrote:
> From: Manuel Bentele <development@manuel-bentele.de>
> 
> Hi
> 
> Regarding to the following discussion [1] on the mailing list I show you 
> the result of my work as announced at the end of the discussion [2].
> 
> The discussion was about the project topic of how to implement the 
> reading/writing of QCOW2 in the kernel. The project focuses on an read-only 
> in-kernel QCOW2 implementation to increase the read/write performance 
> and tries to avoid nbd. Furthermore, the project is part of a project 
> series to develop a in-kernel network boot infrastructure that has no need 

I'd suggest you to share more details about this use case first:

1) what is the in-kernel network boot infrastructure? which functions
does it provide for user?

2) how does the in kernel QCOW2 interacts with in-kernel network boot
infrastructure?

3) most important thing, what are the exact steps for one user to use
the in-kernel network boot infrastructure and in-kernel QCOW2?

Without knowing the motivation/purpose and exact use case, it doesn't
make sense to discuss the implementation details, IMO.

Thanks,
Ming
