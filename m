Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9531519A7;
	Sat, 15 Feb 2025 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739642489; cv=none; b=LsHrk+p7e5ek4iWcnJNcE6JQpL4lWHuKNj2bTcLWUu1IaYDi4hbKYzpqljmynv6paf0MZwAG9HKgso1fj3Kl+4QpqhFzHZjVPyT4XlVUutx6XXwKa9pwb4CVsllQTGJfuuupkX+qm1Firoppe1lv7YvqnqWa3RmWRdJZ5t0KwD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739642489; c=relaxed/simple;
	bh=taWaqU9AJIffNi083S431VvZXElZa2w7Z2Q7dkiccEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8QVQyefyOM+Q+MR1gJ4pTIhNDZMr6+6I8qJFUZ2MPiVch47+fE1IF0lwZD4doItulASu/Tt9AMhJMIYbS88J7APR6f3BwEfi4CyoEdW22D/do8YPjlwevxc18kG6qX5H52xZrcjGzSPtAAQErbpB+nM0jYJy3m6ddgyAVOYk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=S5FEnrgi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qTD046kO; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="S5FEnrgi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qTD046kO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 703ED1140190;
	Sat, 15 Feb 2025 13:01:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 15 Feb 2025 13:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1739642485; x=1739728885; bh=Fya9lbkVWb
	PFwet1rRxpAFVsKDHH9iBCX448CWgNPC8=; b=S5FEnrgie0isFkLmRx1RcT+yQ/
	qg/jKhGjwYLpUg0TaZ4NQ4bcOnUdbI6YoC0jyXq9rwHEyfYjK0y1qOWU+Ozb8FCb
	0KyPzYha6kdfI+1BmpB6nHu/yYM7RPdcmnc8YZ/w4dDhEfWKT63/bvpKtMvNqfn/
	VapT6eO1zSz6PdKOvGxgo3rxYnG1LMLAUFFTKlRJ/KIBKpkyIuR95RmFuNkV7F8e
	+HaoQdQXYLiIlL5lzEijxpSw6QyvyoJFiq6WpxwyDLvJzD1aXWOOxeyUvEeU/OZk
	64aU2pIEOmZOmzZUv+dZSlqy87/IXS7pjSHbLrMtvhhWBaAT6+CSQJNu6vGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739642485; x=1739728885; bh=Fya9lbkVWbPFwet1rRxpAFVsKDHH9iBCX44
	8CWgNPC8=; b=qTD046kOhHcqO6GKtUzVt/fuwDl9+Y6vQbuasLNWbOuxnJ7lxPt
	Bp5g3UHRFJP7aMn6tG2YaCxl76oQBf7csI7UOb5AcUAQe514aaGyD9Tbu12YuepO
	Bje7EICVgAW5j53HMIqHtnQrPHqw4DRPjFmd+kmPp8VIFM7aRHtH8gQTw00X8Suz
	S23dXgRW6zAEg8D/C0v7yKpApq4F/frNRavEcbaxGXVhLai2b7NwUXDgavVnaYtM
	b1CYPwrl3jaqm8E7c/C4RMbMQ4yIn+os+r0Z+/fc3ht+JNvksAv5uZbyegyYNYFr
	3vk2uyewpLK3QhbR6AXPpx5RrJ6RC/Tl8XA==
X-ME-Sender: <xms:dNawZy5JAUq76KbQnA4vx__-R-EJ8aSz2-toHE9NHnZm3ngwjN3RcA>
    <xme:dNawZ76YqUxuZRZ68wVbFd3bTw4O3e_wueugwAvfpW4IU-XvjbdB3EP3Z7nbH9Cqs
    fNmsLJG4T6EzCo2dKM>
X-ME-Received: <xmr:dNawZxcV-Y0yf2s1tg4cWSmty_2p_mOlcIsH9cIZmJaG4IJcHgDO57p-MFBbjmz_6b4i2QUQFwXGWhG7sl7-_01jevF0wjEtivLzDF5UR1mNGrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehfedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrhdrtg
    homheqnecuggftrfgrthhtvghrnhepkedtffffhfekhffhheeuleegfeejffeiudduudff
    geehffejtedtgeduhefgheeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpuggvvh
    hitggvrdhinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmvgesuggrvhhiughrvggrvhgvrhdrtghomhdpnhgspghrtghpthhtohepkedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhr
    tghpthhtohepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhrtghpthhtoheprhguuh
    hnlhgrphesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrgigsohgvsehkvghr
    nhgvlhdrughkpdhrtghpthhtohepkhhotghtlehisehgmhgrihhlrdgtohhmpdhrtghpth
    htoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dNawZ_IQGOQJlYDwAmB-B_lIHmRcQeoa1azClh6VlwhG-XJxRXp2qw>
    <xmx:ddawZ2Jn1HTg0ueeMWJdgu0kiSKzYL_3ioALjWtQL2_8HkhwBHwN7g>
    <xmx:ddawZwytkF5UDpm_3dXrLGBX_a8CYUvTh4HpZSHVwl9JDB7tzU_viQ>
    <xmx:ddawZ6IHwKC_SoZSVdhzxS_6bAU_t3hOSbaJC_bMfdvKEY7ddfvw3w>
    <xmx:ddawZ19xg2QzlcwnDChXiZaIluzb1YD0z7bL35MRmPM_ionYC0J-JjAu>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Feb 2025 13:01:23 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: David Reaver <me@davidreaver.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] docs: iostats: Rewrite intro, remove outdated formats
Date: Sat, 15 Feb 2025 10:01:13 -0800
Message-ID: <20250215180114.157948-1-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introduction discussed stat file formats for very old kernel versions,
which obscured key information that readers may find useful. Additionally,
the example file contents and the reference to "15 fields" did not account
for the flush fields added in b6866318657 ("block: add iostat counters for
flush requests") [1].

Rewrite the introduction to focus only on the current kernel's disk I/O stat
file formats. Also, clean up wording for conciseness.

Link: https://lore.kernel.org/lkml/157433282607.7928.5202409984272248322.stgit@buzz/T/ [1]

Signed-off-by: David Reaver <me@davidreaver.com>
---

Lore links to previous versions:
V1: https://lore.kernel.org/linux-doc/20250214013905.60526-1-me@davidreaver.com/
V2: https://lore.kernel.org/linux-doc/20250214051432.207630-1-me@davidreaver.com/

Changes:
V1 -> V2: Rewrite entire introduction instead of just changing 15 -> 17.
V2 -> V3: Reword counter reset paragraph for accuracy and clarity.

 Documentation/admin-guide/iostats.rst | 89 ++++++++++-----------------
 1 file changed, 33 insertions(+), 56 deletions(-)

diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
index 609a3201fd4e..9453196ade51 100644
--- a/Documentation/admin-guide/iostats.rst
+++ b/Documentation/admin-guide/iostats.rst
@@ -2,62 +2,39 @@
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
+All fields are cumulative, monotonic counters, except for field 9, which
+resets to zero as I/Os complete. The remaining fields reset at boot, on
+device reattachment or reinitialization, or when the underlying counter
+overflows. Applications reading these counters should detect and handle
+resets when comparing stat snapshots.
 
 Each set of stats only applies to the indicated device; if you want
 system-wide stats you'll have to find all the devices and sum them all up.

base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
