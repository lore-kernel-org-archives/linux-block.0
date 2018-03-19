Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 00/11] block: sed-opal support write to shadow mbr
Date: Mon, 19 Mar 2018 19:36:42 +0100
Message-Id: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

Hi,
I was advised to resend the patchset as a v2 where all the patches are
in a flat hierarchy. So here is a complete set which hopefully pleases
all requirements.
As the previous fixes have by now all landed into linux-next, no
additional patches are required for testing.

Thanks,
 Jonas

--

Jonas Rabenstein (11):
  block: sed-opal: use correct macro for method length
  block: sed-opal: unify space check in add_token_*
  block: sed-opal: unify cmd start and finalize
  block: sed-opal: unify error handling of responses
  block: sed-opal: print failed function address
  block: sed-opal: split generation of bytestring header and content
  block: sed-opal: add ioctl for done-mark of shadow mbr
  block: sed-opal: ioctl for writing to shadow mbr
  block: sed-opal: unify retrieval of table columns
  block: sed-opal: get metadata about opal-sed tables
  block: sed-opal: check size of shadow mbr

 block/opal_proto.h            |  18 ++
 block/sed-opal.c              | 619 +++++++++++++++++++++---------------------
 include/linux/sed-opal.h      |   2 +
 include/uapi/linux/sed-opal.h |   9 +
 4 files changed, 339 insertions(+), 309 deletions(-)

-- 
2.16.1
