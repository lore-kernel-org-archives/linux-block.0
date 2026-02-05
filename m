Received: from smtpfallback03.a1.net (smtpfallback03.a1.net [194.48.128.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D12288B8
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.48.128.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308654; cv=none; b=MuLYsqIUI3Mcwl6jMMGE8XiB213d7HOTf7rO9zx1cHyo5E6Lp5Qd0xl31R1dkCYtopMFxngO7HfUa0bEbQiKwxx8JeYEZ9flS1Psm3HF2jBFZ/eja09QhLOiWlAmUJab6nIE8IQuBKSekY8NFEH3jByxukmShQA6Yegx++k95uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308654; c=relaxed/simple;
	bh=sSiMnE7oOgXWmRXKG6Iaa2veWD+evyX+zVEVOkBbatE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJqkQmaAeHOMGQRhp6lfE5lz+jMh0vxsn6d7q7ptc+gQE3wJjdEoUT+HHJZb5PL6aHwv2Imnv5MgIV3bX0HGnd2RefGPDLign7Ud5ZRDlTSXaU3t35pmPx2+stLU/+PkVkQG4TJsVSMEhhdQClOSbt65ikErpuKXJGiQsoghWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aon.at; spf=pass smtp.mailfrom=aon.at; dkim=pass (4096-bit key) header.d=aon.at header.i=@aon.at header.b=ZolKWOjU; arc=none smtp.client-ip=194.48.128.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aon.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aon.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=aon.at header.i=@aon.at header.b="ZolKWOjU"
Received: from smtpout00.a1.net (unknown [10.247.84.4])
	by smtpfallback03.a1.net (Postfix) with ESMTPS id 4f6Mlx17vHzYmFGR
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 17:16:13 +0100 (CET)
Received: from golem (unknown [100.86.133.200])
	by smtpout00.a1.net (Postfix) with ESMTPSA id 4f6Mlk4ZtGzGrqyn;
	Thu,  5 Feb 2026 17:16:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aon.at; s=resmail1;
	t=1770308162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3LL48iR/cEYoaqHekslQGshehwVE6rcIiEemaaFByA=;
	b=ZolKWOjU/ngWWWVloxD4Dqw2QUi3sdZCli9LEJkTsS/j5ZwnpM3kL3d07dbdFTyQZE83N4
	LNbpxK9fYzzyAbhxfDlT7EMp6K+U4gPmwqVy6Wl1fKZaJMHnVTzSFPG67PG7uCroAqjlbM
	Hb+IKlRBhGZWqjxzGhI15itIp9QppgnrrZ/ZUtDOVzNN7zgB9q5z+6ePWWh7fngkog3vbE
	h0W49Po5Oa5QulJ2mCBYpLqgwZzkiMY8wXtO3YpdWqKYsHbaA909KwSfR1iGU1BxTacF9I
	u1l2U7zwGYtfCNVTK9mWKLI5f6Z2fA8pE831gRJE2lKYKNoospQqs/8QW2n1TJy6CFZo6V
	PS/rXqBm1LbarjsSHdpJ+xkv9/tRZ52Pexq6rhbU2IdBVpDxnVbRJ01vyt7RydRTVIUjEp
	AtYtLC7SGH6hKQ7iDhxvLNt+hVN3HGqLyBecNJ4EG5Rl0KRLk03GPtJjGzs8CEiT+IWKbN
	QCrC2DqKuO8NPBNk8DmTPLLIgoV/QuoVEAfhfxkzaYjNjQEuXQWr5JKrkRTXPto7XadSlo
	S/hUys6uOZnyDSqdmvHVE6SPnMadedXSEKhAdEW73q3evm7RrFMN/03s7+oYXg98ji1CBM
	qr5kytqA5m6Svgpvu4Ht3oagO7B9fmDkbDcWSn935a9n+zku6d4Do=
Date: Thu, 5 Feb 2026 17:16:00 +0100
From: nokangaroo <nokangaroo@aon.at>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-block@vger.kernel.org
Subject: Re: Recent commits break loop device unmounting
Message-ID: <20260205171600.1939094f@golem>
In-Reply-To: <62de4453-17e8-47f6-a10b-39bf5a49fdee@leemhuis.info>
References: <20260129131441.7c574b58@golem>
 <62de4453-17e8-47f6-a10b-39bf5a49fdee@leemhuis.info>
X-Mailer: Claws Mail 4.3.1git129 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/BS1X_5dRFMrQTGEME0S/qBz"
X-Spam-Level: 

--MP_/BS1X_5dRFMrQTGEME0S/qBz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Still broken. The disk image in question has a UDF filesystem (DVD image)

uname -r:
6.19.0-rc8-2-mainline-00045-gf14faaf3a1fb-dirty

The fix is still the same:

  git revert -n 2704024d83fa9eb8e5f16925aae340fd9d246694
  git revert -n 08e136ebd193eae7d5eff4c66d576c4a2dabdc3f

I attach a script to create a sample DVD image for reproducing the error.

> On Sun, 1 Feb 2026 11:19:09 +0100
> Thorsten Leemhuis <regressions@leemhuis.info> wrote:

> Lo! Top-posting to facilitate processing. And Ccing a few people and lists.
> 
> Thx for the report. Does the problem still happen with latest mainline
> (e.g. 6.19-rc7 or later)? Asking, as a fix for the culprit went into -rc5
> 
> Ciao, Thorsten

--MP_/BS1X_5dRFMrQTGEME0S/qBz
Content-Type: application/x-shellscript
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=create-dvd-sample.sh

IyEvYmluL2Jhc2gKI25lZWRzIGZmbXBlZywgZHZkYXV0aG9yLCBhbmQgZ2VuaXNvaW1hZ2UKY2QK
d2dldCBodHRwOi8vc2FtcGxlcy5mZm1wZWcub3JnL01QRUcyL2RvdGhhY2syLm1wZwp3Z2V0IGh0
dHA6Ly9zYW1wbGVzLmZmbXBlZy5vcmcvTVBFRzIvZHZkLm1wZWcKCndhaXQKCiNtYWtlIG5hdiBw
YWNrZXRzOgpmZm1wZWcgLWkgZG90aGFjazIubXBnIC10YXJnZXQgcGFsLWR2ZCAtdmNvZGVjIGNv
cHkgLWFjb2RlYyBjb3B5IGRvdGhhY2syLnZvYgpmZm1wZWcgLWkgZHZkLm1wZWcgLXRhcmdldCBw
YWwtZHZkIC12Y29kZWMgY29weSAtYWNvZGVjIGNvcHkgZHZkLnZvYgoKd2FpdAoKI2R2ZGF1dGhv
ciB4bWw6CmNhdCA8PCBFT0YgPiAkSE9NRS9zYW1wbGVfZHZkLnhtbAo8ZHZkYXV0aG9yIGp1bXBw
YWQgPSAiMSI+CiAgICA8dm1nbT4KCQk8bWVudXM+CiAgIAkJCTx2aWRlbyBmb3JtYXQ9InBhbCIv
PgogICAJCQkgICAgPHBnYz4KICAgCQkJICAgICAgICA8cG9zdD5qdW1wIHRpdGxlc2V0IDEgdGl0
bGUgMTs8L3Bvc3Q+CiAgIAkJCSAgICA8L3BnYz4KICAgIAk8L21lbnVzPgogICAgPC92bWdtPgog
ICAgPHRpdGxlc2V0PgogICAgICAgIDx0aXRsZXM+CiAgICAgICAgICAgIDxwZ2M+CiAgICAgICAg
ICAgIAk8dm9iIGNoYXB0ZXJzPSIwLDAwOjAwOjA5LjE4MCIgZmlsZT0iJEhPTUUvZG90aGFjazIu
dm9iIiAvPgogICAgICAgICAgICAgICAgPHBvc3Q+anVtcCB0aXRsZXNldCAyIHRpdGxlIDE7PC9w
b3N0PgogICAgICAgICAgICA8L3BnYz4KICAgICAgICA8L3RpdGxlcz4KICAgIDwvdGl0bGVzZXQ+
CiAgICA8dGl0bGVzZXQ+CiAgICAgICAgPHRpdGxlcz4KICAgICAgICAgICAgPHBnYz4KICAgICAg
ICAgICAgCTx2b2IgY2hhcHRlcnM9IjAsMDA6MDA6MTIuMDAwLDAwOjAwOjIxLjAwMCIgZmlsZT0i
JEhPTUUvZHZkLnZvYiIgLz4KICAgICAgICAgICAgICAgIDxwb3N0Pmp1bXAgdGl0bGVzZXQgMSB0
aXRsZSAxOzwvcG9zdD4KICAgICAgICAgICAgICAgIDwhLS08cG9zdD5leGl0OzwvcG9zdD4tLT4K
ICAgICAgICAgICAgPC9wZ2M+CiAgICAgICAgPC90aXRsZXM+CiAgICA8L3RpdGxlc2V0Pgo8L2R2
ZGF1dGhvcj4KRU9GCgp3YWl0CiNtYWtlIGR2ZDoKZHZkYXV0aG9yIC1vIHNhbXBsZV9kdmQgLXgg
c2FtcGxlX2R2ZC54bWwKd2FpdAojbWFrZSBpc286Cmdlbmlzb2ltYWdlIC1kdmQtdmlkZW8gLW8g
dGVzdF9kdmQuaXNvIC1WIHRlc3QtZHZkIHNhbXBsZV9kdmQK

--MP_/BS1X_5dRFMrQTGEME0S/qBz--
