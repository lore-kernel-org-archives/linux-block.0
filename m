Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932F78635A;
	Fri, 14 Feb 2025 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739497164; cv=none; b=SgblEOxuXH9YOxSd5s4eNcWJxXwyuzj/KAfJhp+P4wtEBvn8oz5OUUrfN+ylYDEVdEgs4AW+tPx7bUcxY/V21JkYyry2OJOOJlduWpnf0hSTITqOy59E4/C59T4KsQ7cwr4hkQhvIoHJ/7Mj+ivr/ptR8ueN+ulLX3jvIMImSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739497164; c=relaxed/simple;
	bh=G5ketHuTT1aX5H0RGZyPsOQ32Z/Id/Hhu1g3lKP6FDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwEAB5IHUSEaBLpDhbrTOqMA5Rmb8OV1KD3Im+p5hZ/fhIFpsdmu3brWqBQh/KTZOOCbhZAlonkG1FnfLMDJmmgW4zzsvzCho5v0sZyhLGJsJX1T2ShUCpNfmVSnSCfPbkY9v8H0LXPnICgo1dG2obB1veKf+6/ifUDdEgEzdc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com; spf=pass smtp.mailfrom=davidreaver.com; dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b=YYA6X1sO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ayRA3Q+g; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidreaver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidreaver.com header.i=@davidreaver.com header.b="YYA6X1sO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ayRA3Q+g"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 560ED2540178;
	Thu, 13 Feb 2025 20:39:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 13 Feb 2025 20:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1739497160; x=1739583560; bh=QvAZiN2S36
	7ORY1BfihIdVfFr3Luz9f4x5gnPlo5pac=; b=YYA6X1sOT2e9tsO8WicDUiw3E7
	U3hLIJE9f5w/C+rM6ifgxytiLQnAkbtmvH9KzoLUuP6//gharMWt9NbKvsSohAKs
	HsJxKqNIwHLgSJtlBPLNXQ3slZp3itWpjQ2xvphT7bnmSF5LXHgxtEfs77818TCE
	q1I2bRH674W8JnccQHIDlK0YPDZjJk2CE7AKNgm0Z8YRO/aPkS8zwZz/FWy3b2lR
	1O5HURCzGIchm+XofA6OeiaLE+cOPL75AZjdkrv2Y8K3s2gy+x4gMURRwWqbXVS6
	jIBIRaN/SXR1J9uejFWapE6PyUg0NFAt+n8vX2K8bdhMfdN3699w5ZcKUGEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739497160; x=1739583560; bh=QvAZiN2S367ORY1BfihIdVfFr3Luz9f4x5g
	nPlo5pac=; b=ayRA3Q+grv2mhHjh5ptfbzt0YCq8niJT4abEmFNWWuk5nPsS/H6
	AZYUO1C9hhBYiyi1Z1Qw+DA4+tTEBQJrR16wa04nwRRyhv4P3WYEnVfVrV7VxKNC
	yAY9H31B4pJV2WHTTREUJ7VuUCCct8te15La90hfo6RsfbXQWcdU6kBrIlWT+dIK
	hC+zNcs6h168I+wmOGYTilKxqCqI/6RffPPoovRt5ZxwlgyazAPdSJ9w23hjmyi9
	a1TjMhBkUIgkqA2eCW7Vmir7w5ozUX6FlPS4nirUNEUfN6V6Q22JQb4UTjv3aduR
	cXUhxqgKuttNuTuAFZ0FZY6Oi6uxjbtB/Lg==
X-ME-Sender: <xms:x56uZ64R5WbDBsyO5KpH2U58Mtho4PiQikQ4ElNzDMqmo79CEBLf7A>
    <xme:x56uZz73yBWCgTP_QrAdUZ6XHGBuB6i2CEbHCm_TbCD3bY6XzVrM-9myobwr4ZBDm
    GifljaE4jBxl1QSY48>
