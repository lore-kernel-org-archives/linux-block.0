Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F52BEC4E
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266015; cv=pass; b=ZunHeCk/mhL+ezlh6DDEYVZeqY37F6SS98m4JqLHJgbHNTLPp9w05+yQH57Cupxdee6rC3gtHTB/ilBCX9ZGioU0EDWdChhggvUOqZdBczQSKpkcwCjCfMk0P8qyBt25DxeT2sxEQIrjAIwrpPeAugr1QSth4fptRo89CivZVpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266015; c=relaxed/simple;
	bh=tTilPEePkpjTFCruJKJ/IvVnzIPmWB7ZxbAkmTpfbLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inZBiozSfg6s8EbNig9U04Ooo1FscbzF9uIxmxjpbrpwTPnpXkHn7ZwIZyXZHNj5BaaNRMdXVtFweXQ2xsR7/LaQJEliMf+jpiuQU1Ah5GGGZ/7weYIpjwtHlTDrm//WjqmUJcFxojwNr+nBLsMtBtUdV2IQZ9jj3brZ3RigIko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LwULko2B; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LwULko2B"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956869750eso31933165e9.2
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 05:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788266011; cv=none;
        d=google.com; s=arc-20260327;
        b=B9WOGKjCIW6orUi2Qu3N3FFl5EYxBZeXZf88vw3+2krcpjIZ3THpfKHxO1HT6f+kuU
         4Gxf1iREbwUsN6qA1rCsYqiTNaYC7B3UO+KNZ6gqJ9hUPhh4B1sDbXYtkqMu2dWGMLs3
         nMgXg7YI98dh8eJqwxeVmVAIK9LZ1L6CoFRhPE38RsT7WP0F1ChGvh+TNJJbA7Oa/Cm4
         NPT1/ORQcZ+XIL2dAEx5WE/GZ4J307FkGVLtPvEL51gZcQduKabsZ+ZFYYk0xVoV1h4E
         BSE000+ddBpV3a3SzQVEGGWpo333BCyUvqshcSVCYBrqDFSzbwj9/g8RA3ASdpTqcRei
         woWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cfOC0PiJENFhgp3GUEin/fTduYk5GNhKZ1VkMcNkAxk=;
        fh=JnT88ck8AeWALk1PGXFVEIeBa1xP05z6Cg9pMIrP1Sg=;
        b=NwiZ8iC4QVkr6BEhdIU/9IfRux2XpxFEGkOQH21+M6U5Ek1Y9Y8c1ILoEL8STD/8qA
         4zklwCF/aVSANgkFLQvr3nT9O/orvuhqB9XFnQfDDCZruKsKww5Pdi5yMdB9S8GWyBqK
         h+VY2aa+QiIBTmzwzZGZfjSxIhsIf4uvSfUJit5u3EU3niJtMkpvplAe9touLK4CpElV
         y3Nj3G1B37lw9ZwDtb4ErYrHYT8hQiXOLtFM2NvIIQnoW5TUWzeo8fAA3MkLY7Y9/cna
         gezRoMuLYjn8nMriAp+iz4fk60c/A/n/aMdfewKJkzApqCEIgpykxE6cx+9m7OpiOqCv
         CH4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788266011; x=1788870811; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cfOC0PiJENFhgp3GUEin/fTduYk5GNhKZ1VkMcNkAxk=;
        b=LwULko2Bs2/mrcLVVTaUXuF8PSdjkYkM7/aT0kj3uLwex+mk+2tR4S+4gfN0f9f81f
         y0tITeUFsvdVAIOSundN4TaLgBLXIklaAiLC9FCYq/6oVyvNBCOATTVCaKQgmmkq5g91
         sVSJbFUHpl1v++n4aVhRL0t+np6VpsuFHXngdlrNwy1liHtUPiTZvsjdVx5oxjrzmVAc
         iIgvUafOTrGYjXM+hG8UghqxdwaEi4zYMeWAjKmGSl6/AcwLQ8ywIkVNCj0F8yv5XiOJ
         z6heTKm6E1Ho28SNQcNkp1eU/9ja4Q9ZgktC9cZXnzagpNWsy44ijRIIC9dlo5G9EXWJ
         qViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788266011; x=1788870811;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cfOC0PiJENFhgp3GUEin/fTduYk5GNhKZ1VkMcNkAxk=;
        b=P0FW6efXHIv6mKR3gUl115p8FCODx/0XglAi2Rd6lQVrDrRusG+jIhRfAHaPqR/CVS
         YUuH+SAuNhGow7SAKq9j39MIpLstxhRVIiqhpEyEvy80XHQUL9d61iu7h8RjH5dpgLBA
         S3pXlj777JuWWHBqk50PyUfYAhd6MOz5w7DIY81w5eLYDs+MC8VYpCG/49x8Hap+b/sd
         871eP0mvzoa6x+sYOM5CTRLlCQV6fhbNSEw3RJbf9uQk3aklD6Xht6qCrVUkBnjYdCXk
         TOehYIzB7FnchR4MXp70cw0iaZ7SQn5AG58TA4jU780nSyhn8Pop3Qo8GFunwuI8T5rx
         WBtw==
