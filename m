Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9A1DEFC8
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477105; cv=none; b=bDkJavidfEnGzssthS+rTsgDKvZVTm+TbOk3KZlCi5Y3Zc1PTKFTbe4lz8lI743Rly+awLBCebTdGOu3fGF3/fA/1MEQP9KssGmQXqlXwQKukFVbiMgwGNebEunu0Re4rKLUAeqWBXl3YlUSPoxE9A3e+3W9QeQ/9cEcZtagI5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477105; c=relaxed/simple;
	bh=Jvo/YhqIjXOfgWKWVr/xOXRXys269a9eHbiCnC4yzcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njawG/8oxNUhUg5Mbfv6zV9u5i7uD/OLixlT4aNO3b8ckoYvvP7MMrGU6w/HEkhqTiT8IR8GjkImjL+oKSsks6evkziuBUan5a7RQzF0iXNymsnK+NWahYJsLPHFLGkyQHsO7Tx+XK9TYjHAtjKTaUdgbiX2F68PgWwSszQEGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LLMVf8lE; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LLMVf8lE"
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-6e900a7ce55so87072626d6.3
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746477102; x=1747081902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jvo/YhqIjXOfgWKWVr/xOXRXys269a9eHbiCnC4yzcA=;
        b=LLMVf8lEuwOKx06CaTrkHHbHABoHe5K12CpvA0w4O1MZ5LRXsozswI1KKLdYxbCecC
         kQdcQ4iTbjcuBYZJZGMytnXH/DoHMLnb7a9c1bTSo96hMTbinO/8Jv1OVZERXWv+3jqP
         dAj31G3aP7HR34JcgKvQbQFjdQoPtE0YbiRPTAOnRxinHdrll+TccIZ2ws3UqCw6AAB/
         GB4zGOYwr2fdoLVZpVmkodMVq2yJZTCLNLj+us3henDckincdmqtoNW4YDIvn6O/yHZb
         +boiBz2gsdiZD093pfEsdI90k2TsOv42Mw/oIyR8TrO6G4ii3evWN7doi7zzX8Qa01i2
         4m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746477102; x=1747081902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvo/YhqIjXOfgWKWVr/xOXRXys269a9eHbiCnC4yzcA=;
        b=TvvA+glnwIAJi54kYr2e9AXbIWrQZ2uLRLiOeflO49VLlIRqIfG1f9lVkWvkANHMZH
         0rXKjXXiBeyBrqCIcXcWLH+XLqt22951l3w6oT6Pm2LNEO5dgiXLl+YESb2GmkwsUgxU
         MszLH41bPdvpekhNCPIkl4hsaV2+uEetFXhAh+KXSxvROJuLI7hmHQVlLv2Jp4wmAhq0
         W4wl0W+2PN298NcJFu0QF150f/GCKBBshUCeXq2zqFWbh6Y16S4DbknsjBEIVD8YDzBz
         RqO/9cxgMuyKgSnzk9u1kpLblPvbZvdsiIaSNNbGLVLMOoFv5pJBzWZZ/AUEtlhpv9CD
         3Wng==
X-Gm-Message-State: AOJu0YzZ2d7Sl42wA5UTbGiFgReO/RUEYGS6Tq0L6R7l9X9HJDM7nUMO
	39Pmew05rHS+spT37wTCH0G5UbmWJNRE1vXmWdj8rTirXD+8Co7k8J8knyDZwSNKeBItVfEwBjw
	tRJjOxMKhjQB5eWt9EjCVQGl3DOf+vrO7
X-Gm-Gg: ASbGncthLY400oQAmLxgDjiOzTmUcHB2yIrNIRKQFdlTpSYHIETfd4ClCeh7wVpHw6X
	oM8fdhnb1/qP5zYBGTkcaMoBiWU602Gn1hIzSTAQO1no7CoUMi8PyMOfJO/1GuAUZHWUocIoQgX
	nJvjz6xbaCJ3T5Z8IVtgZJ09FzK0JNviSiQNsk+ODORGPEDKMk0bs38uIzGL2jpN/KGenFs24hR
	w2H5mjUMPokZUy4ch5BAmB1LPZVSwfO3tMUjTE0m1oT6Rg6OOwimwlxJrHGD4rqbcZdUykMRy5x
	inZNNOsfEyLNOZunpS7bwPip421SaqgxVbpmcbMS6N7kGA==
X-Google-Smtp-Source: AGHT+IFjyj7LaxQN5e+7YK7FuGnLBthZu97bImvgrg9DXkMwiEuu/3ei/Y3A5hwO46/WZOpmK8fMARAjTlxM
X-Received: by 2002:a05:6214:124a:b0:6e8:f99c:7939 with SMTP id 6a1803df08f44-6f528d126c1mr126873906d6.44.1746477102056;
        Mon, 05 May 2025 13:31:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f50f3abcbesm23261896d6.3.2025.05.05.13.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 13:31:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0C6B23401B7;
	Mon,  5 May 2025 14:31:41 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id F1B49E401BF; Mon,  5 May 2025 14:31:40 -0600 (MDT)
Date: Mon, 5 May 2025 14:31:40 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests: ublk: more misc fixes
Message-ID: <aBkgLOxWLp74TShe@dev-ushankar.dev.purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>

Hi Jens,

Can you take a look at Ming's comment on the first patch and merge the
set if things look good? I can rebase/repost it as needed.

Thanks,
Uday

