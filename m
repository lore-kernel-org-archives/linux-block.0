Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.71.154.88
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698737;
	b=oFlU9THG45hyzW2ShDPCEevUfefTS+ev6Qp9iQVMgjVUJqrlCHR/S7i0ciQZFBiIiu1u
	 QLF1nO3kijPB8/evnloVxq7RxGbGJxukdC8Zz4kzaEMzyEpea5uauJZNDYR3fmIhfO6kA
	 9RW1c/Jr/t0xT4jioh3vhwpGk+uMTFIU8xCN/O/jcuh1cuPgM2VTnEpGHHkEXV8o3Ob8M
	 NMbFS2UckVhjTsAVxaRue9HQu+32ZPAlkCqh7kyuKyOALefzws9szKXXcReLZRzm2SerZ
	 2aqYLnaduroAhE5Hn9gQ8ncVs13txyLgMwDa6ebqBd/7vg/KurHcK79oDcG2OvMzLNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698737;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:IronPort-SDR:Received:
	 X-CSE-ConnectionGUID:X-CSE-MsgGUID:SanDiskIronportException:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kG7hbsIs0LGHYzA8KeJZi3mrT6QUwCifRqpQmdUsJ1U=;
	b=BNc01PrXRXXOQVZSBfc+gJCUVTwKMA0MjqzCYUvJdf5tLs+OHyDNtlklntorrkpLHDB5
	 /x+CZnLUsZOVdT1uuemNX4cnTyUkPhkwwhsDqkR7NWCD2Ij/RjLViGztnRLRoBaUOczLa
	 Es7kMM0JY1toncuQKBdFj2ERhahkcgXa7kaUB8NZJk6WcksI/+NjG5rKfmcA/XgnGYJ/D
	 ygG41YUc7IWgAR0cSrdzJcPpngQ5S1UlHt+pyBsN+Fat02CQDTs2fb7kdG2ev0nesb7uw
	 IFpgTrWNVkqktEgMxv8TfrapGAAv6EfJy4OZqV+d1JOGRtVt9U6wT4ipVvYa+M1Sz5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sandisk.com;
	spf=pass smtp.mailfrom=sandisk.com;
	dkim=pass header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b="Bq1Zi/7K";
	arc=none smtp.remote-ip=216.71.154.88
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62F606A329;
	Tue,  3 Nov 2026 09:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E62F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=Bq1Zi/7K
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1793698737; x=1825234737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6l1B/IO5jaLbJkNRw753wWhduj0VS5+axdNT27du1w=;
  b=Bq1Zi/7KM0arQkzqfIIItO0xawf27amqCzltCyzQvkybdqhoRNk0+oUd
   /jfkdDe7NBZNEafppkscbF9UE/PvXIBaU08XgYesO3mdFjAQzYEJNzYdE
   zxDpIaxDp6PJq06XL0zCpjFUVhTElj/ac/hz0F0Maha+owdByRKcjn5mW
   ufOQ95d+bFcGj7uvHg6Dkrk1N8SpQMZSJ57QgPT0uj2iJF/QS01SM9pZQ
   NGclHNZqtChSDq/qIB8adS1mCVFJdcOoN03SOcq13FdCIKYm0517d5GQG
   JCpe6jtDqqHaJGgJ2ouIHHVVrtCUj9uzhnUkx7xKH0LUnkmWfPJy/8YSB
   g==;
X-CSE-ConnectionGUID: RHfKbv7iRvuxDijqxZFvkg==
X-CSE-MsgGUID: yRym0a9eQ/W0XZ/EIAKl6g==
Received: from unknown (HELO uls-op-esaep03.corp.sandisk.com) ([129.253.192.43])
  by ob1.hc6817-7.iphmx.com with ESMTP; 03 Nov 2026 01:38:56 -0800
X-CSE-ConnectionGUID: fJ32eDA9TD+V843+Vy1UNw==
X-CSE-MsgGUID: G82fnQ9jS0qNuswZjHJWGw==
IronPort-SDR: 6ae9abb0_orKl6vXLGYs0yO/9mZy2IW3lMGJE7lGcXt4NszywCqCwAdt
 YyES1Sv6zDgpsjTcW1pZA0yu/5BTkhQ8FVMYLfQ==
Received: from unknown (HELO uls-op-esaip04.corp.sandisk.com) ([10.15.0.10])
  by uls-op-esaep03.corp.sandisk.com with ESMTP; 03 Nov 2026 01:38:56 -0800
X-CSE-ConnectionGUID: OS8w0ffdSo+rDeEeagDNyQ==
X-CSE-MsgGUID: i8IWh6yWTCiN8bzbLaoTOQ==
SanDiskIronportException: Internal
Received: from ulssdxvpxsnip.corp.sandisk.com (HELO WDAP-ez2C89klLd.corp.sandisk.com) ([10.9.34.160])
  by uls-op-esaip04.corp.sandisk.com with ESMTP; 03 Nov 2026 01:38:52 -0800
From: Arthur Simchaev <arthur.simchaev@sandisk.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Andres Freund <andres@anarazel.de>,
	Pankaj Raghav <pankaj.raghav@linux.dev>,
	GOST <gost.dev@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Avi.Shchislowski@sandisk.com,
	Alex.Lemberg@sandisk.com
Subject: Re: [PATCH RFC 1/2] block: add BLK_FEAT_ATOMIC_WRITE_MULTI
Date: Tue,  3 Nov 2026 11:38:49 +0200
Message-ID: <20261103093849.203851-1-arthur.simchaev@sandisk.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929-nvme-mam-v1-1-48dcbe79cece@samsung.com>
References: <20260929-nvme-mam-v1-1-48dcbe79cece@samsung.com>
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

On Tue, Sep 29, 2026 at 01:17:11PM +0200, Daniel Gomez wrote:
[...]
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d003a9d2d1f6c..92efd4ff67f26 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -360,6 +360,9 @@ typedef unsigned int __bitwise blk_features_t;
>  #define BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE \
>  	((__force blk_features_t)(1u << 15))
>  
> +/* device writes each atomic write boundary window of a command atomically */
> +#define BLK_FEAT_ATOMIC_WRITE_MULTI	((__force blk_features_t)(1u << 16))

With this flag set, a request with REQ_ATOMIC may now carry several independent
atomic writes rather than one. Code that looks at REQ_ATOMIC on a request (e.g.
blk_insert_cloned_request(), or a future SCSI WRITE ATOMIC user) needs to know
that. Could the comment here (or Documentation/block/) spell out what REQ_ATOMIC
means on a merged request, and what a driver must guarantee before setting the
flag?

It might also be useful to expose the feature in sysfs next to the other
atomic_write_* attributes, so users can tell whether merging across boundaries
is active on a device.

Regards,
Arthur
