Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8.0/8.4] block: sed-opal: check size of shadow mbr
Date: Wed, 14 Mar 2018 07:15:41 +0100
Message-Id: <cover.1521006595.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5>
References: <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <b0b34fc0132312c09629c868d33b74fe5a19854e.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <20180313154416.sgptuw7jcn7l76vn@sbauer-Z170X-UD5>
List-ID: <linux-block@vger.kernel.org>

Hi,
I managed to extract the usable shadow mbr size out of my 850Evos
OPAL_TABLE_TABLE and added an appropriate check into the write function.
As this involves more than just a few lines, I decided to split the v2
of this subpatch into 4 separate patches. I am unsure what whould be the
best practice for such an situation but hope it is okay like this.

Also the userspace exported pointer is replaced with an u64 value.

Jonas Rabenstein (4):
  block: sed-opal: ioctl for writing to shadow mbr
  block: sed-opal: unify retrieval of table columns
  block: sed-opal: get metadata about opal-sed tables
  block: sed-opal: check size of shadow mbr

 block/opal_proto.h            |  18 ++++
 block/sed-opal.c              | 245 ++++++++++++++++++++++++++++--------------
 include/linux/sed-opal.h      |   1 +
 include/uapi/linux/sed-opal.h |   8 ++
 4 files changed, 189 insertions(+), 83 deletions(-)

-- 
2.16.1
