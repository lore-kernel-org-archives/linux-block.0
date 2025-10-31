Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F233987
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928233; cv=none; b=p17lZ+Me53aoeV7bmELILXScaZXbSPDK7QeJzJLxTwy1xs9Ocfb7lbSCRZLXtha5Zee+E8t3OCMGqzf1vozQoZSmfHN3F/f5Hy/yWaYgpbSjffiWWQS8t8pBnvv7yBiOOxsEBQ5Ghb5J/1RTiJ3VX7AiU/z+zQ91GgDH9BRwp78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928233; c=relaxed/simple;
	bh=fY4FiQOBHOZhR9CGYCZyVsyAJBH1cSuT7A9/k8YyMTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rE996xy3RcTiXZ2QhLaoXLQOET2MkzxpDGiENm9iLNlgUb8GVol4MB6INDILqHIZeHOk60uvHrZCWM9o0FSZhLQf3Eqtyeyog9HwiKLA8pewfKgm2TQKgt5fb24y1WDjPFJFB+xNc4Mb7mSZQn3OQ4SZ2Llh6+sGpP7F2FwrSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aPJwoIOc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aPJwoIOc"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d3340dc2aso673857566b.0
        for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 09:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761928229; x=1762533029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cDYNWSApLb0T0CEMAKuoBZ4CmprFjy5i/htqaeEinvs=;
        b=aPJwoIOcWmzfqBOsTdGPZ4QG8FFXQC2tdPLMIo7CmkSWWG0Ow2vWNel7drc0bsl7l1
         u6QfkYU5mVke8F18P+VPEfrNUE78lo3orrqm8n2p27EsO9z/o5GBCEgUuU92amM6AmQU
         LBGUz9BZliJNxpk7HXql+qTko8EXpxHgNo+ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761928229; x=1762533029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cDYNWSApLb0T0CEMAKuoBZ4CmprFjy5i/htqaeEinvs=;
        b=UGFTFLJpYURgUkUaKGwU3rqhksAUuHoLtty9ue3kiaKP/AIT2KHVuOdeE7cC33xZBi
         KWg3GFSKWZPmTWO+QPvsVjHhg3Uk47/J9ZRHhlRLxahcFiZM4BvD0hv4wtsMS/WX5z39
         b+ts4KLt2myBFHqk4hv+YzFEp+NBYp+VeDt8q24/WMcIO8Dbv2potgDKUrOzTdjHt2wd
         izLNlYkObUS22cXHyl3CKikuo259HhAvVDHMKkNi02xBkavETYXCuCD/fYHnPVHut+Ho
         B4SJBttt60cf3n2vdId24U3Z4a711Zo2T6a+XjtAXWi7378Qhl3Kl//1/R4yLNhi+Gt+
         pgZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvNmkp+WTpgo6KpF1Ekpn0rjfwfrl4PJbcesNEIO9KCeXHRGM9Le8GtBCmTVtiyTQsPHLClEJ6qDuaZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUf0eGBmutHcnFeqcQA0pc8RoJhZ80soJzVOxzkhS5FiGCV6sq
	Jf9QrSsb5lXcS9AnsxntCguViYWBsEPlI32eta9TOmSu+tVak8z132IzojMo4rancGDmsU+AzAB
	CULn4O1g=
X-Gm-Gg: ASbGncv/4uBPloy9LcO1yDG3off6hx64C/OqsvxzZpZTcPv+U9H7eMOWs70RrOurLXA
	24I5lFNoLHrTJ3M21anl2cV8lDTWJpg3EypoeYGDhmQb8sDqDhm5fsATEErzNcZhkSgc3kLU83g
	wE0YD+KzE1RFC2YsQhS7hw3YpBg4SDptJp132VTtKuwlFh9uGa4p4IJkchuITX0l9Ju6SuaddP8
	OFGNc2vhaeF4mfLmZHPwEgodIaLRlfvJ6OPWhHyU3xhvI+8/ZZoxq0FF2sAqoY5sQysT+smOiYU
	BJvzRsNF/iJidd9BqHVrDKYByDHzm7n+MZsaZP/7a+2v9G2NPsJvdItTQh50hB6EQuxSg+HdOlG
	PgA+rEb2P9b+4X83S6HWFUBoMwAvPuJfSpN1xKko+2hqwzI/Of6SFDDtpe+P1qFx5p92YTyO1IA
	AKW8seHfT+roXYexmWP2gUr294RdgVk8vnVyA+MGaoWNtXrUQukg==
