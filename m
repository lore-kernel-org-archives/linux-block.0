Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F72A357D09
	for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788080252; cv=none; b=d7R15Xrd+U/7g72qDfgpwVDRc4utIWJTauoJbepzd6nIa6lxgkwdCQJYpgeKHMEgNUeChuYtc6GYxcl1oVycRkSMj8UhX3rTjwiwcEPNiMldD+r6jD5plwBQYK6YskcC56sz7G+s4kOf2kkiALXMzAkc7tzmgRs+IH8AlhFczZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788080252; c=relaxed/simple;
	bh=E8nmShe8kC7jCCQNYbIRUwo3OQACoeUixu9mDApoJtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8iU6kx8cDA9/yAck6Q37AgLzato19YuKYtQ5YDsv5WmEEI3fXZH4xUKwiwuHMya7GY6HqWh9x3WnkY9ERjKFdVFf1KRZoAjGIcR7kjJmupdfcXKMJkinV5mXCIo3YkrhU+Lgf9DCWTONJW0Wd1BJbQuvaaZ0A71EOREnNfoNsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqxJpBEt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqxJpBEt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27FD1F00AC4
	for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788080251;
	bh=029+faS5ZzWsov4hpcUm5x/4rseKLpq/BvplkVhE40Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oqxJpBEt3n/PrGLolRfZZ7q7RTLGVwOKqEZrxdigyJmNaxBaixGYhIkZxi2c5aHwD
	 zunXvrJiXLvdfJs1+0b3rPl0Y12AJ6soo/nCjQKUUc1BAfJfxfp9TUJdt6hnaVQ5Xv
	 EOylIyrS38eh5Fzk+dcH48n0ojGUMd2gnf020FT3U/1Gcnp3OqcRsb6YSMxUiPJQDF
	 8CefjlqcToWNeNbAvueJxf/Hsb0MyCeMlYp437F6XPwy4Crs8HHWbPfdJdUMQclMCk
	 CPhTPBIGDk+KRETf7XulrJk+h2d4YVk2vmGBwsCXP8eRAnUKt7aRL6YxuvwEqPA/JQ
	 9/X7BSHxiyo4g==
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52b6543169fso16312521cf.2
        for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 01:57:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpFogigGxe60ToGfCheI7w40H5+TVslICawebmcV96lvTlI1xWyc4F0bvOHWedgxj0vyxqhfVrTxplXuA==@vger.kernel.org
X-Gm-Message-State: AFuF++nrK9WHAQUTTrAZye5LiSNAiHt13Zb512iSJxYlLXl1YBv0f4Ei
	dXrPNlMCsR7MraL2kKc3yXPxoCINL4nCUtRXKIUhaUAJWDc42jRjBevRRANtXnPr4WH1Q5b/4PD
	u6Ba9cofX2ntEmGQzmJjUorkgBMHEE2g=
X-Received: by 2002:a05:620a:5d83:b0:92f:279:5953 with SMTP id
 af79cd13be357-939138ae01emr1707149385a.27.1788080250323; Sun, 30 Aug 2026
 01:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
 <20260730-blk-dontcache-v7-2-3e8e6850068d@columbia.edu> <CAGsJ_4wUvLoKGafR3U-ji1kUUaz6K_QdN6QxMT-apSaO5tXp0A@mail.gmail.com>
 <6672b30b-427f-45ed-a172-4c47a63d2c7c@columbia.edu>
In-Reply-To: <6672b30b-427f-45ed-a172-4c47a63d2c7c@columbia.edu>
From: Barry Song <baohua@kernel.org>
Date: Sun, 30 Aug 2026 16:57:18 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y8tAh8A8pfi5TJEtPq-JMPjrLX4gCLvesmPNYuZdWCCA@mail.gmail.com>
X-Gm-Features: AcwNN1UV9cGDBED4rxscU4sOzbiEGy-p9iJ4uD11AMCMxh60PQMZXIFRTunlV-4
Message-ID: <CAGsJ_4y8tAh8A8pfi5TJEtPq-JMPjrLX4gCLvesmPNYuZdWCCA@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] block: add task-context bio completion infrastructure
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jens Axboe <axboe@kernel.dk>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Chunhai Guo <guochunhai@vivo.com>, Dave Chinner <dgc@kernel.org>, 
	Bart Van Assche <bvanassche@acm.org>, Hillf Danton <hdanton@sina.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 11:26=E2=80=AFPM Tal Zussman <tz2294@columbia.edu> =
wrote:
>
> On 8/16/26 7:11 AM, Barry Song wrote:
> > Hi Tal,
> >
> > Thanks very much for the patch. I=E2=80=99m just a bit confused that
> > folio_end_dropbehind() only requires in_task(), and nothing more.
> >
> > void folio_end_dropbehind(struct folio *folio)
> > {
> >          if (!folio_test_dropbehind(folio))
> >                  return;
> >
> >          /*
> >           * Hitting !in_task() should not happen off RWF_DONTCACHE writ=
eback,
> >           * but can happen if normal writeback just happens to find dir=
ty folios
> >           * that were created as part of uncached writeback, and that w=
riteback
> >           * would otherwise not need non-IRQ handling. Just skip the
> >           * invalidation in that case.
> >           */
> >          if (in_task() && folio_trylock(folio)) {
> >                  filemap_end_dropbehind(folio);
> >                  folio_unlock(folio);
> >          }
> > }
> >
> > But we=E2=80=99re applying a much stricter check with bio_in_atomic():
> >
> > +static inline bool bio_in_atomic(void)
> > +{
> > +     if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
> > +           return true;
> > +     if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
> > +           return true;
> > +      return !preemptible();
> > +}
> >
> > I feel like something may be missing either in
> > folio_end_dropbehind() itself or somewhere in the
> > filesystem/block-device path.
> >
> > Do you know why they don=E2=80=99t match each other?
> >
> > Best Regards
> > Barry
> >
>
> Hi Barry,
>
> Apologies for the delay.
>
> As far as I can tell, the in_task() in folio_end_dropbehind() wasn't mean=
t
> to be a generic test for if it's safe to sleep, but rather filtered out t=
he
> known unsafe case of buffer_head writeback completing from IRQ context.
> In contrast, the bio_in_atomic() check needs to be stricter since the bi_=
end_io()
> callbacks could sleep or the callers could be holding locks, RCU, etc.
>
> I see there's some more discussion about this at [1], but I suspect there=
 are
> other instances that are (incorrectly) using in_task() as a proxy for bei=
ng able
> to sleep (like f2fs_read_end_io(), but I haven't looked too closely at it=
).
>
> Additionally, it probably only makes sense to use bio_in_atomic() when th=
ere's
> some deferral path, since with CONFIG_PREEMPT_COUNT=3Dn, it'll always ret=
urn true.

Tal, thanks very much for your reply and the kind clarification. It
seems you're right, and I think we should also use `bio_in_atomic()` in
`folio_end_dropbehind()`.

On the other hand, as I mentioned in another thread[1], I really feel that
`bio_in_atomic()` has nothing to do with `bio` at all; it's really a
scheduler thing. We may want to move it to the scheduler layer and
discuss it there.

[1] https://lore.kernel.org/linux-mm/CAGsJ_4xxDpeaPv9Uh_1qsuXsMLkx+J0X=3D2V=
6342idLFO5jkTBw@mail.gmail.com/

Best Regards
Barry
