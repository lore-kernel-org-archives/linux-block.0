Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0850275
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053008; cv=none; b=VUMbyq5m4lyEskewbZE/+CwCOGA4S6wnA7LVo9fQl46OOqqdGZ1ucY/DN7xArALnA4ZMCVBOfhciWCQ2Qi6wuRBfI0VeuogYteVFqbt97Dysfk7YlvFonox0nlbyNmm3/o5BUrkq9NHnvpLlFT+8mpiXWBcfPVJCq2EpVUxVpkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053008; c=relaxed/simple;
	bh=51EEDb0ue/Nhh7wtSldBpAO4aoc8AOeutvOQIatD1gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NOCm82h0tnlvsgq09t6VovBnzIbVb849gkLAbWmkwOtElMpO5X7KPN05hOIfOyQIcyT27Gx3IJnLbxB/zSFjHz2isc7LjX9i+twt/r7hM/ri3p/ODXWa0n+0sI+cMvHYqE4FPSFhmWSjyVE+teijmuOqGRAlU2BC1GrdEVx9fyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CWhCeBTG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CWhCeBTG"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62a2424ed00so44145997b3.1
        for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 13:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718053006; x=1718657806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCHlrp1sqWxXkENQgyX1SA6e/23clY3UwLtIBI7esY0=;
        b=CWhCeBTG3Q0p0XsuKyOTUvQ0qPEMzZFPx5wDriOHW+PHt9qNp8exs2zS4RhDUwz6tl
         0teTqbs4HduRtEbNGACtYTgLE6G2Et6VswyA9jy3DI/rd+FESjuGI2WafyolHNngzuHl
         kPNqTPfQxuKGCO5Zhyd49EprGdM9MtZXWPFQkcKs7gPwcRTQi/8eFw5kXRCHSBWdxZjV
         UH6CBNkS7rsS1yd/C3VW9yR4lf8mdKUrEHouq61hQ5uv3MPfx4r4AL+I439mBpsCJCr8
         GONZAvefmIEog28pmMNqE2MIXZm74FWIiVeMae0fvOfNlkx5ax8jZ2IaU+gWnCX5Ufif
         EfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718053006; x=1718657806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCHlrp1sqWxXkENQgyX1SA6e/23clY3UwLtIBI7esY0=;
        b=Us0KKginkjxXKvv6CjijxKxWYR865QMzISTnpaoDMSFW7GM/rwVzHIXz1eWX494vgw
         triYmKieAAYVnyrbOlF62Hza+MT5RBsW/fA13aF42tvg+CYHKPeukc3od8ZGp84WU54m
         ixRLKNC1ZELvbuPCX+W85wmehrv7uT7vJa3yuieOZCqtR3riVhBrSUmravdG7JMKYYqy
         b7oUSiQ5Yg08GkfOtibuwTdNTGzEDOhUUNzXgwo1ll6a4UMMoDhNOWvMTMnBlXUpg/d3
         V269WzF0E8IQ3z/3uxe50OvQQtLusSnqoMfapUC4uiCXy9U5vH/6frwQ4OAhxFGo7N6+
         zTeg==
X-Forwarded-Encrypted: i=1; AJvYcCWDNkRt7/yNc4nt/ndJbwsqetEPHg+zsX5BFHanUyetyoLsqDiBdywY636atLJru7b6olK6PdWXQTII1DTLksZprFLhX1FYUregIq4=
X-Gm-Message-State: AOJu0YwOAwD8/6X464HaSi/Csxuev//dEPVdCJzUh7kltXxDzLRGEPGc
	5gsgGzbl4Ud2ywvJOolg7MPqdWVdo1OnFmlZY/gkbvogHeJPLH4M+GPzqG6n7ecgCWf1a87Bx2m
	l0e4yNsgDacHdcYFKuA0yBAEcT3D0CwZxAhd2
X-Google-Smtp-Source: AGHT+IFvfIOmbU92tIEUP97U962ZwkX+dae5pNDe8HVsVV2fINnzI7Cy6PJ/dYbQrp9/0zG0WtFUc6q1Xyv7UapuZHg=
X-Received: by 2002:a0d:c186:0:b0:62d:355:5b34 with SMTP id
 00721157ae682-62d03555e3fmr47903587b3.20.1718053006262; Mon, 10 Jun 2024
 13:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com>
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Jun 2024 16:56:35 -0400
Message-ID: <CAHC9VhRekFEc5HHAEhp52tNT6NLnLw__fpy7F0Yq=Qry0Jk_-Q@mail.gmail.com>
Subject: Re: [PATCH 01/10] capability: introduce new capable flag CAP_OPT_NOAUDIT_ONDENY
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, linux-block@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	selinux@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 7:38=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Introduce a new capable flag, CAP_OPT_NOAUDIT_ONDENY, to not generate
> an audit event if the requested capability is not granted.  This will be
> used in a new capable_any() functionality to reduce the number of
> necessary capable calls.
>
> Handle the flag accordingly in AppArmor and SELinux.
>
> CC: linux-block@vger.kernel.org
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v5:
>    rename flag to CAP_OPT_NOAUDIT_ONDENY, suggested by Serge:
>      https://lore.kernel.org/all/20230606190013.GA640488@mail.hallyn.com/
> ---
>  include/linux/security.h       |  2 ++
>  security/apparmor/capability.c |  8 +++++---
>  security/selinux/hooks.c       | 14 ++++++++------
>  3 files changed, 15 insertions(+), 9 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
