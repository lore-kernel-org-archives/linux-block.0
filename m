Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD684252D9
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189459; cv=none; b=Wb5rJbTsouq0+iiC3wcNluZntd4Gt5iqdxlwHE8g88PjrufSRESQSxpy4sEA2O3Nc8tgQ1blPlZ/iMaS7hdilgXI/TLm9e4tvRBlhZiH2fXaTWmfYaFDPmuULwhqYv8sAzrlmO59otpRSCmvvV7w6nApJB23PkZku9mxrNN7Isg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189459; c=relaxed/simple;
	bh=6PbhU26GmKGjBJC3fCXX84soDY4rE8czxvMawXB9xjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcBr0RdIiA0fUdeaN8NsJlLSyUeJIkoVGaP2oIUlJLxAAk0xwKyyYbv1x1wPr8NpyySXAB+rvxsQxG5j/RZ7g67vDkXmMvKJ+/glxbfBU3pqK439k9TVMDOhE647bZk/y+hpEaslh5MccZ4BiHftGAICrqBslLTXIe14j+5UPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5n38yj/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5n38yj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85141F00A3D;
	Mon, 31 Aug 2026 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788189458;
	bh=6PbhU26GmKGjBJC3fCXX84soDY4rE8czxvMawXB9xjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V5n38yj/VspNmjk92AdgJjObPXSh6cTC4peUmOmWJKuVgh1QWViQVKJth1FVp6vuH
	 JyCokDPlqrH4Vgw4ZCmDK50v0AUkPRI2RFDlH9HuyICtjea0TPUtwVJDRzdlWgWA17
	 Obzau0yKmcLtUk1SQfYnsvODa4GWbgsFHJy0/wbG7MrwGxLDzfFLD7CrR9XhHgKYTu
	 Touyc0HLKsLF6hCsGyuM7IGNXekPYyc2Xme+/jyScok7EoFSm3p47P5hkcid+GQY3t
	 Vkc9sk3L8tNEgBpH0vMZF0Z07AeDOnp5AdHWBBaUKwG3nLcc0fKglivb6u1tHm/g8M
	 i/hDpo7CeJg9A==
Date: Mon, 31 Aug 2026 09:17:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Auger <eauger@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCHv2] block: save page offset gaps in cloned bio
Message-ID: <apWbEA42WEJQ1uBB@kbusch-mbp>
References: <20260819154937.3903312-1-kbusch@meta.com>
 <a31c539d-3554-4f8a-8ff8-a313a554d4f1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a31c539d-3554-4f8a-8ff8-a313a554d4f1@redhat.com>

On Mon, Aug 31, 2026 at 02:26:06PM +0200, Eric Auger wrote:
> gentle ping on that fix. Could someone pull it?

Yes, and these two pending patches as well:

https://lore.kernel.org/linux-block/20260810164218.3721636-1-kbusch@meta.com/
https://lore.kernel.org/linux-block/d919f5285d16afbec6c51ecdf201692a484566e5.1786637565.git.bvanassche@acm.org/
