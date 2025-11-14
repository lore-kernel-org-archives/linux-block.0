Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136B35CBB4
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128942; cv=none; b=XZwiTTx0eT7Kaih277P72VwP4L8TZvddoBSAUuWewmQmBjD0f2bjSLPcrihplZOOg9+Zs4FG2BbPShFxof01VWD4ltgJCQFODgMGAoomm1AEUuWPX0OgsTxp/Ywd0Q+TkFFsh3DCjMnni1Uuw0t9KkQgTj1mE+qIsUHBcrlsM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128942; c=relaxed/simple;
	bh=Vs+Jv/xCDzpFes86+bq61UsFzFr5W7S/PNqGuHcum+I=;
	h=Date:Message-Id:Cc:To:Subject:From:Mime-Version:Content-Type; b=msqHtCQkDSBRJdHS2d3nQzBnuYC6GvklenpnJ5CtWPhDmzLAGWU6/VKtjYSmlhWF2YBQyMc8es71WdY2epaBekMjFIRxNeQjRyoTQSEMBEncy8b8TwF+CNgqbyZL5RU3nIxEk78UwnXfzsjVREQNGqBpbxjLD3kswWcajoLzic8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=nzt3cS9B; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="nzt3cS9B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:To:Cc
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=SRdqxqWnYgXUJz0c36Sp8+pZfAxVoZT4gyoZLWtoQGs=; b=n
	zt3cS9BZgxfBTt7nZpSlw1vs/tcncU89KBT4Kr/E7zyOxofPkgsRSryT0T86QF96jBnZMR05KCVeu
	zbOovm3Ii4NSbu2hcGqD7veuPhUc6uzwcii61ZyGw4bqhcIzMYo42QiAGrvvzXbI33eNQWsR5H3CN
	5oUI7Yz3YCbUvhFzKHzPvtV+dKhUKXejXd+RnavL07zM7naiZOpD0YBSPNFt9JyOkrHWNHn0cWUvm
	GczCt0ymxJ2YH1lx2LwGT2uqmyi2KifRGW2tSnbZek/8OVgPdTwKl1UgGT+vSrwUh7LbED1ryP1QB
	4edE5fku5K1b6RclMgIJ2aXHSWHlDvXlQ==;
Date: Fri, 14 Nov 2025 14:41:27 +0100 (CET)
Message-Id: <20251114.144127.170518024415947073.rene@exactco.de>
Cc: Denis Efremov <efremov@linux.com>
To: linux-block@vger.kernel.org
Subject: [PATCH] fix floppy for PAGE_SIZE != 4KB
From: Rene Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

For years I wondered why the floppy driver does not just work on
sparc64, e.g:

root@SUNW_375_0066:# disktype /dev/fd0
--- /dev/fd0
disktype: Can't open /dev/fd0: No such device or address

[  525.341906] disktype: attempt to access beyond end of device
               fd0: rw=3D0, sector=3D0, nr_sectors =3D 16 limit=3D8
[  525.341991] floppy: error 10 while reading block 0

Turns out floppy.c __floppy_read_block_0 tries to read one page for
the first test read to determine the disk size and thus fails if that
is greater than 4k. Adjust minimum MAX_DISK_SIZE to PAGE_SIZE to fix
floppy on sparc64 and likely all other PAGE_SIZE !=3D 4KB configs.

Signed-off-by: Ren=E9 Rebe <rene@exactco.de>

--- linux-6.16/drivers/block/floppy.c.vanilla	2025-09-07 11:16:02.42089=
5667 +0200
+++ linux-6.16/drivers/block/floppy.c	2025-09-07 11:17:17.538595643 +02=
00
@@ -331,7 +331,7 @@
  * This default is used whenever the current disk size is unknown.
  * [Now it is rather a minimum]
  */
-#define MAX_DISK_SIZE 4		/* 3984 */
+#define MAX_DISK_SIZE (PAGE_SIZE / 1024)
 =

 /*
  * globals used by 'result()'

-- =

  Ren=E9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
  https://exactcode.com | https://t2sde.org | https://rene.rebe.de
