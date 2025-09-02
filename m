Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AA7198A11;
	Tue,  2 Sep 2025 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756842088; cv=pass; b=FcUP59+DGCu/B5+fF0uj9lHmq7I2VZdQ20TH1473dUlgNSXkjiOcA40VrVw0lM9QOCwMH+0mDW57NijzvC9EX6VfDPd0YvqoUNVI5w6SBcgW4WdJxVl145vYWsMdx6yzTqZQKxDPgyzbJ//Umlye1Yk556+9RqPRM1nyWvyuqJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756842088; c=relaxed/simple;
	bh=9KUiVlHOSx3yLQtBjqIEEn8A6eLglGZix9UneSF8ZFo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LjyzLTWahXFBAq6ZTmiEPvp1l7upiugSKDW9TwCCYI5ovWV+pDgPxVOohRBQ6yYkMRVah7UHgEccduaHaFvt9IqNrosJnGpVOZHDmSwB/gIoGTU87N0BP3y6GzqgFLqNBQ+79vJu8BmvZXNpOlZ9wdQC5nCfUFNaX/Epes/OqLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=VDlptCP2; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="VDlptCP2"
ARC-Seal: i=1; a=rsa-sha256; t=1756842064; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UHvzHgVFpRNKwZW6xC3IYWq3/z1MAQ+WGRwP83cnUgUArqIimwAZXtbUBFa3e1kfr4XvsNx6YvUvuD5UFGrcSCS7/hx1ZKWMNKk+h73Le0QfwhAEpglvarnvqLzCDcICbaOrtVFeD+NbDQIYvNbXGUZLUrBI73IGAIOmdmfFBU0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756842064; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9KUiVlHOSx3yLQtBjqIEEn8A6eLglGZix9UneSF8ZFo=; 
	b=URq60oLY7951Lx9OjIWl1GVh3uQYNQwZ/3I6cteQKzWKdE4BBTKFB8OExO08zASrEcO3hUk2OwV3l/TAQ0NBXrOZTd3j+WNrncBnqCn9eIqGDw8SyTjy8D9FuWlWb1ACfmutJ6sz5TplSfI5lfasNU5eWP3czJvxtcU7Y5Qmto8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756842064;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=9KUiVlHOSx3yLQtBjqIEEn8A6eLglGZix9UneSF8ZFo=;
	b=VDlptCP2gcaFGw4epeQDpIxmm1hV7gbUHrrpW2N3yLLYYR8cl/h4N6EcjivXbGhl
	fp4B7F2ccRpo52GKB92eZ36LugVEgUkBN0DeL56lqoFJuskFEEMd/q9iyW0a2S6gVJF
	vd4uTh2j9NzvxdDoo7mN1XhVs9E5kt1eTQT5fZ58=
Received: by mx.zohomail.com with SMTPS id 1756842062765279.12565293887326;
	Tue, 2 Sep 2025 12:41:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v7 00/17] rnull: add configfs, remote completion to rnull
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
Date: Tue, 2 Sep 2025 16:40:46 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 Breno Leitao <leitao@debian.org>,
 linux-block@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A619CD0-4B72-433D-97D9-CBA8AC37DB01@collabora.com>
References: <20250902-rnull-up-v6-16-v7-0-b5212cc89b98@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Andreas,

> On 2 Sep 2025, at 06:54, Andreas Hindborg <a.hindborg@kernel.org> =
wrote:
>=20
> This series adds configuration via configfs and remote completion to
> the rnull driver. The series also includes a set of changes to the
> rust block device driver API: a few cleanup patches, and a few =
features
> supporting the rnull changes.
>=20
> The series removes the raw buffer formatting logic from =
`kernel::block`
> and improves the logic available in `kernel::string` to support the =
same
> use as the removed logic.
>=20
> This series is a smaller subset of the patches available in the
> downstream rnull tree. I hope to minimize the delta between upstream
> and downstream over the next few kernel releases.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> Changes in v7:
> - Fix name of `kstrtobool_bytes` in commit message of patch 06/18.
> - Fix stale safety comments in patch 15/18.
> - Refactor `kstrtobool_raw` for readability.
> - Link to v6: =
https://lore.kernel.org/r/20250822-rnull-up-v6-16-v6-0-ec65006e2f07@kernel=
.org
>=20

You told me that some of my tags were not picked up by accident?

I checked again and all patches seem to have my rb tag. In any case,

For the series:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

This should be enough for "b4 trailers" to pick this up.

=E2=80=94 Daniel=
