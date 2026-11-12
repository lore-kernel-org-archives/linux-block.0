Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499668;
	b=dEX/O85+hr5bSzjDPbycBmq5lsUEVRzq1kKyGzsS6t7U897QuEnc9W89JIgqn3n/OqJm
	 J9crPtD6qaerbEL1XzQsQC7uTxLGwowd88xcPW3UeNFzzSCnldeVnmElwI1QS1ozJPw52
	 Ov9YFsF+pAsX7TK64YDFl4YU2YG9IRWyg5ET8yF+i3xz4JtPEu0yvOpGZnO31hKloiFqZ
	 hwCBUVWuHCTfwL0r+0R1+fug5hW448tb2hR7biD4Neu7PNTno6cnHzep7LeCPh7wtFGv3
	 Re5YGMQIRgbhdganfZZ7+/yUCD68mudLbrmyeMmbdDeZV1viCtjeDIuk91plHsGS64A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499668;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=GxEAh1VPtSYJm7RgQ8GwuBf7Xw9of2C5ciQVntp50E0=;
	b=fTI+TwfdGM2X+A3Tlggc6PSJIFRzKSC2Ohetj/EWgdwQnCA+psAYVRV+q3q3EfjBkukO
	 eKboB5CRjb7Oh3xs6wOu5o/+/QpgZr4jdRkWlXLjbfv+2OH7y3WjwUaTAjWKspWNqiw97
	 /t39GQyMaqNdZUO3de6B/w0t6qQe1EKpW1ngaSoC6WfC45cfosJzZidx26Xrk4MvhC+6P
	 7tpFotso3JJJ3gUqHdnrHeNhPvaI21QR2nidon9csDS/blmhWETXcPMUXVmSrbzrUFMQo
	 2iOk+0NNpM9FVFsusqoDa/9WDKX5bO0IUteGPcl2GVPWX83Xp6I5sl6vn4DqV0+y6mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=TP3FNqnB;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDF606A32E;
	Thu, 12 Nov 2026 16:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72BDF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=TP3FNqnB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794499661; bh=GxEAh1VPtSYJm7RgQ8GwuBf7Xw9of2C5ciQVntp50E0=;
	h=From:To:Cc:Subject:Date;
	b=TP3FNqnBPbHOWz6OGI0NiaRMQCeo8Ph+Womix3t9hLHDIwvKypNaMF8wOzRB+R4Yc
	 AkxGfcNWoGPgRRXEYqU+dUveBZx+TgYVzYwNaOYFCKGfCDcWPwh0QFqoyL/CVz2Z0w
	 x0VPno+JaHufd/cTm85g4OBdDDxjiVyabaW6GGUg=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 1E7B98F9; Fri, 13 Nov 2026 00:07:39 +0800
X-QQ-mid: xmsmtpt1794499659tr0eenu2o
Message-ID: <tencent_444214B18F57945FAADD37F108ABD3A22906@qq.com>
X-QQ-XMAILINFO: NYXSVuwhoxRbJ+PBQO6iO+2Qb3cYRBc/B4kjx1OTwvBa+gMuvI8lRkK7cayto/
	 Pm/QnoaHNXbgzcfiBXM32OuKDKXE5U9V6yW63MaOHcsGBBZJcxhcROf14ynK+txvuJhRmnL09SkE
	 IqW+Tj0iI7fr295urfw7Vav3QIhLjngZc0gZtkwcHK2Li5ugIxboNlP+5hCvuMG538C+STTAGLS4
	 1eOpXUAMXPkFc6Fu/jhOVsQ8XYTxVYaVARiOaHlhn7EDZD0n64MKixv2k3+snLBFyEsX0yszv5gZ
	 4w5BGNZoWzv3natZdmGNuxus3H58Kuh/qPQsBSlF2ayvBaz5TVJkorAMaHvutpnMT/UM/iVUuIxC
	 1NcHCrjHus5k1KWAaGcHLZrAZYQJQ2VS0hENiDoasgN1y0POfMHOzF7yQVXaXvTt3l/eS0Pnmqaq
	 Xue9gRom4QAuC9rQgRxHIqD3edKN1pk+Yn2mCHA7l+dEX60fo0mbJY97HaiYS12lPZZTXJlok1lm
	 OwVTPotYyWUdZefAeP4NdC3qSbDEzk2eywz2Hg38X96fc3G3V60ShNAD1D3cTBuPSgFgidNJYc8Y
	 G0C/G8MzTTMxuzfIqCo3bq/Zw612JNlJYJZY1ndfaYEYe27OkcANyCozPOhtpfDukU2DXK8r1bGb
	 xV/z0CA/HDvjseEP/tLWj+25t3B38gsBwYc+BtP4/fl4bfK0K02psKImcrGTWQf9phCwu0QhBUjE
	 E7plNn7XbEZKHnzh3QxM+tMnn/EnF+auKXQkdUoorow3IzF1ufl2q/AOwYkAvd7v+hGdMXCLkPgB
	 YQPPjmhAjbhm4B2LIIKJsAXRjLb+27ITd4gfDWOisw5z716+TEIkNKcUVYxny6KpyhsY9uueJCht
	 jcv9ZgzQtkWNrxC5mt4TrZummofFxxJ6OxhP6NPNwOvP14kl4cb76E8m+b0iP6tInMb7mx+L4aNl
	 zbS+6BQDNZRjEMWQ50+vhFVQfPCHE/HV6lsJhbJ6JXvjTZDJ5b9aBGaWLZLWUPwBit+AGx0pRZmy
	 WlM6XJA7K2rQJ1SkmLjqXyNut/VvQ=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Guikun Yang <yangguikun19@qq.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Bug report] partitions/aix: unbounded lvname string read panics the
 boot partition scan (regression in v7.1)
