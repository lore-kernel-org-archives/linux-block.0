Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151A16CD33;
	Fri, 14 Feb 2025 05:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739510095; cv=none; b=H4RXpzq0QKAfdMRFTUU/kIFjjiVyatEVTWgCm7EImr+UtpzC/QMtmgt9ijvVtL+DJm7I9uvzzAQBdJEBcXjjO7T1hnBCRMIim/FjMTekJbEsMop1glEVRjxNsLA6r5mFx7yBerI67nQx2WYwRWlbFtxmX+EvV2DhpRL6WiKXoRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739510095; c=relaxed/simple;
	bh=1kskZG13mWWx6SDOsHAtgL4UfHmDhSwHYfFo9cdUNyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/ONAbyc9qODHeD51GSFLoGrDfDk+iXtNGXF+0UlfuQwTg7isg+x5omH47JjnR9ohMztogq+4n+H5TGhmlSMjRPXjlE1Df8oDp0zTF9pztBh6unljr15uJMblTfSO1cc5jSruZgAcgrVHUsVqY1Lvpjh7DnYrtXRzqCM17NKKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=gScARDyk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s/r+zzXO; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="gScARDyk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s/r+zzXO"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 788FA2540130;
	Fri, 14 Feb 2025 00:14:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 14 Feb 2025 00:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739510091; x=
	1739596491; bh=HfqX30mZrCgAa+8ET/Xg+WbqjpSGXVUD+tOnzaOmqk4=; b=g
	ScARDyk8FObnBFRya19vhsClllJHnpmoFzbo72nzCJzfEfJZ8vK1qbcffU53Q8im
	y4/xZyFCSlOR+NOD6ELytBRxn7xwPIPmjo18vSjtif6eeRuJKLZx0qCVTmDbM+Us
	+OXKE9UZIQTwyVf/dP2n5FAqZYRYHKyExbWYenCaTf7ewcezWlQJuiWK5B+HJCkG
	0ZhTK6stBIA+L+cJTvoCualIOLBUDpJeDKqkNijz9fujKSEWO56ov0Y+xgm9b6/o
	6s3xRUTgr1kKvVY6ck/gxMpAp0Avt4KIR47Y5ljZ4xFDj/BA7FBFM3P2w15q92TU
	6zqk9TjhecZAXPBoUGAQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1739510091; x=1739596491; bh=H
	fqX30mZrCgAa+8ET/Xg+WbqjpSGXVUD+tOnzaOmqk4=; b=s/r+zzXOPyAy8T9cj
	CersVZmwN/aUZ/XXzswitaz9iWdeMbVyqCMI/6eat8S50sLYTyLmKhSa0WvXoxVd
	jhRXBpk/dwh4lAx78G6RxLkgyuLveLXNxfg4kVUNN8A+7K+DFRQzKkLOvxgNJtJy
	7XC/+T01YonvJt/a/V4HwOYti+XI1IwIweTuqBCu2Zq/LcDQQgT4CFIdOKGmr5sX
	JKbFZ4zVCM78ibkxT4ZkgsHarPrxVOn2CYroPn2vBZnSDEw5ibsdrP2P2GRDgL0R
	5avADO3RTPBFl5I9xC2aYGaZe8MEHJsQG7rCXzUCMP+Yki1WM+py0k3YeujE10xk
	bYBOw==
X-ME-Sender: <xms:StGuZ-UI2c51iDW6dDKws1mxeQbYirR4xp_dJpzAgpJydWMRrg5kAg>
    <xme:StGuZ6mjeCGlDfS4RmzGCd7nghRKM37i1fqlmAdBnu46V5n5Gu7oJFjIkMFbylUCH
    aq8xVJh719dsU-yEto>
