Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669441C29F
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173662; cv=none; b=fa9LQ81LIw0NA0kfjP5CnNRb0MZdZF0Tk7F+2rqbOvj6HEDJ50h16+g4xXPFvzyhXPMzn+gXQi+sve9nuOWT48ZLo5QjQVVEZW+JdxlSQ7L6E8FGqMk8zOcLyYwTYC6XO/Q2uIb8G1mA7O9NiNmhqQnN5PXq4lZK5vAYcnSDArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173662; c=relaxed/simple;
	bh=vAeDSSN4CvvWCtqCLAIaHEzK7l96MnUrA7S/EltXCN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type:References; b=kHQ79jY+BpScfEZd314NypbC/qVNxXVtWvXZYvVHbyuNLnqB0XpdDnuH/Ttr4HwPYKLMalfTpaE13bAypWx7S4iWTM7IywiZFYpWwqCDjHPdZ117waJkUh3K3ufIm4aZYgnzagJY/stvthKX1OYvETDkgOb5kvwbGqvYuNON0F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EO1BmP1x; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EO1BmP1x"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240125090737euoutp0192a3cc2a338fd337db8ac0898c1b9b32~ti_bXYiAX2652526525euoutp01K
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 09:07:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240125090737euoutp0192a3cc2a338fd337db8ac0898c1b9b32~ti_bXYiAX2652526525euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706173657;
	bh=PFsNUmgLCKUdzUro9n3bBkakNSd/IUhVnsDoeOvBGGo=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=EO1BmP1xTKQHvWVqyFFhFtakJ+rPKJOdyPy+UalE2vbmhTQSoB742EpB5MyID/TnN
	 J/aEV0zqUt4YDXWiKCWmrfeKhabznRrnF0c7Oqk++Tb+EsRsa7iH81/TeVTR3VwqFp
	 J94BDSPT1EjlxPEAgN2GkfA0ZCG0c/FDhxEIhnEA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240125090737eucas1p26797a7b213a2eaff0ae76173d4ea6e31~ti_bQNdPO3127831278eucas1p2D;
	Thu, 25 Jan 2024 09:07:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 29.8D.09552.9D422B56; Thu, 25
	Jan 2024 09:07:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240125090736eucas1p2db13dcc5d62272ce330da83b2bf7b1cd~ti_a7_Ig83126831268eucas1p2B;
	Thu, 25 Jan 2024 09:07:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240125090736eusmtrp1280fbd7639d3324b94b66efff61387c8~ti_a7eCCu3004130041eusmtrp1T;
	Thu, 25 Jan 2024 09:07:36 +0000 (GMT)
X-AuditID: cbfec7f5-853ff70000002550-7f-65b224d904bf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 29.F3.09146.8D422B56; Thu, 25
	Jan 2024 09:07:36 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240125090736eusmtip262c9f11a2356eca44627386b96fcde56~ti_av2_yC2714727147eusmtip2A;
	Thu, 25 Jan 2024 09:07:36 +0000 (GMT)
