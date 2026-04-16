Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE83E3C6F
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353902; cv=pass; b=usns820IAvsn3BXEPfb+cciwANQhKKxdgx6jsAGiCDMeZTTwstw7CSHhsmbpBT+XNaMojBXygnK3eMwRl4HwAyM4MmuY8Pdwfd1xdz2nYJrOshRiYQOqPwe/peMJRGF1boxOQjlkucWHwtASCtYOTDDGLjik2UelZVAH01I+gA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353902; c=relaxed/simple;
	bh=AWxB0J1B6KAtOPYtjfiwdJN7ZhgoPpnQloeJYrsQ2O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9+Xpz6szQR6Xq8FSV6LE3RZTWlsjMiOxdXe75fwhRSDi1BoCOgE8X/+tqnDy/pTLO29ZE0weZQtHghhzYnO5sbQZSpQrYzNw/QAolP3htvAUwaThRTvN+z5PwfiyK8vX9WC9YUlm/gQG4uUwImwcizNEKNsCA6ivMdD6g2DCDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SBa1ougG; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SBa1ougG"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dbbf1e1058so548210a34.0
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 08:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776353899; cv=none;
        d=google.com; s=arc-20240605;
        b=SjT8/HKqp1hRlItWmnl3vsmepZwsx1wsSUvewH2CgoAMzk/nX9lbaTW5+qQWYPitXf
         iWRlce0U1mKSEkzyT+Se1pIutoJ24Byd6f+egQs/BqU4DZYs5DppxzxzyUQOfX4KxGCE
         tp+47HRnzrqWe6vv4wEopAZ9N+C1pgjAUbpnL9q2moCucv8ZB5sXoG5T2gyrhA9pwjr8
         E2YzXdisMfFCKxYbg57RmX9Kb3I8VkXGXeKHoGkZXrHkQBIOJPyXImQGosbdm7D+f8WH
         QLqd0ZpuO4k7ksN+3lb4z4aLLY5l9+T3uNM55rMkhoIcFUHq4cSHPNKSAcF0uheUQdO5
         YAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rO65poDPP2TbW/BEGrFidJzuG0j5NALbmB0fqJgYvtc=;
        fh=4ieScxZLoP92QAfIpXwQ+1KK5rPQk21ukvhb+LkO7I8=;
        b=UTmj2rUvLx2e9NJ8uaYAk7QkuMNcE7upys/rQpzIqyPBUZCrKUHSp/SDQkJm3DHemG
         RB+E7exDwkQ3FMdcFnvF3PW1T0JfV9ymVhYkAH/+bYlcx85BzUZoHhG7/kWT433jkr8L
         xrUyX1ZaRfqbdMarsSGMnJxEGz1cetfYLKQRuUTiUYsRtVNomoqH/aaebeM9huAgrF5+
         8lphSfm24LrVRoxEX3MA2u0cvHQrPdXNlMAMESvOccgrOJxx1e1pf0ukXXOPvLvmtsvQ
         zeaaBryt2VbuW08YxX1FyI6sKlFlEvCRCqaHVXjKOCO0KkaVyih2bfvsaVeQl0PKHVLy
         7kBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776353899; x=1776958699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rO65poDPP2TbW/BEGrFidJzuG0j5NALbmB0fqJgYvtc=;
        b=SBa1ougGt7Bbg/L4kED8H3h5MfaSe8zEW2zCVcyWDN6Dph84xWvhl9657MApRlQvt+
         n4hhbkWh7aDtMVG1O3zmKxxi8yUriEd69bkIGjGtZOvogAH1YSO5+oMA63gAwidGkvT1
         w3tYInhOu/43JJqgVP34tfL0GLwuk0sxSpio8tJwU8YX1McRG6w8dBzSf3aEjEF9Y0lF
         hm5IY8O+hZtkX/rkdqag9dLTITeYY281rH+B+YVYX+ufk5ignirYLwXzJf8Xmdn0HkYr
         QkPr3GWe+1drXt2wb4/7l+E2Ku3DNhLMOkPxV2GTXbNQOxEUIHHjFlQI6iZg92DVW3h0
         ZWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353899; x=1776958699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rO65poDPP2TbW/BEGrFidJzuG0j5NALbmB0fqJgYvtc=;
        b=IUNRJ7HeOlZyHWxCxqJ9127dtd9CC/y/JwxA3SbL9NRBLPqN0PcXTiPJ5s5urhKZ8j
         xV98h3skqZF3Dv6MpjXha821jn10c+OCJQIuoSAsZBx1anIbu2aWiTYSjGpL5O/WlI6f
         50b4Dow9mSo4KgdNj1sRtZB3MMjEhoPazs7C2Ur+YCx4vwQahrHMECBH8ci4EjsSanmK
         HttLdFHtqJzxkskQ8kF5Dq2VEb+2kvrv9+Mxd6cp1FVTJehaBkP1slk6AA5cNyJoqV05
         V8KwhYXLgTeu02YM5mEAZfb2VQg7gwnMKPkcci9G5vNj8x7F6ZFi8k7tY1MzxapWacRn
         ujqg==
