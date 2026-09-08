Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9D2F7F15
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886062; cv=pass; b=MBxFpjPuG5vUJC2lF18kw0mkJhJ8c3VaKwuo+S4VgzUtcKMH5Wj3tTh5ci6H4PUhVh7uFM+DBJlhMG7ZU+sVphcWcX0EhPB9aJx/iyNvE9tt+jjw1dPTxwloobHlSNyCL5IygT/jLCnunpD+baASoQEmRO4rNuQ240Hq4CJFlOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886062; c=relaxed/simple;
	bh=mwAxvZMzHRoyoS5SlFNnDSEx6Xh8O3uTGsYLqZ4P580=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRa2MgvbQt62rpRLM3LuKPmNpB0UP60e4X2OaoeBgCUeVbCOPX+CDVGmJXUeTLDp+/GQbWPBu/UImKDckDLeeRHUSg9iDEx054lu1r2zf0uDTJCC2OkJgyubwCbB62M2VGiKXu12Q7clT+e1/9MmjyzmWUcPuewK9iXvzZopN0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZeWDij5q; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZeWDij5q"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso39974385e9.0
        for <linux-block@vger.kernel.org>; Tue, 08 Sep 2026 09:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788886058; cv=none;
        d=google.com; s=arc-20260327;
        b=IxvDjTxJGpQ6Ro4hboR2JC2suNkz6Lv3YeCzGighmXHTJqbmvEqUdMAkax6y5nFvE/
         rVbI/jDH2+1+yskDuZ5pxJZMq9+MYyG7dEPMZURWGiH+6AcjcUpe6OXTM8PwT2ZpLd4R
         cauN02ZhTnuT0X6M9xfLMLw6WBx22G8q+2idF+dy31exWejaGtIkHP1uk0KEkZXqJRQb
         hni3E8PBfgmOUFxQIJvSFCkc4ymiK3voGZdVhZHxvBbnyXZ12jo9yapC0cn+SQW5vnhE
         zKIXCpGRcCo9eqwxmX+yt3kfVodFdulvGPTnmUYe+b0iMjmUVHLZkrspMmGURhwVdlrk
         vF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lQTr2U76uYl3nor0tns8i6gi/m+LsiVvyKvG51LqGmw=;
        fh=uHhzK3NsOzQbLW4E02Qrkr2Y4qUfko+dJ1caLDh/4hQ=;
        b=J3o0Z6yzOexjMU+FJzUuQaHQvcG3BhOZ2s6JTBeYUFFQTS0EwA7SRftpZHnAk64RQf
         y6MjzyCvc/FLcYqxmLrbfb5im9e/pyNTnAY6WCDe83NMUvcKLpoh2wEx41wZ7hPrEwyC
         ojDDxy1UY6wg6E7UhPMxXzKCWQAxm4kKikVJ4wLyft9Y/VC13Bip2EveGPgpcvae1hVL
         Hz7AnC+dvwpMsmhVBwlxgwgq64WqjQ5HkdjDQ+u196S3TBX87eVFZM/vulaYdsxUSd6o
         FBayPs2/PSTg6yRfMxg0mOtjcuM31YJHEtwWkUMUZ3wjdBvSF8L201Eoh5GLroQI4XjP
         nTQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1788886058; x=1789490858; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lQTr2U76uYl3nor0tns8i6gi/m+LsiVvyKvG51LqGmw=;
        b=ZeWDij5qCX58pjNIOWqP5T0WwTbCTYmg9/C3jusLKLwjD09DWYEnX0tdae7ZguME6H
         lhfsqRR1a1twNwVjmiRA+E0Z25HLxcD1pvX4jHJ31YZQGRC/53qQgUw+lJo4NKHkLrRl
         425BHkFkIpOduF245QPbwxdQXdoQCVsk2ydZWdL7imUQtEWxlBpTYbCjPYw5HoDIPFwR
         ZN8SdF1WQAaYoiNp1EhGISVBI/RZ/M1e08APN4/r16Oo98wmnJsQKDSWMv72NL/0O7s2
         HmqaXM808bFk/ir0x0a7IPVbtg5GVCAvwUnHyidWwkWCBDD35wxITvIYgKUSz0wVWUgw
         DuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886058; x=1789490858;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lQTr2U76uYl3nor0tns8i6gi/m+LsiVvyKvG51LqGmw=;
        b=mA5RS+/JuU6YaEqnBO+6651NVzyML/uKVgm/PuP9EwIelRxCKzTx3b8ajObh209qf7
         xZgCy0Y+p0c8pHI6Yfx5uhRc5X3IAD0hRdaEABW+zfFP70PgwGpwnxpi1v1yPP+wbvTJ
         xQNCouJ5eYPuodNJxz+SF2z2zuvhL9cC/t+M4uuVIl5WCvuHPMISx/YKPndIXQXYa8mB
         7e90bKWNzyTXgmADRI2roMr7TPfCsv+kyHdX1JIe7Ym46VUvFgBZmpgyjILolmw/gk+j
         hMBhVDf0GBkT/bNxPrw+6Xi42545WHm1hW2WVnG0JfetDxAR302JsHqwZm7GRMad2mTQ
         UXEg==
