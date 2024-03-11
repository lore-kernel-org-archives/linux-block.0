Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAAD59163
	for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201530; cv=none; b=o9ligQlEIRqNSkW1Amfx3eBQzlerXbgXP6G0/DutJdfFNB0uK2upsUjVQMPhStdZ+tca2pvXCK6am9HtN1DwDT1qIcoAStG5cyJW7NLZh+ha466RzzrGCJjQ0wOobZNjHxuNlSSR3Q1Ega3TyBq5BCuGf45o/AoyCuFdPcf13BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201530; c=relaxed/simple;
	bh=M4jw6dZydMkYP63oheWPsauxNdA0G7X34TelmM2k5ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3oC5tFNQKqW8qJf6v79Hj1jheMaJb92rFM7jPnUb5mqsgHaw6Iljd98Bk8NVaMASoeAVjApKZDucKbs/eKXlyyMh77wxPLZWpAGl4+yNRVc2vmHGAf9UWpAzsAZjzMKVoW/tuI5BSrzeSoHrRLj88DRw970MO7X89+Z9HiGQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D3nTu6V2; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D3nTu6V2"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512bde3d197so4215035e87.0
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 16:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710201526; x=1710806326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=etT2ZFDYgnSyOcTBK0rDd9D2Pw5wbVfY1VYVbEe5Sy8=;
        b=D3nTu6V2UaMBVVOhZcXHCHEK9Q1JeEqWPMBYZYa1U0DUlY/Fjwf9MgntKaxFvnOK5H
         nKfYrEkANDaLsQP9JDOo9qPaH8QhSgVKsxMkETcYdy5P4bIOylxtEX0ClGcoMtdwj2n7
         3hNGYrm1KP9JJlbxkcbjeXnckRtWOFS5OY424=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710201526; x=1710806326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etT2ZFDYgnSyOcTBK0rDd9D2Pw5wbVfY1VYVbEe5Sy8=;
        b=WeiCghB6J5eQlGuNKSJoutLNqigOIfyuZIXs3FNt18DDwB9CGlnCWWxK9TqSZPh4Mz
         zLUHk+WXtADdjZi8K8ONQIoG/7ixI5Uh5Ud4CkeBlx27+Ucx6j81UGJpugERH+pqywfJ
         x/MKwrSdLqiEg+7tO0bSzLfRCvYFF0DfoN4rScZVDxDi75tyoSB5iZshu4oN+aYheoZ+
         OJJQdL+VIselGkjVcGQ8LrkLxv9wv3emYuSkexcV2yLcizQnm6caTqDyAXkA/B1SFW+8
         dM0x6rIFYcxzV2g5/rOhge9lgsPOkIKm/zJpDaX4+E0DNTQZ1kr5lpwaEuMm757FRcQ+
         Aihg==
X-Forwarded-Encrypted: i=1; AJvYcCU3USLYnElbcYnIlNER1GWbc1dIL/H/ViHm1LXshSzCPzPCsziwP0CSbl6SZbi2UratZl559bQiSlgkxM+4G9SlNnJAJHgq03s280M=
X-Gm-Message-State: AOJu0YwYiHzEgjgdcTPq3pZmoTN9DSzDNdfIOTcqOYEYgr97aFr992Ou
	idGJbfd4f6ac+7zhmG5eVIcfCCtxPeiriKP3vg6uazNZizQrgo+tAl+kFDQN7tvvbTta4LYDsvl
	nAEUhig==
X-Google-Smtp-Source: AGHT+IH0152rqVoNdIwxzLke7ozZBFSJIA0piC6IQc7GrOT1GvHWiqBP7HHAaWu0YL9KGfsFiO0ZLA==
X-Received: by 2002:ac2:5104:0:b0:512:d895:c17 with SMTP id q4-20020ac25104000000b00512d8950c17mr5302124lfb.33.1710201526345;
        Mon, 11 Mar 2024 16:58:46 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c1-20020ac25f61000000b005114a0c56afsm1302860lfc.279.2024.03.11.16.58.43
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 16:58:43 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512bde3d197so4214965e87.0
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 16:58:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDG6Qul1592bE1RieXmOAz+8AZO6ORzoLKQcD3A7FV2FQnr3BnFUmoBLtP0hC5ukrTiDW9jl5lujVnlFKVa2ra6p7IV9v4t1hST8M=
X-Received: by 2002:a19:8c41:0:b0:513:7e6a:ecfb with SMTP id
 i1-20020a198c41000000b005137e6aecfbmr5499814lfj.65.1710201522568; Mon, 11 Mar
 2024 16:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk> <20240311235023.GA1205@cmpxchg.org>
In-Reply-To: <20240311235023.GA1205@cmpxchg.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 16:58:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
Message-ID: <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Mike Snitzer <snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 16:50, Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> My desktop fails to decrypt /home on boot with this:

Yup. Same here. I'm actually in the middle of bisect, just got to the
block pull, and was going to report that the pull was broken.

I don't have a full bisect done yet.

              Linus
