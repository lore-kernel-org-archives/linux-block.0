Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:36183 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755550AbdBQM7s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 07:59:48 -0500
From: Christoph Hellwig <hch@lst.de>
To: scott.bauer@intel.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: OPAL fixups
Date: Fri, 17 Feb 2017 13:59:37 +0100
Message-Id: <20170217125941.14319-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

this contains a few more OPAL-related fixups.  It tones down warnings a bit,
allocates the OPAL-ѕpecific data structure in a separate dynamic allocation,
checks for support of Security Send/Receive in NVMe before using them,
and makes sure we re-discovery the security capabilities after each reset.
