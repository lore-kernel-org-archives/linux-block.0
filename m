Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5AD4418F5
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207474; cv=pass; b=S0INvrhpp0zoU0g9Kk9CmizPIkwnCHiReGE1OURWTyTWPpNP8KfXvuwBJ6O48vtNy9OcfcBDZT0UlLn7LQKiXvjy+XkMMxYmKFsr8UTUssBMzTUtPJzlIrnBd6ZwuCvk2zWB19HbUEE/Wrd1ermrd47wDAnICsnyhBvw567BfpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207474; c=relaxed/simple;
	bh=C2dXB1sxCI7Pk9wL8pHCeBM7riM5637FJHGRurs2elQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceR9C6mH7XLqjf2Y9U1JiOdRZQ2bS1QWLaEWsKeAdWvoRqQ7PDZR9bNCWhrANm67EHA8DvqoBsv90B+ODbjQEg2uP72UlqdHOEPut+uA1xeyRlwnB42QZq7SCymOP/VH7DQTNYgcJfc8pIKBUPuPR9fFoj6lzPIRuax5/8vfrnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O7xfHkJq; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O7xfHkJq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48069a48629so23661495e9.0
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 07:51:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772207469; cv=none;
        d=google.com; s=arc-20240605;
        b=O+Go8LCEslHD3V3bfU5NMprNY0Gl04/3Vk97BoYL54xW1KS4uQHeqjVsVtAbJCb92A
         uXItYjh8GxsdX88vuCIMu7dJqBISqR4jh3Tj0npI8/TaoRcFrOB98Qt1xJx5N5t3yUi1
         iJ2fXFCqqVOVodjvCf/moaKUIxFmbGpFsGrMQc+kVPXgi5BLOjjxXGQnW98JT8K6Ll2r
         DL/nJ2KtwnMoVMCoVFyBhVZ9iJWkhlEQi6UXNJqJbbxkyUJLiPUFHcXJV4aVq1t6kvFi
         yLciWZYwj6c53XSX9+c9aEZPhFf+yaxP2MPZlNM0Dqyxfci05tv+DuVRzsSEtaF4ftzx
         BZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rdJol8PThaHnFzgvtP9ZLYZ64xJsOVkwosdclABQFrk=;
        fh=93SgD5xy2zCl4Gc8im9kX3JGunlpxi9urHZTJ1Mg6dA=;
        b=HeHlRwVzExhgF/KYGPZUFWlqfsMcUfxt7qq8koB3zb/mdYO9iVy8E4/iHDnB0rUJJN
         aTENRycSyYNiTf4vI0PmJlt+ERRM66YkL0bOLCkHqrWoK3S9/CJbLDqarDs9VIHh8yST
         mcH5xzEpRj/8THW8nGmcZldhWH8b4nHKWZdgnryqqdPt36Q6QwbH5WxWVblCZ7AzfnQ/
         unkXnlibO9roqNXmag8CJalkyMjSUHaagXdwjWhtv4kVESKPPn1XuAVHMP2/xj0GnE7a
         KSG1zqNMnL1bxnD1OassbcFSIm5tkKVh86kaLRwzV3ANz9+cUILrpuTr8ZaRxK9pQgJC
         usHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772207469; x=1772812269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rdJol8PThaHnFzgvtP9ZLYZ64xJsOVkwosdclABQFrk=;
        b=O7xfHkJqIj7ysBjltL+OEuC7IvVKrnNE/caIfi4So4zLwms0AvlloqnR4SaSsbCDZR
         iN5wiC+rxAHlSLUT9rMACdeNPTXynI0oS3IBvZkP0iwHAB2V41FMXNtUHT5ApUcvP8OK
         9NW4oK8f3opDJUA2V9DW2OC1iQQrpgxWCky12CG5Xa1DnqU9Vcu0bW401OIN92YJpFdW
         T3FEmUHB6nB+AywKA20yuam/TrIySGBysDmP9NW0WyRY5APuYfNd96qDCGqBa8wEU55O
         h4SRqYxkRS/Wr1gxZPonSBmuR2Go40C0sztGPllflGuYHBfM/m4rB+pic5ux5krWgIYv
         cwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207469; x=1772812269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdJol8PThaHnFzgvtP9ZLYZ64xJsOVkwosdclABQFrk=;
        b=pMuMXypaPp+Z9zjUk2CbD5chslZJmfH36666eN/8M0l3EzyzoFnbH5thqwq8A33o+i
         DxNhgEjaQUR4NZePCIThpcZ43e1nIxzS+tSTKOrbIwn4yf4oiEyMQ0/mSMecCgH8Jx1U
         x5BiNTVx71k9FcTWryk18KGxFrU/RYA5fvIg4fRlqGnCsSOC555LhZzF7JF5wdaAAZz0
         A+22WopWOYSNjHDzM0yuk35WkuheeNpSE1RrD4Y3uMyRZvgE5uAes6B8EEGKfv++CT2x
         tObrTHMVgYAx2ZDmG8aeHwLhzLUbrrtJrgNFwswwX0TNWyPzKJit8ILxvZa+suTGt7wW
         qlbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWctQp+m2hozyMJ4kwhRkm05YwDGQjyo+z6v8sipEoU2/1v5OWpeH+Y6QpVeP39lItcayJNkiUZAydm1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDYQpJMO2EYpmR+zXT1TnkuH1OpyLqXRwBTNVmVSRLzIts+Agq
	qHz0Z3kbM8nqnOJS0alBZkO04mZz5+rNeT4WwhILFeJ9vz6JPJYJ9vPDqHGZX0te4ZFhFsolSTL
	BC8cQ/tjEJT/0/SSKg99GKwllhqBytPcwyktIDd3Jfg==
