Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F239202F9C
	for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314360; cv=none; b=rZjfDehuEI487oFP4BgwLkokArpxWg8AWEypB3nlAToWTefzy6Xz1gdp3yVP8YwBbfGN5rCPayaUnPaqV1d/WIJrxIiiv9Au8BeXanpnuFJEbM6tDQ6SBN2VSldgXtzEWjpeC3+sFIP0lK1BCGJLE15GtNbAv9sY12bs/ADa78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314360; c=relaxed/simple;
	bh=5DNSNq9MQd9G2PUa7xawgkaNLF3qeJ9VFaixzQuj+fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8k7CqbcGrqXmmluIEujBOSmhUgBJ45Y4H/8wAno0AlCWE0z8FrPJ+I5oZICi8FEMU4apiidnBXDCgcLiC8Yx2t/YezXy91Ynccff4Dml0rROT6y7pFO30B7EjvpsejlvxliMhu6v5Gt4QmI6vZAsCFKWpdmPOT1ZsRXiwCf4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5bnn0Is; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5bnn0Is"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3f13043e2fdso2796809fac.1
        for <linux-block@vger.kernel.org>; Tue, 13 Jan 2026 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768314358; x=1768919158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5DNSNq9MQd9G2PUa7xawgkaNLF3qeJ9VFaixzQuj+fs=;
        b=Z5bnn0Ispxo4KKrrdNp9mDthhQM94tO+LPuOh2EqfwLkZuDmY7hOgXPq16kiXLF4W+
         q7Vv7S9WZ0CTgeTHO7u/MKXkBYrysY/tSlHi5uzJy11Ta/iK5w7m1YGthMQPpPIYEcnJ
         axvtYmBCkROQ8G+cdZ0uqS3R/zvppAkEFfNQExyiaIpq0+JRzoj0opStewx0o8C8X0M8
         6tCZSSMxO/wuRZxHuwTi56JSbapBaSq2Yz0wpFn5lEbWUR5+teu/aspl6R6YtpFjG30f
         o5gICuO9XpNkz1NWoGyib96CH8FBcC2TW3fbp8f+gHRRy7ZlaRBpU9ttJ/nd+ZQ6giMh
         q6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314358; x=1768919158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DNSNq9MQd9G2PUa7xawgkaNLF3qeJ9VFaixzQuj+fs=;
        b=NNqqb1E47v3Px4mogi41yaTy+VXYWFxZCba0O7tQZ7zVaU1B4ZBLIq/06/1+d3b2eL
         Co0M++4g9aWBrMSd4GqlftotRsIQrmHdIbLv7Qp2ysSVCCXLKideuR70hCvEFL8WK+9G
         LFniTq+dIMW1Z4OO8hYQ3spSJXarYaZFI+I1gDysBJ2MQMMRxZdX4fvrM0S+2ygZidCJ
         OF/cZMKlDqLV/WkcWpVoIwWNJtt/rFxKe4fZz5mTc2/26ae2gITwOWKz6oBVtvp8j358
         fk1h5P4TWbmXUZrAwQLEGBkAp7A4hRseSrC9sR17FXqlpA887YRhBtJ1M8ZhGN/LlVT8
         znEg==
X-Gm-Message-State: AOJu0Yye5eHhCDeVIPcdWdrILLFvbz/ivZqOZnoADrNnX9zsqVhjEmyr
	RKbJ5WkePR7u0IElt1nK9VrMJkIB+akbx+bLsB53YWr9+9NTyfQ/0lsXJxXNDo26on7oCf2RAFt
	J6QTle6ICK86Hjd9jsShxV8h6tarhqw4HFUV2
X-Gm-Gg: AY/fxX4LyIpwLosfVTh4axpG0lLIQguvbyI8aSsfLhqzURLo8Rl8uKg2EPFXJqxHh4K
	k+SnJURpVAGpuryscV6nvRxq/A81kVjrdLSsRFhTHbUssJJJ1aKvLbniQrO1zd7DqEzXhbEsaH7
	IvdgC5qNNJC8W/ef3NYJ4sMHXYujaGqPDx/LmPFrif7dgr8cYO+T9rbYVSoV1Pf2KAWLztQ/uNW
	jFjpz8oVwfwXFfZFU41uXd3cMvoYMyEYwCNN/f6q5k0Dk+7tr4lZ7AkNEOOsz4/L1+xMAe9OmTs
	aR5PA60W3JUjwue1vjJBtLMsZWDRlPqswto/vV9aJ8mtHlr8YQ2GO/p5brA=
X-Google-Smtp-Source: AGHT+IGXEVyxh1r5DpDmVWhueY0N+0Jp3e8jPwWMKfuSFBTgriyw1P/K6APHWhYtB6ZeNT6dhK47KGYvJrt1woGnjOU=
X-Received: by 2002:a05:6870:32d5:b0:3fa:966:a847 with SMTP id
 586e51a60fabf-3ffc0bf65acmr10505770fac.47.1768314357848; Tue, 13 Jan 2026
 06:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224115312.27036-1-vitalifster@gmail.com> <cc83c3fa-1bee-48b0-bfda-3a807c0b46bd@oracle.com>
 <CAPqjcqqEAb9cUTU3QrmgZ7J-wc_b7Ai_8fi17q5OQAyRZ8RfwQ@mail.gmail.com>
 <492a0427-2b84-47aa-b70c-a4355a7566f2@oracle.com> <CAPqjcqpPQMhTOd3hHTsZxKuLwZB-QJdHqOyac2vyZ+AeDYWC6g@mail.gmail.com>
 <6cd50989-2cae-4535-9581-63b6a297d183@oracle.com> <CAPqjcqo=A45mK01h+o3avOUaSSSX6g_y3FfvCFLRoO7YEwUddw@mail.gmail.com>
 <58a89dc4-1bc9-4b38-a8cc-d0097ee74b29@oracle.com> <CAPqjcqq+DFc4TwAPDZodZ61b5pRrt4i+moy3K1dkzGhH9r-2Rw@mail.gmail.com>
 <704e5d2a-1b37-43c5-8ad6-bda47a4e7fc6@oracle.com> <CAPqjcqqhFWz0eNGJRW-_PoJhdM7f-yxr=pWN2_AfGSP=-VpyMg@mail.gmail.com>
 <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
In-Reply-To: <02c255b8-2ddb-43bd-9bfd-4946ef065463@oracle.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 13 Jan 2026 17:25:46 +0300
X-Gm-Features: AZwV_QgGmVCLvOrE1mbQJXUeZhWwA5eYHysOC7ryKk27-LWtIhw5TW2eG5CG-5k
Message-ID: <CAPqjcqrx=9HOS7+ywoxqsiTQWTtb5G5wE3ydNLzfN4Lq9W-3AA@mail.gmail.com>
Subject: Re: [PATCH] fs: remove power of 2 and length boundary atomic write restrictions
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi again, so what do you think? Can the restriction be removed for raw devices?

Maybe we could consult with someone else about my question?
