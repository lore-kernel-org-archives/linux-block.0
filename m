Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F2142087B;
	Mon,  6 Jul 2026 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343382; cv=none; b=qJWfeep/77hw7rHWmEbvTl9uuWwTLVVin9jIHjGyesIQAd9qrh3qpJnz5WcdyhZkLyFgCf6A9e+E3A7D8znqvj4lWmW9QleIS4SbDT8n7qkPcjfLRtqARy5JoCHaarq3jbgLXMbsnrsWiR6bCsCLqKlY50URWXuqIYGNUm5/wwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343382; c=relaxed/simple;
	bh=OcnMw8egfvLFzXD/0CCTqlghbuhYW8htOYqsc71uG2Q=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QvIWuGWKinu6dl75dlH35oYkC32bPjMddgsCIhub0FIRPmwZtrfGtpoUDHP+GqUEw5Pv8BBSLxStnXGjOYUe5XAVoXYaNixGSi7DHcsEpEdM00qApBHEQE15Vzedthyi6pfN1OkaFt9eMkJpUXxbdR7/qBzzKwRFlkzRvmCqN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOSRt7ts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOSRt7ts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B119D1F000E9;
	Mon,  6 Jul 2026 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343381;
	bh=oaUS4o+OCdA++JRZVpENFHMgrpsIBgCmDimelppknkc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=IOSRt7ts6ZiFuuYHDDuuAdfzX5zZC4jjq4v4cJeJ/0xCdvajACZnYcro1UaRufaQu
	 k6KaWVYtuCn+SA8PfScCE9DCYsNyQPZ5KZzAmoh5UtyHwi1R85C+4Bfk+EALohOowK
	 6V3WCMdX6qI1AcLeuIwMKW4YzZSzeTH5Gg/fgJiQ/0v3pcnPz38piZ7rHjs3CjbaNp
	 +wBqfPTYjnG9oe39BqKlfljNCvH92uur5h1l89Y/Z3Wys+QiPPzCUniozj9rm4hn2o
	 nu9owkT5nTrx3ziv12Ey0022YYQGEEU7eUZ7DNBTZg8mueWWcbyc99txirtYEbezMu
	 hYflRKsrle9Pg==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] block: split out a new blk_plug.h helper
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, 
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20260706041125.642097-1-hch@lst.de>
References: <20260706041125.642097-1-hch@lst.de>
Date: Mon, 06 Jul 2026 15:09:36 +0200
Message-Id: <20260706-hochmoderne-vorher-chipsatz-8882212e1328@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=597; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OcnMw8egfvLFzXD/0CCTqlghbuhYW8htOYqsc71uG2Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR5rxTeuk3s5/GXM8/utNgdk3dV9JTCxQlpT72besXUe
 i5ztStwdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkSyTD/0jhBa4/V3W1c7Gp
 VDLWzq15FvX2yTXPnAmZivmzX90+84jhD9+E9uS6vsm/Oqc+WTg3/X+2x86Q1AMX9mvJab/IK5s
 2hwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> blkdev.h gets included in various places outside the block layer just
> for struct blk_plug and related plugging functions.
> 
> Split blk_plug into a separate helper to reduce the amount of code
> that needs to get rebuilt when blkdev.h changes and to slightly
> reduce compile times.
> 
> In io_uring this requires pulling in a few other headers explicitly that
> previously were implicitly included through blkdev.h.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 
Christian Brauner <brauner@kernel.org>
