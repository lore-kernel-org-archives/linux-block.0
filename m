Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA64D3E63A8;
	Tue,  9 Jun 2026 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993492; cv=none; b=s7smo79HQtk8gN0kSj8HTJ3Q2qYZDFVAD1rLCH6noNnV92wsQEHmIORGmU3yX80ZOdalE5G+mWcl7N5Zez2cxP5cNPAuXmZWy8C37mE7qoJvFUO36Y52ebSkySZ8uXTQ+TkoWDnGljElkUGJ0cB0chHlNH3SqUtMOEY0hYIwaro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993492; c=relaxed/simple;
	bh=0HTp1iYUvRqECS6D6duhwPXq1Pb8twNlBGaG6PkvE0A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBviPa0d6gjdeOTWTbEFZZmNcNm1fb1kV74VGKexGYigi4HNhtxc61trDTu5+sV+BDO08G/37j/r4zy1wwCNKmITRQ7WNDdtv8eyCLnfnnrvYfgajY3Cnv5V3ANOZUhdUIa5lynzGsn71R5Ba62YLj6R8kQEn4IKx7IAazIYnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com; spf=none smtp.mailfrom=joint-cloud.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rgOMxVNV; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rgOMxVNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780993478; bh=WUdcWDS9vhyr8mnJoAhLdoplLTV9ShqIlxeHz8A/mSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rgOMxVNVUbfZaGq9m3+0l59Jqhx3dUxlpPzxR49arv8GnXOoDhvw6i0Kl3nVciC89
	 INMDlNNyqjEAHDtoGQlnRHYz7ADCM5dGZvjI5EPE6OYXIlmMn+T7tguTyIPRvLp03G
	 nEaBgS4JDFS2lF+mlwt9+IRAKgIXUFMYyiH36MT8=
Received: from ASUS.localdomain ([113.65.236.83])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 6182265C; Tue, 09 Jun 2026 16:24:24 +0800
X-QQ-mid: xmsmtpt1780993464tjoa6bi7a
Message-ID: <tencent_D401AE078217E74AB03222FB6EFCCE443607@qq.com>
X-QQ-XMAILINFO: NFIWYslbmIjP8BsYRLkTLEqqNhGHDkMJyErqZb9y/DBEi+1myDxtyoiooOeZpE
	 b4hr8goSftw6+pt9CQ3zb9y4ss2e1BOJbzDmI9Pxwf+JJwQAhiriD5YVdugj2QNjuVzUQGtOWPPu
	 +nuzNYF45w3cYWTrHtY21W21anhn+MwMdDUO7iAfaW3jaf4TXU/r1TdAbWsaNwNQcQv3Id57avAY
	 jHjGVnxlaQ8JfODexDDXMGiyeoxVqu/3iuZhxQ1wninUrJqRYqw5PbPKVnSFgHA3mQilllSH5Ewl
	 m8t2fHAwByGOugGgzRq1+ifwyiF68Md6CsvREc4oNqCr9jvEivUMRk20+NiwXf4Yr6AASeAWoCRb
	 cJbDd59Y91RDX+lCzLEXVrI+TG8tSxWezXSeQ9gGwf9BEi90yAyV2J45IhwPfwEYH4BQZUGOTXNj
	 gQKp02IqCnjIiOhmEmyfq3Rr3uHMeHxTJHYkuVMntd3K8P+OwKGbbr4BvX7Pact1hlUF2zu7CzJd
	 cdCNBjIeKBfEieuEjKuvGm1KLbFsl8CnrGWCM8+RNhBdAT8q6L5Qldgy9YWmxQFutt4waB7oPNbq
	 tRsHtnrGBbrcg1KpS7+6TEV7RPblYpD7NRaqmZs9wS/OVXtysV49BpendXcRgbb8vyCeX136bz+G
	 rG97GE7cpAyNTSqwVSv037uZI5cOtxC7mo/TRa5Hn6NvUXuCx98nQSYrpCl6FWfKvAloo6DTswXK
	 Bn+0PFnjZI5K+uO1R4oApIM2eMUSfn6ai4jsvcqRHeUd4qNJsYd0XxF52uFQnzAvMv2RpD52llRl
	 eBy8UzmEFTLbO0+IjuuhKipCrVvjsWLqEPLMHkQ+dCJJ/KIEWegZLnOG06TMEjlXYriSsrE1y2CF
	 evbyVpOEtC7Dux5deJiyWaGW76ZD7bHKv178cVJKA6Ue1ZhmOGYH64wgaEwGWJb+GmQlHq512g9z
	 j9f6K8yKbv7YjmBimqlyDz+RdHZLHGJ5wspiUa2eJaIiqWlVSeovDNEMNYL0WouDxTiZ20iALDRg
	 dT8uLTUy+ZyjzCyIGmqujENX+xwaJgLjAkRCyeYivxCCpPa/Ui
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Steven Feng <steven@joint-cloud.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Feng <steven@joint-cloud.com>
Subject: Re: [PATCH] block: optimize I/O merge hot path with unlikely() hints
Date: Tue,  9 Jun 2026 16:24:10 +0800
X-OQ-MSGID: <20260609082420.5973-1-steven@joint-cloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZmUjB3aF8K1xYzHr@lst.de>
References: <20260606024218.12345-1-steven@joint-cloud.com> <ZmUjB3aF8K1xYzHr@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jun 09, 2026 at 12:38:47AM -0700, Christoph Hellwig wrote:
> Umm, these are not failures.  Just conditions to not merge because
> of this, and not merging, both because of these conditions and others,
> it the most common case for most workloads.

You're absolutely right. I misunderstood the workload characteristics.
I incorrectly assumed these were rare failure cases rather than common
merge rejection conditions.

> With your patch the object file size of blk-merge.o increases slightly
> for me on x86_64:
> 
> What kind of optimization are you attempting and how did you measure
> the results of this "optimizatіon"?

I apologize - I did not properly measure the impact. I was focused on 
code style cleanup (removing '== false' comparisons) and incorrectly
added unlikely() hints based on a flawed assumption about branch 
frequency.

Given the increased code size and my incorrect understanding of the
workload, please disregard this patch.

Thank you for the detailed feedback. I'll be more careful to profile
and measure before claiming performance improvements in the future.

Steven

