Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B61140E52
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710163; cv=none; b=u54KrpOFmdk5DnpRWWFQzsGNVbmnBiV+nwudaBD5SgIgESbNMUl6b4dPHb/ZWER24/Le6062muk785MuvHlFxZk5XQO63dWeO6PI9i+VBg7MILKJySEI+CEZJ2DjdQEzI1hcSCQ+weFAgwuOwQxnzuFIDoy5N4L0dMe+1Dx6Bjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710163; c=relaxed/simple;
	bh=jeZbYS+BcOd8N6/JweKPQT1XTcIDiakeVKNyuTtEwxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbvIG4J3nmIcpsTiNYmpuQaWzmn3CR/GCV+PXOEZbcG28xncpctwjbVBpeCvMcolm2xA93NKEXY0O7EhXcYn/dakEL8Coiq3XAYg+6baf0Zj9CKQPKd/tBici0Mz37fOVqjd80xIYAFY7ivXlq5L/3aFU8ZrOl32uFCiB+nhpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fj5uLpL5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fj5uLpL5"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so1212444a12.0
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708710159; x=1709314959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uYL2xp6+btxz9vbSsFSOIotbONXDjrZtHKQ6wV9cybo=;
        b=Fj5uLpL54wTckPViMSJLqOkHFsRgJLQu1xtXHUatO9fUM+RPewPJaFfu+gT3SBIYKD
         bR4Ag2nogPO8Pd3UNaGFcTxjKcsPVp5BbXk0pMqR6zKAz/695wO4/IjSOPYmjVIjyz7y
         BXCevwPZULcenKnMiBGLS6EPFBt7PYBUbUlEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710159; x=1709314959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYL2xp6+btxz9vbSsFSOIotbONXDjrZtHKQ6wV9cybo=;
        b=iJU5wqj+Ynqn2mfTAQT+Aaqqagsi3RdhfxUy3LcGzjgG/Ok9qno7oI9xcwLraLNw7g
         j31L72veKcZNmVxLuX7M+xDVfQrPV9av72WK3697aL0Dpo93wAxxCUCxqKkhLp0F8BjK
         jvTs7uPhu3VxK2sFqksgixclrs6pv4zNuBpIYe1kIpXPzxZmIel16gCYoEalUm5AGicn
         vophgaLgAp4AhHKALy4IOxU9cNrT8hSSe4yPiBRj+ipveAwA/KOy7QkisgjDB7Wo7Ybs
         yc6v6i0NNjCHljkm19B8NIcFXHhkAa8TTUqrIwYgTSCykuXSUVXEx9GGsKlf/9ZreIM1
         t0lg==
X-Forwarded-Encrypted: i=1; AJvYcCULWlAalafWDLnyUdPJHTu1kt2Avq8CDyHr5GKmi7jJqNZs5UGYJRXFEn8Q+rxuib2M4HGOZJKzJD/c7AZWMs3ipgKQQV+pLEOHx4E=
X-Gm-Message-State: AOJu0Yy6Pvf0IdKBc/dJUdQWtl6dSxDaMZQCI5HhCvjXeuo+G4i10nEd
	TMT0PfSAiPW4vD6nwuyqvLUSH944YwQuLA7rVUXekjhjr9w89s5yPmWtyv4ZHIGhu+7KEiTJcjR
	6WL4SOA==
X-Google-Smtp-Source: AGHT+IG0FgpfzUAa4LN53eVUkZxeUlVlCasyqHyC580ixKQXhUd3R9nsVAdsug85gcGo8zmNTthfgQ==
X-Received: by 2002:a17:906:a2d7:b0:a3f:899e:d3ac with SMTP id by23-20020a170906a2d700b00a3f899ed3acmr330047ejb.35.1708710159145;
        Fri, 23 Feb 2024 09:42:39 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id y13-20020a170906470d00b00a3ec0600ddasm4671676ejq.148.2024.02.23.09.42.38
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 09:42:38 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso123597866b.1
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 09:42:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKZsCsQb3F7nuVn3DntKk81S9Bcwkm9V2MSx6VkDw6KIjMvcJ85b956s8V98LgTpS3OpuCqkGMR28fJFloLHShsbltXUYYkVzNAZc=
X-Received: by 2002:a17:906:fa8d:b0:a3f:f8a7:e1f7 with SMTP id
 lt13-20020a170906fa8d00b00a3ff8a7e1f7mr456458ejb.5.1708710157949; Fri, 23 Feb
 2024 09:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZdjTMZRwZ_9GjCmc@redhat.com>
In-Reply-To: <ZdjTMZRwZ_9GjCmc@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Feb 2024 09:42:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=whmiQC_F1s1bWmOhM8csz_zxL32B=sPGgaz1kiTK_T2iA@mail.gmail.com>
Message-ID: <CAHk-=whmiQC_F1s1bWmOhM8csz_zxL32B=sPGgaz1kiTK_T2iA@mail.gmail.com>
Subject: Re: [git pull] device mapper fixes for 6.8-rc6
To: Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Ming Lei <ming.lei@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Alasdair G Kergon <agk@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
	Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 09:17, Mike Snitzer <snitzer@kernel.org> wrote:
>
> - Fix DM crypt and verity targets to align their respective bvec_iter
>   struct members to avoid the need for byte level access (due to
>   __packed attribute) that is costly on some arches (like RISC).

Ugh. This is due to commit 19416123ab3e ("block: define 'struct
bvec_iter' as packed"), and the point of *that* commit was that it
doesn't hurt to mark it packed.

That was clearly not true.

And honestly, "__packed" really is wrong here.  Nobody ever wanted it
to be completely unaligned.

I think we might be better off marking it as being 4-byte aligned.
That would mean that instead of __packed, it is done as

   __packed __aligned(4)

because "__aligned" on its own only increases alignment (so without
the __packed it would stay 8-byte aligned).

Then the only part of that structure that might be unaligned is
"sector_t", and that would only matter on 64-bit architectures.

 And very few architectures are both 64-bit _and_ so broken as to not
do unaligned loads well. And even if such broken architectures exist,
at least they can do the 8-byte load as two 4-byte ones rather than
doing it as byte loads..

Anyway, I've pulled this, but I really think this should have been
fixed in bvec.h instead.

Jens/Christoph/whoever feels they own bvec.h?

                Linus