X-Gm-Gg: ATEYQzztw94rLFbD6NNDBz5h0TrtIvnpbLWdyLdK8EWOGLkxdAqXK/gKNuo5a2t7HfA
	daKCQ0a8+J6t4qZRrzqXg0Yf0OPupR6FTi1cJiAMnbsReoJ8yus0C/8/qBCOSIrBEFYOh0GibMC
	TObEHrZxvirkULHJlHMH7eKQFuqgFzylE03DNMqJE9XJ/Yd7kBsr7gK5Q5ifZlVxwo9j5K0NG3Q
	+rfkqk+qQZQnTqbpq5SrcgIgIE6eiHkL0cWOI9eLMqE+kTQY1orC9vf28U+CAxZZ5fRRHzrNLlR
	GfjZiCDP/RvDn7JSA18VRJ/AtivIY5GNS9PK8QoyM7cKmKbknVxIQhzBx4oV89wI20YpLEDHbTK
	Pu+gQ
X-Received: by 2002:a05:600c:154b:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-483c9c2059bmr44092495e9.32.1772207469176; Fri, 27 Feb 2026
 07:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260221205606.GA23260@quark>
In-Reply-To: <20260221205606.GA23260@quark>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 27 Feb 2026 16:50:57 +0100
X-Gm-Features: AaiRm50Djn6O6G3P77GWwQPmb2f1tOFDkZh63lAskdXhiotebz4l7KeZVsyYZpU
Message-ID: <CAPjX3Fet5M2C=1TDNRhrqmanvJ2=aFdtQXfXK7MuxiOkz2rNUw@mail.gmail.com>
Subject: Re: [PATCH v6 00/43] btrfs: add fscrypt support
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Feb 2026 at 21:56, Eric Biggers <ebiggers@kernel.org> wrote:
> On Fri, Feb 06, 2026 at 07:22:32PM +0100, Daniel Vacek wrote:
> > Hello,
> >
> > These are the remaining parts from former series [1] from Omar, Sweet Tea
> > and Josef.  Some bits of it were split into the separate set [2] before.
> >
> > Notably, at this stage encryption is not supported with RAID5/6 setup
> > and send is also isabled for now.
>
> Where does this series apply to?  There's no base-commit or git tree,
> and it doesn't apply to mainline or btrfs/for-next.

Hi Eric,

My apologies, I did not explicitly mention the base. I'll do it next time.
This was based on for-next @20260127 (commit 80dbfe6512d9c).
Since then, some changes occurred that will require additional
touches. No wonder it does not apply anymore.

Daniel

> - Eric
