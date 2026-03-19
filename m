Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5042EC08C
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904881; cv=none; b=fyxDnjeFLwiLmWnbYnjjph5qJpL54taBLU+UMNY5oElTaz03XNzWGTiOhT8KjD+ECmD/YXGEX/EdsKEhFUKKXN1Dsf95iWWUyLxBcKKM2HJbCkVi8rK8bU+y3yGt85GDVMGn2gCNLtwbF9f4g00PaLUGfd3/MRL13N1KLR2BZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904881; c=relaxed/simple;
	bh=3vJp2+G8ODaRMaNHiZrkLVcvKlxykiqKJibSD05/p1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/y/alLpIhOMjmcUzQfzoArhG2OCTdhZQ+N4URy4ykuyg7/LKoP7ave+844gy0NKfkdv79HbFrzZfJ3AW/uLOJA0yUWG/2kPXTq4GqyCbYoXAK72cQbgjoSIaPdOOFtb/ZLHt+/2TaAZdoSnh8bv7qGXCEuOSgXFOWU1UaNyiWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SeXc6mWX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SeXc6mWX"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad9516a653so2554195ad.0
        for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 00:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773904880; x=1774509680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mT5CVxEEsQlA7iRjeSIzOh9lr8aiAprp04Qac2/CxY=;
        b=SeXc6mWXEr44vX0tbtjsDCWqA95cGG6jNGhUz3U2MOl99ZD72nqDb5M6/YjsWAGZZu
         6+kJ8XbEuPhloakNHKEs1x++dd8mNq7yt1qEEBJvczQmWmPWcpOy5G+6rvV+wLsESI1k
         UYW9kpH5mfAClnWeTWTN6/xTHfi+FcFe+NQ9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773904880; x=1774509680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mT5CVxEEsQlA7iRjeSIzOh9lr8aiAprp04Qac2/CxY=;
        b=gY81K5yLwZiV5T4bBowHgXdcc7S1jjD8yyinuLU/KZY/e6c8BlK2u29LXTJFtGeFY2
         mkcsVwEX9uhb2pjedXo5TmtNsQ6M/PQq95x814xdo9JRKIkBiSiUP7zvb3UXYYdcdszG
         76itLf9Izkpb1AbZuyzfNX8Tj+/0HgzwyFWcTpBW0ahzEEL/TIJrzqoYzND5KeLlyMaw
         rlyoBAO5eK4iQeTGyc4OFd2bA6WHQIoH4eRFxGqmEcqSz/tSq+I+Gf2p+2BUXtNVqCsv
         PfEVpw8AUSAn+86xEdG/asw760MIeQwz6YcF1ZejCcXkcwa8NF4K8oWll5V14l7RYL8N
         npsg==
X-Forwarded-Encrypted: i=1; AJvYcCU7hY4/rnjoaDRZmietbMOfpxX3vArXRxRJEnCncYzXP0R79J1LslWmV414unaTUyMNbBOxgEzhGwZ2yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEg90BdYpH7L0ldmxerfnDeJT4MLGN3U2bXKQkWQIOAVZcMqF9
	GsPjkde/oCtjPSM6InRBGNxN14PxiIfx9jVdi05WAyCLgUi1OluES92ZXgpsph7E9w==
X-Gm-Gg: ATEYQzzCHHPDtomurge7VS2MzaYWkCWviW4IIPEEgdTn/g4/P9hVupcKULSPzIQywio
	/GCeKz8+V9I5D5a+taabfzB5VEy0ckRL86uNeAIsjoZtCfgw0b9RKHVAYqIS08MhdnSxM/h+Gp+
	hAuqAISJFvCRnD9rYYO1wlL3+zXmMItunLaIbEznZ1HqbkSoQtRXMhSLi7IOXFmgpb6hMQ6CQgE
	frU9kr4DH943CN38KrW11eyc9O49c3OmZ2cVXvFCRwipVre6pJ9BK5OvQbwxzZhQ2vK5Qr84hm4
	Jx98nwIRkZlUweBuM4ad+SdVTQfqwnaBLMsET4hVwkxJmNKOoWa9lG7pABOdwrRZwiM42eLzHld
	nwYkz5nAAMRkGRbDLFf9Lr4ce35u0Ir0ol3u8XP9g9b3SwZyM7qsOpZmXhVWL/FeXiCZgVxZqZN
	ByRpUAwHPynZ4hB8KbOW8AEoeNsOj6PxQ/4jYscovfRYuVBautL3QfJcZw7XWJCK0=
X-Received: by 2002:a17:903:1b4b:b0:2b0:5c0c:b9af with SMTP id d9443c01a7336-2b06e424b48mr63922315ad.53.1773904879945;
        Thu, 19 Mar 2026 00:21:19 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:13e1:7517:52f3:cfc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e448fa4sm48352965ad.32.2026.03.19.00.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 00:21:19 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:21:16 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Richard Chang <richardycc@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zram: do not slot_free() written-back slots
Message-ID: <abuj00rFtWVMThVA@google.com>
References: <20260319034912.1894770-1-senozhatsky@chromium.org>
 <abt1dsjsT9826Ewy@google.com>
 <CALC_0q_2meJ7T8gvij5oR=idy9hn5rMC_RQhCbePJFVBOOd0Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALC_0q_2meJ7T8gvij5oR=idy9hn5rMC_RQhCbePJFVBOOd0Tw@mail.gmail.com>

On (26/03/19 14:47), Richard Chang wrote:
> 
> I think we also need clear_slot_flag(zram, index, ZRAM_PP_SLOT)

release_pp_slot() does that for us.
