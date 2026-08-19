Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B543B9927
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149359; cv=pass; b=EWif3DtrvwSO0k5tmjzduc6z4HxAvuLKAdU56YA3tb/U+vVEKc18K6zUwSlOvBztIUZwyQIO+iDy2g0JvQUCdlfPTssFw2dnF455VJbz90V/R8Dl5bLsHmAYCZCQfO8kM9UcUy9OZHMyPu7rhkBJ+BUnl4u+Ea9MLEfxwAuRplU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149359; c=relaxed/simple;
	bh=WL0CzJuCKxnFNyuks1xwgxS4AVbpYe5kVLC/zCyuP48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0N5pl6VNjZcRzhfdU6rxTS6Zlm+AHF7ita4pYtvQOJUtNYmKv8zYwBdlRi5a6Qwl2HRtf2h0c9/9xQp2whLGBKpC+/4f2bTeAebI/LsPQOEMyQb3/QfL/s1X3oHlqB2bwJOCtX3eCkb0/eln/g2kmD8fw/5DmULQ1u9Z9hC3Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X55aiLUn; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X55aiLUn"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so861354f8f.1
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 07:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787149354; cv=none;
        d=google.com; s=arc-20260327;
        b=gESDS8ckyNWxX1d1Keo/mqRHuMprMW+cQvBNOGGoRh+LE8chgIHiiZ8oNXoxMaoyOx
         acGT6O3P/SKUeLm9TkW8/sgWIROAYbaw+aZWEskgIfT9gSTwnabl0xbRG45IJG/aoeeE
         Kwd6MX8FXuQf4S7g3oM7MksWt3fwUQjl861IdxcK2q+oJr8O3UJiHQd8/fNx5T3xPw1F
         Bo8khHN2CYronZZSDJqVrg7nlG5QkGHsztN7RfnN2bw66KIAo/g0LRWi76gSvB9hqp4L
         rLtaiPOIB05nDcxCTKSWm/ONn21GsDq49cr3H1UGLKzTshBLzVhTt3pSjR5w+nFCDWJq
         AjxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cQvDWR+gFuMyKUr3DP+1B7x5IuCKckvrgbg8XFRCHiM=;
        fh=tJQKZZCnzmdNAaTxZFmJopIThDEVaYzTiaLg9Jk7WZE=;
        b=Q57epzxgyEzKef8lycYKEUZEvzFo8KseCpclvUt3aN0ZsCEljOTW142HLUV/d/JXhM
         WkMkx5CL7Kcef3XzGldoz6GLYKpNYms4VypCi8JahrqEAzkQIfN4UqRkmIiRUPbnoUjl
         9JNZd4lMYTvNtIjjB5Sq7txQzhgT2C4eSM+eaNx9x7Lib3Lmf94dWKSeCBU+2gdLXx2r
         MwJ9oS4+7uaxlngHpwN4n+jfdlg6PpuZK9018sFuFAn4+Y7w+Dq3w8bkf9dCDIq6GbiB
         ldheyI3W8dA2el9pMS/HzMRoFzbtycOCVG/GTMiiigHiau0rGSHZaYbUa32A0LfOuDr1
         g0Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787149354; x=1787754154; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cQvDWR+gFuMyKUr3DP+1B7x5IuCKckvrgbg8XFRCHiM=;
        b=X55aiLUnSO9BWT0vC/lXMnlXZNsGts0j+QV/FUoakYVLv53le8mps12TvXy7doKZjp
         +fNMDkmKY1T59u8G4gwbzoaVg8avuroLpRcS4cLvC+ymUKF98RtytMbZat4iqvLp9vHD
         dEwsy0uHUjGzuR+Kwa4OCDeP53+Lcx7jH815GBFUqgZLBuAyg/f75zC1/1u4dSbtc0AR
         H4kUoQNQoInUBKBYo4vy1xKhHNHtGUgiLTq3SdahS5ftFsYL3FTeHE6Aqx/XDFib2A++
         fMlGZLXIa4Lruw8j+nFupztiBGR+ALRima4Y2j5SPLHnXA6IhrhNg7WqFD6fgAeeNBJu
         qsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787149354; x=1787754154;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cQvDWR+gFuMyKUr3DP+1B7x5IuCKckvrgbg8XFRCHiM=;
        b=Y6Z7C2kJVvmSptYNO6rpQyDqn9JEJUqS/2Rs3u3dZNnl9rg+NZD+Cs1VI93UYCr0Si
         I5LwNo7k3sdCXqczBNhVX5QLn7gulR0aGtrNetio9FPDXulC9O+PTul/CaCgr0vYWAHD
         x9ctuH2UCK2CdAxbK0XvZjCgnQ7DVVYvbdelTsqQIsXDhohhxudSS2cMNj9iDTsp/Y9i
         O1v5dmINE3rdYgKDnSM4cs+24PPcIgEFtpYIItxi9/GHLVvBrEMN/PDp07HqlFkY/1OI
         UwIg5NZTmb92BByh9WJbA4tfwdtEVaGB20maL9LcdQl2f7OteE0boyJOvdU+lw9FsjYP
         X7tQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrs0r25LO1rmv0fQyQMqeqE3WhrueGsJHTE/LUw6+kj2gAKVTUryTQnpBuk7DO4BWgg2eEypoxFfQweeg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy85Brwej3dMm/hpYPLEY6W1T8I7MGovo8Irhlq4BITZTTSxAYh
	FDrMKOuHa/vQZ+ViIWNokO57LNzv50SN5is4IymjiwYdhXWGCtsHUwoYg2O/lgPKjJzQ8IfUZDM
	4ObVR9pFjK8QU10iw7xIjog0Hbsm7I9HNd3EQhHMmTA==
