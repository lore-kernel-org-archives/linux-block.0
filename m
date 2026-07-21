Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CE3415F38
	for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656328; cv=pass; b=na8PDdcxLfQ/iSVUyZ6qSivx0kCVLWD5OuUQ/UZvBkNFeWH7tLSN6adC12gs2Y3XjLv5kEbgiAPEsWDmUQ+USn1VPGNhpBOyUCFfLRYw1PdNqYRUJhEAVhpee7yo9fwJP561xwylBEu2KDAx+207iZQpDm7jGm1az9WfO2j5yps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656328; c=relaxed/simple;
	bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQ+psMrEzXAmK2PE+Ieh6g8JwuggY6ChyF5JHjrff6h3Kx2XdbyJBOFVPeHhY8DDeRCM1MplzoUm2N6wIeTW65Bns9/Q9xLk0ZDiVpJJ1xZdkii006KUDUNyYh69WccoiPNFN+GHHJQQZWz+NvMTe8ZNHA2oPn/2wAbROPsKBhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=ciM98YPw; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="ciM98YPw"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-381216921aaso11061229a91.1
        for <linux-block@vger.kernel.org>; Tue, 21 Jul 2026 10:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784656326; cv=none;
        d=google.com; s=arc-20260327;
        b=je6fwJTvzTHKshp2CUKRceA4WbEuXBQVFKLHhAfcWAZG9RFPsYwEcaF+sLK7jbicBc
         sGl+upLvXbYRU16yzOmhAzXxu3WICn2jutFhIZ33INjn7Peb+rCMrl5ejv6aesBRQV0B
         FkKbxBP5TqyT393nxc96EOPP5KMXSMeVNbFCtOqm7DiqoQQsittPnIqlY63FqY8Da6oO
         JStGJPA513BuNS4YKGV72/9NSvw/1m9odIcOZZWFOekMeKQ5x1AMF7xAZ6Nyhl5FKOpT
         o4+exZxvOZIsowE8XqjFiwxziEB8jBmwAGBLJcOkX8IdT960lPxADQTKuhVuKHMBmlwS
         2tOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=;
        fh=RoqflwDWCC6ekPgln0liynYfwV50FXQdEQv96HQrZ5E=;
        b=Qoy8yyganzKNNI09uCekGTM2LA0htXcRaBOwv5PcLp6Q2Bd19JZbL+S4rHu6iCdTwu
         hYZaRTrAfEutkd+cQCjGTK0Q2KI793AvxqX3r8lLqrY7lqWZ18brwvYUHqTCfiwrutrw
         u0EMQNbV2whzwUCQiWSe8V/tp9Tm1BsIlBvWAxHpLz50oUh1c2gfCCWI3nejQoDZmxHg
         +N9E0rtypCjWAQB1lelzLzKUal1QRE7IFVkX0KBQTulaI2o/L9oMfQYaxjtm/fYunFKW
         /6FYyRnYHGWF/0Bs5CrHqDgtDPQmWZpE9AaY2iaRDQ+/McT+mI2PHY3i/LYAeJVXQ+yk
         vbbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784656326; x=1785261126; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=;
        b=ciM98YPwwqhVDh39wBw+AH4bzjh7xU/N/H9aik3M5yBvwF1UCf4YAQy5msJ+4GYErU
         GuzrwUMPXRtMbduUVSvtYyerXesojT+AKo6LuobEd3zGS3krQ0v3K3CiO0MoGDlvRR2d
         YwQWsf92fTVscp0PI6EsFqtvArWWi6JlPi+0lXIbcva2+LjMWSheh2y+qebh1iwX6nlv
         /zue2udrnV4TyGi1x/P02OjHk7AWixl7D0avY02fPtazPCrtdPjGHrczQoJgYws2T32j
         ci6WxZ4oInTDjyHSWWDQIN0Y9wR5ZuXOLLouoEKSkL29s6p+QTsUV+pD5bCx2RTmybWX
         MQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656326; x=1785261126;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U1weix+8QOcbtdINHI0GYDYejwzqLj6PgDCfT9nNcoc=;
        b=rauR7KW9Hlzn/uUertMDHuszLqNA7w/ZMGlgoZ7xIwzc03f8L1KQ2vcU5nqBFa63Qd
         QlEzVulk1Tj8lI9zPiONTWsJY0pDk7f0sH/tXS3+1wFb7d+m9xfd6iTWLeGhVKDYZAQX
         xCsq/bDW1qa9aJzwssxS1Aoz6v7iv7VqsdzTfMBZkfn4cLHMsG/SJfoBzKNKHUnQhLiO
         /5uhOZCcGghvzqy0WslP7ipfKsXZyuaS7rCwC+MSQjLS9x09nrf7BqaxEK5xkhj26fpS
         F4EooJdE5Vv9Do+l6SvtUb2Fq1uQUg47GobetZFGrWYBElUPBkCGr3mDD4Hqhvc/ljeL
         6e4g==
