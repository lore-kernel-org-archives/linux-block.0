Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284424734C6
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348387; cv=pass; b=eCawbjnOjRp6YZraysKpzahilc6/FZrtBWoUXxBm8IFQU9BtaWn/c4U9wQVMdMK55rhdYjUdf8EAaDfMZmyNr/A5UWl06ugOMbXUZsrc1Si8R3GbxdgGRxAUDss0ZxdtndRxPORHb9zi7YnDhs0lpUE9K6kiJ1bwLDju+42Kypw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348387; c=relaxed/simple;
	bh=FyDbbZPYKYMWaFjRS+uVtqLuXGG9Q0hCZIMV3hMspcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJCj2z8Ur6VzRvUopNorpTUVeCOxDzc0XmR604dzFucJgppnPue1eUHoHjile82THgiUl8beddFJ7g7rLI4vMlj2FjQl32fdU2FbgsIVW7K+TlvN1uYPF0dFnxCCPlLHdY6SJxlxEVPDzsLovzaLQQlWAptovGuFOAkcejSdohI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oat9md8c; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oat9md8c"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b1a1a442c1so563117eaf.1
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 04:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788348385; cv=none;
        d=google.com; s=arc-20260327;
        b=rMxbIUpO7EE52xDKn7fwqWI59y0QHAqirPDj7q2/kAtiIqJdTVh6bgji40qccS2moQ
         kJLG5vxxqqzYvTuLeX4NFegsVmresnnhfV09DLoocfkN8Q5nt/AZ8xE+Loox+FpXuo1X
         XcW6TTTpkSOitCZfhVI696Og/VasgeeHxhLq9dRSm3z/xsoynorfJIVvAwpczPeUyxXH
         RN5SQsRq7BQBhYfPcYyK8cTlmqEDBuXiUr8lXYNaudlrAgJHo7UGAG/MR24wBhtZsq6i
         MLrb946kFk/APJuqrCNGGk9HHPa3KmVaB5yMEB4HqFukP9s5ILvKS0Kxn98wEBC1v57x
         rzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wcmJkyCZLmx9JarKkkbqP9BwAVB6mlEmU2z7IeOq2cU=;
        fh=t7rbDgC80YntJLykmO8DAdwSY+WZO22w+lpi+SMC9R0=;
        b=V9KhmR2IQYp6uvxedV9UYo3ftU2IAhjP1bkLx/+OI+mo251i/Jabtu4nYIDWwD8+DV
         h2JOaR1e3YoMA2wkPQAatS53S2kd1bZQ5leT0JbK+f1bMjqBNT6DMoijvmOIMPUVN1Tr
         ekXRHSIBFnLdJjBx65IU0u3qqFFZyftH2jV/kMbHLvpDCiwQd2iIktZGx1oFpu0Zi+MG
         VG6Sdj/JQiL6ESSI/HUkmMPkur1DWqwsq647ECx0AVX9EXAsZXq6iCulv+bSCjyvToeB
         Mxq+gJbuiT4FzH8tLZ/fzqWrqPSC5eN63EwdC9DU2BcJvLivyr+Z5e5HNH4I0AYeE+kD
         76ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788348385; x=1788953185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wcmJkyCZLmx9JarKkkbqP9BwAVB6mlEmU2z7IeOq2cU=;
        b=oat9md8cLHgMKacdTbsFMfULsSoFZ0Wa33mafEkAUUwUyV11mHicsJ4tBTXkYNIxa7
         N6ZFqx6BYmGETOEATtBFlL3YDHe1ANJy+jREDXZIcHOwJEGmKwtchqrHzoB3NYO3WRAm
         5TRMqejHd6AGihJ5b4xLSf1krLPv1Ix15QikmFMOlqyyddUc721QL7DpxL4yYnUdRCpJ
         u+r9uQuQ+nqrjfl7fKp3H8kNMyl/GsrXQsAP0WuaAs154WCLKW9DngnxrxF7Bv56rOsQ
         GkWS1VpEgHbGgpXdN487gDjtsjPqeHA/CXgAj+BoYMvMd8y3/cNnLHDuW5xbILfSNNj0
         /Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788348385; x=1788953185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wcmJkyCZLmx9JarKkkbqP9BwAVB6mlEmU2z7IeOq2cU=;
        b=ZPnhqW3c3BcWA3pJWWYsPEPL+qHC5IVlL9tUNWfAO+AyIpNrihXkZOFB4OfAQo9W+g
         SqPP7Q3S0QN6FIyOs+E/0A4u/4qaglkJKTk32f4mj4dvLoD8mT1h/ASjv5ZtjlUvi308
         HKFCe8gNJEH0Nog+VI1XJm0fcK7tYIzgnLmnX6jQGggaUJZeDa4438+lC/tAnE86FftV
         7NmF5BkH4PfpRsvvH/jlRABfHXX4wEm5ivSIZmuoKzjg0NRyC3ST3FtirPyurWStTqCt
         DnnvcshFHajg9lyzjyfIJwexEFZD15RPux+rbQ3YNfRUyPIewLLel+HQnZdLRRKEQuMY
         mAEw==
