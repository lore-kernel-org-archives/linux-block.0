Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D13A1DB
	for <linux-block@vger.kernel.org>; Sun, 12 Jul 2026 01:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783818384; cv=pass; b=MpIgd8M1IwUJiSof4B4PMtpP/HYS/imNg6QsasPWUQwhXfuoVjKvO/FvefwH00tuNvO3xO/59LzB7qHrvxh/Bs6ziPwRbw/9A84/10fu00IQtO4+6UZ0D1AABzNcODnXYKeUWc6QeuDkxNB3Bp24It6NIr5HbAjV9regG8/O9XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783818384; c=relaxed/simple;
	bh=IGzq7ETeJY5S3VO32m1zptipSu2uzAS7cUAAkmQv2ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REubApG38ALimRf6+N7CUUW9U9ter5tAx5gnnrj91/L5/q1lZwB1Im3DvwkigA2auwamz7yqCb8/0+PfNXctqH+7RFkSgXwjNcAYjRwdsG6i3Wp3WJIHy26Qxx5Simgvym3sXcMC8HH/oOf0LRWeJZkfeNTLhpZq/up8GEljzyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4VKO6pO; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4VKO6pO"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8111c0c7561so22188647b3.3
        for <linux-block@vger.kernel.org>; Sat, 11 Jul 2026 18:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783818382; cv=none;
        d=google.com; s=arc-20260327;
        b=pwEnEZvJL9O/sfGnV3qlfZZp3rMcaj6pw/yOoVuCj0gnAeljNr/lFUSz9u7PYgcYN1
         ckXrJsnir+dwXCtOB8l/2/VjDQNyMn+l4CQGYwq37RzcwiBjtWdx21/3RGZ1awkSN58c
         nEET9xg192VuKj9WNj9C3SpdX3FMzoyDePz3moE8Iuu2xQO8YbYR8GYLKAB8duvwrTQu
         N3o4ttYL0lxvFmTLMkahZkP66lYL/6ncocwaHu/IAfBi6AR3itWvLaweoSzyG1RhnAuP
         MVWmrcI36DObIc/oa5jHxVAMxY+3a5fJfPsROhGlTsZSr9xii7MtkBqPS1Sc8lQ6etMX
         aE3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IGzq7ETeJY5S3VO32m1zptipSu2uzAS7cUAAkmQv2ck=;
        fh=KX0rn3KpL8tj9EVWygt9qRwTWbMZJBZDCkDJTBgp910=;
        b=CW6u4hnZuUilpvZiQxwq5mQqXP9shN4NRzDyoD7IGKVTnSBr5zDjzvW6RD7w2kC2HI
         ZiLcYhi82mMM2ij+YQC2w1qRCHoIfufnRfy1vBA1D4igyyYj46MW/IrbE0mIXIfNHmHH
         s6lz3tOZNO/eUNFhwfmiufUq5zQmbioMNgaNntXY0eh2YueagsFMROAmYYvpiyDpVO8S
         LnRrRIB2n5pytTw7L9dqP66JgX06nywy6tbElzXsJ9XuhcOELM19tB3XOK4y8X1Q2SUH
         ad5GwV+KlGAOi5Er4KPLkSuqVuR0S8xLmReogUfLo3GuCm+Q/vvnjJl2tf0BBo2zBBh4
         e3WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783818382; x=1784423182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IGzq7ETeJY5S3VO32m1zptipSu2uzAS7cUAAkmQv2ck=;
        b=H4VKO6pOpayD2q5aJTs7Ube90mKDFqMlKBh5tyO5QpSaGY3jUs768TSWg8HnJM6zIo
         dj4klyNrJx0Te+BbfBO6M9hHXN1LnJoLKnfuyBQ3mdLpE+URDfeE4MOtglEorf6xEgqR
         eAvgVI4gwFy9zc9T1y/B6V+2ewOGc3zRcn9eTD9BlQrBaIwGT/YWTlKiWFMszn40R12t
         ox6KCMhM5AnQ9/2TWBtxWHB+7/GNTxbQv8+aV053HguSaw2Fs9jXBX6uOCC3cBAFGcp/
         22E/5JLC8b4Iqxqcivn13gR10A18nEsBlELShrTtPAE37kUoxiGgqJmQKkL0CAQS4C5P
         GvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783818382; x=1784423182;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGzq7ETeJY5S3VO32m1zptipSu2uzAS7cUAAkmQv2ck=;
        b=e4txixXlTqeDjEq75grp5yLuyHsoE8/oqChm9aysiyi+6r4+BlDdDZLT1mrs5aB95p
         RA5flhRBWi6rH6J47yjQx5e0NWLpdWScdyKqfGDPsVRPS6UZSdzMuG4Q0a3v2uYF1HEq
         ajWiFRX2U7IwnMWKsCeCaH0O3MJBf0EdwUGCwr0YhmdOsQuVhLAoB3iiRwARHIUJeqWS
         b6nb4FxnrGVHrIhBWEPsfxNTaAIHuoNB1eJt22Cn6vBiiPNZwtbeOWMTT3X9jvGI7AlG
         TMyaf3oCmlOOlhgLmR/BR6c1z5ZCC7QV1kCLs+//52H4S9j25fhJO0veZgYcy+DS+lX+
         7PVg==
