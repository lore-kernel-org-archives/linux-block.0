Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39686 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbdHPKtg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2017 06:49:36 -0400
Date: Wed, 16 Aug 2017 12:49:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: Centralize nvme controller reset, delete and fabrics periodic
        reconnects
Message-ID: <20170816104935.GA30525@lst.de>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Did you get a chance to take a look at converting PCIe over?

A lot of the design decisions seem to be driven by allowing PCIe
as well, and I'd like to see if that's possible / useful to start
with.
