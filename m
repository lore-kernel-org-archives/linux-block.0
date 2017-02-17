Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8020 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934159AbdBQPSx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 10:18:53 -0500
Date: Fri, 17 Feb 2017 10:27:16 -0500
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: scott.bauer@intel.com, jonathan.derrick@intel.com, axboe@fb.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: OPAL fixups
Message-ID: <20170217152716.GB18275@localhost.localdomain>
References: <20170217125941.14319-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170217125941.14319-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 17, 2017 at 01:59:37PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this contains a few more OPAL-related fixups.  It tones down warnings a bit,
> allocates the OPAL-ѕpecific data structure in a separate dynamic allocation,
> checks for support of Security Send/Receive in NVMe before using them,
> and makes sure we re-discovery the security capabilities after each reset.

Patches 1-3 look good to me.
