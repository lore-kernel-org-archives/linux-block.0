Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F8D175A6
	for <linux-block@vger.kernel.org>; Tue, 20 Aug 2024 02:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724122330; cv=none; b=cXG7YE6z04uDL6ucDBvEVXdSS1NNNZbNXsy3qplzhcgulU2vEOwsOsNcE7Ws394l/lNrz6GSVbjIvwD637ua5P2/otD/aEYwnwHiU5SEUMnzDXAHawKVBR8ucYVkknJL1ALPv/rN1X9EJMPR9NIWzm+fSlWvTLeUApUmXturcRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724122330; c=relaxed/simple;
	bh=ZDr5ZbxqvFQWLLGyxixOKscT+4fsLzUr364GEc8bx4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFcS0gjlFZfPtUBS0E23+I7Co+3Bn/StPpDay35L/bUVYXqfcfrjhIKgUFfqQhYuf+rnYoYDTNuG0KuxlZU9qeS/iXR+8wqWiq38Jxc+3x9kBm8jleXTI9OkPi2QJYnjfl/Y8vjMn6rqeEpORyku+AbVTZhdSg4PZNEo8iCPL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dqOkZljJ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dqOkZljJ"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1654a42cb8so184363276.1
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 19:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724122327; x=1724727127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMMqIhR8mNN7qbNLvHC3cSRq9saBfgJ6P2Pudx1fscs=;
        b=dqOkZljJ/4XbyB5lfn0o4WdQuoguaCyga7HO4AANEqA0oaRTt5aUuJ9QhtHuwDPRMw
         mEw+K0qCLjIAwbi7NtZAYAZtPJ8R382PbpPsZDVDDU6QbWjyW0oDHoS1d4yq/dWbihz5
         yLsyVA5ubIkQVO3Bk7JEFA12oWZq5h3sp0QPu1/eqqyq9x6s2h1sSpMgbintfGTI6vY3
         N3QYxaOGerWRC/yHj+uOu7/Mcnfu2rXGvRhWVxhuA4bBZkSdAzIzX+K4zJZy/wss9Xre
         a6qjc/CVIIQGFRXWSGf/XpVDLoDhRWY9PoltyLQ83+DFFx3kdYcAILRMwOYINusjg0jk
         ujng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724122327; x=1724727127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMMqIhR8mNN7qbNLvHC3cSRq9saBfgJ6P2Pudx1fscs=;
        b=YWEwWN0CWc7YJ+cjJPtdIVy0+9cfROXXdnCwprQpG6lDFtedh6jJoefyNPax+fK/9u
         AmrJ6ZFmhD2SXwDGZwVcjoqPhKkcd+W2sZR4iwJIJCIme8FiEfd+GJeSAX72e2LHk+Q3
         lZrfT/bKD9JkdVBqnd44x4Qq/y/jI6tvY54GBh6gLmg5Rw9dLQGdn6jNufomJILMA11G
         o/hDMv6c2MLu7crCCUgb5nQD59eb//+CmF5raskiKHXBN0wAf30OJ4VW2p+HIO9pceqk
         5UZL7gOfzjdhuwSGWUYrXtKV+r+2YsmsbAa4ajiGJ7IejoXfn2L7UOyhLrJIxFS2ZVZN
         t6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCV1ViuSes3tvOO7b1h94PU+mL0AjFM3mYOHK7b8ajbGvxK5AuBuwXO/Tvz9RGQqjyzAzcFgKPx9Kzsp9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01iR/dUz4IyUObpHTz/1krm9nGUO8jql1j/HfvJv9Honr81NL
	G+diaaLYLJGFmybfHHgMyaZEiXXxtTycK8FjDwSJZGy+TtwiVK3i7RsOFOGklK4mGd+qNshEfHU
	9241perFolqsb0NFcWcFBiED/Ny/iZkLUtCL8
X-Google-Smtp-Source: AGHT+IGx4BZUDH+LCtHEYeY3Jj6i77Krk/e4mCpEtrxZEdqLSGFNLBDOXv3VOnuXbn9YLa/m+2U6fa38CFBTVrK6h9g=
X-Received: by 2002:a25:d8ce:0:b0:e11:83ac:a024 with SMTP id
 3f1490d57ef6-e1183acaecemr11644146276.39.1724122327544; Mon, 19 Aug 2024
 19:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com> <CAHC9VhQ3LobZks+JtcmOxiDH1_kbjXq3ao8th4V_VXO8VAh6YA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ3LobZks+JtcmOxiDH1_kbjXq3ao8th4V_VXO8VAh6YA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 19 Aug 2024 22:51:56 -0400
Message-ID: <CAHC9VhR7CEBmzjnruFaHHpepYWSRu0bvPUxYk_jz7oXRS5yJUw@mail.gmail.com>
Subject: Re: [PATCH v20 00/20] Integrity Policy Enforcement LSM (IPE)
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 4:59=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Sat, Aug 3, 2024 at 2:08=E2=80=AFAM Fan Wu <wufan@linux.microsoft.com>=
 wrote:
> >
> > IPE is a Linux Security Module that takes a complementary approach to
> > access control. Unlike traditional access control mechanisms that rely =
on
> > labels and paths for decision-making, IPE focuses on the immutable secu=
rity
> > properties inherent to system components. These properties are fundamen=
tal
> > attributes or features of a system component that cannot be altered,
> > ensuring a consistent and reliable basis for security decisions.
> >
> > ...
>
> There was some minor merge fuzz, a handful of overly long lines in the
> comments, and some subject lines that needed some minor tweaking but
> overall I think this looks good.  I only see one thing holding me back
> from merging this into the LSM tree: an updated ACK from the
> device-mapper folks; if we can get that within the next week or two
> that would be great.

I've just merged IPE into the lsm/dev branch, it should go up to Linus
during the next merge window.  Thanks everyone!

--=20
paul-moore.com
