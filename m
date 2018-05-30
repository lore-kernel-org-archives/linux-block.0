Return-Path: <BATV+1f4557cc97fec8e307c5+5393+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: nvme/nvmet AEN and log page fixups v2
Date: Wed, 30 May 2018 18:45:48 +0200
Message-Id: <20180530164600.26856-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi all,

this series started as prep work for ANA, but has grown a lot.

The idea is to make the AEN handling in the target closer to what
the standard says, and implement the changed namespaces list log page,
which is required to clear the namespace attribute notice event.

One the host side this just makes sure we actually have the events
we handle enabled using Set Features, and it fixes the handling of
the namespace attribute notice event so that it actually does get
cleared by issuing the log page.

Last but not last two block cleanups are thrown in so that we don't
print a pointless message when we delete a namespaces, and also
unexport the function printing said message as it should only be
called from the core code.

Changes from v1:
 - don't copy garbage when more then 1024 namespaces changed
 - filter out duplicates in the changed namespace list log page
 - use the proper define for the supported events to initialize
   OAES
 - add the nvmet_aen_disabled helper from the ANA series
 - allow the mandatory smart AENs in Set Features
