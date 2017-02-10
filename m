Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Subject: Sed-opal Fixes
Date: Fri, 10 Feb 2017 09:00:52 -0700
Message-Id: <1486742454-3254-1-git-send-email-scott.bauer@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: keith.busch@intel.com, arnd@arndb.de, hch@infradead.org,
 linux-kernel@vger.kernel.org, axboe@fb.com, David.Laight@ACULAB.COM,
 linux-block@vger.kernel.org, jonathan.derrick@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

changes from v3->v4:

Changed manual kzalloc + copy from user to memdup_user.

This small series fixes a small ABI issue when using the _IOC_SIZE
with the Activate Locking SP ioctl. I had put the wrong structure
in the IOW macro in the uapi header which caused issues when trying
to copy in the contents for the command.




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
