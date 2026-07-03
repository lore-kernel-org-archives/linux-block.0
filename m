Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418CA23EAA6
	for <linux-block@vger.kernel.org>; Fri,  3 Jul 2026 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783043279; cv=pass; b=MycJIxvKVcgojXxsAWh47O/k2pM8O0K7Mrr34KOKK4t4aP8XhkD18x+RzItK099LYYNDE/1Ho0xUugOPVtytB4CthhFyh2baxNK67oh4SBki3CaASAjf8Ibknv2R9+PuvM/0LvWjWZ34+QMZ1NqqMJeYe5MruGJF7HQwVgpKlEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783043279; c=relaxed/simple;
	bh=JLtvplRuOrV1XCd+vmBKYGpvhguS1Ynr34OsxGcjbOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0FwJm9j3Lkp5f/hG9sTtF9aDEdpoGMKjREidj9ViGqOdoSUbG13kzokIweqquD57m9xxn21VZdLuDEbvd5myiWOzqyONjQpsQKoNhaffO4PqfLpi7ADyp3D9uHGpjSpj5GuDsKdXA8Q03ENuOAy6TfMwX2VRQAa5vzqG3kpqfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dufoFZFh; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dufoFZFh"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4629051c946so28061f8f.1
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2026 18:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783043277; cv=none;
        d=google.com; s=arc-20260327;
        b=aB2EP2awpjtL0K3Pdk3p97+OSpqL0w4hapk2OixtejHSMPEErY+BR4bMxs0yVK4Xqu
         CHzxxVvYiy6ifQ1cC14R1+Hs1sM9JUNcRml66m0cm/Ng3KqJ9wMcDqJQ8bf6g1XqgtLv
         mXNzmS5dAJHVkTWiNg1wTG3v41OeUWZWn/ZBOJdrn0JmupnEidq5u/YQ+OKTsqvz9mE9
         746WI27/FoObFBTQ5y24oRXO08htdHVsmmx9/9ZrDfAX4NLFxWnPyPDbQT2jmwM4P4KB
         FYY6GaGKhGlNMF5ccV/EW3js67x8gIVAwuTTDqoRZeJRChGZ+lovVYdUnKvaNNZNUFFW
         jlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DOn6vRfEsVTpudhzzAfawUs56a4yn/B/CVb7CXUItZw=;
        fh=5ZvNNGPciqxP+5UdgX1KuVmSy5VJLLAJfNml7OzxnO0=;
        b=H1BdGlmR2o2tPolQ8nkJX2+qvvvspSveqQRdJzBgM55o5TiKjYkkYKbWhDXPXPDUST
         iKsL/ILuW8FS8KZXSbJ41cOVbF3KAaUqqZ2VMoPNWDDSiStqIrneA56/WQ+irNkBnf8J
         wOYLA2eNntR+3fvZwT9l4lxpieqtoZJesJNpP2YIRA/F+L0sFfSsvtnBsUgvYXOyaTln
         hSabdqqAIVjK39C6AcG8m4B6fN1A9ChCEijEAe7T2Kr/aJYRP6o6qYGlbzOH540PzXwg
         Lb1YBXYCbn+/1hXjo2CUiYlQRYseN+w3B3a73mn27YmKmzsF+csL+irPrvUlZI3LAu3U
         2rvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783043277; x=1783648077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOn6vRfEsVTpudhzzAfawUs56a4yn/B/CVb7CXUItZw=;
        b=dufoFZFhKQJbHC9rHylIz0aof78rVCYT3QUD5mRkGhy2l7H+cJFcrmx0ybWXWVb0Bz
         lrW7QlHAltzBw+kvMLizK0YEHAsZoyWS0+XBAoIi5xhndr82fJHS0BTO14xA2bp0pF09
         V9ZauT/73+0QwIKwA8dZRxz7vTpOQodLMGz6+b6JtbzgHZWnE4U3ZSPxEiq9b/IPAP61
         XgxOaQaSXfFyC+6XiKajOM6iaFL3E6uuC8U+Vp4QxuvemfkTSW28CH+qwU8M2vcSQlbp
         EcQ0Cc6bpR44VXn7DnhTNgPmvFIcLFMk2xzoNdLcWJ+zRAytywpl/r3mFm9GN/af3ipm
         Fn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783043277; x=1783648077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DOn6vRfEsVTpudhzzAfawUs56a4yn/B/CVb7CXUItZw=;
        b=eW4c7rKmRtCE6gKKXavuWRaEI2JNxds/W6sIPOh/632pJWXl+meGBkxb/+4GMNJiBY
         DZ6trF+gjOHny0EH77pG1CWB7SCfu/ZT3YbAXHBE9h0uTnK1Xv0/UZ9yMxcHXbmivtTC
         8fNqQpfJfZ38NAiY01O0xyMginyLgNIxPoZEp19gbOuvqiG3pDDR3dEm1JbFz33Kjou1
         rH3T+QvmPXY3DDJeO+8Ic1LWAbbNBr08ajIopuXrqlRjcYV5KZNMDRXZpN0/7uFqJRv2
         +/rtiFHXzTiGkuRnulpn4j/Lb0j57r5BR4bKQLtYwXAEM47+2apivMXSbGhIP0f7uQ2U
         3Ang==
