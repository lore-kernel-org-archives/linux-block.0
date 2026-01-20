Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B120E2EF64F
	for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952917; cv=pass; b=HdlppXYS2nSc6moadSWoZpA9/yOoFsYwcAvK4Aurs5GBNK3CjEC76nnYDSdAGGxh8dr8UhIHaq/7vNPyZ8iI5cap3Pbp+43OAi7jhPlUSsuhxTlD/83NGPs/0VYjr+FHnJ2tT61c5PSeN/bra/FJX0BTjFReCH2kWG02A5Z97AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952917; c=relaxed/simple;
	bh=b4Ra1IAKXj43r7dEVKtdSlDl5ZeezwY4kOuFrzRvZi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=An938Z7HEqDhVTT+SPNVefyoqt4BP+iDPIAlDcFMsX+gKx2cWkZbX6A+gWDL4x162Gbyr9EjNk8s9YBESaoQ88kGHL8zKgOmlTVN7+KMyykpd6wmCJ1QYxgqishRLr693SPV2IY6P4VD1OXINBS+4oPoxdPPLXAF9oQKWXvE8W4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=blE9cun/; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="blE9cun/"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso763966666b.3
        for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 15:48:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768952914; cv=none;
        d=google.com; s=arc-20240605;
        b=SfAtFUXKNsGoq8JnMunNzdjt3qtVvjGDl8DlXF0fuPweQQtplNWjgy/EJGrOHOjAkW
         mqQTFyGowuXUQENd82TGBxpXygonMaXCv4q8QX9OPelSXqdE+4ykQKR+3HpgZmkwr8yU
         icPPCtVB1mZb8K2m6W0ExgG0OBltdcNcJ4/8vxQltYipIH6JGiSjyc4gsg3rD//NRjji
         meqr1NOnDjFIqkGPNVOVZIlenUYV19px8IHz+3m0Y9pnB8TqWC8m9vJ6S+mPH7eQ3Y4N
         mIwtIgRViYuYCW4+gipvITd95fcRYH8Qszm9Hgi1TCdEB+8H2VpsT/Y81sKiGrcBVEdD
         eLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b4Ra1IAKXj43r7dEVKtdSlDl5ZeezwY4kOuFrzRvZi4=;
        fh=GGNVhS6RikziKSP4BBiSjOsKwxmuqZ1rS52nC0fGrlo=;
        b=gtOgftE45zi/aY9J7RhbRO5vIOaaRhekuO2REyRJoRK3yXQn5J1og4rq2eY+YAOOpy
         pOtQL1AwhcqVKh06NRejYHXKfwTdpIO/CjAii1f+KuPVObFJiVMl8ZwgJWmjAOAOwRBn
         EaLBP7PFs4Pfzk5op0k5fapzDdeAS7Wx9MZI5h3c/p/NI+CTlwwShWdu/yWl0x+oT4Vi
         FHjW5IN//G374kbPCKQf05uqbiIrX6qmtd7LUH9IZW08AOU84z1riiRAKeNh53N5Lhv9
         gxz2BGugps6fjrEIZVQhlDhNV/RxkyI5AQV7iOSBVJ21sz6tbQw/6RWRAcAign4MNvVI
         0PjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1768952914; x=1769557714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Ra1IAKXj43r7dEVKtdSlDl5ZeezwY4kOuFrzRvZi4=;
        b=blE9cun/nIMgHBtBKyNCmGIM82uLt1Q7kkj2kpqzp/se/tLVrrQrzT9AOQCtH3xVDH
         se3oBN7hAWS1WO1ASm0pSrIXsu4HP+otifTFuMb9ifBZDsZCR/Lq+W7KyScAzKswpt0g
         H4A0aUWPrgMEOpwU78uISxa9VYDoNqW63qxSHGu3e3y0PEeCvzrWPHS2VKvpdfWneGvn
         1eyyIZU2yMswr3u/z6fS+6tH2NukoNDBZLe6Fs3QGdFAUKR/R4exzWUiLXypGqGbV39S
         Za0zPFN3lRnDcR/c1qzBvxeOe6QJCxEMklxm3OqECzMLMERoMVBH8OXRxhcY1i+xUKZJ
         qYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768952914; x=1769557714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4Ra1IAKXj43r7dEVKtdSlDl5ZeezwY4kOuFrzRvZi4=;
        b=nY0Th+HrR7sJJj1lWhtwImoKuSISuMeJHrVA3e0m7r18d8p8+R4MAUd1J+LJ6Qe/n+
         6qNi9OZbyFv7P+Pchz7pJgaApjtkb9yOcsVqep8ilFh2xYGgPPE6x6X75ek9gjSM46B+
         KArZOz0EN/3RfFiODOPPz1Fri9hAMOrdHG4c8cNOIS0iwxSoHmYvXXA0miuL/Ku+2T0L
         0jsz8CXSsrFbdoPCmObwuW+ZHB5pyudWw9XeP7agS2aWaTciKZIEfhwI02CJ+sBYAW/A
         LYkuGOR5fWVyPqmd0mJHvth9ayPclft3uzirbZTTpKfg5rOgy0uUx+2HQ+v/WolIO+mr
         Ovog==
