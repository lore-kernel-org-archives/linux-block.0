Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A803DA5B6
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 03:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916647; cv=none; b=px5q+MhSiBgK2W5OXPSzRGdpCIYJkFgXRRBuk18nl2qpi0dMg/Vf9N6JHupPPHmcTORPourAUrb6M7X8T8I7eRzrhHgkLKmIsd9mEcGWgXEAP7BxkVzUFXstJEJS80FVy1Smj0QPjPbSEtIZ0gDhPX09LPO9VL1SAUky4DMRKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916647; c=relaxed/simple;
	bh=hov8j8OBBk6KKCciup9KzW5pzA21qGDmu++kv8kz8Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC3CyImJKMoadhRFY0mfkeGFDMJ1BdUR66JHhl4PGGBTo4/zU37tEgEK91euGezD+shaQiUI4q0ABzPG15/UmnxbEfHddBQh2ZjW/oHuFGVlu7cU7xxdltRnrsnhscuUjOr0KnLG/Mhin39BwygTsOMbUsZeYahXvHGNL2VC4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHHppME7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHHppME7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso5403519f8f.0
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2026 20:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776916644; x=1777521444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOKAMPFZKUfzrB+GANZr413WPPbfCUJLAABtk6nlwSk=;
        b=IHHppME7CevXx1gUrGPhFt7gkSCIXj6p/0NPnFwCtWJ8cqRbBmHsBWXlVkhkXN5X2V
         ZPnChqnqnVaAJ7npJIL1KrJRghqU5Ag5HOy7YjPYPSkx4OlHEmQnMj+Z5hzanpDNJAWl
         rvDs5cSJKVeDAfML/+mfR+EfTBdxqQbXyrqJe/8gPS8GiVieozDoVbMnF33oA9jM1NjS
         wKM291QFP+JdwGsV6ALojDv65PFOV0/BlIRgzGmTJCB+0KcVvBFP9IlWdbTvOzEPLX/q
         oF8K4X2vU2+JUSLPWDk6nDhj9+CKZNA0rNlivzS5ifIae3ktcSPd6YQs2VJoCOnfCJHT
         KbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916644; x=1777521444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOKAMPFZKUfzrB+GANZr413WPPbfCUJLAABtk6nlwSk=;
        b=DUggleiG7etaVBoRviojuH6atUXUrpGQtc8LH90bbbMUsJp3Qx5wwW1tBu/XlDJVu/
         Mowb+taSkCRJC4pJu/x+HblDcVI0hrsVyi50uhl/UXMNs4r2Uclwb7CtNbz9fY5zP+r6
         HGEXkSICty5DmABrr1tAmG+/CYMn/zwsV+lZ2D3zxPOh20TDcsU/3HqU0lrIxQyPpkTe
         ZamhhQt4tF2C1pC2iSsSIv8smrflLN3TITVPBlBp8Ssh0MTdGxyk+/0Pj6d5buon9g0Q
         G0dXDJ2xh9FkqcOVj7dJcAPrGSURiOJq5g9IzWBYhU+t6fFCcEfBJ38IgMWLZcL8mnbo
         csoA==
X-Forwarded-Encrypted: i=1; AFNElJ9OlY/Eng1LcviTlB+YdW6iK/Yh6JE9cXBhGYiEYEb831543Rg+b0nJ71PjJkK08lshWb6c7FzmJNdPtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3Wi0n7NX4uHIZixv+m1pjpproW8jDRMKPvwV583RcJ20ZGOt
	vRHAiK+BHzlXpb16xV3Db90oZHr5xfpnQtbewwrBoJ554xcNIqjGw88h
X-Gm-Gg: AeBDievO8iTU78z8LyfuEcyvTj5yM/6Gu8bnPRaOUqKJZ28Gk5QCgfLCdpkGbcVocbz
	Exqy4ZuafXCf0U+VzuXQfMu4RwvVPt2S4UD3Ilf7rQZqMJY1liFGJFhgIMYI4pL1W+hEBe5gqCI
	4GwEckOqHn9CHbVpRWhdzhsaXDhjwmiNwRsh+iV3P5JiMG6TA4pXny7X1AnXmp0/slyaOMGuyjU
	SO8Tk84bv8I2gnVhDSQMo3bxA+k1aQ/TlaYktGvW5y8Hz7Ba3ZbM7FQa8vQug0jgpvVlWdzrryd
	QIcysAIm+ACoerHY9ReIF4XLtkSyCUqMSfrL+s4DqvU2iDENzb+pG2J8ZOuK/QgEtQrAIl1jK1i
	Y5QtyC1704jin5lKJq16WigkBwEOnaEHm4fuqIL50gFKH7BFtQBXeV4FoZfzp9++Cj2UXJUF1yQ
	b8nl1nOet/6jGmZfoTZYhmj3rIdAFLUOzmdRCYzznb2DS4lMai8XC6YHQcHqPsHV5ZNK9mdH2uu
	tqpoOgXfbFJ9Nn6fuDOPUQltxrr6Q==
X-Received: by 2002:a05:6000:178f:b0:43d:2be:e4e with SMTP id ffacd0b85a97d-43fe3e23d1fmr39055753f8f.46.1776916643703;
        Wed, 22 Apr 2026 20:57:23 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4412150a071sm14978481f8f.21.2026.04.22.20.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 20:57:23 -0700 (PDT)
Date: Thu, 23 Apr 2026 11:57:17 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests: ublk: enable test_integrity_02.sh on fio
 3.42
Message-ID: <aemYndGj2TrYl7MG@fedora>
References: <20260421200901.1528842-1-csander@purestorage.com>
 <20260421200901.1528842-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421200901.1528842-3-csander@purestorage.com>

On Tue, Apr 21, 2026 at 02:09:00PM -0600, Caleb Sander Mateos wrote:
> fio 3.42 was released with the needed fix for test_integrity_02.sh.
> Allow 3.42 and newer in the fio version check.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
Ming
