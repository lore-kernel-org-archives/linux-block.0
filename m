Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56345 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbdFSMzd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 08:55:33 -0400
Date: Mon, 19 Jun 2017 14:55:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH rfc 29/30] nvme: add sed-opal ctrl manipulation in
        admin configuration
Message-ID: <20170619125531.GT29061@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me> <1497799324-19598-30-git-send-email-sagi@grimberg.me> <20170619072220.GF13168@lst.de> <a13e909c-6f0b-0cb3-18c7-878fcf02b3d5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a13e909c-6f0b-0cb3-18c7-878fcf02b3d5@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 19, 2017 at 11:03:36AM +0300, Sagi Grimberg wrote:
>
>> The subject sounds odd and it could use a changelog.  But I'd love to
>> pick this change up ASAP as it's the right thing to do..
>
> How? where would you place it? there is no nvme_configure_admin_queue in
> nvme-core.

Doh.  Yeah, let's keep it where it is.