X-Forwarded-Encrypted: i=1; AFNElJ9ElUWp5i+MQfcl6EY0CPibT0bEwfdrVQ+2fazshV+FfTd34ud4SlATtmpinZH+U0vw61WlWF+/QfgqTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzO469mMLV9HH+4UDlTWHvrN0nsmU4t7PD/GKtBIq9FR0NUMEJb
	bG8o/0yj/DRsTOpKCbRxCKnNHlKKWIsimtbH2aFXdj/HvD+s5agP579aegi1zAPR8skNN1wskOZ
	Rnv9Jzx0G5Rgykj6P9K4sjscyPotMLjM5zghigrjTZA==
X-Gm-Gg: AeBDiesDg/KIRt+qy9gX2cGsbWDOVV32a0peJHYUTjSbZ1qZQwRfpVQZq4TSs5pl9pd
	M7H6Mn93/uw20AJdOcV/4Y/D/nO27UkoK6aU7FG19IQ8I4uJDQYyEH38c+92wgMOqnLB21FoUKn
	pbR7rtW0+HnCdALyAoS8ALpbFyO+1q2ydAJzOE/73LZZs5JDp3iZbLUxStSfdRKFa1TkqIqX320
	SZq+QFD6hmawt44kF++GEZx/kxS0liUfqWHT5+qAinEMzV7Vui1sUXF3HKOn+lChZmkjAYFQLpr
	2s+zBNXN35any+YCUQ==
X-Received: by 2002:a05:6830:348c:b0:7d9:b338:a669 with SMTP id
 46e09a7af769-7dc83cf961dmr1163907a34.2.1776353898946; Thu, 16 Apr 2026
 08:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415210847.1730016-1-csander@purestorage.com> <aeBxOVmQ2bLli78f@infradead.org>
In-Reply-To: <aeBxOVmQ2bLli78f@infradead.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 16 Apr 2026 08:38:07 -0700
X-Gm-Features: AQROBzAYjsmVYKZSSCDVvPyzGlyPCSBq9VE4-_297gBMh499ii0YGZaNdUE1y0s
Message-ID: <CADUfDZpcNG_GPpZYh9tWKEBjKHD53DVCmQGTrXKQvBpP7PCqsg@mail.gmail.com>
Subject: Re: [PATCH v2] t10-pi: reduce ref tag code duplication
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 10:18=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Wed, Apr 15, 2026 at 03:08:47PM -0600, Caleb Sander Mateos wrote:
> >  #ifndef _LINUX_T10_PI_H
> >  #define _LINUX_T10_PI_H
> >
> >  #include <linux/types.h>
> >  #include <linux/blk-mq.h>
> > +#include <linux/wordpart.h>
>
> We must have already gotten this implicitly given that the code
> already uses lower_48_bits.

lower_48_bits() is defined (and only used) in this header. Yes,
wordpart.h is already transitively included by the other headers, but
I think it's good practice for each file to explicitly include the
headers defining all the items it uses. It reduces the risk that
refactoring the other header files in the future will result in a
compilation error here by dropping the transitive include.

Thanks,
Caleb
