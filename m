Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5FE46DFE7;
	Tue,  4 Aug 2026 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874248; cv=none; b=eiqwn92zavJ2f2jz3bNBfd0IWBFHof9WaC7Ur8cv5WmgIx2jTgFo42YmmrfU1c9wwewikm2fnlMLGA9iaDLKQU1oWypvWJWKsM4XjzOsLcqs7lEyi4cs4dPUry9svB4aOCDCBvO0vlP2EMOweVlvScNgrPsDZeuxcmGiNCGXi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874248; c=relaxed/simple;
	bh=EfibkzaErMQMpa2DaC51mT0iheQTOmvxBRBMTCxprNc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HvTxJHLvpy7PcNm59ilT+T4JJVmGHS4+WYjQCFqBx+keu9HDyehMdsMshbBR2cxlCoQ2kXZZSvDmZO3wl2ZIKSY9EZxi1BPcvkK2RLhwhCmx+f6AUJIRXhZhrfIwfEw2o/OXFEIqapVlrSwSZK4jpdSx7FDyY2GF0bN3XAurup8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gjQ0Gtdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gjQ0Gtdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEDB1F000E9;
	Tue,  4 Aug 2026 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785874246;
	bh=LiA+i9mh7z1w8TWb05qob900VSB5xbB2w3Aq0oqzIfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gjQ0GtdvjaXjGhLdYxl+DGa3rST3Ct0Sh/CcazHn6tlU71I4SOXEZLkLkkjuh6Yw4
	 TstqaZbjxUEdd2ymSixplCay7VE07DXfU2fueRFfNE6D6nKlm+uaKhvIGNfFK0D3Vu
	 pp9KOCAJKnUPK9OKxoGVq/yMy/LxYTlDYNmMfUK8=
Date: Tue, 4 Aug 2026 13:10:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Longlong Xia <xialonglong2025@163.com>
Cc: Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, Longlong Xia
 <xialonglong@kylinos.cn>
Subject: Re: [PATCH 0/2] zram: fix stale scan bounds after reinitialization
Message-Id: <20260804131046.7c485858542d586bb7c51857@linux-foundation.org>
In-Reply-To: <20260804065919.3970386-1-xialonglong2025@163.com>
References: <20260804065919.3970386-1-xialonglong2025@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 14:59:17 +0800 Longlong Xia <xialonglong2025@163.com> wrote:

> Both writeback_store() and read_block_state() derive their table scan
> bounds from zram->disksize before acquiring dev_lock. If the device is
> reset and reinitialized with a smaller disksize between that read and lock
> acquisition, the bound can describe the old table while the scan operates
> on the new one. This can lead to out-of-bounds slot accesses.
> 
> Move both bound calculations under dev_lock so each bound remains
> consistent with the table throughout its scan. Keep the fixes separate
> because the affected interfaces originate from different commits and can
> be backported independently.

Thanks.  AI review found several things to be worried about, all are
pre-existing.

	https://sashiko.dev/#/patchset/20260804065919.3970386-1-xialonglong2025@163.com
