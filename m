Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8D3CF6C
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753457; cv=none; b=chhjMtHZjVIxGPyz02d1EBBWsQVOjuF90edm901r40tNkpLUyGwxGcQWrrKPLr/Oxpl77ZVsjWtAQnSn2UljY+4/vKCFTtwZGgCS62WhawYhqFbgjirD9X+89KDM1aymb6NRahhGkkypXuMiOkVcn4HV8iSzIhacER1Fk6YIF4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753457; c=relaxed/simple;
	bh=e6R/iPNI3hQSc4/ZfaypT+HmeA9j0H3vnXa/ahf/PvA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lNO8BcscZKFmNg3sElC/UgLxlr6sBk6SGjN8ggYpsNF/Rd4yCSBxYfzMDMf9DSzkLoeVT2PtVlLjf/gaOBAAvL+44A3S0ZbiKjDvNOIx6hVXzaU+modwzvBupOvY0lQ7fLBv1cnQkLLTQ7UYvCMU4Vs2j1hzlCpjlyiXLS/y05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2jUqRZcc; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2jUqRZcc"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-363f0a9cf87so5442105ab.0
        for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 07:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707753454; x=1708358254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaynTH9pMydfhvq1EdD/6Y3LrUBXYd3m2w1fILaHNjE=;
        b=2jUqRZccORffYC5wO4HHH23l4elshWjGa22OTq2K1a/Bx2vgBXy7ZPjxB8am3o+OkS
         XliVnZHH+QSQiybzpDnjiIqm1WikKgnyffO+PUKE3wVHv9E+tmzRCVPuENTf2cEksq1k
         4rQo5oIDY+PXqkYqEZFZU7goiqJWuK2TqN8IrO2W2z6f5hSq0iScrIdwO4+O4jY8fPY2
         LvuXlexPgQ2UULWzCrNJCmSQhPKtpfS9Cbs/Ye7blFZMoMhAqfJxniVhok1R8C+b5GJ9
         we+dnadIasH7IJn0BwK4SgsY/YaJ7dxSB0Cg+w8KTZZfNaggJW7j0CasO6HQF1opHAdh
         8OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753454; x=1708358254;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaynTH9pMydfhvq1EdD/6Y3LrUBXYd3m2w1fILaHNjE=;
        b=gq/NUVl4sf/PT8Ve8FHEiltkbACn5ABqRmLQOdVSUnYID6+AFZTsSNYYSkgiWa/W6I
         xUSgvX+XzjS4prOW3PdHFNtYgFNhrXtPRzk0V8JUCQLIZOVaTAphuHY8P6+SdeyY4AxR
         wb+mzCQ2xC5jvzsRhkQ+4QuDiCUjLfIK2SWdD1dB9736j2heT0r0I+5aHvWWgUSeciej
         e3fncOEY7aPhVT0JOPT6Kae74WdDZXfwIhUjOyHOcTN1qAXWU7UCdsK7Pp4iQkTokX3X
         orgkcS4sxLHVa2w3UBVIdnt8LR4FBuzNfdvpHZ4Vh1oahK5wkrm2MCUtMmAQOp9Nj8XL
         1lMw==
X-Forwarded-Encrypted: i=1; AJvYcCWeXSKoHn683Dynaxn8nZ/RMqniJoqlgzmcVtMzlnY7pE/SPd7iLIgrT3M9IU3FrTCS4pmnsix3IWQ3bV7frGMkzw9Y9uASifUS570=
X-Gm-Message-State: AOJu0YwLeYwuXMskWhYLYHQWaglPTcMHONtrbIMXVQQe9GNXtZzvxBeC
	xJ6D7/jbUkCF1Jt5KhfWMmKJOftWhJNemCVTMuGW0bjI4ke/8Dp8KJIV5kfVRaY=
X-Google-Smtp-Source: AGHT+IEfRx3FWxgGHWmntgqJQoFE7HENnxyzWuguASDfqyWZ7rcmJVU1YUwn3EUOd3+i552Y0c8+2Q==
X-Received: by 2002:a05:6e02:1d93:b0:363:d7d2:1ddb with SMTP id h19-20020a056e021d9300b00363d7d21ddbmr7164162ila.0.1707753454127;
        Mon, 12 Feb 2024 07:57:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfxKtYa15lRVvNjy/1m9LMda5eb/rXCMv14SY9YWAJBPanw/6EKSm3pJDzUnNRU/XrSy5iO5trXAPgLbUYhG5+HAeg1/PdYVWyfE9THwyyYUqOyUkj9BNBrByLgRjbzwQwhkRhdIOu38wYONYxmSP9nEOjLJ85L0v4cnWNhTnP3yXDu1ZVmziLlJv+aS8vpPWb7xwrOhgIXZJPQPz0Xgle5WuNrI7xqeLMDiJcWokSMQ==
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bs19-20020a056e02241300b00363f1de3813sm1960211ilb.53.2024.02.12.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 07:57:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, hch@lst.de, martin.petersen@oracle.com, 
 sagi@grimberg.me, Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 gost.dev@samsung.com
In-Reply-To: <20240201130126.211402-1-joshi.k@samsung.com>
References: <CGME20240201130828epcas5p10bd98bcb6b8e9444603e347c2a910c44@epcas5p1.samsung.com>
 <20240201130126.211402-1-joshi.k@samsung.com>
Subject: Re: [PATCH v2 0/3] Block integrity with flexible-offset PI
Message-Id: <170775345334.1919824.14569482933790271087.b4-ty@kernel.dk>
Date: Mon, 12 Feb 2024 08:57:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 01 Feb 2024 18:31:23 +0530, Kanchan Joshi wrote:
> The block integrity subsystem can only work with PI placed in the first
> bytes of the metadata buffer.
> 
> The series makes block-integrity support the flexible placement of PI.
> And changes NVMe driver to make use of the new capability.
> 
> This helps to
> (i) enable the more common case for NVMe (PI in last bytes is the norm)
> (ii) reduce nop profile users (tried by Jens recently [1]).
> 
> [...]

Applied, thanks!

[1/3] block: refactor guard helpers
      commit: 6b5c132a3f0d3b7c024ae98f0ace07c04d32cf73
[2/3] block: support PI at non-zero offset within metadata
      commit: 60d21aac52e26531affdadb7543fe5b93f58b450
[3/3] nvme: allow integrity when PI is not in first bytes
      commit: 921e81db524d17db683cc29aed7ff02f06ea3f96

Best regards,
-- 
Jens Axboe



