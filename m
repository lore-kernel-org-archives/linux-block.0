Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170237AA7A
	for <linux-block@vger.kernel.org>; Mon,  2 Feb 2026 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045696; cv=none; b=tbqouWL9lE6NeBp451ePHA6rmaXShghUM/5Zp1s5Efu1T1pTHIup8dgYBzEN4JtWr0nGWwJHggAkFp8PaDeKaAzcy080EODhShKPtKbbV9dG8wAXZRhMB8iqWSO1Ps0bDM7hhkJWLMvR5/Np6XC8EJA9fk7mZwxkd5yK6BlbZ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045696; c=relaxed/simple;
	bh=G3wxvRXndLSCindh8vH66Wtzq/2emkXFLla5F7qesDY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nGgl+snk9JOrpuHfMqrHy37ZKZ7hJ1T8NdhsvoYc3XDPPd+ZuDIryPb5gszhJzlq4AXISeIiIgIMfiYx/EVGhDP/5OJ3tOB68YhUBgRYJVE3C4TUR/lieK/rsseedFJm9ZuSlQ3a9Y2KtZmM4gIs0SjYyRw+NlgBniXP2GJC4mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vZx5UPJ0; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vZx5UPJ0"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d122733808so1832729a34.2
        for <linux-block@vger.kernel.org>; Mon, 02 Feb 2026 07:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770045693; x=1770650493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imqXtXAMqjwqrZJ4me5EhkyiwWuCH+dNooCxlLycMwY=;
        b=vZx5UPJ09if8e/jSsIXOixnWFq0loEL3oLFdyG2lARBs5WvJmDk2szlO+M8NjVz9I0
         8/8TK3flpS3q/bklQhL49RhU9wnHR3n3RJuDDvpTot4cFIYA3+jhlZ7tphF9X9LVcREt
         pv7XkSCy7axMsUQ8Dim9IlpkTDrts8kl74PAXvy7fiLx8nJ3pSfWiLclBaNpleQWhKK3
         ezYIxezKS9PiFSRbgFsM0Lr0yKtQf2zZMZf0SztIEoAz1AWyruJNf6gDfvkMbGP6JEPA
         Fmwk6tZxXZ/TssRrWW+4uZYK1mS4FYG4DUcqu0d4l8H+rtp25yvy0h42PWlHG1aOpacJ
         tYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770045693; x=1770650493;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imqXtXAMqjwqrZJ4me5EhkyiwWuCH+dNooCxlLycMwY=;
        b=FsoDPumfSc8ktP2Qeni8gCMwBVbKpGOuysauOSdlyOR6itjWvxB1tMCg8No4zl/YRl
         FKP4ssWjybLU2S7Ksee+AFkQNQTZchZA3SSpGsfBinNYceAIL6XQpLri+BNdoou23/rz
         x11NCDgMGQaxxOdtmtEK4hLQ2lQ8reNcWWqyPh8PlPWBA5FfOvNeK30j5OmIG9xOo7tR
         8Dk6eAEg0EgnMUNmuxRJa6z5NUP6N+vmcEdcNRH1ihM9yOCDyinQa2vra0sT87HR1QZ1
         IbmmuXD0akqy4snG2LK2jht8IvfqB/5kVYUFvLqojBeo3P6YS/VyIrsIFuF7Tt0z0h4j
         C5kA==
X-Gm-Message-State: AOJu0Yzkm46Ft04jGybUr3Z4PcxX5yBrXf1vJSq6rw/TNATdQ5fMmJjg
	W+i2ptrtK/j9q80rX9PGog+kRZEXENrXUx69fHtNophB8UFZylYyq/RRL8cKjbtgn0X0DqRqiek
	4tD5Wt4M=
X-Gm-Gg: AZuq6aIKLa+tbSMbXPwzIi7PvDX5vEMjfaJJONQP3FBG4xxhAeZ6SiRQi1FImRm792O
	+sox3gkZhTbzhtSdfP3OWB+TEBjgh4zKvhp1J/trJeCR9VEVWvnAdWXe5Rad2xPouBNoOJkrta3
	IjoAOAzi7b9S0LnpZiIH93rLDbkDT97bwqpYABWcx/OTzBNQsrKhI8xV+5qROMO1PY0t6zE3vgY
	IA2O0Jhy8LLNE1glxoRYJxFRI8qe7UVq5b+zQYTgMNJNtXLLv8+QksPHZgHocx8Dmuzn6do26pN
	RmTips7Yih3Vd3sB0t8Q2uA+w3IYfPmuZzEr+xVNw7Ly7ZGxk/D1tjfwXTo+FQ9d4cxHG2TeXqm
	5QJKGzNBgJpo1OI9p9oDOSmjGhHOpWa0Doz7HLwi55S0VdgHh2oqQc8g0zmenslP/B7LgEfvPnk
	bYPq66bKHTWRKhuUKp5CBzW7452vFXW9t8nE21tItUAX3Vz+GjoDobQ9n1EmNwoJCh
X-Received: by 2002:a05:6830:2113:b0:7cf:d744:4e2 with SMTP id 46e09a7af769-7d1a534bf43mr5309902a34.35.1770045693249;
        Mon, 02 Feb 2026 07:21:33 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c7ffcbcsm10613171a34.24.2026.02.02.07.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:21:32 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ondrej Kozina <okozina@redhat.com>
Cc: gmazyland@gmail.com, jonathan.derrick@linux.dev
In-Reply-To: <20260130163402.571854-1-okozina@redhat.com>
References: <20260130163402.571854-1-okozina@redhat.com>
Subject: Re: [PATCH] sed-opal: ignore locking ranges array when not
 enabling SUM.
Message-Id: <177004569230.1085433.17763154253309288629.b4-ty@kernel.dk>
Date: Mon, 02 Feb 2026 08:21:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 30 Jan 2026 17:33:52 +0100, Ondrej Kozina wrote:
> The locking ranges count and the array items are always ignored unless
> Single User Mode (SUM) is requested in the activate method.
> 
> It is useless to enforce limits of unused array in the non-SUM case.
> 
> 

Applied, thanks!

[1/1] sed-opal: ignore locking ranges array when not enabling SUM.
      commit: 06564bae93d024e346c49304dfb4e2aaa68cf620

Best regards,
-- 
Jens Axboe



