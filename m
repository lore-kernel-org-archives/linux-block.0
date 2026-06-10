Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC5408636
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097574; cv=pass; b=CZF6b0Rav8XxiGZn0YwnUsCafEtE88NhxST6mDIeic7LfuEnq1zz9m9m7HfFcTeqVgrtyD9ZQ8c6CiEvQIWhr6GfnuX6+8N1Q7VV3lBucXEPAHOq8aPbtME44XFpxQUDRY9+tJYnKkjpiPo4OyJjJg97cKDOX2f1b1VnDi4Y7SQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097574; c=relaxed/simple;
	bh=lGRQFI3Hp/wayJqw+xf0lgQEfSFmDvi6/ZWTJl9pGSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVw1AyU5VFLE9uGb9jBQU+Y82TlRgKr2FgW1fmGEJJisw4sB/Tanc2ImZNkCRrEfJDmjMMSkdxHLeyRz0O56O7PoHUO1in6GkJoCH8Z6UspTkL/IZYI8pXhUawvCY7zJqzSTSB9XN42glpMp4WRS+BKe8a7ci6QXLJ0vABnw40U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EWsQI+1P; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EWsQI+1P"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so5112739f8f.2
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 06:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781097570; cv=none;
        d=google.com; s=arc-20240605;
        b=bRDzURQSYOAGLOk76swqb0L0G4jddSxcKuVAdW1t8HRjZdrGpcIk3ov2Y2TBjp+8h9
         tcC6D8R8crEDc0EdAx85dEGhhXcXiEvxflbj8IT8JM44CMgRQnDC/ByxRWx3eZuoj1Gc
         rSKquLAs6mQXvgm8pjEXMb7VjbfkIPTV6CjwWe8NJ5/B9gdN+DNYRFiUI3R9qmMKb6Hl
         lsCxfDSbkfCywPBrQ+N4qTUPhNgJGm3pbqBLG3vrj46ypCplKU/tqJQp21hrIpJmv3YG
         sKIcRuu8AjaGhwfQhA01rf8DL9KHMtK+joJfA40xEM0Lnvtr1wGMqqTs3oCM5ujcHFXZ
         9KMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZiiuXZsTISkwh6lAvtwah1aW4/G3cB8JXIp3JxzVYw8=;
        fh=OtbTAWRxQEaxCjZ5fVK0YHSz9WtlI43SDaoe+NT9e5w=;
        b=B+ti6feaw4+528YdWD1xyTMT8rqaYhJsPjEZTkm5R5MN73Bhbn3RCOGOFDNjCSNX5k
         y93CFzgQQCOKlm8r16eow4vxOKrodbliUtlUL7FJ8mb5QVGHae65JxXzD8/oo5iXjo3W
         hUDStGPt482cJgFg7qBskhFFbB8LWSXFVc6V5VXl1Aogr6h5p1gMtrsVeiFeIoKEvKu/
         JRRaJG6DLRzJGmETTsFpLGQe3vdp6odbXt23dNdz9C1TA2oPiKI1RWmnkejxx2tPMddG
         jNGE1/Fu6gKhXdy/kIeZYSfHKTjyH0F32yEXhVeYP5OHMeyTHjCLvUTLHKHYBKPYv0GE
         z7vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781097570; x=1781702370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiiuXZsTISkwh6lAvtwah1aW4/G3cB8JXIp3JxzVYw8=;
        b=EWsQI+1PHRt5cJmsyJ3ajj9Tth53M2IR+9GHVPtZW6HR6bWyc4weZjTdyEOmMIW7ef
         IqM3ByglwjqeWAfLJ9MUU91AauLIXZZ2q3t2EhYg47KYAfonhd4cjXBKDslAJughRWdW
         BQkfHCAxvNYKeRDj/fzsv/rifdgfKIxv38JyS8cXlY92rzg+iUklQAjCBefVTgIMlE6H
         chRUlexFVEeKdMwisLFkrif8PF4rz3IhkKKIrKaxzNfwVhEY5KOrm+rq4XS3imqM6jU3
         +o0aqlpPDapAzO7B3JjrgEW3zZ199s0lLtvrtOni71ediE1rjMOI2kgpIwk6+OPJV06H
         ey+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097570; x=1781702370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiiuXZsTISkwh6lAvtwah1aW4/G3cB8JXIp3JxzVYw8=;
        b=HRoiOsA2cfmRiibpDU1KPS4dHgSZ3synQEj8gVYJnqGnD2rMpZ1SY6Jt66okf0jG5t
         qTQOJIvPMfC2DyJNahfmCH6KIRasXoMjwRHtM1Qq22nnMmX3ftdQlxKdPEY9zF1XVejU
         FbJ8rd7knjbRStrHA5HzWTo8+dKQjgpEmREzoJKTN7PHB+P7sZ1BSNw5hArzq3WxCwx/
         aKdFFyO64Slz07WOn34AQRYKUea2hzJUL7GjjZ5nFZNqLgFASnDIBZUigwks4hLG16cy
         RFuG9zIYpDM0zawzZ90ba+qQdwACBn0aNz73u4+vp76DUMHIru08NU6TDv6r26NQV4Pa
         BTEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5cZlF6YtAQyT/oya++pwA3TKipuFBYeauQfyxKNY5ZdyWmk1xW7qHY4ZvOcqlqnV61FGPolJJHdEmiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzeCyblLxzUHxwoh6dvdygeLaiiik7aMmxQyc39eWKt4WeJXN+
	TdBlMOSSfp0mRDz6ucQtX4tCuH4lFVAtVFAay9GTIb36v2TQxH5lkjpla5H//JMwSOrLHzi2s9D
	fy3BfIsCVL216sf1V14lbe/q9WuC15TOclQzDVWyk6g==
