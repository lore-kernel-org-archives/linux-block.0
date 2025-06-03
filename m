Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB01B85C5;
	Tue,  3 Jun 2025 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748993798; cv=none; b=JElu8N6JB3PmrjKBsCpWQvfj18J5IDAy+S6iYI+ZFvwNqBvvh3SuYOqzvrr/LM5lofdV5b2+UHq8npWC1KgVMbtWUVkH3adRfQ48I4vC6z8NQr2PZU1D+gMsagE/Qi7zJAD9x99TEravcx3KQaqrlmPh3OAAcDe+Odhop7hZjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748993798; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pguQ9es52cUCvrg9H0B12SrQubQXUTvz89Gp/EQedB8txbQMn82wkBwU3Vu+d/jk8wQfG3HFZPidsPfw3cHjsaoc+lD0tq1Lzk+opBmm1iLUHhBDCqiYQeuo9muEwhvKjehshQwxQbrTGZYjpCJFAYaxd0nbJU5FicbEiB16td8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naEzItGR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naEzItGR"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad89f9bb725so1237472166b.2;
        Tue, 03 Jun 2025 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748993795; x=1749598595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=naEzItGRZXUELH63yA1fgrfLBi3h/MuZfQ/4Gv0NLB0IlVu4rEuof7Ytht6/o4aEwy
         b7lmbbAJAxr/5WIlEPr6vza8Ujwt7eoGwPaNvsXYv1pQTK+61F3FsZZfw4SW3YSYsgXT
         ZGLe9sE8SyES79ArBIKRmYHEogMFStKaSSc/I0Nl0ghbagdLs4Bbsl+PNhzio584qoPv
         0ggXbxxvKaEHvrTtscAP12Z/3j1Q9cVoWHY99Kvklht9vc9GmFKQei260YZdh8P6i7yF
         OB+rc8smn9ebr0LoF75buhXPFMk1x1MQ9XQkLOd9pT0/BzahChSRYwuaWRRsmdhxkCRw
         KsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748993795; x=1749598595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=GLG2j/dmTCsOFIhm7KKBhObq+fqkuhMZ8y50bn/kr26dbPKonrSU12Z2ry+ULVojCk
         vsyv/5MVsVVDX7PPo4f/Woyi8p9UOt6oG1fpWv9HONRj+bl7S/5wUHusY55yLty87v+x
         jWXzGAIO1a7Bwtn0KCfgEbDDz7bi5gHhFnRTcbugH4whhcV1sIzxeMpHrfiD+OqH/P+I
         qxI2qVFBRPVWt6enm6hcWq3A+R23+QZSYMFyZnVp6H2n835Yv+ACbv/eUYeBOHxQeV9I
         d1BOOuH865aoafdQalfuf9judNUzDgHz3bfRjunIanbGTc1udZ7y9dKh01cBTZ/0CtEV
         jEUg==
X-Forwarded-Encrypted: i=1; AJvYcCVmrdLUvcXvGw2rBtMirHZyLj6S1psnnL3aWq45tS/iO+jWJQbpHgf+3esbSr978m8/W2bKo8/9CM9HprGg@vger.kernel.org, AJvYcCXNfVOQaOfyAmR9tRtqQAVcc8/2GEO1+N4vrKtVqPFv6vlnJrzpfbySSRkR35e1DTIegZYul1AHg3bNoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC505FoAKmj18lvoQEBE8ppwhnRuH2GqZjffCDZiIdxFjNIRK/
	HG/9lFDlvSqXWndz4VlxzOe7zx3ldPJtQuXvwO3/UDOasVoqbiT8d2rSox12+hgF6yIG7pJsmbk
	e3/tKc6W+TNa8u9tqnL4qi149ILSWeQ==
X-Gm-Gg: ASbGncvJHp12KmmYHYdROH9wxYniVJIX7Bdaoa+99/FVM3PKsePEdh6IJH2twdC80eb
	TcUOSZEfVx6QvgGng/Iz+jITvCtX2xc9jM2xn0naYF+9Rwd3LE7WeW78qRly//ZLKb8t8uj2C6+
	VffJMAo9WkLl6x8RHzfRTEeZEhcBdlx5TD9i5nj11eIkZRCqmn2aHjz0PcTL/a3fEelUAu02UOn
	yaLAYIWT7o2
X-Google-Smtp-Source: AGHT+IGpgofeEjM/2yrs1izJ62rbrSRbfvypEK9Kgum/HdJpoT/YJ0nOAGUL/tlHWb4n1jJSlFkhZVV1UZNoaspahtQ=
X-Received: by 2002:a17:906:9fca:b0:ad2:24e5:27c9 with SMTP id
 a640c23a62f3a-addf8f698e8mr45977566b.44.1748993794661; Tue, 03 Jun 2025
 16:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603184752.1185676-1-csander@purestorage.com>
In-Reply-To: <20250603184752.1185676-1-csander@purestorage.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 4 Jun 2025 05:05:56 +0530
X-Gm-Features: AX0GCFvzFm1-HXMLV4Mved_hkP6zM4mTmQrxpJFOBdv7dIhfetUc9Oji1q7eopw
Message-ID: <CACzX3At8V7rCTrWnZvhFh8ZCw+7JQ7y2azZW2dhzUuTsXZGtxg@mail.gmail.com>
Subject: Re: [PATCH] block: flip iter directions in blk_rq_integrity_map_user()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