X-Gm-Message-State: AFuF++mhD5SfhXpLUYZDPdA0++BgH5T97yGMcpwH14dxtEM7N+DeKvJO
	MV5SO6SbI3TH7wDPWGDLb5XGI7dg/zEyYzr3AOlQyZtBcvwkJs4dq47FV9dM9SDSMbF/UCerrh3
	K9pZJ+iR2sR/IGJ7DTTBt/kwjpGn85uA=
X-Gm-Gg: AR+sD13pWE37fZW+Dr7jzYdPKQ4yFl66a5CnSFmLzH7/Sa4yt+nuCD73UWg/zOHR5DO
	HZpKfTOkWdxE/bQIP+HksDL90MDPFTHciHDUmpG+Bx3PyUSHw2VtpAztmnxOahGN6mytsVas8wt
	mviL5zyS8G3ABQMjeh3ETTiDggnSyhFyEoqEfXOxpWyoNp6rJ1oFySluNprF49OuAhQVVMGhkpF
	nuBPE1NosCfFxC2/+RV2KXs/Ecps5XVOCvygFd4WjM1FXjFDqQvy/4rKptiKrWA3gj/oQhTuAJB
	c92dNnRhOBvkDVUxQmVnw92TvorQFAk0CeHe8hL9wFN4+Mv4JVEoAOmXoWoVDAvDjH6dXs4amRR
	e4HlhPxZJPbMZlN40kimuuetDVP2wpJNtqWflNSeFFDzP
X-Received: by 2002:a05:6820:4c83:b0:6b1:be9f:ce6c with SMTP id
 006d021491bc7-6b47ecca88cmr3371164eaf.4.1788348384937; Wed, 02 Sep 2026
 04:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902064437.1376-1-yanlonglong@kylinos.cn>
In-Reply-To: <20260902064437.1376-1-yanlonglong@kylinos.cn>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 2 Sep 2026 06:26:12 -0500
X-Gm-Features: AcwNN1ULId5dgyvfzhvLeQbUKIYfl-Wufo2Tsfts7a1j3EvoRrStToG4vaJ75pk
Message-ID: <CACVXFVOYhYd14pvXAVni=tCnbaJ4AKbOh3y7L=0qWY9+e14=bg@mail.gmail.com>
Subject: Re: [PATCH] selftests/ublk: add NULL check after calloc()
To: longlong yan <yanlonglong@kylinos.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 1:45=E2=80=AFAM longlong yan <yanlonglong@kylinos.cn=
> wrote:
>
> Three calloc() calls in the ublk selftests lack NULL return checks,
> leading to potential NULL pointer dereferences on allocation failure:
>
> 1. kublk.c ublk_ctrl_init(): the allocated `dev` is dereferenced
>    immediately via `info =3D &dev->dev_info` without checking for NULL.
>
> 2. batch.c alloc_batch_commit_buf(): the allocated `t->commit` is
>    dereferenced in the following for-loop without checking for NULL.
>
> 3. batch.c alloc_batch_fetch_buf(): the allocated `t->fetch` is
>    dereferenced in the following for-loop without checking for NULL.
>
> Add NULL checks after each calloc(), returning NULL or -ENOMEM consistent
> with existing error handling in the same functions.
>
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>

Looks fine, all needn't special failure handling:

Reviewed-by: Ming Lei <tom.leiming@gmail.com>



Thanks,
Ming
