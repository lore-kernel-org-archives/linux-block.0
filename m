Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4F3FBEBE
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633560; cv=pass; b=dJhpEJ9HJ95ejYKJ/crcROFP9uC0sTHWUJR/MIxm7Q4BPF+2vAjgoJCjsN0cELkR4f0UNqXL7TRV/dkhER7aMO7RymLcnBNPP8bPqZJ1Fj0ENmNLNtYtgnOBOaaqQdJE6S/Dmrfqw+Todzv2K0F3dfd2P8vaF/eD+32K0TfejEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633560; c=relaxed/simple;
	bh=m6hW95/C3ET1V9mEwYcyKNAogg+hpF0krbdZ9S9hmMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elPeNbWvsAtUN8muT2lC4JHK/0kEiAYcplUKqClDgixtb3oR5qpdl0UWUWGusPKMkqbO2Gi/+ZOS06uZj4qdX9wy4/uUSYwtfy0JaMLPyI4Mt8u5c9Y/XvAzX+5z2WF40YIwgzKHqICl5L3bKwkoX6SuFrlIT7JRCzcOkxu2+8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdOTT6AH; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdOTT6AH"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1277863a912so328029c88.0
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 10:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774633558; cv=none;
        d=google.com; s=arc-20240605;
        b=caZMcwmq+ZtkBIcgvZuvh4FixDeXzwE2cuPQ/T6/jcTbVuyJMqFdu6z8V6oKrJOrWo
         yIeHTAcUDXyu6u9NC5Fw7Yq3bvzS2D8I+XN0Zm0nPgFbJn3BIvk2igKK0C3mVfMQ/+l9
         c+JTX+hfNLSLK55YTLQt7vRU0U40TlQWslLdBocK+NMHRF+scfbdjaFtRVLDgaoORzt5
         tlYUbNycVsyU+nQB91Q8BoVcgWQhIoIyfPjHBRiWgPoIoPTbiJPdT2bfg84jeyK4QvKB
         TuLCwoZzT8Kg09Lbb1b01UtlUpGGym/5Ha5mTtwqAL5p6PT/v3HplRNPrxa+JwFAziy9
         j2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m6hW95/C3ET1V9mEwYcyKNAogg+hpF0krbdZ9S9hmMw=;
        fh=6QhEXKM1obbJcEUWl98C0vPgOAipmim6LveidSwM6kE=;
        b=jxHTgPMFatS3TF8FuFeliG5FCBVv38wVsGkzmiFShuLHQF+qmlEj4mFwL9qstvt5ur
         PcnIFqnqCCdgNQYLCX6BS6ZsMqEChzEtMvtiBh904t5DJg/kLFr/dsJuPatPVJQC017r
         rp2s+eAZ2bkUxvRAhmOsDUJgwnudHZw/3rpgwU96HIfkqJRE7mB/R93YhQvpap7a/kYU
         BcrX3hqGM53mfY2LVXephAhjXj37HJk/GqecexSMn4RTqo7jZDMP+/bf8k4MqOdspBtT
         fX/4xY9cJj2xNvhY0eFdVuCh6jBeRg8mC/N3vvZisi2PKwIq+3oYAofqWXjDvAQUrWSR
         XvNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774633558; x=1775238358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6hW95/C3ET1V9mEwYcyKNAogg+hpF0krbdZ9S9hmMw=;
        b=RdOTT6AHvnrolfFcvWDh2iQzspgRJYxk+7Qp0EQ+q+vdAQ8/GCP4oJG0bvmHmfBx/F
         pH+USxFfAT26792b/CLvv8lTIDlrQEuFoZZ/Hyqc/Hxe/qJZeBdVO5XdVDTiyirXY1mj
         BvEhSOgzVpi0KjjKNVKuysIxsNiTA4LnFtAYeKk0+Hp1jmmRd7eU1ENFgnFdCPmIdHyU
         UZVknEuL7cb6C/t4A4xafLFoc0flwFBGnC12icxbA8A/jN4mYmqiJDhTCj33Axk4CYnu
         s+q+UNDvBYtivT2i21GDYN3JX4I6K1WXw1VjkVvyqW0zGcqXlvTRidWNw2jeLgcXc571
         NJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633558; x=1775238358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m6hW95/C3ET1V9mEwYcyKNAogg+hpF0krbdZ9S9hmMw=;
        b=EJdnwuKuxfxPoBJNAGr9gYgrqhk+ZwBgQqXO6HLCOiUcrFB1oSxB/1zEgWmNfntaGs
         PLCf3xN1nFVH1LQOsV1VQz7HU+dbC2ol9uDnuvi3qYEHnI15HFadBmC4J398R7UClML2
         q5smXL7wwuNIDlJOTVLWNMfxaC9X26fEUkrbULODjxPFeJP7l22jCgSbBoyGfeAEvCLN
         FJsc0LdAEvf1HdJ0Q5dSbWOa2ZQVmPbYsdr0wfG22FeE2tLvklONw7sKQqDsJlWcVHKZ
         eMtenZIluo6Gw/ozZw/p7WfpN8glH81FUgmCFvgVFZhgZ4sf0ZziTKGGv06mvwCWutAj
         gIiw==
