Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35DBC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9825720867
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kJCAa/7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9825720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeLADgZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:36:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeLADgZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 22:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=965IEQwCeaP7tM4UAHQvRgfeimmruA3ABQaNbuXy5UE=; b=kJCAa/7pEIB308S0v6COoBQOF
        G/ZL/c72WMlTfrbtMdd9A/Q9bOoB5rhQEcZ7U0C7iaF9ei+X14NGNgjbqb9uGuOHQa//CMPz7g59s
        LFRhJ+XwSbe06L6ge1r8+RuPdfwm4AI9LxlVwzVCpoqid12tdXF8VY65bbJFquzPjhBu7+9Kxcl+n
        te+fh85E9+feo+rE/uSloSri/o+V0JEePVeDxzmwC6q8UXmMPutQ6IttBQr6B6trG3WTMf5EL6sqn
        cQ1lfNVcO9Lh/4EajxTCbyCbPCMara/huxqKHPsDelbvoHdspWS7zurcVyxZSLk6xh+mUe1bTRb93
        zc8j5X9mw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSlcf-0004S4-FF; Fri, 30 Nov 2018 16:26:33 +0000
Date:   Fri, 30 Nov 2018 08:26:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for 4.20
Message-ID: <20181130162633.GA16933@infradead.org>
References: <20181130152430.GA3107@infradead.org>
 <01b6314c-903e-6787-ccf6-e93aa789199a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01b6314c-903e-6787-ccf6-e93aa789199a@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 08:26:24AM -0700, Jens Axboe wrote:
> On 11/30/18 8:24 AM, Christoph Hellwig wrote:
> > Various fixlets all over, including throwing in a 'default y' for the
> > multipath code, given that we want people to actually enable it for full
> > functionality.
> 
> Why enable it by default? 99.9% of users aren't going to care. That
> seems like an odd choice.

Because its small, and if you don't have it you are going to run into
problems pretty soon.

Anyway, to get the fixes out ASAP here is the updated request without
it:

The following changes since commit 14b04063cc994effc86f976625bf8f806d8d44cb:

  Merge branch 'nvme-4.20' of git://git.infradead.org/nvme into for-linus (2018-11-21 05:56:28 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.20

for you to fetch changes up to 6344d02dc8f886b6bbcd922ae1a17e4a41500f2d:

  nvme-rdma: fix double freeing of async event data (2018-11-30 17:23:23 +0100)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: warn when finding multi-port subsystems without multipathing enabled

Ewan D. Milne (1):
      nvme-fc: initialize nvme_req(rq)->ctrl after calling __nvme_fc_init_request()

Igor Konopko (1):
      nvme-pci: fix surprise removal

Keith Busch (1):
      nvme: Free ctrl device name on init failure

Prabhath Sajeepa (1):
      nvme-rdma: fix double freeing of async event data

Sagi Grimberg (1):
      nvme: flush namespace scanning work just before removing namespaces

 drivers/nvme/host/core.c | 8 +++++---
 drivers/nvme/host/fc.c   | 2 +-
 drivers/nvme/host/nvme.h | 3 +++
 drivers/nvme/host/rdma.c | 2 ++
 4 files changed, 11 insertions(+), 4 deletions(-)
