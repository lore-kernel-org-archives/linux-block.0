Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759172BD587
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 02:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922044; cv=none; b=EFsgjfzpn0Y2c7kVBkjsPaXNdN1eNbmNaS9c/mKv6raSKIwqhYbPCXgcg+zY+gPw0s1pdw96BHIYcfgyN/OisLdHIsOIALgtjTUEFGUFZ1WsSWPRrNixbJAvwT2/UOb69959Ks/Z3V8/WIRhKITq1bIiyHh8M+TlMBATaBmtL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922044; c=relaxed/simple;
	bh=YHs08TRb4N/NWyWkqxx7huT09Urrmvp66AtsaUP5E98=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=C5PT0XQfjfkpqIb9ii/k3NlR2c8zwIlylrgelNFuDnX+Galjt/Pry5ijXJ03CMgpV8GUacUI3Bf+QQ2CM4yf4Ync4qyjEt8Rdj4ioHl0JWj+jdca05ezk1LjDS6VWttJIzkYEFoQVCjRzwNwv7SGLoiJO6N7soM36XeN2Lv22dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtZhB8t7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtZhB8t7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2991F00A3A;
	Wed,  9 Sep 2026 02:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788922043;
	bh=qExEyYPUmtJTnz1pyIM/yTfC4MkzWaJR87E+ULF6BW8=;
	h=To:Cc:Subject:From:In-Reply-To:References:Date;
	b=LtZhB8t7RZe+9jywm+o6JAA8bammNdhEw7e5hzDXY2zQUWrfTogI/v15g5MNqH5zW
	 RtZ2ZAHrWxOSU6D1vMpr7YyQxH3QaAwnObRyXo6eWKK/OKhKNGGrlneQ2wCkplZxsQ
	 LCR99M3Ybf9Cfqe/MCefU/QRB56hZqcmJHNFbTBXjm4t2fUCZG1rUZp+pJj2v2GIRU
	 US8xIR/oM+LAi/QS3w+c1ArIgSbty6VUgv5u8BbVjMX7+h6UXcIWDPPoTmf/UgSvba
	 tML54ucaM4Sok8vKkCTF+z5W3/8kGW+xi7//e+LYBedbp26fRCzP3IKvhC3THYXIeN
	 DBfEsxGAXhxug==
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,  John Garry <john.g.garry@oracle.com>,
  "Martin K. Petersen" <mkp@kernel.org>,  linux-block@vger.kernel.org
Subject: Re: misc block PI / bounce buffering fixes
From: "Martin K. Petersen (Oracle)" <mkp@kernel.org>
In-Reply-To: <20260907074111.721054-1-hch@lst.de> (Christoph Hellwig's message
	of "Mon, 7 Sep 2026 10:40:51 +0300")
Message-ID: <yq1tsnzcfa3.fsf@mail.kernel.org>
References: <20260907074111.721054-1-hch@lst.de>
Date: Tue, 08 Sep 2026 22:47:21 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Christoph,

> this series fixes pre-existing issues found by the Sashiko review of
> the lazy bounce buffering series.

These look OK to me.

Reviewed-by: Martin K. Petersen <mkp@kernel.org>

-- 
Martin K. Petersen
