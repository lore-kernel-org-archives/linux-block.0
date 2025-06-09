Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9C70830
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485783; cv=none; b=ehFQbbrHtcI9To03H+x6yrrS0bNlmNi0OorcmfcC8UfsuP3zo32lHqjevaY5uGH2u+bdKMAL+RFYJusclqz45jc6lwOxQDfzqVDuLfOh4ey4V0Erpw5I68bIEWDpITDsCar3T9vgycbo3u/IGlBkwdnCS1AuaMXJfmifasFP8DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485783; c=relaxed/simple;
	bh=5lS7oMNFf9d65+AqCkm2BuOl4CHrcCtx0dWgMsP0gj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TA+oawiU7zh7Ijc2rf2b/VS042KCZKHAQsGCz8nLEUus9tB2PZYTGeSuz8KO07g7Qc/B6BUDOrNSUtsa4ps6uRFVCvZifBMSWceKzowcEcRmiYaO88yaCXFUe940n8KrgfHIGOL7ZZLRdIvL5aQ563jHwqEi5a611FvLxT9RDW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so6099409a12.3
        for <linux-block@vger.kernel.org>; Mon, 09 Jun 2025 09:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749485780; x=1750090580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thFh6Ia0PsT+Kq2zHBJM813Mt7IhgQv9Q3wFoz6qDrM=;
        b=KEmXTTWme0UgaVDFfAVr49YwS2dGyy6N906FBcKPxEjraZpFvxuV6IY/tD/OY15wWa
         iZM3i4gy1q+Y5/rMj2jYB2+qQScUbewzPLsczNERdaVKYXsCD4Fl1nkEw8ntyXpVPF8d
         N0SMV4bsyLvmOP1EuwRzDIbEv/nuU+jG2lVns8wP1OzRB89X6pFY4nBgAqDTKCy4ZEby
         pqtfkTGJ/0NZiyVC/0rZcHc2M8be85up50p/Vguvp2gY41+gAgalngquGk2dlz6y60Pq
         JLixChWQXfgYS5EyOWITaw9BwscANwj4yGh5isZkoLJjhaZkT4298+uY9yKWF2kF/IYi
         VhHw==
X-Forwarded-Encrypted: i=1; AJvYcCUSEkUPgJG9nNubRNeQcn2cdmQBFWUuksgSQkw99DUd+lWfkaG/UStnbDFGgr28jDy1+FROKkuGkY4etw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwgzXP9dCJtd9J1Wk5LsVSuY7Tl5EgK9C8VmlL4zGtCneKcZC
	Adm0Q7NxDjjwXoVaLkvW1aUqHEivtVGbhtc6B05WUOEjmHiltnbXoDym
X-Gm-Gg: ASbGncsbWg564C+sI057Hr7MIAgmYAaGugmsJCJETkxVyLRlDsfnsY77pg7lETmJwdI
	VuOshKEhr0o4HA6zEwb/JYTjJSHmGj7s1Ouk2JbAFmjpidZ03yQmME7B7jF/HcC7Hp4TpBgTmYP
	xxwwPIJ6fHlW03BSydZgoZ5tcYVN3Ynynu1/ittq9+n65FaDyokPf5Igw6+nBd5m4/+fH0cHcAp
	sQu+wijaNEWrpWdIknz3qPwNfyeist28fOOINZW38TYoy1CEx5DIeNcqeNXCCY4spRzTafUF7u9
	QkaI1VT3v6V+noWuAd3GCdDjLHJFLdyz57EttuJhQJi7Vs6CpXoALQ==
X-Google-Smtp-Source: AGHT+IEJrrVL+bvR3Y34262/z3ACr9105EMVi0sh16Wa1iO72vEb3q/YevFzJosrrP4BCJo9/6DIOA==
X-Received: by 2002:a17:906:ef03:b0:ade:3a7a:26cb with SMTP id a640c23a62f3a-ade3a7a539emr998204266b.58.1749485779989;
        Mon, 09 Jun 2025 09:16:19 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade399c1887sm444538466b.93.2025.06.09.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 09:16:19 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:16:17 -0700