X-Forwarded-Encrypted: i=1; AHgh+RoBBPlU7WzkBDy8ODxhV59Cbj+DXP3iW/09zCl0gZVT0Yoc5y0QZeiGvj4mQfB8/8uLd54fz2WmZqxg+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFuptAHu2/C1kS+CHrrNCaHfKxs9n/XJp2tkoI+0JxSfmaiCJC
	9/xf0kaB+Jz8Wu50FgrTUWrD4LDHHZCEe6QAzIUt/isDLEMuyQ0Xzr1yje8qK1fT6J6KU4tinZq
	A8URwdvj5u8E+fUL0WLqRRPktYXZKzz4=
X-Gm-Gg: AfdE7cl6ktOsanS9+VdjvUvOy82cld5lArX0BiyWffmjGvZsJMxy3bUBq3nfguPruRg
	X7QVB9YjebxlzolaTDhneMpjSGHCjB3djD3VITkfmllNPSZ9csDBcyiz5B69UFxVrSWpJ5H5iBk
	p5nOE3MN3/vClDsmrL9mLYzjAvfSWJNehZUiGnB4uar+/72O4pMdZwU/xTLe/K9whoNo2T703Gt
	xbWh8D1HRUrMqRF2e8aI3CRDVe70ye0OWo3WQJKXMLiK18ypOUhRzrMzIO3c6RdGHKt29bJqyJz
	cc1FnVsQs+0sDqgkM6BlRghzhA==
X-Received: by 2002:a05:690c:6005:b0:80c:85b6:7654 with SMTP id
 00721157ae682-81e9015e694mr32431107b3.57.1783818382373; Sat, 11 Jul 2026
 18:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606170721.1530005-1-michael.bommarito@gmail.com> <20260712001902.14177-1-jkrshnmenon@gmail.com>
In-Reply-To: <20260712001902.14177-1-jkrshnmenon@gmail.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 11 Jul 2026 21:06:11 -0400
X-Gm-Features: AUfX_mwho5kVjGKanFC924Ce7F_anxJasbS6drQ32hpZxFSIqbE6fWXYr0gAdUs
Message-ID: <CAJJ9bXwo3gKk4hvHbg_isODY12Aspduf_Zht9T6WX5frOob7cw@mail.gmail.com>
Subject: Re: [PATCH] partitions: aix: bound the lvd scan to one sector
To: Jay Vadayath <jkrshnmenon@gmail.com>
Cc: axboe@kernel.dk, kees@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2026 at 8:19=E2=80=AFPM Jay Vadayath <jkrshnmenon@gmail.com=
> wrote:
> I only confirmed the bug on an unpatched kernel; I have not yet verified
> the fix on top of this reproducer.

FYI, I confirmed no splat after patch before sending this in (although
that was against 7.0 or 7.1 I think).

Thanks,
Mike
