Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552914286
	for <linux-block@vger.kernel.org>; Fri, 23 May 2025 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010161; cv=none; b=X8pVysw/a5wGcfEDvTD/NbXvO7RXMiBlfmC70e83ILTRMFSq2eeJAp5VrSuHa8vL17uXC7IINYPJyEzpJOaBXuBbpUoBbdz5ZPF8mmpj6O5Oswc4aPpO7UGLYI6UzCWDNyKDp+3+GUxAOEOInbvdvf88yuazfieydBWTr1s43os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010161; c=relaxed/simple;
	bh=z3yAZ7jqjRAVq7lG5FikWrtEB5Q/BhNcOjJlolcCzIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyWWnWIR+ybIF3CRBBG5xOJrDi7IWjvrrJljfERsPgyMtG2sIKymrBQmA22+PouYF00a8Vt2NsexF/HI5QNaHpVHqJSsZPjQYd+Dg7Jmg8ao94NJ67wtQnbxG6jz9ottte3KPuQFMP6u4TJtcx/tli0GZkH+HamVYBp0It5iXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PmBggujF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PmBggujF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231b7b21535so6452795ad.1
        for <linux-block@vger.kernel.org>; Fri, 23 May 2025 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748010159; x=1748614959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJDfkgUwozZzeZBpK+xDymRSUD5EkwZtCEbmySTlTfw=;
        b=PmBggujFSFVpyriC1jpq8zjs8gq/lGIHNw5lU9kgzJmn7MN84qbNZDm49w4MuA8mvA
         jd3d+ie40tsZPO61irKsskmccoxAiXWzdkDSXZJT55iiwLBj8B6C7euMi6sj7aJpuv9G
         RohlI7LnqAdZaSc4ZeTyyy6OJkbIJCE4HXAuB0Z0dZTIuhQCu9pTckbQd9wjNXb1q2uF
         lH0AhTTIGUAoL5q/5wio+CbtwkitOzq7L3R2c+/h9Bu+eZcdVPsEsYttPEM6AGqahYFM
         g6O0mRqpDxSHmnNmxMoCWAR0xBryLfuHP0pCJoawZ9rfrrTB0WcDXEbfudpZ4ummL5fB
         2C9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748010159; x=1748614959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJDfkgUwozZzeZBpK+xDymRSUD5EkwZtCEbmySTlTfw=;
        b=FXmLVBYDzC6MJwxvwuWFNPfj/V7Kr2jOLEYHybiaXdRC0wa2JUNbtGNT89lbprbZ3l
         mxGQhl4w/u60azWKMxf/lx86ASLUPtK0LSzaK1QKTVCkPiAPCh98F/olr3c9yBCT+ON4
         9+iSgPzEtGaIKzEa+QnYwiJYxJBZriWMDKMA9QSwbuk6w2htRxukktwcaIRiwPbJ1FJo
         5cBDtSDr4+l7bsiudmPtCaqk/Z7xaZjbPJQcTPjZpwd2zlgSIZoAF+afo9/ibALH0yM5
         tt3ybrsJOFUSqXOLS861Edbgq60NM2P/rOsW9MqkUKIowg6J6qINcgOpZE3Va7zK0QV6
         KdVA==
X-Forwarded-Encrypted: i=1; AJvYcCVxVB0HMRpFtzEKTAETbjBcEX1ClyAeUCvoBKq3goaEFtSnEoq2f+vvhj5HvsolG57aZBLEMQQ7HAJZPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEy3QheUtTbXFDlkzxj1Ww0CcJvOvEbJp9FjRIJeg1PBE+wzx+
	Yhvr3ijWxKd2F4MepHQXVPe0fVpaQB+q7hZVjyPBZF6DCY8Jb6zeLmrlY6Gz03Gm5Po9Dn67Qq7
	o8ZelsJZ4YagOOUZZYH5irdMcUvTfo4lYvRWQzdglJg==
X-Gm-Gg: ASbGncv9lNRgfvBVRVBrSc3ELB5wDOhCOEgCUa0sxo4WZtpX/7kaHtvGPak5Px9PSRW
	qiT/eepXxul2S5P/Y6v+rgHh1JA5dzsroW1GhUrmeB+958PJyYcpI1jYsMKAoTg3ZiiYIGRjlAe
	EOMQt8L+EDqe70TNwr5eZKqniPh77RIZI=
X-Google-Smtp-Source: AGHT+IHVjcBX/czUHf7pHZJvI5G11eB5EPBJfllY0Y8QwUzFZTEC/O8svL5ryEi2wpmnQsiLzD3bzULjV8c0BQUJT2Q=
X-Received: by 2002:a17:902:fc43:b0:22e:62da:2e58 with SMTP id
 d9443c01a7336-233f36e4923mr17730315ad.10.1748010159343; Fri, 23 May 2025
 07:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521223107.709131-1-kbusch@meta.com> <20250521223107.709131-4-kbusch@meta.com>
 <7aab2c6c-4cd8-4f23-b61b-153f6e9c2ce7@suse.de> <aDBvHWPjYQwJQx7N@infradead.org>
In-Reply-To: <aDBvHWPjYQwJQx7N@infradead.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 23 May 2025 07:22:28 -0700
X-Gm-Features: AX0GCFsqtdzTcd53wJfGkmsKkSxEdxSzR2SdxOJ7MSkj3OZ_tFnZBmaupGbQwss
Message-ID: <CADUfDZr5n1whmFszEWaY3hjSHQAiLYjfvEAA-VHfEB6_b4m=hg@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
To: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 5:50=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, May 22, 2025 at 03:54:46PM +0200, Hannes Reinecke wrote:
> > > +   if (req->cmd_flags & REQ_FUA)
> > > +           control |=3D NVME_RW_FUA;
> > > +   if (req->cmd_flags & REQ_FAILFAST_DEV)
> > > +           control |=3D NVME_RW_LR;
> >
> > FAILFAST_DEV? Is that even set anywhere?
>
> That is a good question, but this is consistent with what we do for
> other I/O commands.

Looks like it might be set by blk_mq_bio_to_request() and
blk_update_mixed_merge() for read-ahead bios:
#define REQ_FAILFAST_MASK \
        (REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)

if (bio->bi_opf & REQ_RAHEAD)
        rq->cmd_flags |=3D REQ_FAILFAST_MASK;

Best,
Caleb
