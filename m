Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE567E2
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 01:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206422; cv=none; b=UARRQJ6LxJay75/9lxIg9eZtHXvqzgEmD/bAskfSTzZuWg5JUmhKUtyqa2xtoGphD3qSJC9ZCrzZeqpS6sc/epRshCMGyejnFKVnWi81Ck64yjw0WJHdqxW4v4I/s6JG5hGkqSNh/2T8cTD2PLBrm2vBLHB+y0rBbud3aFJp9dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206422; c=relaxed/simple;
	bh=TGDU5J370BGZiZNTZ3sLrr2XPUVa6r+RRyts1GJp4rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qagG/wd7yLsUyBQAOQqIBGdNeSoLMyAVpewzDeA7QFCYMQ9HGTbJQ9IBzjKZa3HD0NwQhQ1zjRxfE0T3xCuEhNnzUqPJ+TED2/AzM3S1h6sC7awsNKPEuNNr9i8AvdcaCMIVShMsUET8wnMJM1AElWx0ZK4+pBKKwxEJQGClqyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U0djCEVj; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U0djCEVj"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44d084bfe1so440616466b.1
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 18:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710206419; x=1710811219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqKdt/t2yPLUgDHND/wAzCBm6itUcWzUBc99SF3ejSc=;
        b=U0djCEVjQFE1/7GcZR/czrsesDdfluS2AJNuDhXwnG9zOwTbItGet52KycPqEzqnLI
         SQ6z8VfxilnPYd+7lC4ajpN7i+OuJqpALnrAqzeFRNqkurke4XB9BH/2tkFNl6slOV8w
         KrY/tJMhA0CGzakmOtoxMlphHqHB6kCco4EKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710206419; x=1710811219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqKdt/t2yPLUgDHND/wAzCBm6itUcWzUBc99SF3ejSc=;
        b=d16r3A7i1TWvNALKMlni3Mrmgsc9Pqkouil3icxtv+xxXDInPPI5egFaqUU1/wJsaZ
         ebK8e+exa/HqJssWtFI/11RIty4JgTiVyI88teAneODmkkp8RSoqtypEqkytRiyq1beL
         iQpeoS+vBE92/KVO+dRWX/gOCjgD1Dv6gzKQc1UOvy9sYoRQpjUnzVBhZxKpVhHYf61J
         F51XxrumhV8LIxuHyxlz/FUZCgSfM7pP/0aHbw8/VyCTveNdIbRyZzA8oNn8dCzQg3td
         6ngZkjnxG+Xz8Zh4LDJOmTMM27YDXzOxIWnc6XnvbrVw6of2qS8Q7r+ZGlwyHDMSckb4
         A+9A==
X-Forwarded-Encrypted: i=1; AJvYcCXLl4MNma+eGZNisCVtxA8tGmDET2WSlJB4E2TR+2JGVz2IDf/nmvpcvM8XdsZEA88sa0CvpEwRlTaDrkwXIAgYcaDrna8/9xZnN/o=
X-Gm-Message-State: AOJu0YzaUNEQlaUqaKn0crDEir2GUldVbKK7mONJfMV0tpzSK85nwaOL
	aQLkNkXah5RRttPkVmal/7lc4sL9CIAj6AL1lM+gmaR4B48fy9VEFJoOUSBRb1Ou9BIFwkEChed
	5nfHRfg==
X-Google-Smtp-Source: AGHT+IG73tPfK1lDAI9rEvv95T59hL5uJ9JpQ0pCXcdXSG3NTb0uGuXSAZTW5j2Kx6K6n+hSJeMXDA==
X-Received: by 2002:a17:907:d50a:b0:a3e:39f7:52b4 with SMTP id wb10-20020a170907d50a00b00a3e39f752b4mr6146797ejc.49.1710206418910;
        Mon, 11 Mar 2024 18:20:18 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id hb6-20020a170906b88600b00a44dfaf84f4sm3327732ejb.153.2024.03.11.18.20.18
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 18:20:18 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e99b639e0so802539f8f.0
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2024 18:20:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUquvUYV949ASZwAmtllR21VWWSFNDK0sfE+lVOHoU0I3/XGgsFYbeRjlCaRmvrpXncu6HeDnn0sMD5b/t9ehTJxQNJUvJvi498DGY=
X-Received: by 2002:a5d:47cc:0:b0:33e:78d5:848e with SMTP id
 o12-20020a5d47cc000000b0033e78d5848emr6137462wrc.12.1710206417892; Mon, 11
 Mar 2024 18:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eaeec3b6-75c2-4b65-8c50-2d37450ccdd9@kernel.dk>
 <20240311235023.GA1205@cmpxchg.org> <CAHk-=wgOfw8NBQ2Qyh8QUjhp5z4v--PuciLE7drn5LJkTtgPVw@mail.gmail.com>
 <e3fea6c3-7704-46cd-b078-0c6e8d966474@kernel.dk> <CAHk-=wgXZ6dE1yHK_jQmnSjbEbndyzZHC5dJNsmQYTD2K-m61w@mail.gmail.com>
 <Ze-hwnd3ocfJc9xU@redhat.com> <Ze-rRvKpux44ueao@infradead.org> <07ab62c9-06af-4a4f-bae8-297b3e254ef5@kernel.dk>
In-Reply-To: <07ab62c9-06af-4a4f-bae8-297b3e254ef5@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Mar 2024 18:20:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtVMQQbez4ZhXBeu4gbrC+BxUf3gd8ypyR5BzV5ekfnA@mail.gmail.com>
Message-ID: <CAHk-=wjtVMQQbez4ZhXBeu4gbrC+BxUf3gd8ypyR5BzV5ekfnA@mail.gmail.com>
Subject: Re: [GIT PULL] Block updates for 6.9-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 18:17, Jens Axboe <axboe@kernel.dk> wrote:
>
> That does seem like the most plausible explanation, I'm just puzzled why
> nobody hit it before it landed in Linus's tree.

Yeah, who _doesn't_ have nvme drives in their system today?

What odd hardware are people running?

             Linus