X-Forwarded-Encrypted: i=1; AJvYcCWg3/EJB8naATL4TAsWxFtI9ne0VCmEaZMXBXa57kVUwHefFCinoa7G6A6eMZpb4BdvmPy663dGKO0RaA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyy1ZlBMMEh4GuQN8tgFsYdtbORIpcXeRiSBHYOdiuSRuHJHpm
	QvcDbSV1VBUF1LNelueDfdAoaDovck4FKgNh14oWQ5r/4Xb5Rw4iMF7xW1YEbxntQMWa+sYJ5zG
	LZjQrQcO0v4rIP8fQWlZTe8mws2O4nhM=
X-Gm-Gg: ATEYQzzj8njKVRere8dRL+ZYiUe0OeBAf7YxDItvZRzwpFI1drO86O7CFhpp5F/lzsD
	r7W/ZtvXNCFwL5rGjzlJC4Tz1cXyDxbf+RjsUhw7UMxsZo1giAenLQNcsTb1HQcbl5Tuci1SriU
	gDB6v2yfO9OjPnx2pUzXM6xt9nsxaVIaa3D49CDhxoMXcZQj2jeYieKIz85scWcF28NgMaTB/zu
	SiUWRY6/JptTGiyJOhxzKp8zAk5kksz0XXK2w8a9rdhG7a9KWA0bRigXur1VV723EAA6tqGoeJt
	ZkcHbtSUx9e/r/nq0aPZVaAZO4HkKx8cQsMhlvA1S5Rra2wro4ADmfkxIqdo2qdaIRb0KHZPJJT
	SwuFVB7eBRAT7xjlFhkBVZng=
X-Received: by 2002:a05:7300:80ca:b0:2c0:d9be:eb09 with SMTP id
 5a478bee46e88-2c185a57557mr875171eec.0.1774633557661; Fri, 27 Mar 2026
 10:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327114741.91500-1-pilgrimtao@gmail.com> <20260327114741.91500-3-pilgrimtao@gmail.com>
In-Reply-To: <20260327114741.91500-3-pilgrimtao@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 18:45:45 +0100
X-Gm-Features: AQROBzB5tJkP8M6dPCGpMeaOv63a95dhaN59p5xt7LwFdgRiK0mSmaXLq6iSY1Q
Message-ID: <CANiq72nFSyKSUcRJL-uME7QsvS-4aaNN2nVp44W49Q6VZhCJJQ@mail.gmail.com>
Subject: Re: [RFC 2/2] tools/ufq_iosched: add BPF example scheduler and build scaffolding
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: axboe@kernel.dk, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Kaitao Cheng <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 12:48=E2=80=AFPM Chengkaitao <pilgrimtao@gmail.com>=
 wrote:
>
> +3. rust >=3D 1.70.0
> +
> +Rust schedulers uses features present in the rust toolchain >=3D 1.70.0.=
 You
> +should be able to use the stable build from rustup, but if that doesn't
> +work, try using the rustup nightly build.

[ I have no context on this patch series, but since the filter Cc the
Rust for Linux mailing list due to the Rust keyword (I imagine), I
guess I will take the chance to ask. ]

Is there a reason to have a different minimum than the Rust global one?

Currently it is Rust 1.78.0, and soon (this cycle) will be Rust
1.85.0, so that should be fine for you. The plan is to follow Debian
Stable's Rust toolchain.

In addition, you mention nightly -- why someone would need nightly?
i.e. you offer a Rust 1.70.0 minimum, which is 3 years old, but then
right after you mention Rust nightly, which is essentially 1 day old.
So it is a huge contrast, not to mention the availability of unstable
features in nightly. Do you mean sometimes you may need unstable
features?

Thanks!

Cheers,
Miguel
