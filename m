Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F02C69B;
	Tue, 11 Jun 2024 15:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118935; cv=none; b=iIwnAc2KHzWePXrvwkBE4aTrqjI2zZHXPK6Tx+uJIb9b8sa51RYGydN21uG66xaw8YMyFnsthzxUdHfsOHIgNZPdIQETPc2FOtX+1wQt324u5XfY2WSwqNNxu3bw1KSLIp8ISiVJxh5dHbeoI1rFZ73oDAvX+m6xxO8kWbDyssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118935; c=relaxed/simple;
	bh=xMLV2sd8FsrG6JWqA4Eoeeg1GA6HduhpKbcLiHnUZ7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT+/cODbt/PL8T3m27cmYh4IgvD1ZESDMKOpaGdPtFqc8Q/eY3tm/F4FEWKDvoMwyLUhgTknsKztGfiYlg0hZ+sfkNTLtxTXFDzBWxUbC8gTACgBQ+cFCVozZtybu5+6+H0DybNl5ZFKqLGto9qzZDrSu+u2j+f/9bkEgRk3XcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxbSlKoC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxbSlKoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931C3C2BD10;
	Tue, 11 Jun 2024 15:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118935;
	bh=xMLV2sd8FsrG6JWqA4Eoeeg1GA6HduhpKbcLiHnUZ7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxbSlKoCtG+T4zqh3yYeHSTBNVU+KKPf5mzgeyyJ/yqkaMcmpAUk4S0jPBTX+eEpP
	 Etx38DHXSu0Kyc0Jck+DeWuc2lXIL/aR9zfSkr5IRhs9uRJvwfy++8sdBLQTEVu17O
	 SsLjDpz1CofxuG4bzCQrI9XwGg6jN6E6nIYBbf0/Pkm7uCmZqVFN+LXwt3/ifSfyr+
	 w0KXyqjZfpiQVIt899j60zcmAVo1fAVJVU9+hqnr99zwXZ7pEQbWL3PL5johehutMa
	 uQ2IWmAyx7PgWc0TiGFqnXWtP5uHl2CzopF6C4udcTs9hmi4PxXcvu4cw4EESSNnDu
	 ZVJ8roq3AV2KQ==
Date: Tue, 11 Jun 2024 09:15:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Karina Yankevich <k.yankevich@omp.ru>,
	"lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [bug report] block: integer overflow in __bvec_gap_to_prev()
Message-ID: <ZmhqFLdCW6aXriqP@kbusch-mbp.dhcp.thefacebook.com>
References: <9d8ac82ab63a64583f753878dd03e3503c68ffbe.camel@omp.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d8ac82ab63a64583f753878dd03e3503c68ffbe.camel@omp.ru>

On Tue, Jun 11, 2024 at 02:23:48PM +0000, Roman Smirnov wrote:
> Hello.
> 
> There is a case of integer overflow in __bvec_gap_to_prev():
> 
> 	((bprv->bv_offset + bprv->bv_len) & lim->virt_boundary_mask);
> 
> bio_vec can cross multiple pages:
> 
> https://lore.kernel.org/lkml/20190215111324.30129-1-ming.lei@redhat.com/t/
> 
> So, in case bio has one bio_vec bv_len can have a maximum value of UINT_MAX.
> The check happens in bio_full(). In the case when bv_len is equal to
> UINT_MAX and bv_offset is greater than zero, an overflow may occur.

Does it matter? The lower bits checked against the mask should be the
same regardless of overflow.