X-Forwarded-Encrypted: i=1; AHgh+RqsiI16dbAXH26pBZM/ME+6htADgSO3fYDKJOKwTXDLuZ35V9yDnENdMNX09qP57mIHJ8iRjIFOO5nMmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtEXE+MfE+ErEgy6XWVzL6a1AEgvlkmJwJbWYNE2XT8L2KWKt0
	z95kzpALyxwxUZmD/moNsPrPpU3yOXHjgX3EklpP2oQj49Q9V1vIFWRtGDP2anpcwYpHGk/iH7L
	h27IgoxmMgGSh2FABxPGCP1o/GCSJ9V61hL8mkg2N
X-Gm-Gg: AR+sD13TQ4l/kohoFQD/9e9JQyRw9EmIZHGdRDkkZPCPWppQ8ZJYh3iyDEsjR9l/jhR
	aGkLCh5D8WdihFf3gk+J5ubay0+tH/QTPR92b+C3OpNNt4So9dX6vo102MprVs0S2W4RgLJRa7h
	DW17tCfujKQBjDCrkwzPSLM7zGKn6T/vka7qNAF+8wiPz/Yf7Cn95UyohB5fA0+jRPrZj2t47p5
	xlCJFtG2S5gdgftPlYZDa/ioOax7ZNgLylIu0E+pjh40nx1XS7Bp+0A9qwmAnViwh27zrP4LSLZ
	YiZc3osyuJhqVQW8CT9xUgeUguio0pB5L8R/XdUK+Tw=
X-Received: by 2002:a17:90a:d2cb:b0:37f:ad36:8fc5 with SMTP id
 98e67ed59e1d1-38e4b515bfamr20269142a91.23.1784656326031; Tue, 21 Jul 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718162547.448892-1-mykola@meshstor.io> <20260720124304.GE110966@unreal>
 <al5IJb-L0FpztnYz@kbusch-mbp> <20260721124944.GL110966@unreal>
In-Reply-To: <20260721124944.GL110966@unreal>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Tue, 21 Jul 2026 19:51:53 +0200
X-Gm-Features: AUfX_mzytkhLoaPSiTn9RmB0hwu7xEFpMpTLbojjFKRzqIcqMRM-jx5SaIRHGbs
Message-ID: <CAPzsNDuY9OB8FWb8aPTpxpVYC0u1ewCmFnvQXfSKQO6xqEJhBA@mail.gmail.com>
Subject: Re: [PATCH 0/6] block,md,nvme: correct handling of unsupported P2PDMA transfers
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Henrique Carvalho <henrique.carvalho@suse.com>, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 21, 2026 at 03:49:44PM +0300, Leon Romanovsky wrote:
> Yeah, too verbose and conveys almost no useful information.
>
> Lately, I've started ignoring such submissions to prioritize commits
> from people who put real effort into explaining what they are doing.

Point taken, thank you. Please check v3, I reworked descriptions.

In any case, the problem is real, Leon, I would really appreciate if
you could review the RDMA changes.

Mykola
