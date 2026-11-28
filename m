Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795856135;
	b=R/26lAsivymRCMpD5FZBwF9o6/J+RRrDvxqApTKECBy6Arlo1VyuxahhGgzUsu1rphbZ
	 QNln27hBxovwafFYDfVFte2dGyuNZlSakoxNgoH2ieh/0v61nehJboJDmKVIS/5peS+89
	 CkV7tDweEjCpFtKZxV896mECYjdtYbkmWaO01sJH+oQ/o1zbIL5qdixvGMyMsgKD+mCI7
	 CpV9v9h9VOY4G43z4OzaQ4ZUMqjT3cpzWZ4ZfEuBuky4/1i8u7WjT+Hzs+MYArAz3TYKV
	 ZbxShIHkiN29wOI9ZnfbMyAedgUwYHj1NOstfc5t3DeM7l6wOM25VdD3vHlGeM1UROg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795856135;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=65UtGJ7fSwzMVurIhv/cFm1+CfEydmPsrjASwnr1vJ8=;
	b=LfbrKa0wWOYEvuSoBi7o7xtnsLX7zihw3IMF0ZCq87rF4CG8VJ24BABAwzwX3fa6Bg5P
	 pCb/stwQoOUNsKseAkK211awO3iqjiojHQv9i82esWw7JHso5RXNkUi9Y4IltmmtstwXa
	 Bqy5z6+12gcXQZq7pO3KimbWgioQOj2CzO9o9xBEkbgEa3SI49R0Cua8ODNr+yGQzK9WX
	 5OVg8oYDdyhepn2oeNVRN7X9xaGED2htiGGVlE3BySWNutCnW1xczxiUEd+VgUd53drjI
	 Aop+pavtlWswuxI1eZ21WDn4IH6jRP3V/qaO0AiwwTAJiuEtrnZFSEU7EJpsAJ+isPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=mkoxgApY;
	arc=none smtp.remote-ip=198.54.127.90
Received: from out-zbxj-a90.jellyfish.systems (out-zbxj-a90.jellyfish.systems [198.54.127.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4083D606A327
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 08:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4083D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=mkoxgApY
Received: from fedora (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jc3yZ1Yt4z8sWP;
	Sat, 28 Nov 2026 08:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1795856122;
	bh=65UtGJ7fSwzMVurIhv/cFm1+CfEydmPsrjASwnr1vJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkoxgApYS+ZL4enwNdAbQMK6dYarH0tdwlh2dGq+pccuYgjo1YPaHiyymVV3+Ikuo
	 8s8leiu5BJ0wXTNjUR3vwdKu4j/tVjRqoKh1Nvvg+5hO27J/rdyBuNlDN1Q53ZhD/r
	 qEtkGtYYQ0iRC+1db2+X+Pe0lTM7SHf53x9rI2mDIZaSk/i6X7RD1sKXzBOScEklJU
	 i0nm3mK7g4Ij1YNAbWyhBw+S5S3K7e5ULs4+O5NFsN5vTXyL04ljfOU5f2WunUUzSz
	 E0LdyDzLilk3IEP7LoD2GSmTrt8ZUIIz8VG5NqGmluZMOzYVUY1uYJMu3uEGQGC2ne
	 3kwefu17eNm3A==
From: Tianyi Chen <hi@tychen.cc>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Chris Mason <mason@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Ming Lei <tom.leiming@gmail.com>,
	Yu Kuai <yukuai@fygo.io>,
	Mark Korenberg <socketpair@gmail.com>,
	linux-btrfs@vger.kernel.org,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	hi@tychen.cc
Subject: Re: btrfs, blk-throttle: cross-subvolume fsync stalls behind throttled write_dev_flush()
Date: Sat, 28 Nov 2026 17:55:08 +0900
Message-ID: <20261128085508.2227850-1-hi@tychen.cc>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <a0ae6351-2eb1-41b9-b085-db924442c685@gmx.com>
References: <20261127121458.2090454-1-hi@tychen.cc> <a0ae6351-2eb1-41b9-b085-db924442c685@gmx.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

On 2026/11/28 07:37, Qu Wenruo wrote:
> What's the point here? The series (older or merged version) has never
> touched the barrier part, nor my comment.
>
> This looks like some unrelated LLM word salad.
>
> And again, make LLM generated reports shorter for human readers.

Sorry, you're right. Neither the series nor your comment is about the
flush, and that paragraph should not have been in the report.

[...]

> I'd prefer more advice from block layer on such separate flush and sb
> writes.
> Is it recommended to use the same flags for such cases?

One result that matters for this question: with the super block flags
on the flush, a cgroup can escape io.max. One process under wiops=32
doing create + 64-byte write + fsync in a loop (the files stay inline)
ran at 2542 io.stat wios/s over 60s, 79x the cap; under wbps=512KiB/s
it ran at 55x in io.stat wbytes. Stock stays within the cap (0.94x and
1.00x). One run per kernel. The flush flags are the only difference
between the two kernels, so on this path the untagged flush is what
keeps the group at its cap. This is the unpaced fsync loop my first
mail listed as not tested.

Thanks,
Tianyi
