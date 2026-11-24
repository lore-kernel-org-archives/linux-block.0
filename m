Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554247;
	b=nWcMqWYWcJqcEt5qZ7As5q0YkUUaCr5/fRAx6upcOfzx6VFsCJEFzW9tYQcMj1Hrrhyx
	 l1J0WamWCNFZy7rrHF/gmh48tso4vsJNSVkm4BcZOiCVripSOistO55RLalBR6dZNaggD
	 ShamV93C0Pq4iKBDxkCIL5lROdWK2bJ7cGyQafjbjL2fC5MLrdAjsvj0LtKXMrkHk7eYd
	 o5QpCnnInZs2qhCBfw20sVBdsfcb4pFbZbE73J77DXS+RsnisW7euS51wqm6559WceMeq
	 YWs6LawRpKnLJpThO/s9FmRJ4jewS5B/2fYiSuTpc8eq+TZg81V41gF7WYdP67dj5xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554247;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-MIME-Autoconverted;
	bh=f1LrI4F2sKsO306nzg/h2ovN7/3ZcOp7p0chdwD8VeA=;
	b=3ov/Cs/qNs/y22rSTVyHJKL9Msi9AwQjmI315NETn0fM6WV32MDS7VgIhlNpTxIzIdho
	 OAYKKT3nD1BZvkEkcEzN87WIaoEAwEFnnYMGMdAfqo9dWnNk4tBvcYb81pwsCu/xFFto8
	 skvB2BCzk4D8wPCqRM/ESvbC6Y5g9jbK2NXFH1eBEzmcGo0PNfeh3IBG7NowL+9m6OR1Q
	 5DQKrQ5cux+OGNAk30dRU5R4KSjzX1WUHyejim7ZmdbHnzv8XR1GgaIV8PWT4XFE4DcWl
	 JopSULIw35TMaPzkCcl81UoyysZxZxwgJ7SdWBKRvrDphXFPO2fxYXQfF02+gu24giQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	dkim=pass header.d=atomlin.com header.i=@atomlin.com header.a=rsa-sha256 header.s=purelymail2 header.b=bvY+kW9s;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=NV3pbREF;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9FA606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 21:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B9FA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=atomlin.com header.i=@atomlin.com header.a=rsa-sha256 header.s=purelymail2 header.b=bvY+kW9s;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=NV3pbREF
DKIM-Signature: a=rsa-sha256; b=bvY+kW9smQ/USSNTgGxUuIjv7MH+/vcE3aruhQ3qL5AJS471/M00i6PR9yIqof3dDsH+yvfsKhhymID5zTPUHJcso/W9qory1BilPTnB0rBdjzxUWmkFqakHISanXgAMu8xlEqQlEGpBfyOq+F3JUjIvSDrjVlfhOI8eb+WXYGoqIk9kGzQPAYeDHKIl4ehMndr4wpa4cw1IweczFimpUxNuTNy9QM9k20cfTPwt9QEO0Jh6xPyp76WsQkkWhqWWz8GDirX/FBIAgf0ndnqUbsGLF13YDOxFdB8xsMn7RqdBEQwJ72PAEMDftEk3BMbvjBWz1vwINeOn0ZJPVpYqpA==; s=purelymail2; d=atomlin.com; v=1; bh=LBTIbpSasOIttazXOXIKcClliW3GfeA4oLmDKjXQ628=; h=Received:Date:From:To:Subject:Message-ID;
DKIM-Signature: a=rsa-sha256; b=NV3pbREFn0LmAuGk5gPXW0P/M6HzawY5DFxLnmR/wb6GoOcr+7EseirwQ0rRCTKihZ/IxJ0vyjZ/9cGp/WP+ivzlS8+PBT++F6C3r9LRVdw4VwzVOwmmFiVSBwWNmBI6WzdYskgAkPx1WJglBNEhwvm0pWUFaSy0i9C9Wp6yOvzks3PK5hCGRPJBu0yiH88iGuFw4TLTBdwUXRgCXVip1Ikia+ZvzBTZf1/18lIw1dSEahWNxSPC3k7aMLkcPrcr20+h//Y/iVr+/Ms1rQonZu3INGQ5Kofcbj9dmLFMll+hfXO+RncjNtyS02XNqJ+Pal+NGYZqMoVPru4Ir73KxQ==; s=purelymail2; d=purelymail.com; v=1; bh=LBTIbpSasOIttazXOXIKcClliW3GfeA4oLmDKjXQ628=; h=Feedback-ID:Received:Date:From:To:Subject:Message-ID;
Feedback-ID: 1802931:67223:null:purelymail
X-Pm-Original-To: linux-block@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1233994586;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 24 Nov 2026 21:03:22 +0000 (UTC)
Date: Tue, 24 Nov 2026 16:03:21 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, dwagner@suse.de, 
	emilne@redhat.com, frederic@kernel.org, tj@kernel.org, sean@ashe.io, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <b7vpfd7x6mqmxlu2kqpdzx4oeyxvak7tiit7xslkjdrqblcoh4@aujkhfpmwqnh>
References: <20261121235203.811792-1-atomlin@atomlin.com>
 <CAAofZF5D+ycbtMxsnUgZjhUbfD+_ZD6kYyci95OTdXug_aw-dQ@mail.gmail.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAofZF5D+ycbtMxsnUgZjhUbfD+_ZD6kYyci95OTdXug_aw-dQ@mail.gmail.com>
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On Mon, Nov 23, 2026 at 11:47:47AM +0100, Marco Crivellari wrote:
> Hi Aaron,

Hi Marco,

>=20
> On Sun, Nov 22, 2026 at 12:52=E2=80=AFAM Aaron Tomlin <atomlin@atomlin.co=
m> wrote:
> >
> > [...] In real-time environments, an active SCHED_FIFO workload will
> > starve this SCHED_NORMAL worker and stall hardware dispatch, whilst als=
o
> > introducing unwanted latency jitter on nohz_full cores, defeating that
> > commit's original objective.
>=20
> I would phrase this differently. cpu_is_isolated() checks HK_TYPE_DOMAIN,
> so the jitter argument holds only when the nohz_full CPU is also
> domain isolated (isolcpus=3Ddomain or an isolated cpuset partition). With
> nohz_full alone, or isolcpus=3Dnohz without domain, this patch does not
> apply and the behavior is unchanged.

Agreed, that distinction is much clearer. Since both commit a46c27026da1
and blk_mq_hctx_unbound_cpu() test cpu_is_isolated() (HK_TYPE_DOMAIN), CPUs
configured solely with nohz_full=3D or isolcpus=3Dnohz without domain isola=
tion
(or an isolated cpuset partition) remain unaffected. I will reword the
commit log in the next iteration to clarify that this applies specifically
to domain-isolated CPUs (including when combined with nohz_full).

>=20
> > +static inline int blk_mq_hctx_unbound_cpu(void)
> > +{
> > +#ifdef CONFIG_CPU_ISOLATION
> > +       if (static_branch_unlikely(&housekeeping_overridden)) {
> > +               int cpu;
> > +
> > +               guard(preempt)();
> > +               if (!cpu_is_isolated(raw_smp_processor_id()))
> > +                       return WORK_CPU_UNBOUND;
>=20
> Since preemption is disabled by guard(preempt)(), you can use
> smp_processor_id() here instead of raw_smp_processor_id().

Oops! raw_smp_processor_id() was a leftover from v4 before guard(preempt)()
was moved ahead of cpu_is_isolated(). I will switch to smp_processor_id()
in the next iteration.

Thank you for the review!

Kind regards,
--=20
Aaron Tomlin
