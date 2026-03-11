Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9970A3382E1
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238392; cv=none; b=tEbH9SGWqJ8fTZC32zvNTusp27N4XxnfewcnvddFeYlpr6SjvM55AczhJsR7+ojUP6HFF/xA9QKHlmCoqL0ltm2QHYaku05w7Tpbimomqs+sNso9IaaTQz88wu4fOFX/EzJ3gNvYIYZ63ZOznF+HcBUBNw6TS7AtHUJMytT11yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238392; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMbu6d5k3Al0WZc+2xMpzk1Sq6+lFQvoEUPxB4i30VpEisRXAHMXwaKV+g+uGpb/RsFwWoy7zGin2UUQkl0npR8F110Md1O0fVDG+RU+cpGHpf8CENwhTRImNpd/mj0Rd9F4zGx0IaM88a8nVVtByGLLmQmOcQitEETOTtcB7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b93698bb57aso170392166b.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 07:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238390; x=1773843190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=J7SC3HNU0ZwHlRM+/ZdCIdsc1LmekqCHOMjAk8JPVNFTwFwe4/4Fe9owDA/wlSX7li
         thN43HL+yXbD7wXMrz7NM+P7T05xARlf2PbuUlEv+Jjo7ihDKqnMMMKklkUp+q62jDGW
         7WJ1qvVjh5jvWRjDdO2vddNv3Tyd2XhVBb3AAHoZtosALgqCYDHcbE89FmkqrI3tkvyF
         kf2c/xWZGG/B0k7TvUIqaID34n/DiaiA/Dk+7eRZuLS/Ljcbt9IPjyc3JYNCOOQ06yY3
         9EQv0+eIVmtdxPjL+nssil3fGNIBdvNpUWMvGTGEJtQWwkG4H6OYH8w04cg+GAza1ncO
         c7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVmkEBwrk3aGD2LAUNmOn2uOWOGCFnsWGcDAHY57OjdZyhZ21Xol51RT4NvX0RO0yxOncbyAEsJKxp6Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyblakGKLzHrrI+LZ5RvcLlfZc93Z7XTuxGUGXEltB3cMAniweC
	vb8HKvO2nQNSB15IGCIWSWkbPKwjPQp07NZPHREaSwDmmk/FZNVMOq6kw8/YiVgXX5LBRw==
X-Gm-Gg: ATEYQzw5ZwNEpZ4RuPOIVebcA6K/4/HUvI23F9R2hKh4PWAB138iR+iFOJ5NXk5IFgf
	dI67iu96tqm9r/VrNEhNc3Ff1dfaeGwjhPbAzgIXsmJKnds4ktTjAX7p8IYQhJkfsvshe7y5yUF
	XUiBXlGlSyw9mMvstmvsHSLCa8tXE/SkOMh9WERSIhedK0jkS9S+Jc6ju7iEkyRUDrG4HbrhZ8W
	+Juh9KGO+72rsdzgRwMGEXP7/Bf+SfkA+DVQt1p/Kvca3AjDFV0aH0PfjFEkSkZUSbQ3ylN8+ZP
	A/BeOaD7Iuyx8hI+jXnxoZtFNrj4776ldTyBQrIGyNRD/I2YdaEjwa2z/OGF3priY1dzka8yefs
	i5T7Fq4qGduBP2mH7xwByX9c02KucLyCdlB04AMwFxhnWcLM0atVHzW8cEJKTmP3sFzSgPaOo3z
	xhOVBc78SnuoBzki3toNPGoj5WJyOH8KwnWjALsZNrsnBlYVLrGhw+VldW2phi
X-Received: by 2002:a17:907:3d56:b0:b88:5b72:ec39 with SMTP id a640c23a62f3a-b9711851e14mr416154466b.5.1773238389726;
        Wed, 11 Mar 2026 07:13:09 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e14c45bsm57453066b.34.2026.03.11.07.13.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:13:09 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b93698bb57aso170388366b.0
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 07:13:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlVHeHcLCfI9j0i34WZJJ7AIXA1d3QCWPeIPK/4KIKrYyCypOldVIoDESt6STxFLc9aSCFbgeWQUJ8mg==@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
