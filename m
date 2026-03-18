Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A93290AA
	for <linux-block@vger.kernel.org>; Wed, 18 Mar 2026 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773806739; cv=pass; b=YtVb18O3UudBDuNkexedFYWuclSOtgwKrlFEZu2ne3p8W2G9dWeEqlnSbIFInyOtb/WIPj+L/uyc7WlIULmBN+vnnOGIQXHlIsULC4bKwiEOa+eXpMY4r2o0h2d6XCZNcbT2m1qVxYNnZLEr/zGiowz93HK3EdhNz67S5zSPPE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773806739; c=relaxed/simple;
	bh=qEKi+BX0k4c086sEa57PPDm5brYp8ZHhPHPk2z3RNwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1fF7i8ZAStHz5tECPos2Gwg4gGZAPS0rd9cG9ilyignCcdHwXwLe5gl6F2uSJvXZBCeXgydv5dv2m+o7vu8cbzyUNRl9+dJ8wNt6Vrc66TZy2zVKIWExyuiYyIFvsA6QY5IJ6tkSA/oY4idmjEGiL2y7hY/DoOT4DO3Ds8elzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1CtJ519; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1CtJ519"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7947cf097c1so60397717b3.2
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 21:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773806737; cv=none;
        d=google.com; s=arc-20240605;
        b=ASRqPjfcigSzagkvAITiVfYN6/BtPmh6b7lxr9xAP7IgU/cjS3y7b1rClx5l5z7AIA
         HnYDX3OjZzmZjowRXAqXffZESCBqL6E5uKHt7xhq0MBrTNSaXQG78AuGJ6/sFjPHalUH
         mX4TG8omjw1nNCD1RDoEVbAO3qI02EQddD/dmKZPBkdeelVS4IYrmDtbwcXMRUJUTSjZ
         gQnfRzaJA9WFgR8XMFpUx76mY0/8Bg+gBKGynAqxPGqnzmwZxFePeyyp6IaeC8tfudX3
         LpQ/tI+Sh1noOWBDGcU0s+UIYPYyzgpy/946BzC2eolcYEHPOUrIi6qy3c/Qk/ZiskLz
         HDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PPMXZyJwPK2gDxTuWBhIWhpgA2iein69KFknpN9HYA0=;
        fh=6L0qUPc9aHuMWRb/OASNAr2AojvRI+pKw16m201W5n4=;
        b=L6QCRgKCIJMMrF2wpRsIEvmhjQ99Yk9MxRMz5vb4o9EXlbHkQJhEPAEHHgqMW+cGA6
         U6L4z3cPFerO6e5ut8z/u7idNKhOFG83clzfn9r6a9LU4e63Gw/31cufG+d2V7WCmgr7
         0z1yfCaLbB251dKEiLT8TsYpbI/aPgHeFy3y2rMq9QY44fGD/12hQd5cW60TQeouHCnr
         R5D5DJ9gbKgyc0jyXfUB2nJbyNhqFNpvWJ5356vtspYHo7zpSFUFP8wFocSscNjJhX+U
         ghC7Njx7Wpv2YP7R3ia+YZwiyvB9SUe+UTrtjdw3EubgjRO47hmG5dvIZc45svOZ0uFW
         cLuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773806737; x=1774411537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PPMXZyJwPK2gDxTuWBhIWhpgA2iein69KFknpN9HYA0=;
        b=L1CtJ519DbSQLffW/phNHZvzj4wjUm2fnJ46aGJnNeLXumNo8dgdHnZF8Kn4iYXu2b
         y+HJmxvYQI0FnUOrTKMfLAsavdOSYFt4CbkNZq3r0uO1naP+NdT3ZrtIN5bAk8D1u80l
         WD+qHlg8Ttz1LTvt6X1Od6Cax3hLIlB7DO+3hgMF0n2qAR3ONAua/D0oz7CFPKgekfaW
         8UsYY0d+FNIaz4A61hmjg5pPmo0ileSqpcamX5MqmJk2fKcGRDWuOlrDiRpaEAT2CGFh
         oacO1dBHIhzozev88fyDrpm4W1J3K1JasO+FcWU+Ax9D+YsrD07uvlWqrLLsgW9641EC
         MYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773806737; x=1774411537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPMXZyJwPK2gDxTuWBhIWhpgA2iein69KFknpN9HYA0=;
        b=F+ywuxRMe3GK3Wt1rU9sdupW2L1Jq5fsUqqJ9bh/4yICCd3Aj50wabWm6E7LC3g5au
         hUBNEc+vub62xitYf46Ufvm9v7nGmj+fwDSF/0CKnygoR9fVRSjMx+9t57kRO4CaUJRE
         IFwz7XoYcK59yzFItsU8D/hxnsL1UX+fNC6FflmIZVnCgIya11ylMrBzRtabMD1Rgf3z
         vjeVXSTg5/VThcPiCJ/tC82E2yDxXmiuoZi33rmurcqti9N1C5aHhf8LixkFEsFEbyeN
         GZ4kI7H93gu8ayp6AoagvxZ6/hJ42H10D1rtHl3ZSqU1D+J/k124ZATL3SRQr4SBpHCr
         WoMg==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZAP03Et1uo82uI6JLnURWhYXbm9qZj7PIdhzjhJ0n6+vQ2nTq2TrjcbdcRueqVG9R2l7Cnfri3PbzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCImB5NCRg2ya3IqDN4Ih0GDF2rYFESaRL5MJ36yENCtNIaMXq
	54PdcMPl7kFVJG/Cr47jc1we007ggJQYLPMxxY0Xe7YShxXvBLRMYYQGWN8Ye6M6g36v8pIkU31
	YLFOpI04czBi2dVgz/xfmP8joon5QidQ=
