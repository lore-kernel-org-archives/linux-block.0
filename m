Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9CD3382E5
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497805; cv=pass; b=cp3/IGOptT5ZpUAeUcWlbfnzS97BDN4/48jVqDh2Lj0XrOrdeq3befY/HrWt0+RRYnj6/Ru12TZzrwSifovj4TBkIHuNWP/k+9eYB7dm3K7+4uAHR2aOptbjucIVDD4ZoUppfDYvD7+9+NwCq/HwDdcNvxuLNQ2QSU4z8wKv9cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497805; c=relaxed/simple;
	bh=fhnuYB8beKyJ4Mt13AymxBrbjVthPvqwfJloa7cxwhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBd6c8GXYG9HQMMiFav7YMbJbVthTsierruf0b8O3uC9IEnDdRXyKqglmWyuFbNxENrcXiDEDgRjgI3awY8etJfMxjYv5FAP5e1SIc0+5gtLM4lo+HX55riaPL1JAYzreEsKpXCN78sgW6M7F1nTogHw+FpTzmpbo/8n5pzaKPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WTNE7KR1; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WTNE7KR1"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59de2d1fc2cso795650e87.2
        for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 02:43:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771497794; cv=none;
        d=google.com; s=arc-20240605;
        b=czH3OW4fvyvlkyvP6rYsCoF5Dowmc5PmO75g7jfyA0PIrREB7LdEdbK7j+DcOoJ/pa
         9FKPbl7keaVP4FsH/VTXEhDG391EZbuircylFhQZgukNvuEGdHrajgjBKByFsXJMJa3p
         zAQXLopRsy6bnOjRl3wrSLJoI0lUQ2xeaHyQTvEl2uLLOq1AkS6WqJF6Lx2GmmvaEHEq
         3zUtOJ1V6AqfuinJOMlyl/TvTDx7u6Nu2bbgqh6KrWGTDobc9eKqZdEkqxD9fgU0LUfx
         Xh4COmN895wNnn1tJ2I5cpCPU/c0jTsEtg02TUQAy1olHvMk8u85cGWWQbFDRhXz29xR
         mP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fhnuYB8beKyJ4Mt13AymxBrbjVthPvqwfJloa7cxwhA=;
        fh=FUPt2XbM33hlu7Ok+22UmMs3T9GUMMSzI3Jj9pjZ1ok=;
        b=THrdAeexC7wcCdP5PZKn1hIXI0GSUdwlbvWLAcbFXqMw8F5/BrYu1W0201hW/ttb3P
         k5nWbDLJDEGL5hQF4JeLqCTtFtEAxw3HM+KP2kNuj1ngs5168bSB//EIJjuB1VhHY/BM
         fncV1hyrdMECsliIbmmR07QEjNGWVhU6ocjZ4aKCw9jyTGnSXbr4f8uBerCTWO2cbUS/
         iUO/S34v1ACQ8FkQ9KDNovFadv0RUgyCgUODgoEAMAhY7LldCdjRmg0UAtvkPHvqVXVE
         OE8Md0ujoxpC6qDt/F9I0rwoKa8v+ktpPJcqhED+2my5Zq6EsI9zhzNndxv4tf1wCnQ/
         +Q2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771497794; x=1772102594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhnuYB8beKyJ4Mt13AymxBrbjVthPvqwfJloa7cxwhA=;
        b=WTNE7KR1coqYdbKJ7BUEzoZ6fx2KB9yole8aO4nbXOr/oUJIZNEEhOqXAQa5tVlwf/
         P0x7GIDc8zXnPB+uwvG9+f3YzAv73rXEp+ZxaaiBkOkeclyFn/kzM6sbkZ9wQRwxvXFg
         SzXUkr67W4JfxTqRECdHwMcbDmmRHbB+zTOeAYqYj4gu7YTpsYinWrsWcA9bRamQRomH
         ZquLc4+c4KD0v+2jSsmVYYLUEPZQjY4uH5xmexdm9BLRfTbDv+cBSPhZxajl+j6vZkl0
         bc+oe9v4wGPn/pmWA/t/OcKsexjzVL0O5ZKWwN8BZNN9LR04G9FE/dWUKASCjesE+HH6
         Uuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771497794; x=1772102594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhnuYB8beKyJ4Mt13AymxBrbjVthPvqwfJloa7cxwhA=;
        b=mKh9/mvbn57kpqtNUhRhPdJByidDu0FdIFZkIP8f32suiId+Zhzo4hACqqBlrw4LC6
         s1XyiUnCdGGiNfAcL5IxHcleipYyObDeMtQVUaYCrzhhgdNGKeMrTSECBu5qMs5eDaDS
         yuFb7CVKGvIsJt4x2SO3/JKzB6zjyXBpLPGjUkyvkuN9FGgqrO186wvU/gYDqz8QGUVl
         2plTOcIVg4eXByAvm40JZFQL3gvbQ3VRynikf+XuDtQAi5HIHYJOhp1GVPLPShnRLJkG
         DdhETGuGFtDv2LPQt6URwtrd2+tg3jDoiVyXkNEYaSmSimBDMhvgIyct4I10OFTmMrrR
         zYgw==