X-Forwarded-Encrypted: i=1; AKwUvBwMWaLteNS0qSlrp8jLEJfvEqudcvdz0N5ftNq+NDh88SKFivsWxbh+HH1cKp7O3W9O7PwM84LMB9Sftw==@vger.kernel.org
X-Gm-Message-State: AFuF++kmBZV+Y76e1TJPayfbRCVOPt7ijWu6pwXx9Yu1DwWORHSxjE+o
	7oAIhqhJirUSQHOXSPwAbxikpbFNoB+N9yEVzdoqU6fR0EicY4mJGSSq51pwfxd1rVVW8n5TIF2
	c5glPo8OtlMLfhKvrWyvHihJLwRcRVHYQ/c4k/ARUtA==
X-Gm-Gg: AYBFou3kOzCkUZ3zkXhKn7D9O75XvL2b+xMrJMOKPopz0D3ZtPEB4p3TkALuui+pyO5
	PKKeWm+1sNURX+51hPRp8OYbBqTVPJdCGX1khxgC3mQLqlcqbr12Xr7fKRUcwmv5/UHgmrZYeMY
	QTOn959zbm5/+9dbiQVFQZ+knz/VBpZv3PzWy30eXzE7bmEDti/lBWZUg3LFlPj2kFS/24u2jGw
	GbqApRHa/7m83/SNPEbG3h/cLgd8FiCz9JFeFfKgFwZhSHYfO43i4zPCCLKNviwwk20IezvWB/X
	6rFuCoPkcO/3lUrGUZy1vLU5XR3vhMytUR0tIAYkAui2j6Uh/BROFg490z6QIykyDuhCRafKhpp
	lKsEC2IlLnimKnMcbL4kqUBPGubDahWyhdIpsO+JsMg==
X-Received: by 2002:a05:600c:138e:b0:49d:daa:af6e with SMTP id
 5b1f17b1804b1-49d1c7b732amr46339715e9.16.1788886058021; Tue, 08 Sep 2026
 09:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-10-neelx@suse.com>
 <20260602025436.GF2295@sol>
In-Reply-To: <20260602025436.GF2295@sol>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 8 Sep 2026 18:47:27 +0200
X-Gm-Features: AcwNN1WHoSNszmavv4wORasY461K9gsH-mc9zR1O6zdN1S5pOlfHSeHNoKmuOnY
Message-ID: <CAPjX3Fd-YEgnzhMryAJi44tZNs_YsHRAAwsxaKbO_jpgvp=qQg@mail.gmail.com>
Subject: Re: [PATCH v7 09/43] btrfs: add infrastructure for safe em freeing
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>, 
	linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 04:56, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, May 13, 2026 at 10:52:43AM +0200, Daniel Vacek wrote:
> > +/*
> > + * Drop a ref for the extent map in the given tree.
> > + *
> > + * @tree:    tree that the em is a part of.
> > + * @em:              the em to drop the reference to.
> > + *
> > + * Drop the reference count on @em by one, if the reference count hits 0 and
> > + * there is an object on the em that can't be safely freed in the current
> > + * context (if we are holding the extent_map_tree->lock for example), then add
> > + * it to the freed_extents list on the extent_map_tree for later processing.
> > + *
> > + * This must be followed by a btrfs_free_pending_extent_maps() to clear
> > + * the pending frees.
> > + */
> > +void btrfs_free_extent_map_safe(struct extent_map_tree *tree,
> > +                             struct extent_map *em)
>
> The "unsafe" btrfs_free_extent_map() still exists.  Assuming both
> variants will continue to be needed, shouldn't the comment above the
> "unsafe" variant be updated to document the preconditions for using it?

Actually this could be cleaned up and unified into a single function
with optional argument.

> > diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> > index 6f685f3c9327..a962012be1c3 100644
> > --- a/fs/btrfs/extent_map.h
> > +++ b/fs/btrfs/extent_map.h
> > @@ -97,11 +97,18 @@ struct extent_map {
> >       u32 flags;
> >       refcount_t refs;
> >       struct list_head list;
> > +     struct list_head free_list;
> > +};
>
> The comment above this struct says "Keep this structure as compact as
> possible, as we can have really large amounts of allocated extent maps
> at any time."  Is there any way to avoid adding a whole list_head?

Good catch. In fact we can reuse the old list member. No need for a new one.

--nX

> - Eric