X-ME-Received: <xmr:StGuZybdkwj55OFQOIFUn4fIzNtTG1CVrLFkBWAkbZEuvPi3qKyyukrAuRvGRUOgj0gX523O-eraeZpqeyMFviSqDc2lRMLz7AZNJMy1l2j-1QU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegkeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepkeekueeuhfdvheevvdeftdeuhfehieekleeu
    hfevjeefheeggeetveegveekhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpug
    gvvhhitggvrdhinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmvgesuggrvhhiughrvggrvhgvrhdrtghomhdpnhgspghrtghpthhtohepke
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
    pdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehmvgesuggrvhhiughrvggrvhgvrhdrtghomhdprhgtphhtthhopegrgigsohgvsehk
    vghrnhgvlhdrughkpdhrtghpthhtohepkhhotghtlehisehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:StGuZ1W5kJclrDkpdSVQTOtYZqq5z7N_81PVLoGk0EDa8oBYRdE7YA>
    <xmx:S9GuZ4kLwVtpEo8apq5tQHgrP3sjZkNJGqqeqmHhOGP-QBfQk6z9GA>
    <xmx:S9GuZ6ebwXK2GMssZvIVSlI-HdkhdvDKCBdw-VL-regH3HManymtQw>
    <xmx:S9GuZ6Hh2JD_hUBizj6pQ6EcND7UUm_W1SDIcyyfXYt4aAAscGUkig>
    <xmx:S9GuZy5bLAKEA_qcG7jISOCk_zP7qdI2Iy9GMPdbu7i-l6YK43jjluqw>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Feb 2025 00:14:49 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: David Reaver <me@davidreaver.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: iostats: Rewrite intro, remove outdated formats