X-Gm-Gg: Acq92OGxBTGzXThiYib0Fi7hS34sg+ZX1H8TqPMEto2Zp9+/T8aKUuuon//bs8a/Lgr
	UqaQ4n2i2gt2tJObGv3AqIOp70QeRohjlnlmGlFMIgH0NA5BLHo672ANlTJpohsuw/XSNAlAbiw
	Zvg9TtB5AEkx9pxbbgTar/tJBUVhanHeui76nDsWaiImXipRXqnTrebwGTY9l9BYicJiTsgTzGR
	mirJPk4Dhbngf19xlKMTJhYeo0ei4ODWci7XgCkQFDnAzoIdvDMPzEODymukkLJvQfsTEmFxPQH
	ESdBCN4E5P4b/A7dcCdDRbmrgvKoyI9hjH4K+pHRjRZhTC9SfZqYoGH8ksxpzlqGhrU0BSwfee8
	LPQygAuiUeZDIcSY=
X-Received: by 2002:a5d:4285:0:b0:43f:e721:76b8 with SMTP id
 ffacd0b85a97d-46030624015mr27894543f8f.37.1781097569748; Wed, 10 Jun 2026
 06:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <CAPjX3FdHJpZUVk2dfA+Ov5K6vOSsOJMUaxCU4G8y1qg6baMXYw@mail.gmail.com>
 <20260531002812.GA2302@sol>
In-Reply-To: <20260531002812.GA2302@sol>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 10 Jun 2026 15:19:18 +0200
X-Gm-Features: AVVi8Cc3kwl9fZ56YD-UdBCxPsiFupB3WEKTLBFSqqAW2W86Bzv6x7-7G0urFU0
Message-ID: <CAPjX3FcWv4Pv_dc+ArUYdpr+KZh=57q8XFaqrF0=CX+59bDaPA@mail.gmail.com>
Subject: Re: [PATCH v7 00/43] btrfs: add fscrypt support
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 31 May 2026 at 02:29, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, May 22, 2026 at 09:00:46AM +0200, Daniel Vacek wrote:
> > Hi Eric,
> >
> > This is just a gentle ping.
> > I was wondering if you had a chance to look at this version?
> > I believe all your previous feedback has been addressed and this
> > version is solid.
> > Please, let me know your thoughts.
> >
> > Regards,
> > Daniel
>
> It's been really hard to find time to review this huge patchset.  I've
> started going through it and will try to leave comments next week.

Hi Eric,

First, thank you for looking into this.

> In the mean time it would be really helpful if you went through the
> Sashiko reviews
> (https://sashiko.dev/#/patchset/20260513085340.3673127-1-neelx%40suse.com)
> and address the ones that make sense to.  It found 93 issues including
> 16 critical ones, which is kind of a lot.  Some of them are the same
> things I'm noticing already.  Same for the issue that Christoph noticed
> where new devices can be added; Sashiko had already found that too.
>
> If I'm going to have to use my limited human review time to point out
> issues that were already found, that's not a great use of time.

I already went through some of the Sashiko reviews (they were slowly
coming up one by one) before leaving for my vacation. And I found them
mostly confusing or misleading. I'm gonna have a look into the rest I
haven't seen yet to see if there are any useful points. And I'll
compare it to your notes to see if it was Sashiko being confused or if
it was me.

> I also don't see any information about how this was tested (and will
> continue to be tested in the future).

I'm using the `encrypt` group of xfstests as the acceptance criteria
and the full test run to ensure no regressions.

General support for btrfs had to be added. And since we only support
the v2 fscrypt policy, some tests had to be split into two tests - one
testing v1 and the other testing v2 policy.
There are also additional new btrfs specific tests (reflinks,
snapshots). xfstests also need fscrypt support in btrfs-progs with
related changes to export nonces and other metadata like device
offsets of encrypted blocks for validation.

I'll send the fscrypt updated btrfs-progs and xfstests next. I just
need to clean them up a bit first. I'm sorry about the delay, but I
only managed to post the kernel part before my vacation. I was hoping
it would give you all more time to review.

Thanks,
Daniel

> - Eric