From: Breno Leitao <leitao@debian.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
Message-ID: <aEcI0ck4tqkHkXkb@gmail.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <aEal7hIpLpQSMn8+@gmail.com>
 <28f59f4a-7ac6-4c27-ab68-b6621260c760@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28f59f4a-7ac6-4c27-ab68-b6621260c760@kernel.dk>

Hello Jens,

On Mon, Jun 09, 2025 at 08:22:35AM -0600, Jens Axboe wrote:
> On 6/9/25 3:14 AM, Breno Leitao wrote:
> > On Fri, Jun 06, 2025 at 11:31:06AM +0800, Yi Zhang wrote:
> >> Hello
> >>
> >> The following WARNING was triggered by blktests nvme/fc nvme/012,
> >> please help check and let me know if you need any info/test, thanks.
> >>
> >> commit: linux-block: 38f4878b9463 (HEAD, origin/for-next) Merge branch
> >> 'block-6.16' into for-next
> > 
> > I am seeing a similar issue on Linus' recent tree as e271ed52b344
> > ("Merge tag 'pm-6.16-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm").
> > CCing Jens.
> > 
> > This is my stack, in case it is useful.
> 
> What does your storage setup look like? Likely not a new issue, only
> change is that we now report/warn if these counters ever hit < 0. Adding
> Yu to the CC as he recently worked in this area, and added the patch
> that triggers the warning now.

Basically a host with a bunch of nvme:

	# lsblk
	NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
	nvme1n1     259:0    0 238.5G  0 disk
	├─nvme1n1p1 259:2    0   243M  0 part /boot/efi
	├─nvme1n1p2 259:3    0   488M  0 part /boot
	├─nvme1n1p3 259:4    0   1.9G  0 part [SWAP]
	└─nvme1n1p4 259:5    0 235.8G  0 part /
	nvme0n1     259:1    0   1.6T  0 disk
	├─nvme0n1p1 259:6    0 838.4G  0 part
	└─nvme0n1p2 259:7    0 838.4G  0 part

	# dmesg | grep nvme
	[  435.301782] nvme nvme0: pci function 0000:b4:00.0
	[  435.412268] nvme nvme1: pci function 0000:64:00.0
	[  435.459601] nvme nvme0: D3 entry latency set to 8 seconds
	[  435.848628] nvme nvme1: 32/0/0 default/read/poll queues
	[  435.944582] nvme nvme0: 52/0/0 default/read/poll queues
	[  436.135123]  nvme1n1: p1 p2 p3 p4
	[  436.316921]  nvme0n1: p1 p2
	[  500.912739] BTRFS: device label / devid 1 transid 2052 /dev/nvme1n1p4 (259:5) scanned by mount (837)
	[  501.583187] BTRFS info (device nvme1n1p4): first mount of filesystem 0568aa14-1bee-4c76-b409-662d748eefad
	[  501.602891] BTRFS info (device nvme1n1p4): using crc32c (crc32c-x86) checksum algorithm
	[  501.618986] BTRFS info (device nvme1n1p4): using free-space-tree
	[  562.737848] systemd[1]: Expecting device dev-nvme0n1p3.device - /dev/nvme0n1p3...
	[  567.865384] BTRFS info (device nvme1n1p4 state M): force zstd compression, level 3
	[  603.745650] EXT4-fs (nvme1n1p2): mounted filesystem 57120c82-6f1a-4e1f-a8c3-6aa17bffb1f2 r/w with ordered data mode. Quota mode: none.
	[  604.103672] FAT-fs (nvme1n1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
	[  658.986835]        nvme_alloc_ns+0x204/0x2ee0
	[  658.986842]        nvme_scan_ns+0x53f/0x8b0
	[  660.888749] nvme nvme0: using unchecked data buffer
	[  859.589752] Adding 2000892k swap on /dev/nvme1n1p3.  Priority:5 extents:1 across:2000892k SS
	[ 1698.294280] block nvme1n1: No UUID available providing old NGUID
	[ 1698.356183] block nvme1n1: the capability attribute has been deprecated.
	[ 1807.416851] Adding 2000892k swap on /dev/nvme1n1p3.  Priority:5 extents:1 across:2000892k SS

This was happening while a HTTP server was being executed.

Does it answer your question?

Thanks for the reply,
--breno
