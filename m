Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39292 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751517AbdHPJRf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Aug 2017 05:17:35 -0400
Date: Wed, 16 Aug 2017 11:17:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Omar Sandoval <osandov@fb.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-block@vger.kernel.org
Subject: migrate the block tests from Dimity to blktests?
Message-ID: <20170816091733.GA22832@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi all,

Dmitry Monakhov wrote a few very useful block layers tests a while
ago and wired them up for xfstests at that point:

	https://github.com/dmonakhov/xfstests/commits/dif-dix-tests-v2

Is anyone interested in migrating them over to blktests?  Doing
so has been on my todo list for a while, but given that said
lists keeps growing I'd like to check if anyone else might be
interested.
