Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Subject: Sed-opal fixups 
Date: Thu,  9 Feb 2017 10:19:59 -0700
Message-Id: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
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

It may be too late to change anyhting in the uapi header. When we
switched over to using IOC_SIZE I found a bug where I had switched
up a structure in one of the series from v4 to v5 but never changed
the structure in the IOW. The structure that was in there was to small
so when we kzalloc on it we don't request enough space. It worked before
because we were using the cmd strictly as a command #, not using the IOC
and friends.

If it's too late to modify that IOW, I can work around it by reallocing
on the correct size for that command only. I verified the rest of the
commands and the structures are the same.

Let me know what you think, please.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
