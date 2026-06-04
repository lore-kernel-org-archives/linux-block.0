Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5435B650;
	Thu,  4 Jun 2026 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607243; cv=none; b=V/9v6i7eNTewfQDfGQ+IJIDDp3qhl40IHLWsoqjq2opopcUx5fZBGLMEox/lGTB/S1Z05iaOqF1DGiJX+L40Sx58A6Pysy7MV6lApbESzpPjYgwkiCsJcGVcq1339iWAAuOCyU2iALGvzBQ7QwsgCFeStYsmU6b5XSmnTOd06mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607243; c=relaxed/simple;
	bh=g7GV7VqMpijIW+SNfApb2mbR+GSpP8vpvnWUWnP8eqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCK7ZqjCXSouA3HXy3XJIbfjph9x3LdfLgOdoJUlCIpIkjVEfNXIvmGMTJ/msNpiJkVWiwK6hydn++or1AlKmyC9BaP/LcPhpJe3zLJNdXMoQe8FWCzepbcWkykZC+24W00MXXsV5TwuY0CXt82GgQ0SnUomgkk2FlmGeFxnlUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npD/qQCX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npD/qQCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B531F00893;
	Thu,  4 Jun 2026 21:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780607241;
	bh=TNQDzyTjPMOgbDEx67tSPYyxULtyqVXdtuqSOyi2rII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=npD/qQCXliwX+s1LGnUae8rBscKjT9LqeuyXN2Y+WEUsCfVCvW68Q8iCSCNm1XCV8
	 NIm/5JSF5mb5VQwS1T+llt+BLnNor8purnG+vKzOJmUspBUXCtJvnZP3ioPo1sktJv
	 XoTnioM2w/Y/SXH0w0N1i0TPkNkd/pzuriuzadPPT8Zaor60E/yvTn6HfW44MY6uBr
	 rY2euggspZA+vOCnKYWTy0d8iJG7hyDFOUanrZjJIsaKYiGddxfnEMkZrJZJDf+CHD
	 4hNO0y4LEiVQt+m5oh8sZhmCPeiiwiwEAk1Zlu3wz/f0Lw07t+i4V2onX6mgAlHceY
	 UFJS3wUyhlaIg==
From: Miguel Ojeda <ojeda@kernel.org>
To: penguin-kernel@i-love.sakura.ne.jp
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bvanassche@acm.org,
	dlemoal@kernel.org,
	hch@lst.de,
	hdanton@sina.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	tom.leiming@gmail.com,
	wqu@suse.com,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] block: assign caller-specific lockdep class to disk->open_mutex
Date: Thu,  4 Jun 2026 23:07:04 +0200
Message-ID: <20260604210704.41751-1-ojeda@kernel.org>
In-Reply-To: <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
References: <226152a3-1e4c-4eec-9a17-1d40426a7b18@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 03 Jun 2026 20:54:05 +0900 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>
> Acknowledgment:
>   Since I have no experience with Rust, changes needed by Rust block layer
>   bindings and rnull module are made based on conversation with the Gemini
>   AI collaborator.

Then please do Cc the right people as `MAINTAINERS` mentions, including
"BLOCK LAYER DEVICE DRIVER API [RUST]" and "RUST"...

I am quite confused. Why was this added to linux-next?

It doesn't go through block, nor has an Ack or review and breaks
the `rustdoc` build in linux-next (and thus rust.docs.kernel.org):

    error: unresolved link to `my_gendisk_lkclass`
      --> rust/kernel/block/mq/gen_disk.rs:42:50
       |
    42 | /// This type can only be instantiated via the [`my_gendisk_lkclass!`] macro.

It is also not Clippy-clean -- it doesn't follow our usual conventions
for safety comments and sections:

    error: unsafe function's docs are missing a `# Safety` section
      --> rust/kernel/block/mq/gen_disk.rs:59:5
       |
    59 |     pub const unsafe fn new_lock_class(ptr: *mut bindings::gendisk_lkclass) -> GenDiskLockClass {

    error: function has unnecessary safety comment
      --> rust/kernel/block/mq/gen_disk.rs:59:5
       |
    58 |     /// SAFETY: `ptr` must point to a valid static `gendisk_lkclass` instance.
       |         ------- help: consider changing it to a `# Safety` section: `# Safety`
    59 |     pub const unsafe fn new_lock_class(ptr: *mut bindings::gendisk_lkclass) -> GenDiskLockClass {

Please see:

  https://rust-for-linux.com/contributing#submit-checklist-addendum

In any case, it is also too late in the cycle to be experimenting in
linux-next.

So what am I missing? What is going on?

(And on top of all that, for some reason I did not receive it even if I
am apparently in Cc, so I have asked the admins about that.)

Cheers,
Miguel

Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: rust-for-linux@vger.kernel.org

Cc: Mark Brown <broonie@kernel.org>
