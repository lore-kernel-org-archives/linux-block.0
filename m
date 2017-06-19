Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54693 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdFSHNQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 03:13:16 -0400
Date: Mon, 19 Jun 2017 09:13:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH rfc 01/30] nvme: Add admin connect request queue
Message-ID: <20170619071314.GA13168@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me> <1497799324-19598-2-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497799324-19598-2-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jun 18, 2017 at 06:21:35PM +0300, Sagi Grimberg wrote:
> In case we reconnect with inflight admin IO we
> need to make sure that the connect comes before
> the admin command. This can be only achieved by
> using a seperate request queue for admin connects.

Use up a few more lines of the available space for your lines? :)

Wouldn't a head insertation also solve the problem?