X-Gm-Gg: ATEYQzw7VE/ABOd3als1seaBR7D1TRgXHBMfChTImQdO0b+uNjBgJNFNNHvWsdwkl/i
	mzugWUHlUr8TSlLtotNLKw146jHXRrrSy1fl8jrW/FkPwybxuMzjvjDchAmVb2wkzgBM/hALwbP
	tWWKr7+PJL5HkHHKb75QUVBPbpUwH5o7uTV4B8n+yqDAzJO9KQ/omV5h8lQC2dFKi6HIbqzeEt8
	8jlzc6nX200eSSq1puI+S494HJgurGB0wG16KtR8GNXrY9mNIL4hwOVACBsPl14qwnznpvAgmJu
	CYFjAME=
X-Received: by 2002:a05:690c:85:b0:79a:4dd6:13ff with SMTP id
 00721157ae682-79a71dc2358mr19283947b3.59.1773806736583; Tue, 17 Mar 2026
 21:05:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316090826.2878527-1-zzzccc427@gmail.com> <810f2e9c-c8c9-47ad-9ea0-b3a15d647453@linux.com>
In-Reply-To: <810f2e9c-c8c9-47ad-9ea0-b3a15d647453@linux.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 18 Mar 2026 12:05:23 +0800
X-Gm-Features: AaiRm50hKWSng7y3hDiArZFrRC0KX-F1f6aXG8oDed32Rt0NbTEqfLaRiFBTE30
Message-ID: <CAFRLqsXphjoNnPKJU0wBp1OQwxDX76ezUoaN4JEEP=v8OOSsnQ@mail.gmail.com>
Subject: Re: [PATCH] floppy: annotate data-races around command_status and floppy_work_fn
To: efremov@linux.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, r33s3n6@gmail.com, gality369@gmail.com, 
	zhenghaoran154@gmail.com, hanguidong02@gmail.com, ziyuzhang201@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Denis,

Thank you for the review.

> Please, inline a KCSAN report if you used it.

Done.  I used our tools (a concurrency fuzzer) rather than KCSAN;
the relevant reports for all three annotated variables are now
inlined in the commit message.

> WRITE_ONCE(command_status, READ_ONCE(command_status) + 2); ?
>
> or with a temporary variable.

Good catch, fixed.  The RHS now uses READ_ONCE() as well.

Best regards,
Cen
