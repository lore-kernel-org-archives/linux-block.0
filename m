Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97A180A6C
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715716515; cv=none; b=TaFgxjy74ddF6GzZ5VF0+pRdBO5aATO2onM2CMXN6Gyo2b/C6ztx/6gpIIwR29ifchv7NHU/FiflZArZLj/JLVjPewVT/9FtZ2iAhXbhqzxcxdh7cAJWCWUtCK8POSSGwFFpD61HJ1ZB2Nc9y85ZKeJm8cEnASS8J68Rzp5mDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715716515; c=relaxed/simple;
	bh=Tn7ggDBZ467fewog7X29iTchxNr3w1imZ5QlMHFp0v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNZS3q2vcDyN33xgpAzS7P9SCSYzG4TYfn9tEiGVIJqAgysWkevX14uivGQVLPSuDijYQugb9/7zvb+wdfPQ+LqkbayzQN3ggNOZTzsvVLrdz3qRJ5hI/A3sqQWdusSqtGmzZDIajRo3ZjPWqjYi6D/JHfL+yL43Vit4QNwSDsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BQ5nTcrJ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BQ5nTcrJ"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de462979e00so6447185276.3
        for <linux-block@vger.kernel.org>; Tue, 14 May 2024 12:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715716512; x=1716321312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5DfaKSvWBjSuruH8QpkzwqbDWxyqIe8ntp5STBjhPE=;
        b=BQ5nTcrJeiDGmJPbk+0RbPTElKvyqninC22tbUnOXLGS1LGq1NMiBlKd/vEdzgWmX3
         J6CyOwcl5ivwV579DFEK3+TPJNedRbX5ta4rufuEGc9PXSFysi/1ahLWwCZ145ht6Uyl
         Bw6LPtcCw4jhHWxePof5VARvVKrO7Gny5IjBXAEBH3jl2fhWU277pEPsN/aRwtFOao6H
         alRLOYOxC3Mw4O3SYM24cutTSjj6riCyqehsqMkh76Ix8NCPvVfYnaoGWhA3ar0CMRBO
         uOblc/Ql1V5KS6OL2dGv81/5AuDDrkYhB4Q5bH42HhK8obCcNSuLZXmuVzWWpy725Av5
         SDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715716512; x=1716321312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5DfaKSvWBjSuruH8QpkzwqbDWxyqIe8ntp5STBjhPE=;
        b=AY/u3H+u7ssVzb6ZmGbPCzL+cFverOVQrgSDdwUS5+lGLsR7cDyhmwIdt9fpbpKoM7
         nw4rp952FMm0Y2XwRmel3dvZyahbCDz+cIpYErlm1H25U+XrUJksIeXL6kv36p7NxI6O
         2xHO5kHlne0eKTTbleleKcr5zPskN4aMfx4ja2XaeOv3lbxqR83ez0LtenQVFKI8yLgj
         mrI4Bvd/B/YiMAdWlE7x5jafl6dRaLUDqERWYYrKva4v1TWw/vOSZ2SfVCBvrQq4ZgX+
         IORCOdlH8b6DICe3EYO0jI4WPoM/5wjjmRrD+zncImTax1vM4mYHPAp+0LlIJRqIFNxs
         zFAA==
X-Forwarded-Encrypted: i=1; AJvYcCUbDzdMKdXfTD5AqzGGZaUIU04OViSm4CwYPctDJZTtJCvjOP11Ni/DYnGoycOeFRPWHwIVFJfCNMqGUqEW2/x+9SwBGzZcm7fP0iA=
X-Gm-Message-State: AOJu0YyQweSexp2+8YT7MU2uUSm7DmPuqDVsTwBYE8IgZi6NUf9vwsGi
	4j7PEhAXv1o9u0pOn1Fy3u0j/RWC1ncx0npvHPZkZhOpMp9nRQG2y4BrZYfdZE5x0lh8Dk/mAOA
	7WIkwg70a7UxYkMAjUdwOmwpUOInmrV2dTzOV
X-Google-Smtp-Source: AGHT+IGVq5mRXTNrK/KaBwurMBldLnV/6qJN5uwTdGazOX6+s8bWL81rsv23lU+ZbyujJVMk8Qdjk3/8J+Z+jQ3+QZk=
X-Received: by 2002:a25:ad50:0:b0:de4:619a:fbd with SMTP id
 3f1490d57ef6-dee4f2f6cb8mr13359322276.9.1715716512499; Tue, 14 May 2024
 12:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com> <1714775551-22384-17-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1714775551-22384-17-git-send-email-wufan@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 May 2024 15:55:01 -0400
Message-ID: <CAHC9VhTK4WS6BOXqLJ4sNKXR9a17gT3vXJUBc1F11cZ_QaOYBA@mail.gmail.com>
Subject: Re: [PATCH v18 16/21] fsverity: expose verified fsverity built-in
 signatures to LSMs
To: ebiggers@kernel.org
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 6:32=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> w=
rote:
>
> This patch enhances fsverity's capabilities to support both integrity and
> authenticity protection by introducing the exposure of built-in
> signatures through a new LSM hook. This functionality allows LSMs,
> e.g. IPE, to enforce policies based on the authenticity and integrity of
> files, specifically focusing on built-in fsverity signatures. It enables
> a policy enforcement layer within LSMs for fsverity, offering granular
> control over the usage of authenticity claims. For instance, a policy
> could be established to permit the execution of all files with verified
> built-in fsverity signatures while restricting kernel module loading
> from specified fsverity files via fsverity digests.
>
> The introduction of a security_inode_setintegrity() hook call within
> fsverity's workflow ensures that the verified built-in signature of a fil=
e
> is exposed to LSMs. This enables LSMs to recognize and label fsverity fil=
es
> that contain a verified built-in fsverity signature. This hook is invoked
> subsequent to the fsverity_verify_signature() process, guaranteeing the
> signature's verification against fsverity's keyring. This mechanism is
> crucial for maintaining system security, as it operates in kernel space,
> effectively thwarting attempts by malicious binaries to bypass user space
> stack interactions.
>
> The second to last commit in this patch set will add a link to the IPE
> documentation in fsverity.rst.
>
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

Eric, are you okay with the fs-verity patches in v18?  If so, it would
be nice to get your ACK on this patch at the very least.

While it looks like there may be a need for an additional respin to
address some new/different feedback from the device-mapper folks, that
shouldn't affect the fs-verity portions of the patchset.

--=20
paul-moore.com