Date: Thu, 13 Feb 2025 21:14:30 -0800
Message-ID: <20250214051432.207630-1-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <0e8c8ead-423a-45f3-9e10-020334ef8907@infradead.org>
References: <0e8c8ead-423a-45f3-9e10-020334ef8907@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The discussion of file formats for very old kernel versions obscured the
key information in this document. Additionally, the introduction was
missing a discussion of flush fields added in b6866318657 ("block: add
iostat counters for flush requests") [1].

Rewrite the introduction to discuss only the current kernel's disk I/O stat
file formats. Also, clean up wording to be more concise.

Link: https://lore.kernel.org/lkml/157433282607.7928.5202409984272248322.stgit@buzz/T/ [1]

Signed-off-by: David Reaver <me@davidreaver.com>
---

Thanks for the encouragement Randy. Here is a rewrite of the intro.

This patch is mutually exclusive with the original patch I started this
thread with. Let me know if I should submit it as a standalone thread.
(I'm fairly new to contributing to the kernel.)

 Documentation/admin-guide/iostats.rst | 92 +++++++++++----------------
 1 file changed, 36 insertions(+), 56 deletions(-)

diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
index 609a3201fd4e..8e205c8afd80 100644
--- a/Documentation/admin-guide/iostats.rst
+++ b/Documentation/admin-guide/iostats.rst
@@ -2,62 +2,42 @@
 I/O statistics fields
 =====================
 
-Since 2.4.20 (and some versions before, with patches), and 2.5.45,
-more extensive disk statistics have been introduced to help measure disk
-activity. Tools such as ``sar`` and ``iostat`` typically interpret these and do
-the work for you, but in case you are interested in creating your own
-tools, the fields are explained here.
-
-In 2.4 now, the information is found as additional fields in
-``/proc/partitions``.  In 2.6 and upper, the same information is found in two
-places: one is in the file ``/proc/diskstats``, and the other is within
-the sysfs file system, which must be mounted in order to obtain
-the information. Throughout this document we'll assume that sysfs
-is mounted on ``/sys``, although of course it may be mounted anywhere.
-Both ``/proc/diskstats`` and sysfs use the same source for the information
-and so should not differ.
-
-Here are examples of these different formats::
-
-   2.4:
-      3     0   39082680 hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160
-      3     1    9221278 hda1 35486 0 35496 38030 0 0 0 0 0 38030 38030
-
-   2.6+ sysfs:
-      446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160
-      35486    38030    38030    38030
-
-   2.6+ diskstats:
-      3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160
-      3    1   hda1 35486 38030 38030 38030
-
-   4.18+ diskstats:
-      3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160 0 0 0 0
-
-On 2.4 you might execute ``grep 'hda ' /proc/partitions``. On 2.6+, you have
-a choice of ``cat /sys/block/hda/stat`` or ``grep 'hda ' /proc/diskstats``.
-
-The advantage of one over the other is that the sysfs choice works well
-if you are watching a known, small set of disks.  ``/proc/diskstats`` may
-be a better choice if you are watching a large number of disks because
-you'll avoid the overhead of 50, 100, or 500 or more opens/closes with
-each snapshot of your disk statistics.
-
-In 2.4, the statistics fields are those after the device name. In
-the above example, the first field of statistics would be 446216.
-By contrast, in 2.6+ if you look at ``/sys/block/hda/stat``, you'll
-find just the 15 fields, beginning with 446216.  If you look at
-``/proc/diskstats``, the 15 fields will be preceded by the major and
-minor device numbers, and device name.  Each of these formats provides
-15 fields of statistics, each meaning exactly the same things.
-All fields except field 9 are cumulative since boot.  Field 9 should
-go to zero as I/Os complete; all others only increase (unless they
-overflow and wrap). Wrapping might eventually occur on a very busy
-or long-lived system; so applications should be prepared to deal with
-it. Regarding wrapping, the types of the fields are either unsigned
-int (32 bit) or unsigned long (32-bit or 64-bit, depending on your
-machine) as noted per-field below. Unless your observations are very
-spread in time, these fields should not wrap twice before you notice it.
+The kernel exposes disk statistics via ``/proc/diskstats`` and
+``/sys/block/<device>/stat``. These stats are usually accessed via tools
+such as ``sar`` and ``iostat``.
+
+Here are examples using a disk with two partitions::
+
+   /proc/diskstats:
+     259       0 nvme0n1 255999 814 12369153 47919 996852 81 36123024 425995 0 301795 580470 0 0 0 0 60602 106555
+     259       1 nvme0n1p1 492 813 17572 96 848 81 108288 210 0 76 307 0 0 0 0 0 0
+     259       2 nvme0n1p2 255401 1 12343477 47799 996004 0 36014736 425784 0 344336 473584 0 0 0 0 0 0
+
+   /sys/block/nvme0n1/stat:
+     255999 814 12369153 47919 996858 81 36123056 426009 0 301809 580491 0 0 0 0 60605 106562
+
+   /sys/block/nvme0n1/nvme0n1p1/stat:
+     492 813 17572 96 848 81 108288 210 0 76 307 0 0 0 0 0 0
+
+Both files contain the same 17 statistics. ``/sys/block/<device>/stat``
+contains the fields for ``<device>``. In ``/proc/diskstats`` the fields
+are prefixed with the major and minor device numbers and the device
+name. In the example above, the first stat value for ``nvme0n1`` is
+255999 in both files.
+
+The sysfs ``stat`` file is efficient for monitoring a small, known set
+of disks. If you're tracking a large number of devices,
+``/proc/diskstats`` is often the better choice since it avoids the
+overhead of opening and closing multiple files for each snapshot.
+
+All fields are cumulative, monotonic counters that start at zero at
+boot, except for field 9, which resets to zero as I/Os complete. Other
+fields only increase unless they overflow and wrap. Wrapping may occur
+on long-running or high-load systems, so applications should handle this
+properly. Field types are either 32-bit unsigned integers or unsigned
+longs, which may be 32-bit or 64-bit depending on the architecture. As
+long as observations are taken at reasonable intervals, wraparounds
+should be rare.
 
 Each set of stats only applies to the indicated device; if you want
 system-wide stats you'll have to find all the devices and sum them all up.

base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