X-Forwarded-Encrypted: i=1; AJvYcCU03lv0Ag5YMN2F1HbP+l07hzBxmuKwJqxDtvEOlSFV828m0ekxkC9HKtx61oZAOKTVge3gAF3Ji6hqQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOehfTOXQJawfE1+cwj8QOxSR5nqxLSfKa+qL+hgqKeCnY0Dfx
	JCGuNTeIeTGWos63wZ/BJFU+i3Eqb7V7U/mTj7xgwqaxxrnM/c4Z+NP/MCluTxjwRgqxnDtmP9Y
	nyOH9zcSPUaSlvnE/sHM59odTX1isHGOBaZOQD46vLQ==
X-Gm-Gg: AZuq6aIIEC2crvLqn7oA3+vUZ8aERh3OAsztc6BYUfmclrULcn0aCV59mKJd+yKYyV/
	MDpq4BICUQC5uUYmSbJQxXECb2+LYeEGTtSKTgzTLBccAulYp0jMO4XJJU5IJe44ijT4hPk82GX
	MxxrvV2taNoBB3xT2jM8Ws07Ebj8Igj6oHfTB5Io7FMy6v0ijoZbV4sguKpWUQsoMz649iLq4hp
	giNqERPrGSvmtmd44xD8nSfd9ofCnboRqxUDrDBahsU9zUt8ahQF/2iFVgSWn6OjYJy2Fla9QGn
	eQI3fg7lI/P1q5khmUa66nH25LvLlSPneV6mUsBIuh704ALN8gUVlbJEf1yYuRAkg22GrtU58IH
	xrG0=
X-Received: by 2002:a05:6512:124a:b0:59e:2aeb:3acb with SMTP id
 2adb3069b0e04-59f83ba4fa4mr1708881e87.23.1771497794469; Thu, 19 Feb 2026
 02:43:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
 <7aca0686-b255-4ece-b766-ebfc90df7340@acm.org>
In-Reply-To: <7aca0686-b255-4ece-b766-ebfc90df7340@acm.org>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Thu, 19 Feb 2026 11:43:03 +0100
X-Gm-Features: AaiRm515hLP0roKsdGWQZfdyzUXrLj8hv4bgx4OtzfAflEQjzn5D8oCpl6Rn_uM
Message-ID: <CAJpMwyha9Tuzn1nEDvfPbdaPFa6WbVBO91QoPEKJC+DB7V4PBw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication solution
To: Bart Van Assche <bvanassche@acm.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	Jia Li <jia.li@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 6:32=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 2/3/26 7:09 AM, Haris Iqbal wrote:
> > We would like to present the idea and internal workings of the
> > solution, and also discuss design and some benchmarking results
> > (comparison with RAID1 over RNBD/NVMeOF devices, or DRBD) during
> > LSF/MM/BPF. We also want to get feedback, and potentially get more
> > people involved in the project.
>
> Please prepare for the question why the choice has been made to
> implement this functionality as a new kernel module instead of
> integrating this functionality in the DRBD kernel driver.

Hi Bart,


In short, it was mostly because of 2 reasons.
1) We wanted to keep the "single-hop replication and syncing" offering
in a generic transport module (RMR), so that it can be used re-used by
other modules in the future.
2) We think that DRBD=E2=80=99s core abstractions (per=E2=80=91node peer re=
plication,
single lower device) are orthogonal to =E2=80=9Cactive-active replication=
=E2=80=9D
model.

We can discuss this further during the summit.
I assume when you said to "prepare for the question", you meant the same?

>
> Thanks,
>
> Bart.
