Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF38382392
	for <linux-block@vger.kernel.org>; Sun,  5 Apr 2026 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775432651; cv=pass; b=a6DEwOqMREWxdIrqPlz6rmBul3dQZxoKfaUpQklKWOhMuTWWB7jwDVJABJiAHOcN4yyFgeDMNSNXIFe4/qOg5HN6MAxka/epz3hO0rPYWFaWCoE/GGNBheGqNyPrhYQK0cf42xxiSoXLGcrVTh3OyP95tvKd5luEPtadifHnIGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775432651; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBLAkqb/noA+Y6zI645v1MRC3GDlW5d1hIWATGivxgjV5KfdGpGTNXPJJOiVfxMdhE/A/L/iovLXlMqPjB8aSuupNQQTu7+1uB3ioiv5OPvB7nuJtu5HTqsHSZuksxfb+JtSw7QZueTiWgo+vAUpUA8fo1PsoHfwZV71uiEsLhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRy7bNIt; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRy7bNIt"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-66e8cc714fbso2134127a12.0
        for <linux-block@vger.kernel.org>; Sun, 05 Apr 2026 16:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775432648; cv=none;
        d=google.com; s=arc-20240605;
        b=E9UmQgDgq1X6RQSxGSmAFZPJo3lhNVLbSAiMT0QCGwAI0HSYUSbl2yeNrdH5d6Q54+
         JspUkE+n3V21EtH+B40qpXdpu3JshO1sTGRW7JSjX4D9M/oMTU1kaGeCepyRblqN7QpJ
         PosDmGuu7o2YHPt1RfBkCuZezsc2+ccQHJJFPRx99cXNJqjjMQBSzOIzwyJMgpocHbkq
         BC1Zn02i6b1bwPBTzZQO6E3I13F7/N9Sb+dhgmgKwR/73FsyGL9Zdw3CJidn5CRMcb/K
         2wYelP3rmxYgaOnOGyeSth4v7rkaHCEcFHQNj5qL5xc7vAwTWVL4Iurmp99CYleWDpis
         CP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=0nB3GSTaenxWu2DHPWorHeIMkXC3ikeNqzsRKqygUE4=;
        b=Rz4d6I6nbfnxZlDlxGyiPmCD2vurocyzjMWx8d7CIFcU/94yZgoSawdVAnycjofNkd
         7dWaUpUr5QQHtGbICa7HqKSSt99HBjcF8kpUKze0uqXxJKET2+yElcyBiVJH5xmnJoPz
         rkToxjBb0CMywbv09pYsehOlxQasJg8B+XVw8TrQyJK5UHHLRSbnTFarwBQPJpkEHgM9
         aVT1wDWCqdeU6vNuje86zQQTVXXtH3yWthhH80IowkB2S6+OEH1RM1vvQIWtzswwoRfP
         5q1STpty63ZCo4sy8N4ySGUG+7sFB2yTxpMCeVDhighxN4a3ILXYIxUjsfBvGsnAxc+K
         4XGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775432648; x=1776037448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=KRy7bNItuCMjRdhQoDNXmvbrUzsJ/EQuIgectE/2nVrOvHXbxXJ7Qv8UgDHuYfkY1/
         vHf7uRCN0nuZrK5x0OMSNHgPQTpoccJlPwNv9HFLWDmhlARIhVmqRciFrzzDYxifwjL5
         udsGHiQPcPEKcVvraB0avyXDnTsGkpXPkjR+o+kHz/vQ4bGr1wHD4nFPVdU4+IIFachM
         XjFYJoBIkM7dRlAz/LiL/aMthXyxznCmQ6myhdArXSmod+VOkJEP6gcfOXt/JfrPbXdO
         v3WEPlCuKnDFA1J7jZnDHld6xjg2nUtv3ZNb4p2TuBJWNcymrz0vus1KC4orXYifThNO
         ga3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775432648; x=1776037448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=Vu5OYs0XP2RcGFUbJxEcYXnZGEWGHD0pvEtk0UMc3NyB/nBoO3eE2vhTaK2sZWHFdP
         REMWkLTzNUK0BR3oHthS9dnbr9tMEQTsKQxJ1nbtWUP/sUiT5mM46586Cw8/Nv9mHhOZ
         P9TVQvpOErNucTdpk/kk1QhF4m18phejOMp/8A/sS+7rf+vn5eEAnHWJ1PodxahD0n0M
         kRPTckGyerhASHIbbjAnbeWvXrLdzlsAiw5vm6OLXvfrt5kjaCoJ1y153Ift1lN3O2LM
         0yLyZsUIwkisfXFKZsBs7G7Qhcep5HR4Op2MNsZqU4xZ32ye81KvJmzVx+xcLVQV6002
         TcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH1PPcVSYF4506eNbyiqUCWdBI2kQcGjx8Xx8+EEg9c3dJ0A0rBqKYldapu1VFfePmiHO/VgASbyn3hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAiYEVC9mlb8W5uG+As4GbzAGWuRIdpFwdb//FZg85Ic4TZnVB
	jPDyw9yDvIcXfxLzpQxpG5EQTrtuvmdokOVgTWHhCYm8xLCxhHYp9sEHZ08FAdC1etpC+oVXWws
	WIjJvE8unoMC190bGw6cnW8RQ/P5+Ag==
X-Gm-Gg: AeBDietk0vnLMvD9+Gx0DdLgKyCb/2GSO9wONgV9+vegj+bP0WpstCJDH3othCnsZKa
	yds1DyIFYoFJL3WhZ27G3FqF7l4cgZXyf/HlsQT6h7htEWhZgPHI8V9JB7f8QHOLoMkhw9ynzxK
	AdBJMwYKSm6mXPtMDnFZBdUbYpmq4ykXELA3YoODKCys78N4RqXUDzuVjRUQLAfaXpgV0Iy/+3x
	n6A2raOoFqkgkMlguaKyrQSuSzqcxa1zTaFq4fYI75BHUb4Z6zWPjSpNkBXGlQNsaJLMiHf+VKO
	rruJerBCbLTpBGPn8gYZJ1vptuK7gJkhTCAQDSM0URgGivx3SVcAJNce9SSyVnaD8b/GdQ==
X-Received: by 2002:a05:6402:430e:b0:66e:f4c0:c365 with SMTP id
 4fb4d7f45d1cf-66ef4c0c656mr717744a12.10.1775432648191; Sun, 05 Apr 2026
 16:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403194109.2255933-1-csander@purestorage.com> <20260403194109.2255933-6-csander@purestorage.com>
In-Reply-To: <20260403194109.2255933-6-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 6 Apr 2026 05:13:30 +0530
X-Gm-Features: AQROBzAe_pR1JdvPMRMED5Vbpy-Io1YSGKtG2B-bIRotwUzCJw2tWzJbmfKAgHw
Message-ID: <CACzX3As8NN6n3uCvOPhejzZCs4fTnXkohKvZw787+OyP=tpnNw@mail.gmail.com>
Subject: Re: [PATCH 5/6] t10-pi: use bio_integrity_intervals() helper
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
