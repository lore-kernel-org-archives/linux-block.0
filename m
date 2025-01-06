Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CB1DE889
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174369; cv=none; b=gSaVO/yS0I13WKVZhlSYMzv32hupCbfetCsHohnDWMDtMh7h05l6RD4wWpq4CJFBLCnSTyd5n/9docEQg6BZyeX9zN1UJ/qdhsgX6k353xEp/PM4+DxEcoqSKX8COdKbcJKFFdngbA7el/cVDeqJrwu28kngVH5loUICjjOjuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174369; c=relaxed/simple;
	bh=r7ANYYPAK1vUuPZjIm/82W0C5CMaS1y5GSJ7nhHHm94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GaevnT011yRIzX10DFevKAcG+Qotx92iaCePf2XtZHWxmqsxU6i3uyAJljn97Tu4pqRNl8wBADR6/UvANceqr0RwxjIYCIzO5d8QnntPKr1rE8eleyjBPMQY/lrMDI/mx0+Pe88psPOpSEwbzApzi6X9ldCDHyFH9pnF3Oc8jhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=E2gh28xI; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E2gh28xI"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844dfe4b136so451974939f.3
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2025 06:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736174364; x=1736779164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x8oj/ukk7NQ93WrIyrB/dJP9e4zlMZd1IvRQ53DeEc=;
        b=E2gh28xI8LasPRBlZDrG2IO1Y2sgmplt4HpWJHF3Nd2CkkWdiV5fUIY/xF5uSIzSlx
         m9YDW6t7lshK4TWWMeIjxlF1Begh5xeFJQ/lgorDYg/5COCgusbkIjniCymaIgCUNWAZ
         lxckBPKT+zWa0gJpIpbITXRJzVZUtO6XQBZ6OcmSRKqUaWKwRoHELiRqht9iRfnfkDRS
         7Pho0Bk/hareivlyeoQQfgotOGGZE2NeAYdjH4v04lgq6mlLVEhsXj0fJY64kc4pgMf6
         4xDcK5HSWgpfqm8zgxTq1bVsPKns1AyKsmpF3CFosm58gfL0Z/eBtpB56KsyGrdyfkRW
         yGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174364; x=1736779164;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7x8oj/ukk7NQ93WrIyrB/dJP9e4zlMZd1IvRQ53DeEc=;
        b=JYMl+b8LwyDLR1ZPiNo+JPRcupl8V+mO1bIFFUOQmSSyhSuHOkhO7PjyNvjRyNIdDw
         ndm36vyHtpIiucwfkJ5MuSKegtVEzcXcderJ5SSZXW0UNGnN8MsYMo1V9x59vMKmaT3x
         B11Xe4JzZS68QTJivoXjkiCmT7rWAex7lz8u/aRPjEbSc5zsKsnzlNskRCBx8OIrntBf
         ZgrZM1yziazq2dBfcvDFTTS1+k82zBOdKSepGJcFFFmROZxIA/16GCZwMOCnZPAyKVN5
         WJIWRCbVDV3gefQkZjrDA1XlIOfIyU8ix7dShUsl1EkXCM70ki3pgkzcqNIfOFCDyh2F
         2VTQ==
X-Gm-Message-State: AOJu0Yyv0PBgKon7UNXs7WwikJBeMl7HuUHFhFHAUpq+b9SIHrKpbzkO
	ZcrG9fZFiJJ20YRhQUDuwS8sZxfGGvl/kHeg7eSYBO+oEy1mklU7jG6l4juoN9XWiyu1Zhjh9Yo
	7
X-Gm-Gg: ASbGncvhGj6oPobb4gg5CydsWRNeXP/gLlJ0q57tt8oWD+X8B2W/RxtAMewQd6nhHv5
	xgeGsUkFBPKs9CcwdvHi6XxAYkvCS86tF4ujaXyjEPsg3ObBlAERoiwuctPFzhsTKQ4qwqpUdQe
	/9fFEVaLjf/1H+MjiQgfmQeSjGR6bmHzZyvmVwfc8dRidZTwSj0G0p4IzPgwqFg7FzbNK3J/c41
	UgIOmOdw4ZKTLVGDNWnSX1wTldV1Xjd7Lt8qFhUlKGZ+6g=
X-Google-Smtp-Source: AGHT+IFPL4j17zdU6GbLSokd8eulQQKQLMClgY3xCQHRfaj3Pw70peF8ytH0LXG3phguLFby+1uZ1w==
X-Received: by 2002:a05:6602:36c3:b0:84a:51ee:bdc7 with SMTP id ca18e2360f4ac-84a51eebe1emr1829681639f.15.1736174364446;
        Mon, 06 Jan 2025 06:39:24 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8498d7c8308sm879002839f.7.2025.01.06.06.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:39:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250106081437.798213-1-hch@lst.de>
References: <20250106081437.798213-1-hch@lst.de>
Subject: Re: [PATCH] block: use page_to_phys in bvec_phys
Message-Id: <173617436317.57123.10227814225214531644.b4-ty@kernel.dk>
Date: Mon, 06 Jan 2025 07:39:23 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Mon, 06 Jan 2025 09:14:37 +0100, Christoph Hellwig wrote:
> Use page_to_phys instead of open coding it now that it is available in an
> architecture independent way.
> 
> 

Applied, thanks!

[1/1] block: use page_to_phys in bvec_phys
      commit: 2caca8fc7aad9ea9a6ea3ed26ed146b1e5f06fab

Best regards,
-- 
Jens Axboe