X-Gm-Gg: AR+sD12WUbO/hq4m51BUNNhEbwh4YIWxNDX4CVQMn805HdTuJEag4ZovtXlv3/XQvTA
	OczZWyzIb3clPG53DT5aGNf5wzIS0XT6dilEIVbR7H11Q+lNd2XmmlrBxLiUXEcQwSDWMo8Rb4R
	hFMowNDQqFq9Z2sbvH35gC38gASy3qzBXe2ai1nYmu63UrNZJyYqY6+jDw2ihMo3+sBosC+yjYT
	COUfNZzm5epB2HLJftj4VZ1SWIJj6uNdO/g6MG3NhRUKfRTn25Tp0tiIaITcR/NbsWmJACPoKp7
	3meXgX88tfnW2U+XH2gXeYzlB98vGoMulBBzR2o4m84XVvMJoz//hbEqb53C6clKMxyTw9J5dkJ
	yAzNL9W0D4cXUTFmYqSY/wwdjDikVvdGSjyXc2z+vBRR9+Lf/Wx6a
X-Received: by 2002:a05:600c:a012:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-499aa180132mr108268535e9.1.1787149354463; Wed, 19 Aug 2026
 07:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-5-neelx@suse.com>
 <20260601230406.GC25574@quark>
In-Reply-To: <20260601230406.GC25574@quark>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 19 Aug 2026 16:22:23 +0200
X-Gm-Features: AcwNN1WuVLXRwMTVjG6424GkTTp3P9BzGVQP00nzsthmGhd0KVAoGe8C-GfV4As
Message-ID: <CAPjX3FdMBAbz9T5yW=0ytRJD8s6zYHpo+TcYY-9-+egBHL=TFw@mail.gmail.com>
Subject: Re: [PATCH v7 04/43] fscrypt: conditionally don't wipe mk secret
 until the last active user is done
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 01:04, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, May 13, 2026 at 10:52:38AM +0200, Daniel Vacek wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >
> > Previously we were wiping the master key secret when we do
> > FS_IOC_REMOVE_ENCRYPTION_KEY, and then using the fact that it was
> > cleared as the mechanism from keeping new users from being setup.
>
> This seems to be describing the state prior to commit 15baf55481de, not
> the current tip of tree.  We do still wipe on
> FS_IOC_REMOVE_ENCRYPTION_KEY, but there's a separate boolean that
> maintains the status and everyone looks at that now.

I see, I'll clear that out.

> >   * FSCRYPT_KEY_STATUS_INCOMPLETELY_REMOVED
> >   *   Removal of this key has been initiated, but some inodes that were
> > - *   unlocked with it are still in-use.  Like ABSENT, ->mk_secret is wiped,
> > - *   and the key can no longer be used to unlock inodes.  Unlike ABSENT, the
> > - *   key is still in the keyring; ->mk_decrypted_inodes is nonempty; and
> > + *   unlocked with it are still in-use.
> > + *   For filesystems using per-extent encryption ->mk_secret is still
> > + *   being kept as the per-extent keys are derived at writeout time.
> > + *   Otherwise, like ABSENT, ->mk_secret is wiped, and the key can
> > + *   no longer be used to unlock inodes.  Unlike ABSENT, the key is
> > + *   still in the keyring; ->mk_decrypted_inodes is nonempty; and
> >   *   ->mk_active_refs > 0, being equal to the size of ->mk_decrypted_inodes.
>
> This is saying that a bunch of things don't apply to extent-based
> encryption, due to being after the "Otherwise," when in fact they
> actually still do.  So the wording here needs improvement.  How about:
>
>     ->mk_secret exists only if the filesystem uses extent-based
>     encryption, to support key derivation during file data writeback;
>     otherwise it is wiped.  Either way, the key can no longer be used to
>     unlock inodes.  Unlike ABSENT, the key is still in the keyring;
>     ->mk_decrypted_inodes is nonempty; and ->mk_active_refs
>     > 0, being equal to the size of ->mk_decrypted_inodes.

Agreed, this sounds better. I'll use that.

> >   *
> >   *   This state transitions to ABSENT if ->mk_decrypted_inodes becomes empty,
> > diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
> > index be8e6e8011f2..796e02a0db25 100644
> > --- a/fs/crypto/keyring.c
> > +++ b/fs/crypto/keyring.c
> > @@ -110,6 +110,14 @@ void fscrypt_put_master_key_activeref(struct super_block *sb,
> >       WARN_ON_ONCE(mk->mk_present);
> >       WARN_ON_ONCE(!list_empty(&mk->mk_decrypted_inodes));
> >
> > +     /* We can't wipe the master key secret until the last activeref is
> > +      * dropped on the master key with per-extent encryption since the key
> > +      * derivation continues to happen as long as there are active refs.
> > +      * Wipe it here now that we're done using it.
> > +      */
> > +     if (sb->s_cop->has_per_extent_encryption)
> > +             wipe_master_key_secret(&mk->mk_secret);
>
> wipe_master_key_secret() is idempotent, so we might as well just do it
> unconditionally here.

While this is true, it also (kind of) documents that the secret should
already be wiped out by now in case of !extent encryption.

But I can wipe the secret unconditionally here if you insist.

--nX

> - Eric
