Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0DD126C17
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680242; cv=none; b=EXtCA1vX9zkh2r+AaxyhOU49tsinnEPuwZzjaarSlvIN5EN+y8fDKeqI9FikmbftT0Jngw37Un5ImvPQAkS/DtxItklChMhnifk3MsNRZrSR+1Sf86820/dmtLykSD03PEFPBTK8iP+rsa8ouFH6zL2JYznaK6n7Slz32roKF2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680242; c=relaxed/simple;
	bh=myG4apjTuZ7Ud+/Es7YK1g/F3D19R+JaYDcqnvk9FrA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SUk62JlGKB07JLvXev5EZZ8GAmNNHbkctQIsGxN58HwPif0fD/zN8RKP+MZYZFU4k2FUnHHMFqFGZiIjLJrT5XJ0o6IUTlks2te2/JnBwuVjQgTdu2cCplKqC1hWSg9UpKFiuKUpJIF0ftQ+6j/l9m56E3nZpqVXH8QoyipyOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=Jr2U5/uR; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="Jr2U5/uR"
X-Virus-Scanned: Yes
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769680236; bh=myG4apjTuZ7Ud+/Es7YK1g/F3D19R+JaYDcqnvk9FrA=;
	h=Subject:From:In-Reply-To:Cc:References:To;
	b=Jr2U5/uR6Tai3VRye7wkGPARqp/Br3Rr1QKtjY0K0kbr8/X3PArPeiqyMkc3VbV8E
	 0YuK9CCaDeC+CZbgaQH/1fX8gTwOJM4/SeSSbOE7lc/Meo5MZ0xcGIvk1Mck1v5D8S
	 XDvq+xJ4Fsb01Ut3VynMBAeh83/v7sGYvS30lKSdWaw4Oo8+Y4iXx8iSBO+6BRYQmQ
	 1fgc1+wjA4raT6A5WCDASuwUMJe6hBTBUaZXjeW7VYWapPUBMUmxr+EbBYngHEw4fj
	 yDdUSwvvzHHtY6v41edKtzUISD4JpBIyToPttzDY+3CdO22Ec1q3JiFEfO5JZWddcq
	 sYYjw9rEIkzgVf/sGxyfnIKNFicHJz2CDOHVmogL5BT/vPFcIWIkFbZ/ZO2GX9MgCB
	 iSLI6ZKANiwXQjmOl3N46M2oGBtC8kpxUa152GwTP/u/lrdZtROV7oV1a4NxDrabrW
	 HYpwvd3d7X4V6IBydE0/C4KK9ESaCBP6j+YhGRJ/EOiLLCDa2u2PN1muDh5ybECrzo
	 awc//p3WVn1ClJM9R2diP6h44rJ1lZoNw9BYdfj8RxSQTgIi/yV6OSHiXMCy9rPysl
	 noWoBFuLsuMmBTpcfs5/iwX6lTKbmMq2pyvpFnnjaX1wHNRsuu8h2JLfen/J8SZLBy
	 iV818ntnFrqjKRKPi9XfbdXM=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] selftests: ublk: derive TID automatically from script
 name
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <20260129031501.3403688-4-ming.lei@redhat.com>
Date: Thu, 29 Jan 2026 11:50:23 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Caleb Sander Mateos <csander@purestorage.com>,
 Uday Shankar <ushankar@purestorage.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <049F669E-AE1D-4FA7-8F97-3962ECFCF561@zazolabs.com>
References: <20260129031501.3403688-1-ming.lei@redhat.com>
 <20260129031501.3403688-4-ming.lei@redhat.com>
To: Ming Lei <ming.lei@redhat.com>



> On 29 Jan 2026, at 5:14, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> TID=3D$(basename "$0" .sh | sed 's/^test_//=E2=80=98)

TID=3D$(basename "$0" .sh)
TID=3D${TID#test_}

Scripts are using bash, so can save the sed call here.

have fun,
alex



