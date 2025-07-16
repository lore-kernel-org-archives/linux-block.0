Received: from mail71.out.titan.email (mail71.out.titan.email [209.209.25.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F1D28BA8D
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668214; cv=none; b=jYBAKIPJdHfUo7U/2Y5pTU86o1u3DV8iQzdXCIJlDc4ac9taGPnP8HhPw/JmaWruCtiE0FI0fY0u5I/wEVFoPgAvAL5kW8nYiqAXwpXkv3+3EI0SiWZwWXEd9/zdiKtly4hJpyYbLsllA291/eH7IKKNpymwK+VManQHM5QkcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668214; c=relaxed/simple;
	bh=oQEVVZf0K5ytc4KH1/QMMwoLgDw1GDNpLoPUno8MRJo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=D4pk1XF35qGmOpdp9FpxRsvZFSEuM2wulHKN/BiNWGQiFUHQFXhokkkhW8+PlzQQ9km2DNscpj/kSXNlaFEBt8v4HDQwi+BOOSq6lbu0KCwW3Jh6+iTiNpWxn9g8FqmdkwuRv3VcWj63/rl5RS5LjvqvqzpNTKaS9rs1SvkUAyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=pQDgMHYA; arc=none smtp.client-ip=209.209.25.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="pQDgMHYA"
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 49669140082;
	Wed, 16 Jul 2025 12:16:51 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=oQEVVZf0K5ytc4KH1/QMMwoLgDw1GDNpLoPUno8MRJo=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=subject:date:message-id:from:references:to:mime-version:in-reply-to:cc:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1752668211; v=1;
	b=pQDgMHYAOBJCTi3g3sptSs7SPo4HbJBPCUUSTlojEjzgTA41xX0RHMyYCedgtplzI64sHgnd
	i5ouVAEzTMq82gtSplc2K93W5g0dfkmtqkxjFOkEzXGylpf1T5gIp2ptvkQEQyP2fOV5HOP9i+I
	BeXxBJmLgXv1SBU/o2jasTU8=
Received: from smtpclient.apple (tk2-118-59677.vs.sakura.ne.jp [153.121.56.181])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 47DEB1400B0;
	Wed, 16 Jul 2025 12:16:46 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [RFC PATCH] md: split bio by io_opt size in md_submit_bio()
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <20250716121449.GB2043@lst.de>
Date: Wed, 16 Jul 2025 20:16:34 +0800
Cc: Coly Li <colyli@kernel.org>,
 linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org,
 Yu Kuai <yukuai3@huawei.com>,
 Xiao Ni <xni@redhat.com>,
 Hannes Reinecke <hare@suse.de>,
 Martin Wilck <mwilck@suse.com>,
 Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE36C995-4014-44DC-A998-1C4FF9AFD7F9@coly.li>
References: <20250715180241.29731-1-colyli@kernel.org>
 <20250716113737.GA31369@lst.de>
 <437E98DD-7D64-49BF-9F2C-04CB0A142A88@coly.li>
 <20250716114121.GA32207@lst.de>
 <D12A8BDA-5C2B-4FA7-9C92-731BD321A611@coly.li>
 <20250716114533.GA32631@lst.de>
 <danlsghtalte7sku3vlfxkgngujgwzspanfayaxy4jfnk54jbf@yfvmr5plavmp>
 <20250716121449.GB2043@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1752668211096068270.32042.2261184212370483605@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=U6doDfru c=1 sm=1 tr=0 ts=68779833
	a=hXS1xhdqaCDGgKeHTjTB6g==:117 a=hXS1xhdqaCDGgKeHTjTB6g==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=Lo_h2dasU0whG7-bwv8A:9
	a=QEXdDO2ut3YA:10



> 2025=E5=B9=B47=E6=9C=8816=E6=97=A5 20:14=EF=BC=8CChristoph Hellwig =
<hch@lst.de> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jul 16, 2025 at 08:10:33PM +0800, Coly Li wrote:
>> Just like hanlding discard requests, handling raid5 read/write bios =
should
>> try to split the large bio into opt_io_size aligned both *offset* and
>> *length*. If I understand correctly, bio_split_to_limits() doesn't =
handle
>> offset alignment for read5 read/write bios.
>=20
> Well, if you want offset alignment, set chunk_sectors.
>=20

Do you mean setting max_hw_sectors as chunk_sectors?

Coly Li=
