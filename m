Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6E3ACA60;
	Thu, 10 Sep 2026 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024731; cv=none; b=cZjQGpIUi11llWHfEf/anddXPKBOvRXp7ZI47y7yTJ05MWfMzWlRhYQozmG9IUQKaCi5x/hJBorvNBrtzg8K1907KOrzvvgpQnZ+B7hosQygAEkAWRpOJUMgMwiJ/JPW3bpf9YrvdajEVfG2MOfky3bjR/FTRFt2OM6QaRj1jD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024731; c=relaxed/simple;
	bh=shiWjj1lGQKHil7cvcMTNNkQ6u42VvO2m3EcTLYasgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r9jfC3EdYReoJ/i6j1ToJdy8K1Ptx3zV92wjQD64rmYVoIQZHru6FcZE9D5n4Ir1JjkuJ4TxZKta8Zi8Lr4VT3bj2RM0qTGuQHRM9htAbd9KCsylRZ6A/4zwtXf+7+dpPFxVLcbp7P85YLI30MU1GN945XxJx8/P1cgbPi//sJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=acZlyY+G; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="acZlyY+G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=RiTpQGfQvEG2bEzKz9Q0QXGg61I4AiEa7vvH0A0GsWE=; t=1789024727;
	x=1789629527; b=acZlyY+GFFyYKt+vIYUU8eR+frox4ZUqpLTZy71wVa/QGRFdQm+EsePS6ozp9
	9G1IQ4XpS0odTFfRwPbaj8CVlLZe2Q1TBfdIWLf6R4+i6C9YseONQpnTmdx3kov8HQ8VL6EnocfO/
	+OJCM62Roq+X5ZsE5EQ+XlAXGWia+xEku8mRun1bGDWENjEzT4wbsuRhTWZqtqMXabePte2c182RP
	4mG5Q2bwsePxJwEkhSKTNSR2V+FjpRC5xxLZyNRUR+CbPrhadLQbg0qsHAB2iPcofHxD+o+B1b2K9
	xH7Izh9ZIeYNceqXeXihWJaCu9tRPzSH656NjG34mMrhABcELA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x4YzK-00000002uMe-3uzN; Thu, 10 Sep 2026 09:14:26 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x4YzK-00000000Gbj-2v0N; Thu, 10 Sep 2026 09:14:26 +0200
Message-ID: <774b2451be908e2cc07f0cc4d98e4178ab1a0d7b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] sunvdc: fix silent data loss under LDC congestion
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Stian Halseth <stian@itx.no>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andreas@gaisler.com, davem@davemloft.net, 
	regressions@lists.linux.dev
Date: Thu, 10 Sep 2026 09:14:25 +0200
In-Reply-To: <20260901173947.3292110-1-stian@itx.no>
References: <24f8b266-f17c-4909-b43d-8ab05721c5d8@kernel.dk>
	 <20260901173947.3292110-1-stian@itx.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Jens,

any chance you could take a look at this series?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