X-OQ-MSGID: <aix-lvname-oob-20261112@qq.com>
Date: Thu, 12 Nov 2026 20:00:00 +0800
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Jens,

Booting a kernel with CONFIG_AIX_PARTITION=y on a disk whose AIX LVM
logical volume name area contains no NUL byte panics during the
automatic partition scan. The name is read from disk into a
kmalloc(16384) buffer and then handed to seq_buf_printf() as a C
string, so vsnprintf() walks past the end of the allocation:

  BUG: KASAN: use-after-free in string+0x4a9/0x4f0
  Read of size 1 at addr ffff888004ab4000 by task swapper/0/1
   string
   vsnprintf
   seq_buf_printf
   aix_partition+0xd42
   msdos_partition
   bdev_disk_changed
   disk_scan_partitions
   virtblk_probe
  unable to handle page fault for address: ffff888004ab4000
  Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
  Kernel panic - not syncing: Fatal exception

## How the bound was lost

The lack of NUL termination in on-disk lvname strings is a known
property. d43fdae7ba ("partitions/aix: append null character to print
data from disk", 2018) says so explicitly and bounded the pr_warn()
consumer with a local buffer:

  char tmp[sizeof(n[i].name) + 1]; // null char
  snprintf(tmp, sizeof(tmp), "%s", n[i].name);

At that time the other consumer was equally bounded:

  char tmp[70];
  snprintf(tmp, sizeof(tmp), " <%s>\n", n[lv_ix].name);
  strlcat(state->pp_buf, tmp, PAGE_SIZE);

c2d466b9fe ("block: partitions: Replace pp_buf with struct seq_buf")
removed that pair in favour of a direct call, as part of eliminating
local tmp buffers:

-				char tmp[70];
-				snprintf(tmp, sizeof(tmp), " <%s>\n",
-					 n[lv_ix].name);
-				strlcat(state->pp_buf, tmp, PAGE_SIZE);
+				seq_buf_printf(&state->pp_buf, " <%s>\n",
+					       n[lv_ix].name);

seq_buf_printf() bounds the destination, but the source is now the raw
on-disk string with no length limit, so the read is unbounded. The
pr_warn() path kept its 2018 buffer and is still safe; only this
consumer regressed.

alloc_lvn() fills the whole allocation from disk with no terminator
handling (block/partitions/aix.c):

  size_t count = sizeof(struct lvname) * LVM_MAXLVS;   /* 64 * 256 */
  p = kmalloc(count, GFP_KERNEL);
  read_lba(state, lba, (u8 *)p, count);

struct lvname is just char name[64], and lv_ix is bounded by
state->limit (DISK_MAX_PARTS = 256, equal to LVM_MAXLVS), so the array
index itself is in range - it is the string read that runs off the end
of the 16 KiB object.

## Affected versions

Checked by fetching block/partitions/aix.c at each tag:

  v7.0      char tmp[70] + snprintf   bounded
  v7.1      seq_buf_printf            unbounded
  v7.2      seq_buf_printf            unbounded
  v7.3      seq_buf_printf            unbounded
  v7.4-rc2  seq_buf_printf            unbounded

So this is a regression introduced in v7.1 and still present in
mainline.

## Reproduction

The trigger is the boot-time partition scan; no userspace action, no
race, no special mount options. CONFIG_AIX_PARTITION=y is already
enabled in distribution kernels.

An image whose lvname area is filled with non-NUL bytes panics 3/3.
The negative control differs only in having a NUL-terminated short
name: the same code path parses it normally and prints
"vda1 <lv000000>" with no KASAN report.

## Suggested fix

Restore the read bound. Either give the conversion a precision:

-	seq_buf_printf(&state->pp_buf, " <%s>\n", n[lv_ix].name);
+	seq_buf_printf(&state->pp_buf, " <%.*s>\n",
+		       (int)sizeof(n[lv_ix].name), n[lv_ix].name);

or terminate every name once, right after the read in alloc_lvn(),
which also covers any future consumer:

  if (read_lba(state, lba, (u8 *)p, count) < count) {
          kfree(p);
          return NULL;
  }
+ for (i = 0; i < LVM_MAXLVS; i++)
+         p[i].name[sizeof(p[i].name) - 1] = '\0';
  return p;

I prefer the second: the 2018 fix bounded one consumer at a time, and
this regression happened because the other one lost its buffer.
Terminating at the source removes that class of mistake.

Reproducer (image builder for both the positive and negative case,
serial logs) available on request. Happy to send this as a patch if
you prefer.

Fixes: c2d466b9fe ("block: partitions: Replace pp_buf with struct seq_buf")

Thanks,
Guikun Yang