Received: from [192.168.8.209] (106.210.248.230) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 25 Jan 2024 09:07:36 +0000
Message-ID: <c3a537ee-7b93-4337-a795-cbd2647a8201@samsung.com>
Date: Thu, 25 Jan 2024 10:07:35 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: can we drop the bio based path in null_blk
To: Christoph Hellwig <hch@lst.de>, "Pankaj Raghav (Samsung)"
	<kernel@pankajraghav.com>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20240125081502.GC21006@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZduznOd2bKptSDY4t4rdYfbefzWLl6qNM
	Fmdefmax2HtL24HF4/LZUo/dNxvYPM6udPT4vEkugCWKyyYlNSezLLVI3y6BK2Pp02dMBYc4
	Ku7PW8vWwPiCrYuRk0NCwERi1fovLF2MXBxCAisYJRYv6GeCcL4wSvy8O5kZwvnMKLFm/WsW
	mJZlPRNYIRLLGSXaXzxlg6u6+XA1VP9uRokjr84ygrTwCthJ7H08DaydRUBVYuKzNawQcUGJ
	kzOfgMVFBeQl7t+awQ5iCwuYS6x5cBKsV0QgUmLFvQ4mEJsZaPXVd9eYIWxxiVtP5gPFOTjY
	BLQkGjvBWjkFdCTm9N+DKtGUaN3+mx3ClpfY/nYOM0i5hICyxNSlXhDP1Eqc2nIL7GQJgQcc
	EjdOHYX60kVia/NGVghbWOLV8S3sELaMxOnJPVA11RJPb/xmhmhuYZTo37meDWKBtUTfmRyI
	GkeJ63vXQu3lk7jxVhDiHD6JSdumM09gVJ2FFBCzkDw2C8kHs5B8sICRZRWjeGppcW56arFx
	Xmq5XnFibnFpXrpecn7uJkZgYjn97/jXHYwrXn3UO8TIxMF4iFGCg1lJhNfEdGOqEG9KYmVV
	alF+fFFpTmrxIUZpDhYlcV7VFPlUIYH0xJLU7NTUgtQimCwTB6dUA1OsjMmhp48CuNvfHL9k
	cTF0j/zeKK2udD3N/VvNWr1ahNapTiqJYm+ZYLFRp5Npxtn/9wV95n2bUyfotshEbtvr2eIB
	Huz3FU6XJjC5VKddm77n6LqHBre92RSXBd+q6T3q6+vRZ5G++zOzvUaNv8nuuUd6HYyv8G3b
	du6V7vFohct1H1s238mc6f+76jL3m+XnRG9wn6q0OblR7ekCjhmiZmY1806ZaMSdWnLOqStE
	s/H5x8q5zYKXYzaeDeTV0eOtKFhwJuLRzq6H7NlF519eVF7zM9IjYGfkt7um08xmllx/HBDu
	+5WZv7HGd9LGpWqsPMaKUyPXS+U/NmFrZ3o1YfnSCa9mXud/xVj12FGJpTgj0VCLuag4EQCC
	W58omwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7o3VDalGqzuN7FYfbefzWLl6qNM
	Fmdefmax2HtL24HF4/LZUo/dNxvYPM6udPT4vEkugCVKz6Yov7QkVSEjv7jEVina0MJIz9DS
	Qs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL2Pp02dMBYc4Ku7PW8vWwPiCrYuRk0NCwERi
	Wc8E1i5GLg4hgaWMEqt+r2WCSMhIbPxylRXCFpb4c60LrEFI4COjxNkViRANuxkl/nR/YwdJ
	8ArYSex9PI0FxGYRUJWY+GwNK0RcUOLkzCdgcVEBeYn7t2aA1QsLmEuseXCSEcQWEYiUWHGv
	A2wxM9BFV99dY4ZY8JRRomXiSaiEuMStJ/OBbA4ONgEticZOsDmcAjoSc/rvMUOUaEq0bv/N
	DmHLS2x/O4cZpFxCQFli6lIviF9qJT7/fcY4gVF0FpLrZiFZMAvJpFlIJi1gZFnFKJJaWpyb
	nltsqFecmFtcmpeul5yfu4kRGI3bjv3cvINx3quPeocYmTgYDzFKcDArifCamG5MFeJNSays
	Si3Kjy8qzUktPsRoCgyiicxSosn5wHSQVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5Ykpqd
	mlqQWgTTx8TBKdXAxH9FfUtm4wXBPY5/K3ayvZt7Ku3ml2atyHfybK4qNwSXb/x/T3zTrX1l
	zL+V7xjZPPPlWn5/8Zqbr9cHndFd3ml1yMrqSSmz1mr7n6GaPpXfH+h4GT9m3/M5umbPP19G
	4wrp+xd2c66+bcT9+i3jjCdxe74dzxU7c6Yw/+CxFptL9kqCU/eevS2RwBU20/eDu2nVuTet
	C6pOnI/af119GqPYjIMyInMnq/i2Tco6pybrVeac6OPwxeHFVJv5Jds+xB6WcW/t87gfcmLS
	OqOfs+33H758eR9Pw9m/+epiS8P+eP7YyDVfOo533QaN9ZbvIi+VL5u2Sy6wkFXU4drVO9ue
	sPxabCW/WX82e+oPFz8lluKMREMt5qLiRAASTZhHTwMAAA==
X-CMS-MailID: 20240125090736eucas1p2db13dcc5d62272ce330da83b2bf7b1cd
X-Msg-Generator: CA
X-RootMTR: 20240125081512eucas1p1991b4134149cefdc11db7b5e96fb6d81
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240125081512eucas1p1991b4134149cefdc11db7b5e96fb6d81
References: <20240123084942.GA29949@lst.de>
	<znc7pqdsqkznoszbzhvxyyphmpqbesjh56ygn5xt5fjej4glvc@mcccy2dky5eg>
	<CGME20240125081512eucas1p1991b4134149cefdc11db7b5e96fb6d81@eucas1p1.samsung.com>
	<20240125081502.GC21006@lst.de>

On 25/01/2024 09:15, Christoph Hellwig wrote:
> On Wed, Jan 24, 2024 at 09:31:25PM +0100, Pankaj Raghav (Samsung) wrote:
>> The subject says removing the bio mode in null_blk but here you are
>> asking an open question about the non-so-relevant ones should move to
>> blk-mq. My input is for the latter part, FWIW.
> 
> Well, it's two different things.  My prime concern right now is
> null_blk, which is very clumsy due to the two different I/O paths,
> and actually broken in that the bio mode doesn't respect various
> I/O limits that can be configured, and at least in zone modes also
> ones that aren't configured but required (I/Os spanning zones).
> 

My 2 cents: The drivers that still use submit_bio are mostly memory
based except for n64. And there is only one blktest(block/023) that
tests the bio path (Shinchiro can comment here if this is wrong).

So we could remove the submit_bio path in null_blk to simplify things
as most of the drivers that uses this path do not do anything complicated
in submit_bio and are mostly memory based.

--
Pankaj Raghav