X-Forwarded-Encrypted: i=1; AHgh+RqWrr6N5O69jHiVAp1qXXMhgQTAOCZAHiTOuWjhwUGEnGF/iLLH2ScXMa5ULTJ68TjeWFSVTBoTSpTTVA==@vger.kernel.org
X-Gm-Message-State: AFuF++luWPLumU+OLUorY17Oyl4dJCjbqM8nrwTTCdEZ6llPP9qYMWIC
	THGxi2IxF30ROLgqk+8KfbcIAMdQUHxRgv1BVgIjNlGC1L5PiuajOIicBQHrvkPW1/hsG1+twHi
	GvhMcheU+tY/SFZ72vUMcO71hBwevRTLM8I2n4lKJGw==
X-Gm-Gg: AR+sD103aWct+1HrwhxDaZbK0kwOAYWPbgYvqZewIZ6ZcWgyeuY7C+dM5CpdVp7FbQT
	JvDRUWq7IDrFuC+NGQRpOcCjVUiBxLSiJF33eHeUIOGtKwJH/mYLZKGmn9VjuALcfsN+NDsjLp4
	JFri6bVBoKRSwGSpadnxqc1wWmt901EcjVgFbdlLXcjsxKag1SLXlKZwjsSEO68WKhddYOxtyv2
	LbndQuTeRo4aKrW0BVVlMTeq09xRJTvG0MxFvF6mHezVzNvM476jFXAxQ6d8r3bVBktx1i+Rgon
	o6mPyw0VJl23jXnqDxCVLfzfJ3N+nLpwO6TtYcPry0aa9uL881eJcI/6DM7IEF7qzNnos4wHJbJ
	GhKyB3caME+HO1qMOes2NhMRniN3HwSMvJEa7r2sHGg==
X-Received: by 2002:a05:600c:4f92:b0:49b:90cc:3c87 with SMTP id
 5b1f17b1804b1-49b91c487b2mr523873155e9.13.1788266010932; Tue, 01 Sep 2026
 05:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-6-neelx@suse.com>
 <20260602024849.GE2295@sol>
In-Reply-To: <20260602024849.GE2295@sol>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 1 Sep 2026 14:33:18 +0200
X-Gm-Features: AcwNN1X9FeJn91s56e1qLRSgSxckd0pjW883fuhQnYtX531oivm_yi3cZJJZjtc
Message-ID: <CAPjX3FeiYo3XZUuO5qpNaOavwxsVuM_qgs=zRNuNe=bh_cGerQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/43] blk-crypto: add a process bio callback
To: Eric Biggers <ebiggers@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 04:50, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, May 13, 2026 at 10:52:39AM +0200, Daniel Vacek wrote:
> >  /*
> >   * Supported types of keys.  Must be bitflags due to their use in
> >   * blk_crypto_profile::key_types_supported.
> > @@ -77,12 +85,14 @@ enum blk_crypto_key_type {
> >   *   filesystem block size or the disk sector size.
> >   * @dun_bytes: the maximum number of bytes of DUN used when using this key
> >   * @key_type: the type of this key -- either raw or hardware-wrapped
> > + * @proces_bio: optional callback to process encrypted bios.
> >   */
> >  struct blk_crypto_config {
> >       enum blk_crypto_mode_num crypto_mode;
> >       unsigned int data_unit_size;
> >       unsigned int dun_bytes;
> >       enum blk_crypto_key_type key_type;
> > +     blk_crypto_process_bio_t process_bio;
> >  };
>
> This new field needs to be initialized in
> fscrypt_select_encryption_impl().  Otherwise it breaks native inline
> encryption for ext4 and f2fs.

Ouch, sorry. I should do regression testing on at least one of these.

Thanks.

--nX

> - Eric
