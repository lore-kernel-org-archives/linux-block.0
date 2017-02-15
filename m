Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: 
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Scott Bauer <scott.bauer@intel.com>,
	Rafael Antognolli <rafael.antognolli@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv3 0/4] OPAL patches
Date: Wed, 15 Feb 2017 12:42:05 -0700
Message-Id: <1487187731-10293-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-block@vger.kernel.org>

Just a couple of fixes for sed-opal to prevent faulty firmware from
allowing us to go off in the weeds, and a helper to remove some
duplicate code.

v2->v3:
corrected the bad calculation on the response parser check and changed
it to only check the subpacket length

v1->v2:
left tok->len as a size_t
got everyone important on the same email thread


Jon Derrick (4):
  block/sed: Use ssize_t on atom parsers to return errors
  block/sed: Add helper to qualify response tokens
  block/sed: Check received header lengths
  MAINTAINERS: Remove powerpc's opal match

 MAINTAINERS      |   1 -
 block/sed-opal.c | 124 +++++++++++++++++++++++++++----------------------------
 2 files changed, 60 insertions(+), 65 deletions(-)

-- 
1.8.3.1