X-Google-Smtp-Source: AGHT+IHfpHgdsCqH2Q9MqUVrkJ5CUgeOB4u8Jj8W6GP0oE2ecZhXXriGkk1g4gZR7t51DuUevkF88w==
X-Received: by 2002:a17:907:a42:b0:b3e:fc83:fa83 with SMTP id a640c23a62f3a-b70521bce1bmr867425066b.26.1761928228747;
        Fri, 31 Oct 2025 09:30:28 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70779a92c9sm217065666b.22.2025.10.31.09.30.27
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 09:30:27 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6407e617ad4so1584982a12.0
        for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 09:30:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFfX4dm1p2o7vwtvNleroVuYDH8upDZsTEGNfYr0x5OU1Hp4pc4kXzMSYp/eHxcaj1GusMmjkt/xnFIA==@vger.kernel.org
X-Received: by 2002:a50:9e6b:0:b0:633:14bb:dcb1 with SMTP id
 4fb4d7f45d1cf-6405efcc93fmr4626276a12.11.1761928227242; Fri, 31 Oct 2025
 09:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37fb8720-bee9-43b7-b0ff-0214a8ad33a2@kernel.dk>
 <CAHk-=wgZ9x+yxUB9sjete2s9KBiHnPm2+rcwiWNXhx-rpcKxcw@mail.gmail.com> <20251031-zerkratzen-privileg-77a7fb326e34@brauner>
In-Reply-To: <20251031-zerkratzen-privileg-77a7fb326e34@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Oct 2025 09:30:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6+ngpnQsp0ic_5Ebhv5g=cVKVWjrJyRBQWBp4MDiJNQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkyIQQlQkmgn3AWxbQRzVye-4t89_fz8JwOLmT7ueXhoF2H1ZGUGfxzOtU
Message-ID: <CAHk-=wg6+ngpnQsp0ic_5Ebhv5g=cVKVWjrJyRBQWBp4MDiJNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block fixes for 6.18-rc3
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 08:44, Christian Brauner <brauner@kernel.org> wrote:
>
> Hm, two immediate observations before I go off and write the series.
>
> (1) The thing is that init_cred would have to be exposed to modules via
>     EXPORT_SYMBOL() for this to work. It would be easier to just force
>     the use of init_task->cred instead.

Yea, I guess we already export that.

>     That pointer deref won't matter in the face of the allocations and
>     refcounts we wipe out with this. Then we should also move init_cred
>     to init/init_task.c and make it static const. Nobody really needs it
>     currently.

Well, I did the "does it compile ok" with it marked as 'const', but as
mentioned, those 'struct cred' instances aren't *really* const, they
are only pseudo-const things in that they are *marked* const so that
nobody modifies them by mistake, but then the ref-counting will cast
the constness away in order to update references.

So I don't think we can *actually* mark it "static const", because
that will put the data structure in the const data section, and then
the refcounting will trigger kernel page faults.

End result: I think we can indeed move it to init/init_task.c. And
yes, we can and should make it static to that file, but not plain
'const'.

If we expose it to others - but I think you're right that maybe it's
not a good idea - we should *expose* it as a 'const' data structure.

But we should probably put it in some explicitly writable section (I
was going to suggest marking it "__read_mostly", but it turns out some
architectures #define that to be empty, so a "const __read_mosyly"
data structure could still end up in a read-only section).

> (2) I think the plain override_creds() would work but we can do better.
>     I envision we can leverage CLASS() to completely hide any access to
>     init_cred and force a scope with kernel creds.

Ack.

                  Linus