X-ME-Received: <xmr:x56uZ5dRO31FtFbsexougmUKFBJ9W-ku8EzSkqDatJlgv5YmZbpr9u8EYAaMjm_QgzS5Ng6Tf0I7seNZi3JF3edU8_7jmIu2xWjP_VSJwjB-t85KGSOyGDvUhJl6Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegkeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrhdrtg
    homheqnecuggftrfgrthhtvghrnhepheetveetgfdvffehfeffieeugeejhfevieejveei
    vdeuiefgvdduueffhfefveehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesuggrvhhi
    ughrvggrvhgvrhdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepmhgvsegu
    rghvihgurhgvrghvvghrrdgtohhmpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrd
    gukhdprhgtphhtthhopehkohgtthelihesghhmrghilhdrtghomhdprhgtphhtthhopehl
    ihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqsghlohgtkhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x56uZ3LTpgs-uC6ChJolwUqMUUkvY-5cConWHJjzRS_374w6OK50ag>
    <xmx:x56uZ-I3XN174AtLQ-dBE6iMWcQrK_svhO9M7AYe7VSI7cEju9fTGg>
    <xmx:x56uZ4xztxuRUTmZ7fWsYkkoEij6DYzHhhAxxU955q-Z68DGuOUx7A>
    <xmx:x56uZyKMmf42vlGZcVIJxX80njPzg52UwNQTNMq7UBKceK9kzMrlcA>
    <xmx:yJ6uZ_rMdlQcfK6QqdDrMCS_aqfVCCq5WySvPe5mJNzDIM4MlxOCrFSr>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 20:39:18 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: David Reaver <me@davidreaver.com>,
	Jens Axboe <axboe@kernel.dk>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: iostats: Update introduction with flush fields
Date: Thu, 13 Feb 2025 17:39:04 -0800
Message-ID: <20250214013905.60526-1-me@davidreaver.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Counters for flush requests were added to the kernel in
b6866318657 ("block: add iostat counters for flush requests") [1]. While
iostats.rst was updated with descriptions for the new fields, the
introduction still mentions 15 fields instead of 17.

Correct the introduction to state that there are 17 fields instead of 15.
Also, replace the 2.4 vs. 2.6+ comparison with a distinction between
/proc/diskstats and the sysfs stat file.

Link: https://lore.kernel.org/lkml/157433282607.7928.5202409984272248322.stgit@buzz/T/ [1]

Signed-off-by: David Reaver <me@davidreaver.com>
---

I noticed this small discrepancy while writing an observability tool
that uses /proc/diskstats. I did a double take because I noticed the
extra fields in my own system's /proc/diskstats while I was reading this
doc, but _before_ I got to the descriptions for fields 16 and 17.

I think the discussion of historical formats for 2.4, 2.6, and 4.18 in
this document is confusing and not very useful. If you'd like, I'm happy
to make a patch that rewrites the intro to simplify it and remove
discussion of the historical formats.

 Documentation/admin-guide/iostats.rst | 33 +++++++++++++++------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/iostats.rst b/Documentation/admin-guide/iostats.rst
index 609a3201fd4e..1df7961bdc89 100644
--- a/Documentation/admin-guide/iostats.rst
+++ b/Documentation/admin-guide/iostats.rst
@@ -34,6 +34,9 @@ Here are examples of these different formats::
    4.18+ diskstats:
       3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160 0 0 0 0
 
+   5.5+ diskstats:
+      3    0   hda 446216 784926 9550688 4382310 424847 312726 5922052 19310380 0 3376340 23705160 0 0 0 0 0 0
+
 On 2.4 you might execute ``grep 'hda ' /proc/partitions``. On 2.6+, you have
 a choice of ``cat /sys/block/hda/stat`` or ``grep 'hda ' /proc/diskstats``.
 
@@ -43,21 +46,21 @@ be a better choice if you are watching a large number of disks because
 you'll avoid the overhead of 50, 100, or 500 or more opens/closes with
 each snapshot of your disk statistics.
 
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
+In ``/proc/diskstats``, the statistics fields are those after the device
+name. In the above example, the first field of statistics would
+be 446216. By contrast, in ``/sys/block/hda/stat`` you'll find just the
+17 fields, beginning with 446216. If you look at ``/proc/diskstats``,
+the 17 fields will be preceded by the major and minor device numbers,
+and device name. Each of these formats provides 17 fields of statistics,
+each meaning exactly the same things. All fields except field 9 are
+cumulative since boot. Field 9 should go to zero as I/Os complete; all
+others only increase (unless they overflow and wrap). Wrapping might
+eventually occur on a very busy or long-lived system; so applications
+should be prepared to deal with it. Regarding wrapping, the types of the
+fields are either unsigned int (32 bit) or unsigned long (32-bit or
+64-bit, depending on your machine) as noted per-field below. Unless your
+observations are very spread in time, these fields should not wrap twice
+before you notice it.
 
 Each set of stats only applies to the indicated device; if you want
 system-wide stats you'll have to find all the devices and sum them all up.

base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
