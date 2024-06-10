Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343714DA0E
	for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 20:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053113; cv=none; b=VD/lN/cM6+ELg+yk3tznp+fFoH14B4iQMVGNCxybaLLQ219ZgNOSttro7DWq6ogkKwqo4i7Nmeuq5bTzUzHaYjKTDzKvkX5IHIpjD7SduBzdN8ta7UlaV1YtmZNUyDtro4zt+RAEUE+JxfXlayloGxn6VBjAaTEP1Zx0dMWuNNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053113; c=relaxed/simple;
	bh=rzpLM2lx3xfhI1OeqO3c8KCtM3Jbif0gky3MwnhamNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9bsenGZLgnVDzF2pSH+OCxMjrtA2/SCTpDUZBCktDjCt4R3a03uv4kMSXU9HouwV2LUUYRd/DL0m8AjTG0fbKF8POW1csd0tZzwMpyUxWODf7lbwAQ/Ub+AF/aRjd94Jb+ED50ezgrjV5J4Y3NJ3cJfi/VCbtcAiVdrFJyqgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A5jNY1VS; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A5jNY1VS"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfa727cde2dso5211977276.0
        for <linux-block@vger.kernel.org>; Mon, 10 Jun 2024 13:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718053111; x=1718657911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjvTyH44Gn9K0/aODJx5r7ofG0qRZ0/Vhf9vo2Avotc=;
        b=A5jNY1VSG475/Q8Gpwb8qryV4A6e/UoRX45tqQ8e4NiVZm6ghOqo8/V6w98U8ydP56
         opodVKuZOGlMM6602ENIxDZ5swCSRvKX6Ly70M2z9ZK4vRv1sd9LY3bVZhh7EQltrNI9
         eW/rJxvHS8OlH1Qz4XNBk2ORjd9I/KDSaKtuXwUk/jFhIN9QMB9N/jJ3vGFoar4TxfQe
         ZLWRjrEaZNz4zkiyfxEP1yn4fgDXYLFYixUo639jLwVuePlRXsuJSx5aXIx0SBaaNvOo
         7SakF+mUqW9gbGFcs8cza+4iRRwradSJcaDkkGyvPOrg2vRD/4ULxZvqqnPsHljyPc4s
         gy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718053111; x=1718657911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjvTyH44Gn9K0/aODJx5r7ofG0qRZ0/Vhf9vo2Avotc=;
        b=Jse2cpqyiySl4afUTJwAvbcnwIlddX2P4TGqwnGc2G3P/tho4ZX8U71DIEvHG9H0MJ
         hRPKUGnE54/eTsdtoPun0rVAgfp2RcYT0Vhm2AsPM6Few3F68lfUpu+GprqmbWCUY7GA
         R6ljTr/rCWUX6TzVfPj0JMj4pM00kQ9b6TJ5T7OAN1gwGBWmb8mMktunvI1NwHbCLUHN
         IDdkaUdVMdgKG15fA/Jk5zFsxNbKNEvML3GgLpIA6dyXEXo5oPQtOLmnSp4XxPayHoKa
         F/NPNVsSXEUxa8WgFkaOVlCYK2hY0uRu4vPqPObXt3xNf8WC23RTnOOa8BPk7m7n7dkp
         swjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy9SoeHAH+BpZ7mbr2Q3IZ+3YhIkxZ9UEUUmDBEC9RAVF2v//lD7ztRYFGAVYoZ2H8bgVUJeVUGVksfXfN/fI/Kj7WDcR2bAYW3c8=
X-Gm-Message-State: AOJu0YzuuqhkxHHEb5BBqIn+TZiyH6RttouZGtH6o47Eukfl2mShkdM6
	PlGdOK1F0rNrp8vZ4XTlJETkdFtwOIv/qnKelYXfmfHg0lshxfhXdfoG2CmM7IH5nM6HjXoPz3U
	6GHYmx+GWXiNWBifN+kv3UjzrEDQSMknwLLRB
X-Google-Smtp-Source: AGHT+IGSScrJTjOQvFGeppRkPUt3CgNn4lkvBzlnF1vD6RIWPbrbvXfhovFsJiMKqFyRLJy5TCBnWZAWwi5VqAbtGwo=
X-Received: by 2002:a25:ae90:0:b0:dfb:207:dc7d with SMTP id
 3f1490d57ef6-dfb0207deddmr8325148276.4.1718053111170; Mon, 10 Jun 2024
 13:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com>
 <20240315113828.258005-2-cgzones@googlemail.com> <ZfStRK6Z6Rm/KTJj@serge-l-PF3DENS3>
In-Reply-To: <ZfStRK6Z6Rm/KTJj@serge-l-PF3DENS3>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Jun 2024 16:58:20 -0400
Message-ID: <CAHC9VhQaCv7syX+X_r3vA_mGRVgSUVc3HSr58WRZCQnaoSd7WA@mail.gmail.com>
Subject: Re: [PATCH 02/10] capability: add any wrappers to test for multiple
 caps with exactly one audit message
To: Serge Hallyn <serge@hallyn.com>, =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 4:19=E2=80=AFPM Serge Hallyn <serge@hallyn.com> wro=
te:
> On Fri, Mar 15, 2024 at 12:37:23PM +0100, Christian G=C3=B6ttsche wrote:
> > Add the interfaces `capable_any()` and `ns_capable_any()` as an
> > alternative to multiple `capable()`/`ns_capable()` calls, like
> > `capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
> > `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
> >
> > `capable_any()`/`ns_capable_any()` will in particular generate exactly
> > one audit message, either for the left most capability in effect or, if
> > the task has none, the first one.
> >
> > This is especially helpful with regard to SELinux, where each audit
> > message about a not allowed capability request will create a denial
> > message.  Using this new wrapper with the least invasive capability as
> > left most argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables
> > policy writers to only grant the least invasive one for the particular
> > subject instead of both.
> >
> > CC: linux-block@vger.kernel.org
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Looking over the patchset, I'm not seeing any strong objections from
anyone, and most of the patches have ACKs/Reviewed-by tags (exceptions
being the block and coccinelle patches), so I'm thinking we could
probably merge the first two patches that add the basic support along
with all of the subsystem patches except the two that haven't been
ACKd (we can push on those later).

Serge, as far as I'm concerned it's your call as this is largely a
capabilities patchset.  Assuming for a moment that you are still okay
with these patches, are you planning to pull them into the
capabilities tree and send them to Linus, or would you prefer I pull
it via the LSM tree?

--
paul-moore.com
