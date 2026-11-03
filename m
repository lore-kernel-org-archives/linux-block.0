Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.71.154.88
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698735;
	b=tCRHxbfuxZxGcifrIFTjEYiNrM86MpkBcDuVzGcWvkRPYlVUKTu347ZyXwnAlERQXp+r
	 8nFFFH/cQl2fuZuWmGZWfqyrfcLJYsm95qgps5TJlR2XFnm/lpbJjhZAwY+TQ8FYt+k/f
	 3BLPZhGtmInXQrWhRJ88n29+gpdyyF0QNoPhTxNFRgQRzx2MU2LVB4hWv5CrIt3tN1rHb
	 bKLTbrLmbSPJfZ5DpEVqwKrNDa5DIrpdj+nY1i38cu92bTRoh1ZiZCkHrZDi4H6FXDWdK
	 e7nsIIi40ea7Gwq0qIaSZknGaAXO5zaGv3/Gsuj9SnfKdQkuqewGf9ry0BaM4vm2pzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698735;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:IronPort-SDR:Received:
	 X-CSE-ConnectionGUID:X-CSE-MsgGUID:SanDiskIronportException:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Es+iUNXb2N93UImwfSO2oOUm0ra/6NQPCq5iI5VuFgY=;
	b=D6PuayNA5mb7sDrSJ3At7MFmQ8VzR6oCe9QITd9QBqlSFLBIb9Oe+++X3MkB85g2RKDL
	 n6KDLzadboVJaUwv11OjkU1IsjtKtHkKMwTMSbtKQTDoTIcC5O+unDccBWs6ClhgUuU2S
	 fiGM13bii+CbgUvQmDGuOMWR+nWcKyRr554Ugn+pmGHmj0T5tfKX1cHYRy5NpCga027wH
	 s7mqE80F90UaKCo12MVx2VFcoM+Z10kG7PYaM7dJcy0SaaXI7sEfDklOFVMDnhs+2p/IV
	 UrolCFJ29VGXQTV4pvdHCSJOU3G8XFJOXyU08wvnWwRqvjz5jb4Cy4L0D7Tfk9JY6/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sandisk.com;
	spf=pass smtp.mailfrom=sandisk.com;
	dkim=pass header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=DFmjdy2Q;
	arc=none smtp.remote-ip=216.71.154.88
Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53C1606A324;
	Tue,  3 Nov 2026 09:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A53C1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=DFmjdy2Q
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1793698734; x=1825234734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6gILW4913DJmhe6Xf2zy1YvOrI0lTdtkeeHEK4vy7j4=;
  b=DFmjdy2Qbk72YHzWZLB8sYNaSqw+RAp2XMQE9VBPRK6BYkTEqYLfeUQf
   cNyFKUn9apeVpmAW7k34PbD4rG4YhsaaBcQZ5jU6nx0afkm1jDa/n5iB9
   ZZgn6gD8+TBVi6oRl2ErQ3nqjOKzaZmwNLO3zdfhDAxQXih2WTB94n3PG
   voqIzvsZaEJBXQ9yaiEIoEOD6N0c5zj9uvNQQ1nrNLMYAYUHs+cAwocVB
   Iq0TUI4yUxRMIeebht0U8fUmgU9TmF45KWHsqxmiyI+LTCZeR3eLW04Bq
   gqtnzqceN9U7O1Frxm4vyLS+S2bQnw0uRWu8EMMSqe0ue1SsFYKEudl9p
   g==;
X-CSE-ConnectionGUID: N1bTh70GRK+punBLalyGAw==
X-CSE-MsgGUID: TeQFgXW1Q62O82kX2t+5TQ==
Received: from unknown (HELO uls-op-esaep03.corp.sandisk.com) ([129.253.192.43])
  by ob1.hc6817-7.iphmx.com with ESMTP; 03 Nov 2026 01:38:48 -0800
X-CSE-ConnectionGUID: 6XPYSXlnQ3GkBPsp5aRAJw==
X-CSE-MsgGUID: CNK+0/lGTjG+j9BqRxRwFw==
IronPort-SDR: 6ae9aba8_J3mApw+WszOCRAdBjOR5BVqsNJeAwf9wjdY4ATMp+lQjHJe
 AZNDDLNqcb2J4CKrD2PQy9FOFSgBWx+J317EUow==
Received: from unknown (HELO uls-op-esaip04.corp.sandisk.com) ([10.15.0.10])
  by uls-op-esaep03.corp.sandisk.com with ESMTP; 03 Nov 2026 01:38:48 -0800
X-CSE-ConnectionGUID: AqC0UPcGQtuzuCT5q0QjBw==
X-CSE-MsgGUID: f0yvLvy8TYWlKwC8Ag5LTQ==
SanDiskIronportException: Internal
Received: from ulssdxvpxsnip.corp.sandisk.com (HELO WDAP-ez2C89klLd.corp.sandisk.com) ([10.9.34.160])
  by uls-op-esaip04.corp.sandisk.com with ESMTP; 03 Nov 2026 01:38:44 -0800
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
Subject: Re: [PATCH RFC 0/2] Support for Multiple Atomicity Mode
Date: Tue,  3 Nov 2026 11:38:39 +0200
Message-ID: <20261103093839.203841-1-arthur.simchaev@sandisk.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com>
References: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com>
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

On Tue, Sep 29, 2026 at 01:17:10PM +0200, Daniel Gomez wrote:
> While I think this small feature is worth having (hence this RFC)
> for users sending atomic write commands that are contiguous, the
> question I'd also like to discuss really is how to also expose clear
> MAM semantics to userspace for users who can send larger commands,
> so they avoid syscall overhead [2] and splitting, and still get the
> atomic guarantees in the LBA subranges. RWF_ATOMIC currently exposes
> SAM semantics, but I think MAM may be confusing for users, as it's not
> simply a larger atomic write but an atomic carrier. Thoughts? What can
> work best to leverage MAM from userspace without conflicting with SAM?

Hi Daniel,

I agree that RWF_ATOMIC should keep its current meaning: the whole write is
untorn. Letting it accept larger writes on MAM devices would silently weaken
that guarantee for existing users.

If we want userspace to send one large write with per-piece guarantees, I would
keep RWF_ATOMIC unchanged and add a separate opt-in flag that describes the
guarantee rather than the device mode, for example (names are placeholders):

  pwritev2(fd, iov, 1, pos, RWF_ATOMIC_CHUNKED);

  - statx reports a granule G (e.g. stx_atomic_write_chunk)
  - the range is split at file offsets that are multiples of G
  - each piece is untorn; nothing is guaranteed across pieces

If G is tied to atomic_write_unit_max, a G-aligned piece never crosses an atomic
boundary, because the block layer already requires the boundary to be a power of
two no smaller than unit_max. A SAM device could then implement the flag with
one atomic bio per piece, and MAM would only be an optimisation underneath. Open
questions would be the semantics of partial completion and errors, and how
filesystems keep each piece mapped to one contiguous extent.

Before adding a new flag, though: with this series your fio example (io_uring,
iodepth_batch_submit=4) already sends four 16k RWF_ATOMIC writes as one 64k
command, so a single large write would only save per-I/O work in the kernel, not
device commands. I understand real MAM hardware may not be available, but that
cost can be estimated without it, e.g. by comparing host CPU usage of a batch of
small O_DIRECT writes against one large write of the same total size on any NVMe
device. Even a relative number (e.g. % CPU per GB written) would show whether
the remaining overhead justifies new uAPI.

Regards,
Arthur
