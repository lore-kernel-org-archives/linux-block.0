Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: 
Subject: [PATCHv4 0/4] OPAL patches, cont'd
Date: Tue, 21 Feb 2017 11:59:12 -0700
Message-Id: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Rafael Antognolli <rafael.antognolli@intel.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Jon Derrick <jonathan.derrick@intel.com>, Christoph Hellwig <hch@lst.de>,
 Scott Bauer <scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

v3->v4:
Passes in 'lock_held' into opal_lock_unlock() so we don't need to
mutex_trylock(). I wasn't totally confident in that approach anyways.

v2->v3:
Squashed 5/5 into 4/5
Changed opal_step structs back to const
Cleaned up opal_lock_unlock

v1->v2:
Moved misplaced code from 5/5 to 4/5

The first three in the series have been reviewed already but I wanted to
squash them with the last patch since they haven't been pulled yet.

The last patch is an attempt to refactor some of the awkward func data
and state separation into a common struct

Jon Derrick (4):
  block/sed: Use ssize_t on atom parsers to return errors
  block/sed: Add helper to qualify response tokens
  block/sed: Check received header lengths
  block/sed: Embed function data into the function sequence

 block/sed-opal.c | 552 +++++++++++++++++++++++--------------------------------
 1 file changed, 227 insertions(+), 325 deletions(-)

-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
