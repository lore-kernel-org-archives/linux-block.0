Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57687 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbcFIOAm (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2016 10:00:42 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, mchristi@redhat.com
Cc: linux-block@vger.kernel.org
Subject: two small updates for the request op split
Date: Thu,  9 Jun 2016 16:00:34 +0200
Message-Id: <1465480836-32093-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

First one packs struct request better, and the second one gives the
secure erase operation it's own opcode as it's very different from
the normal discard.

