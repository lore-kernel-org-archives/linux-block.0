Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.108.3.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792890712;
	b=lriq5j5NsALn6rSWuojitYYRywnarp7CSk2A4Z9TksywjQDh6OlpnmLcHzeNtuSmLWFm
	 opWZOaf2gG3t7eiQTSOl9c5BFF/pZKaOnM+0EkGTfKqFmeiS832EI/hFch/dmN4yh8Wwh
	 IZPylPet2EmEdSG1u43kHuYZ5W4hpdWd7sJOPFfaKlwKKwQEnwuIPRa/w2lcCHCOB3wV/
	 ZMAYHEIomJIkk9tB56DkPq/MP+ZptxZsskRhbOsEOZbDKcI52hoTDbB1RRjaLkxBEEBgG
	 8ry1bhixMUs471MfN8+2nFK4u7XsNmQvJ5OSCmi5fbWBVDdhXz6LcIxp4RoFhPejXZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792890712;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q8QjgI+cguG7bWbedFj22oT8cvaLq++BS/0yoHckLkk=;
	b=bxEZYlNbFbWyekfv6ZpK0MEmBSDqSBIW08AG1xrvjkNj8bbzCNy8inM8sbo/Xbtdkeh7
	 sQ6rES11Z20y/SS5VlMCL0Z5F+h/kDfBX8NriYylQj56baQxuCe3UqBnzfvlUj5nh99Et
	 Yz6Im+Q85c98zhG7+YarIok81UCQZuUUAfmeB3H6iYusuNKzuroGK7ij0W3SxLlJhIBym
	 Nb664PSk8TpNn+pU+tfGFM5bxxZjNGfyvDtOlxRSS0XBORhe0DuqpZQtXOz1ptOP0h1yD
	 k4zHgoMX8u0phCnpGxVCa4TB8tmXFnPJff6mEvZM0t2aEO0YPJzDivS9U498cSjPVug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	dkim=pass header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=Dt9pEpyA;
	arc=none smtp.remote-ip=202.108.3.162
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509DD606A31A
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 01:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 509DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=Dt9pEpyA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1792890709;
	bh=Q8QjgI+cguG7bWbedFj22oT8cvaLq++BS/0yoHckLkk=;
	h=From:Subject:Date:Message-ID;
	b=Dt9pEpyAAM/AH81vRp0/3ZKnWVUn99TIr/m2pJm41Yk7nJ4oNx7GjKJGBKTEMPntl
	 q0L3UBYZ5WAULybxmpYuNBEEMcwyUe5xepUUkac73j0SxhX/u6c55VyMXtPolJlEGL
	 xCS3gta6qCav1KnJ9r1vHlMYA6n5AJuJLrCDC+mo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.254.1.249])
	by sina.com (10.54.253.34) with ESMTP
	id 6ADD574800005F4F; Sun, 25 Oct 2026 09:11:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4931906291679
X-SMAIL-UIID: 5492C95F558C4561AB8994FC81A21430-20261025-091139-1
From: Hillf Danton <hdanton@sina.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Barry Song <21cnbao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
Date: Sun, 25 Oct 2026 09:11:25 +0800
Message-ID: <20261025011126.1100-1-hdanton@sina.com>
In-Reply-To: <20261024101401.1035-1-hdanton@sina.com>
References: 
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 24 Oct 2026 18:14:00 +0800 Hillf Danton wrote:
>On Sat, 24 Oct 2026 14:48:32 +0900 Sergey Senozhatsky wrote:
>> On (26/10/23 19:40), Hillf Danton wrote:
>> [..]
>> > > writers vs readers 3 runs
>> > > 
>> > >     BASE+PE     IOPS 1,271k  avg 5.57us  sd 1,393us  p99.99 27.5us  max 1,581,800us
>> > >                 IOPS 1,461k  avg 3.43us  sd    78us  p99.99 23.9us  max   227,015us
>> > >                 IOPS 1,444k  avg 3.48us  sd   222us  p99.99 23.9us  max   592,628us
>> > >     PATCHED+PE  IOPS 1,457k  avg 3.32us  sd    18us  p99.99 27.5us  max     5,620us
>> > >                 IOPS 1,464k  avg 3.31us  sd    17us  p99.99 24.2us  max     5,621us
>> > >                 IOPS 1,475k  avg 3.29us  sd    16us  p99.99 26.5us  max     5,620us
>> 
>> BASE+PE looked noisy, so I sat down and tested properly (also tested
>> zstd and various compression levels).
> 
> Lets see the data from another pov (feel free to disagree) -- in the android
> phone/car cockpit environment, the render frequence is required above 60HZ,
> IOW a frame rendered within 16ms, so what share of the 16ms does the IOPS
> account for after this patchset, for example when an app in background is
> brought foreground?
>
I mean cpu cycles are burned to reclaim pages, given zram and swapout/in, OTOH
given whatever a GPU, slow or fast, if it would take more than 16ms to render
a frame, then there is no cure for the dilemma.
