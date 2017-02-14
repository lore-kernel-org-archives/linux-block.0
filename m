Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55101 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbdBNTQF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2017 14:16:05 -0500
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernek.dk
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: sense handling improvements
Date: Tue, 14 Feb 2017 20:15:54 +0100
Message-Id: <20170214191600.17480-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

this series is on top of the scsi_request changes in Jens' tree and
further improves the handling of the sense buffer.

The first patch prevents any possibily of reusing stale sense codes
in sense headers, and is a bug fix that we should probably get into
the block tree ASAP.

The rest cleans up handling of the parsed sense data and could go in
either through the block tree, or a SCSI branch on top of the block
tree.
