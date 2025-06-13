Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E402E337C
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817570; cv=none; b=ZbfcIafkDCrjiw164jA9e/yRJCvJBjpIAHpDyjZZJizN1FJdpqkT0mr8CE5lFUuHRfiJ0Qjr6+EnnaInUk7ZDhhc0T4KW648K20kwaRcAs2ancvWkOPk9hvY+AhXHuv+xKHE9YN5RkZj8GT5kZiBWZ4n9VnZ1PAwLMgrggic0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817570; c=relaxed/simple;
	bh=mr8NoMDAtC8Cl5e+pAuk3w3joGM7BL2cWLMS0QGwo9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I1tmq+4v2Swq03YpYpK+Wg10yWOTFDVnhqVhvaZsrTcZ0s6sTk/ozwisp3WTVJ/v87pwJJxPrFBQ0udGowTGQ0w+IA2DdmxAf3FlohaoGx8CyS3xILMbdKNpjIkm1/n+bP4PlOoeM6fA5JTYfqgIBgeLUz1cbzB41+fcY5v/P8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=a5LFPxU2; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="a5LFPxU2"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a58f79d6e9so25156381cf.2
        for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 05:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749817565; x=1750422365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhqCDb2CYpbAZ30AFy3ZecOBJMf57HjUDY691eUXFdc=;
        b=a5LFPxU2moU8YdYZ9smkVyHPxkGGa575KnhwrBexB2KCSarDelDdfRUsgTSyhtlSeT
         K2xvdSKtnEQ70fVsCmqiI3NZuCnVpgfO2h/L5IUP9PBVv1KdoW9RdHOPipXxm3cVlJfm
         sPKyuLXpV6yquzOZbydKNWWXb28bfDshdE+1NkP3yF4YY3w3XeB59w0c3rG9Q1l+v1V3
         QLfRXzjBFJLkEj1QVxHUBJidkZMkTkTKFoIAeqD42Mzs7NYOyaSzmw89JSIVIOpbvOMI
         sFA7z3DLr2lvHmra5JNEbj8+CyfmxDA1muyQS44EVNjR1u25+rvpMVccUD8eFVZ0cSXP
         6RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749817565; x=1750422365;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhqCDb2CYpbAZ30AFy3ZecOBJMf57HjUDY691eUXFdc=;
        b=NNXg0BCBhPRGV3ZHwzafXmdMe2WZktM0uFMyMeGixsVRzjhfAyRM0urIHv/z4kOWDe
         y4ve/jk8CP4qCBohFJJ+9F2Y1SOvLV8m/VuZV3UpzBdd72UJARJQj01nGO0pY1UUmc4T
         rAXG9bWC0TtbQaJwzdLeDAZcNlRozam2JqEB6dYjYIsZu1hD9VP27KCusfbhxAfOkXjl
         jUa1HYLA8Jptquj7blB5LTBohhjyDnwyUvw90nI1nAsThpH2JvTKAMxFyqR+DeJIa843
         kYdDjcrdSFgVAcIPA4XuG3sbZIzTbOAqu5iUAGJDqa+yhhr/syhCEp6OH8m8yZ1pXTeE
         wyMw==
X-Gm-Message-State: AOJu0YzQLO2K6jL83NSXgeFVAXf46Xu3wHXZ7JsUrAFftKfamIyDK3G+
	wFcCmPVa2bl4StK/nj5tK4GQH1DjAFpgcPClo1OdVzEeu1ak6bnwgfqo7mjlDN/3oK3b9P2/yIo
	6oqDd
X-Gm-Gg: ASbGncu10Oc6hfFg95tafmIQaVD4M3UbCH5B5IPrMWO2lWLd2qlka1M9Bt/KEUrnpiD
	fwAHnZDOvCdYAhLzrphSsxDZt3l+p9kiufmnqij4lJlkXiRmRpMhooBm4wQxw6sg2aqtyDIEC4c
	mHsonDb2NmZuoylm6GqjUF7vtcdD5VfcGvrh7DT4FGOs0C0yaLuuqPaTr+5unRSItJjq7D0cKWI
	RCpKKr6EBLNBKL4XgFmVAgyNEZN6BCG6x0wD4CR2OjVooxRstsg8pBhbEJOExd7HbmTIr5IVKO2
	lGe8JT6g/eQ61eY8/9MYQNNtYly4uBEdDKVcp/Jch1vXTKjFPNzFog==
X-Google-Smtp-Source: AGHT+IEh5Z7XEok5JfckGGQfUgjGZLRPsTG3rqp6gtgGEk815GskksPz4PqAyRAH38z2kiYb/hqwaA==
X-Received: by 2002:a92:ca0c:0:b0:3dc:7563:c3d7 with SMTP id e9e14a558f8ab-3de00b7e541mr32911685ab.12.1749817554814;
        Fri, 13 Jun 2025 05:25:54 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50149b9dabesm279101173.48.2025.06.13.05.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 05:25:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250612144126.2849931-1-willy@infradead.org>
References: <20250612144126.2849931-1-willy@infradead.org>
Subject: Re: [PATCH] bio: Fix bio_first_folio() for SPARSEMEM without
 VMEMMAP
Message-Id: <174981755419.676900.13090581228925001795.b4-ty@kernel.dk>
Date: Fri, 13 Jun 2025 06:25:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 12 Jun 2025 15:41:25 +0100, Matthew Wilcox (Oracle) wrote:
> It is possible for physically contiguous folios to have discontiguous
> struct pages if SPARSEMEM is enabled and SPARSEMEM_VMEMMAP is not.
> This is correctly handled by folio_page_idx(), so remove this open-coded
> implementation.
> 
> 

Applied, thanks!

[1/1] bio: Fix bio_first_folio() for SPARSEMEM without VMEMMAP
      (no commit info)

Best regards,
-- 
Jens Axboe



