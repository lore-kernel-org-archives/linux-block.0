Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07F17A90F;
	Tue, 14 Jan 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867730; cv=none; b=cfEf4ynEgK5bME1nuYe91ONLzoGo/gpSN+b7cggKfKKJFGgUgUFZpeI4Ky3/oJS9XhQUL1pKbd9Tu+CBs4SkCRbE7oP0uuVvVOLNNrjwyoMf13ip8xNkUwQX/p3IC5pD9ruL0K3RIhjq2gSprO6hh45GU87aTyvLwveddRqDl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867730; c=relaxed/simple;
	bh=PnJTQh+Tn8yC3I5toflX+Z6xisXx8PzEO4PPI5l6A54=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RoOg/gZukQtHm/PkOTuCFtZ2a8H2xICqGoFYbfPrcat/7GItj5hiY2gKf7+uPZXSLnDuC0P1xCUFis9gF8t8HDnlhahPd5sJRvfWUVAKfnj/NIkTwMe+sPxhZzTCqTWvrl8GTQYe1AolT+HZGb5nG0A2MilKfoneeFeKgGzFoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=XjZjl+GO; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XjZjl+GO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736867723; bh=QlONSP1b4Vvd4zi4WAv9b3Z9ZK/YyIymb8jB7CXzOpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XjZjl+GO7m2kSgqJDClNfXSF41Nr8imGEyL5qhYnZtA+BX/ZxO+3oJMDT6SuzPpgS
	 PYpwemFwAwaAU8+ypr2zFjZqbpCNGVJiGDX2tUFHMZsyFuG5zhxlOJJEJUqXsNnuge
	 ppv+GsIS3SU1gTPyzUuKIORKzFRwlAfPDbfyd24I=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 3D42F449; Tue, 14 Jan 2025 23:15:20 +0800
X-QQ-mid: xmsmtpt1736867720tzmmivf8j
Message-ID: <tencent_A26C4964E3A9444A17685771A6D2F367A305@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NocU4h9huvo05w2942a2MtYZz0ZB5IQjUZWI68BaDwoTMJWZhUGK
	 ojoRZ+imMi7/p+aVDY0N0aWWYJ4OJMXmFzBslqaRAJgIpL2Fz1pd4djA10cHJmsJzQwc9N/3ISTG
	 XTEMJidBix+E4k9CC6Da+Y2kHrpt8kPYz+HKxp39Oq9vrENMBguHLKkSpxWySLs67HZjRN4W3qGX
	 c0xQwz8XWlYasxAYe8KDIB7mYw7QjD2zNNnCHhxMRa2Cs6GHzW/zpYkBbqhmCeIStcRVazx41YF9
	 QFpaEhAhZiRc7WBaghtW3oo/yF8o4ScRncEge4TCsFfJu/0loYtuB8oUDr3xDkQEGKisfrrbSUhJ
	 mglxMx/gTYSksRVlZe4CzJBitFys9pGxj6OHjlY8xZZUK9GtO5XpGJYdOzUFnUMFdl7fCmLjzWy7
	 sDNLY5Gv/glLl/VQkNMRGsQmCLpG2sxeSsRdVrHfD6pWcrxTAlgioU0DN0aSBwzJ5xhPtidA6JH1
	 LV8t3KXqNEICyV4b3ZgzxLKEx5LPABYHB1S986937fQ8yrZSeFCkJ8YWStxaFNxkYBKMnr07ZXp4
	 QcOKFVj5my7M6JSZqzaOFv5Af+ycYSMx37dCtsfszKvWR38+M0dQnwSB9vcefyGXMuHPwIyCn3gp
	 UcXtJJ/XXLy6b4KrlUBQ1Jrc357oOgxEfSuaA7UIkrpTw4naRR7CC0zmSqn3GLomnHcIg1QI7hr0
	 6JdaNzirAZkHc86O8H1mJWlhsb6egv8icSBCHkDbdLIjNq/obwroCaJK+xwogLmdsPGw97+nPs3o
	 rXQ3jp5EgN7z7en8H+PqC2eexMP9XdYZC8ePgYrHePOVJUR3+3uRhgU58GeE7PTsVxcQIVBA9J1/
	 /2Y/BSwiwcgTU+DPhu4g3gYzrJUT59LtTdDSSqYTnhQnF/b+ZqJ5EfA9ROP6ODlLmFxep27tVnZ0
	 KTWRjrGXNhd18HiH/gug4PoPahUkFBIaF0VjMdC5xZ+tzFZndMdZjZNif/wxp3
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: axboe@kernel.dk
Cc: eadavis@qq.com,
	hare@suse.de,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fcee6b76cf2e261c51a4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] block: no show partitions if partno corrupted
Date: Tue, 14 Jan 2025 23:15:21 +0800
X-OQ-MSGID: <20250114151520.2958158-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <813564af-a67a-4feb-ab32-1ca3bb41edfb@kernel.dk>
References: <813564af-a67a-4feb-ab32-1ca3bb41edfb@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 14 Jan 2025 08:02:15 -0700, Jens Axboe wrote:
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 9130e163e191..3a9c36ad6bbd 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -890,6 +890,9 @@ static int show_partition(struct seq_file *seqf, void *v)
> >
> >  	rcu_read_lock();
> >  	xa_for_each(&sgp->part_tbl, idx, part) {
> > +		int partno = bdev_partno(part);
> > +
> > +		WARN_ON_ONCE(partno >= DISK_MAX_PARTS);
> >  		if (!bdev_nr_sectors(part))
> >  			continue;
> >  		seq_printf(seqf, "%4d  %7d %10llu %pg\n",
> 
> Surely you still want to continue for that condition?
No.
But like following, ok?
diff --git a/block/genhd.c b/block/genhd.c
index 9130e163e191..142b13620f0c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -890,7 +890,10 @@ static int show_partition(struct seq_file *seqf, void *v)
 
        rcu_read_lock();
        xa_for_each(&sgp->part_tbl, idx, part) {
-               if (!bdev_nr_sectors(part))
+               int partno = bdev_partno(part);
+
+               WARN_ON_ONCE(partno >= DISK_MAX_PARTS);
+               if (!bdev_nr_sectors(part) || partno >= DISK_MAX_PARTS)
                        continue;
                seq_printf(seqf, "%4d  %7d %10llu %pg\n",
                           MAJOR(part->bd_dev), MINOR(part->bd_dev),