X-Forwarded-Encrypted: i=1; AJvYcCXwtDy+K/Qpl6Llyk7sfFtrVKFq0ENvCG17Gp+RyWh+OfKdp/CmlS+oaTfBt6JPMfH9ptId/MPan0M3lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXV2MmWfDXYegjUmXAvWBv71A7AaXj1KHi/jZIPMajeJYX4Ik0
	R1u3wP6vRfvFoQ6sVcnyDhP42V7QUl1U7nBSrkxL81zMgwFYC0GqqUHaz2+aJOTvm+ELFNUzHx7
	HyJvTNXW/+ykxnorfxmBmcm0e+5nrod/IU5ITJfzFEQ==
X-Gm-Gg: AZuq6aLV4n/HQpiK2trBacG2S6AkStv2qO5Lmw8HrZJ/RtMNSyF40tkD7BU2tvWL751
	FY5oublGiInOPebttOTtjukjYUqsCun9dNB5N+nrSN60FCuJkKKzEt4h8jjX8vBON4dyA2cyyh1
	krbsueEZeWjIBd6glmJEJbsmH+TjYsxvV5T7KxFp9MOLZ64hPKmugRWK1Cl3kSa4YmLwB6SLKiY
	lWiSAWg1Dn3lKKNG9iVZbpZJVksmSV3hbm/izvTJEnpBFQT+mtzW4xQpwzRZqmJLXzenK0pqfEi
	sTkbVQ==
X-Received: by 2002:a17:907:9344:b0:b87:2c3d:ef08 with SMTP id
 a640c23a62f3a-b87930087femr1454015766b.33.1768952914028; Tue, 20 Jan 2026
 15:48:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
 <20260115025952.2321238-1-sconnor@purestorage.com>
In-Reply-To: <20260115025952.2321238-1-sconnor@purestorage.com>
From: Seamus Connor <sconnor@purestorage.com>
Date: Tue, 20 Jan 2026 15:48:21 -0800
X-Gm-Features: AZwV_Qj2hJglLK8m3hi91871dZ4LhHC6w593rm7fumGepxomWlc1wkyzhrPtEm0
Message-ID: <CAB5MrP5RCc-edT0fobxQHaC-c07gEB0MMj5xdjT5hjCv8=EEmg@mail.gmail.com>
Subject: Re: [PATCH v4] ublk: fix ublksrv pid handling for pid namespaces
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>
Content-Type: text/plain; charset="UTF-8"

Hi Ming and Jens,

As far as I know this patch is ready to be pulled. Let me know if any
further changes are needed.

Thanks,
Seamus
