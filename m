Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8262526A08A
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164965; cv=none; b=R+APJmZtRcgSB0TzqK7x4ZuuE2st5wMD0EzAUWtnW0nK/Iya1YWpa+1Fg/SMntjj86Bl5TA0USw4sHN5SPWh7XjQQ5zqxv/6qfDwLG9lEd14oQue5rX7NGFWZS9jcFyvSr1WFWYz0vPlVxOiqo2Myh3k8NvtQWGiNHHz/2K58S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164965; c=relaxed/simple;
	bh=W37+UJm76gcYtlceZR/206I3VcDHSjYRZX6gB5xCSfk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kaahJv8At3iPb3r1w/tGdQqz0gJP+5jpuAZjNHaofFJDDREDfTmPvcE+XyxPh8aQG6XJXdFvcLGqZJbdPAmTM9ro/EZpxYL3DnpASzHidxOxPdozTdPZ1cvcyXoKvY262xj2ctiJ9sDJ1oZiRiWDIJzi9r35xqFx5neetqFizfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd4hbN7a; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd4hbN7a"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94dd01deb53so406957241.0
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775164963; x=1775769763; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IB55pBrPrRVvy6yC37jMsRUOxNSIdANq32MiVaAR3v4=;
        b=Xd4hbN7arlLvtOPW9Chv3B5WQytuZs+gSyb21gX/ayo+JQpjx9tEpRPBlhNM/N7YYx
         ClDzJCssc8bX6YJS5kyQuHAO3/rs9GqtKaN0YOc5iXEPB5WR2VvkxQsgSm4JSKCC3jCI
         AE6opdMDvqUnqjmBDgXVuqgEFSqvsLUxD3zM8x0yB6/eLb0CthzMLfjQgblw0i/T8aBe
         IteVUPgArest/OZ+fkuzM1Gmv+0weBl1FdO8NaiHhY8dFJAXi1xgko8bNSCz3Kee47o6
         xGM+JSnMaMTm2/nf2ZWSasZzmkmrRQCIGcH0ZIGsCLErQEmDSjAe3H9CY9QjuxP5wpN2
         9M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775164963; x=1775769763;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB55pBrPrRVvy6yC37jMsRUOxNSIdANq32MiVaAR3v4=;
        b=k0AmZb4/s/J49w9U+ht/Zw/E7vqoFVsNr6YriE59Xzx+Tno6DPE98niQLN12T3mEiV
         HRoObWd0NjzZf4eaH60dp0fOy2YUXF4vyXgLAXyNdVC4B1NF+FqkahhsepBJBXCF81BI
         YigFUPWBhKxT5GVSzxTdCOtulknh8SW3YUHKSf97qblN3XRNPDXT4rgcEhfv0JFGnCpi
         k9kLK1FKx7tvVmXaTHGJuiUapL+zB+4/O+5UsXQEOkXi7z36S9KHvGv6vJEvk5+f0kke
         77K05xMtlfAe0ipzL6hsdOUDtJD/CDrED8eM2OHIM+rYdBbIdwnBL9Bn0/JhFuZg5Bwb
         Vfug==
X-Gm-Message-State: AOJu0Yx1/NZw5mXD4koCHWN/u2ylusmsmas5eH5SM7n3z9/tU6LFJDBb
	wu94brq2jGsAdMUrRZbAJWiBL8NleKugSewdp5vSDZ+1p4BILLZ3EEgn
X-Gm-Gg: ATEYQzygYGZZsIi5pEQDD0KRZ3mZv45WvOIbCr4O3xxPDKNTddd4M52K5DpNWNLCPib
	aWmezIHCFCvvV6pck9A9id6CVYBtDUQXuT67Wa/pvR2ikQMoBn6oZAgCB+ova05nSqB2UDOLvHE
	1mryeLoodOTd2r/61GKXxXAF/3SNutJLuOO2oZgM3vehmpjIzwhgxZMTti7NNoBSOHbJnNhJ0OU
	8X6nUzZclCEiHFmELneuwqXFhHoeVU3/loDd/TAmgGmGb9OGwtGIpyd/Th4Uy2GkEFQMyOJDtZS
	DA6/eU2fDrVk8LwyNYrWxQZWyRcwwSOuZy7Grwwr+Np0E/gTvAtQNwnxZV9zlNKdk8Z2i8gA8wC
	ES7fn4+iIjm/Y1iBrEeQ11Sdw+Per1Vw80AflsBJMBz/xOKVg80JAsAjwiEoLbwEzl81HYPkGDI
	AM6RecSyp+AYOpkIpco3wc8MJ1w0bFO+SJpxkNNfdDgBr9ajIClghw1zSq1ax2oq8jjNhxAN+dB
	vQmdYl9WTPrEQ==
X-Received: by 2002:a05:6102:605b:b0:605:1994:a8a8 with SMTP id ada2fe7eead31-605a4d770f1mr250928137.9.1775164963308;
        Thu, 02 Apr 2026 14:22:43 -0700 (PDT)
Received: from localhost ([2800:810:843:17:c685:8ff:fed8:cae8])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-60582e1214esm5184674137.3.2026.04.02.14.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:22:42 -0700 (PDT)
Date: Thu, 2 Apr 2026 18:22:36 -0300
From: Esteban Cerutti <esteban.cerutti@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [RFC] block/nvme: exploring asynchronous durability notification
 semantics
Message-ID: <ac7eHEnFQlLN-vDy@yanara>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I would like to explore whether current NVMe completion semantics
unnecessarily conflate execution completion with durability, and
whether there is room for a more explicit, asynchronous durability
notification model between host and device.

Today, a successful write completion indicates command execution,
but not necessarily physical persistence to non-volatile media unless
FUA or Flush is used. This forces the kernel and filesystems to assume
worst-case durability behavior and rely on synchronous flushes and
barriers for safety.

The device internally knows when data is staged in volatile buffers
versus committed to NAND (or equivalent persistent media), but this
information is not exposed to the host.

This RFC explores a potential extension model with two components:

1) Multi-phase completion semantics

   - Normal completion continues to signal execution.
   - The device assigns a persistence token ID.
   - When the data is physically committed to non-volatile media,
     the device emits an asynchronous durability confirmation
     referencing that token.

This would decouple execution throughput from durability
confirmation and potentially allow filesystems to close journal
transactions only upon confirmed persistence, without forcing
synchronous flush fences.

2) Advisory write intent classification

   - Host-provided hints such as EPHEMERAL, STANDARD, or CRITICAL.
   - CRITICAL writes would request immediate durability.
   - EPHEMERAL writes could tolerate extended volatile staging.

Additionally, I am curious whether host power-state awareness
could be relevant in such a model. For example, if the kernel
can detect battery-backed operation or confirmed UPS
infrastructure, it could advertise a bounded persistence
relaxation window (e.g. guaranteed power for N ms), allowing
the device to safely extend volatile staging within that
window. This would be advisory and revocable, not a mandatory
trust model.

Questions for discussion:

- Has asynchronous durability acknowledgment been previously
  explored in NVMe or block-layer discussions?

- Are there fundamental architectural reasons why separating
  execution completion from durability confirmation would not
  be viable?

- Would such semantics belong strictly in NVMe specification
  work, or is there room for experimentation in the Linux NVMe
  driver as a prototype?

- Are there known workloads where this model would clearly fail
  or provide no measurable benefit?

This is not a proposal for immediate implementation, but an
attempt to identify whether the current binary durability model
(completion vs flush) leaves performance or efficiency on the
table due to lack of explicit state sharing between host and
device.

Feedback, criticism, or pointers to prior art are very welcome.

Thanks,
Esteban Cerutti