X-Forwarded-Encrypted: i=1; AHgh+RpYPCF4IQEW29GkItMxfaVVZFFm/qu8fgIzVg4l/uL/r9Xs31V2cD3QTnbXvj6zRRZC5vEfCvulkazgDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzifskjJsrMgQVIfGqik0D9V+cD661d8H+SmDaOSglWOxUN+I3v
	lLf15LjCgnMgcnlj/4npq9/GXN+Vj2R/QAMMdt/PlzkzBUOWjsJrSFwGkhSezlRRrssUi8uQmdz
	v/Km9UGYJ0tDpud7/ktkKku8qTPCmATQ=
X-Gm-Gg: AfdE7clkBNcX8kMzhb56E6ndAocgidXRUmA2xCY3fvYlmORLq6SBPzPOkqoXgZF23JD
	mw1XJd+UtRNSGK3yPg82xYAuf9m41unLRtZApu3aoVdgV3agzapxCsPwUHKD1mNfZhTYQjYZKfm
	Gc8jc4V2hdSAQBFn8zv22r6sX3YPRv4HvBsgi8fmqjHEeahazIkxi8FBOwVxIjJB4oImZcChIxU
	hFnGkDw2idQcGzGVCAKFxTfo9SYFcolkGMyuFAlkvfE0lyq7u8QtuxunxYd59xJ0uC767FbwW4f
	8Jh8pr6BQTX3WjFUbbRMgM0qOjtHzCshtukXKUvq9E3aVRlXjDxi
X-Received: by 2002:a05:6000:188a:b0:474:88ef:cdec with SMTP id
 ffacd0b85a97d-479347abc89mr3414307f8f.6.1783043276701; Thu, 02 Jul 2026
 18:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-18-joannelkoong@gmail.com> <20260702140705.GE21339@lst.de>
 <20260702165117.GK9392@frogsfrogsfrogs>
In-Reply-To: <20260702165117.GK9392@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jul 2026 18:47:43 -0700
X-Gm-Features: AVVi8CdwjVgCnc8OibEiAJiLFqrCHykAhTtcw0AOMmm18cQj3dSCo5Q-SEBvMhY
Message-ID: <CAJnrk1b8j5WHtbHOWNXc4=QBFOxde1f2QxTOeui7Ta8O-xWcTA@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] iomap: pass iomap_next_fn directly instead of
 struct iomap_ops
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Dan Williams <djbw@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Chunhai Guo <guochunhai@vivo.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, 
	"open list:FILESYSTEM DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>, 
	"open list:EROFS FILE SYSTEM" <linux-erofs@lists.ozlabs.org>, 
	"open list:EXT2 FILE SYSTEM" <linux-ext4@vger.kernel.org>, 
	"open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>, 
	"open list:FUSE FILESYSTEM [CORE]" <fuse-devel@lists.linux.dev>, 
	"open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>, "open list:NTFS3 FILESYSTEM" <ntfs3@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 9:51=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Thu, Jul 02, 2026 at 04:07:05PM +0200, Christoph Hellwig wrote:
> > Looks good:
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >
> > In terms of merge logistics, I wonder if we should delay this and
> > the previous patch to the next merge window so that we can minimize the
> > cross-subsystem merge pain with more file system iomap conversion.
> > If none of them actually happen until rc6 or so, orif  the merges aren'=
t
> > painful we could still pick them up late in the merge window.
>
> I'd say everything but this patch should go in during the merge window
> for 7.3, along with clear instructions to brauner/torvalds to expect
> this patch to appear right before 7.3-rc1 gets tagged, to clean up all
> the other changes that come in.

Just to clarify, did you mean this patch and the previous one? If i'm
interpreting Christoph's concern correctly, I think he's worried about
other filesystems converting to iomap using the ->iomap_begin() /
->iomap_end() functions still? That sounds like a good plan to me, for
v3 I'll submit everything but this patch and the last one and then
submit these patches (and any cleanup ones that become necessary) to
Christian right before 7.3-rc1 gets tagged (which as I understand it,
is when the merge window is about to close).

Thanks,
Joanne
