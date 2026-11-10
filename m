Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280345;
	b=rWp0uFXD/ArugFLTSfWQMzl6F4Y34UzmJWgHA3nejwXfqpzj+2+tCIlMDRh/hnk2GKbN
	 DIyg0WoDaz3UT5qZcssM+HDOtSWscClwlZ4Zw6UrJOzVfb6amIarFPbeU9xT+a8uevQJb
	 MUFHSKPL812rDiolfd9ed7VqHCq46Id90R9BoL0YCHryHnekTHeKzr0Vkx1ziaf/LIuvQ
	 sFDimSey+/sxz07AcbLLItZHiQ/9pZzy9lAuYhC93GqTE6v1AZ12xAQ5ql8GYckmIijXR
	 vZI2sl2du667gdvjDXUQvJn2xtfpCYyMJ3Mb/q8awgXlRRIEgqArJyNlIyeTo9Co0qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NFGbItuCJXnws5VmBkLsQYAO9inTwJbRMBsOInhSTps=;
	b=hPtEIWFFqlXRTmYZmmCHPB+XPLuIjFvoXJPXWVpERcKMIzbLY4IqGBksJjUK/Q1K/vxi
	 s/kidbKzETOBdunGB62outK615gPcQ+leVjjS0/xPfuplzvgWxw4Gk8FlChWPQgwvyGpc
	 Jr9+raaS24clF4rRZDB1sa637t6grIuIrbPRRPoAgBms6ksl9Ql7zEcWdcHDue9/6+uwg
	 dZReC4joq98oecpQb8uAkJb6ycqRM59TowuaNCl3ZJ7Q2WEwy4r9FxofG+iO8ZYnITJWA
	 /m44n2iNuAnoQ/bJA9u8w/VZ+BnY952olTa55uQroXzkk6t0MTLER23clieY8GXkrOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Wx1ShSoX;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC863606A31C
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 03:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC863606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Wx1ShSoX
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8b6b22be970so566501b3a.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 19:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794280344; x=1794885144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NFGbItuCJXnws5VmBkLsQYAO9inTwJbRMBsOInhSTps=;
        b=Wx1ShSoXMAULpOOweXrdNkTnioNB1UaRLWhDjgHh5/OMjYq5jR/knMAZqJsg8NC+T+
         8hk3hYeCsTUgBudpyDMSnwvlyL4KoVvUoRti40/dKvmzmIl0WV2d4GFsRtt5XsFLbZCF
         7nXhS1EDYuqRxEZ46FFkYkMqkdH+7wTd2lt88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794280344; x=1794885144;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NFGbItuCJXnws5VmBkLsQYAO9inTwJbRMBsOInhSTps=;
        b=EO56wcIHjwLD1pZ0A1wEu8kjAdL6O/f8//am8V88WbX2vtecDGASbFH8tzu5jVFIxz
         VPOY1H9fxapA5CkFyQLBx0nF66iRKy0KAF57BqR0eftc5gmHtyWsaYbWubyKnx3M3x4K
         fpFWOclKYmK+RA0dzTPM4UOgszaqAc/FuI7Yp08hOt8GF1f8KjsdopvirpvxWIEUJb5Q
         Mc7MsSU7aBh2lfCv5caiqTGsa1Swh85EFTRazBAnXay6TchUkh+e7T7GklBOk4qyYObq
         6c2VwgjzEl+hKIZZ+XWNdvTNa5Dx+AKcJirpxa845tZR6dKxzs6DYKBwqZ4nOQY+RWYu
         Ry6g==
X-Forwarded-Encrypted: i=1; AL+hErEf2oe9yzsdXGt9K4bu9urrqFYvfYBd6X6oXleXToH8GNFX72esW1NCtrpjM6r0s0g8/9J+L4cOH3iLcg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+dYbvs4abxnWURY94xlfOQ8Gr4WG/b+mOsAHbGCIQ7xX7ndP4H
	MpkUnK3gEvD8yW8vYX7BE+32oSHwJBf+Z1ZLUShXfihxkBB/GyB4FUFE80FbSnRdaQ==
X-Gm-Gg: AYBFou2FIvf7yAhC/zQkNU2NcCvTGR/Td/Ue0e5x7wzhOXsu+Rp1XTODxVXV/V5tao4
	mUEM9IsUGp8w2mjYNRg9EN6WceIokc5RgE7mDBR2Io1NIJ6r3CnHhbhKDIAERGbY+9CqVSwEMDP
	f71Hxf83mOt9rp0T3TxEyiO0msVNbYVmkXLkBqMCILW7WfqA+ucF9EIpb93Pnhjydkt8xY6vi66
	HMTnokkUgtw3NLymqo0X684l82Xv2Hd9A09zt3Uo2Xw80HWJlPP1utOc27RXi/KWc4CUimTo1xG
	Uve+XrQ9B7iuQ+d7i46HrOD7vAQW4gZcL+3ukUdjoLcNriCsZuN75eybQEJ9VNEpPHIif2AfZ2m
	DSqAur4Opyuteqao6cWAFIundKPyHE0RPtJNKHN0PKQ26sZ1P1Zz5Gqk1PrqE+ZTIlw+qib/7UD
	z5rfnMQ0VSGttcVutK1wFyDZZ25DVHj1nprBlEAjJT1MUAo2GkYqhxh1Q8wkd6+fL3rRofAE1Ee
	wNnGiWWHTaSZBilFXu/WPkQ4ZRBKEvNERjKxTvNc2rQV+fV4ftTyWBGwHjX3bvfGcg7ljL5mJ4U
	GhUKoZAAM8lCQKI0shd7bYbLwSlES+CrRiHGBW8J/fpts/2PHddwEDQMi/RKtZrQdW4jOw==
X-Received: by 2002:a05:6a20:3d1a:b0:3e2:e27:1d36 with SMTP id adf61e73a8af0-3f190b8c38cmr1165365637.59.1794280344125;
        Mon, 09 Nov 2026 19:12:24 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d7b6236sm301072a12.23.2026.11.09.19.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 19:12:23 -0800 (PST)
Date: Tue, 10 Nov 2026 12:12:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yosry Ahmed <yosry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 5/7] zsmalloc: embed struct zs_handle into zram and zswap
 entries
Message-ID: <avKLRTmkNGU-wxmp@google.com>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
 <20261105044752.1997895-6-senozhatsky@chromium.org>
 <auy22TkX0ADxP9WR@google.com>
 <avKFc82JS4R9yU-N@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avKFc82JS4R9yU-N@google.com>

On (26/11/10 11:51), Sergey Senozhatsky wrote:
> Date: Tue, 10 Nov 2026 11:51:21 +0900
> From: Sergey Senozhatsky <senozhatsky@chromium.org>
> To: Yosry Ahmed <yosry@kernel.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,  Andrew Morton
>  <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,  Yosry Ahmed
>  <yosry.ahmed@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,  Brian
>  Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>,  Richard
>  Chang <richardycc@google.com>, linux-kernel@vger.kernel.org,
>  linux-block@vger.kernel.org,  linux-mm@kvack.org
> Subject: Re: [PATCH 5/7] zsmalloc: embed struct zs_handle into zram and
>  zswap entries
> Message-ID: <avKFc82JS4R9yU-N@google.com>
> 
> On (26/11/05 17:19), Yosry Ahmed wrote:
> [..]
> > >  Additionally, zs_malloc() does not return a dereferenceable pointer.
> > > -Instead, it returns an opaque handle (unsigned long) which encodes actual
> > > -location of the allocated object. The reason for this indirection is that
> > > +Instead, it stores the encoded location of the allocated object in the
> > > +provided ``struct zs_handle``. The reason for this indirection is that
> > 
> > Should we explicitly call out that zsmalloc will keep a back pointer to
> > the handle and update it asynchronously, so the owner shouldn't modify
> > it, and should keep it allocated until zs_free() (or rebind)?
> > 
> > Probably somewhere in the code comments too?
> 
> Yeah, perhaps.
> 
> > >  zsmalloc does not keep zspages permanently mapped since that would cause
> > >  issues on 32-bit systems where the VA region for kernel space mappings
> > >  is very small. So, using the allocated memory should be done through the
> > > diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> > > index 693c9484b638..6c76fd10344e 100644
> > > --- a/include/linux/zsmalloc.h
> > > +++ b/include/linux/zsmalloc.h
> > > @@ -14,6 +14,7 @@
> > >  #ifndef _ZS_MALLOC_H_
> > >  #define _ZS_MALLOC_H_
> > >  
> > > +#include <linux/compiler.h>
> > >  #include <linux/types.h>
> > >  
> > >  struct zs_pool_stats {
> > > @@ -21,16 +22,39 @@ struct zs_pool_stats {
> > >  	atomic_long_t pages_compacted;
> > >  };
> > >  
> > > +/*
> > > + * zsmalloc writes object location into the handle and updates it when
> > > + * the object moves (compaction, page migration), so the handle must not
> > > + * be on the stack and must not be copied.  Use zs_rebind_handle() to
> > > + * move an object to another handle.
> > > + */
> > > +struct zs_handle {
> > > +	unsigned long __private obj;
> > > +} __aligned(sizeof(unsigned long));
> > 
> > Is alignment guaranteed even if this is embedded in a packed struct? I
> > wonder if we should have an explicit alignment check in
> > zs_malloc()/zs_store(), and probably rebind too?
> 
> I guess only run-time check will work.  I can add those.  I wonder
> if we actually need to worry about this, neither zram nor zswap use
> packed entries, but I think it's cheap enough to make sure in run-time.
> 
> > > +
> > > +static inline void zs_handle_init(struct zs_handle *handle)
> > > +{
> > > +	ACCESS_PRIVATE(handle, obj) = 0;
> > > +}
> > > +
> > > +static inline bool zs_handle_is_allocated(const struct zs_handle *handle)
> > > +{
> > > +	return READ_ONCE(ACCESS_PRIVATE(handle, obj)) != 0;
> > > +}
> > 
> > Can this ever give a false negative?
> 
> That's a very good question.
> 
> > I believe that's only possible with pfn=0, I don't know if this can be the
> > case on any architecture. Should we use something like OBJ_ALLOCATED_TAG?
> 
> Yeah, I don't know, I guess would be better to not rely on "pfn cannot be
> 0".  Let me look into this.

Look what I found:

--------------------------------------------------------------------------
commit 67296874eb1cc80317bf2a8fba22b494e21eb29b
Author: Olav Haugan <ohaugan@codeaurora.org>
Date:   Fri Nov 22 09:30:41 2013 -0800

    staging: zsmalloc: Ensure handle is never 0 on success
    
    zsmalloc encodes a handle using the pfn and an object
    index. On hardware platforms with physical memory starting
    at 0x0 the pfn can be 0. This causes the encoded handle to be
    0 and is incorrectly interpreted as an allocation failure.
    
    This issue affects all current and future SoCs with physical
    memory starting at 0x0. All MSM8974 SoCs which includes
    Google Nexus 5 devices are affected.
    
    To prevent this false error we ensure that the encoded handle
    will not be 0 when allocation succeeds.
    
    Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
    Cc: stable <stable@vger.kernel.org>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


 static void *obj_location_to_handle(struct page *page, unsigned long obj_idx)
 {
        unsigned long handle;
@@ -441,17 +446,21 @@ static void *obj_location_to_handle(struct page *page, unsigned long obj_idx)
        }
 
        handle = page_to_pfn(page) << OBJ_INDEX_BITS;
-       handle |= (obj_idx & OBJ_INDEX_MASK);
+       handle |= ((obj_idx + 1) & OBJ_INDEX_MASK);
 
        return (void *)handle;
 }

 static void obj_handle_to_location(unsigned long handle, struct page **page,
                                unsigned long *obj_idx)
 {
        *page = pfn_to_page(handle >> OBJ_INDEX_BITS);
-       *obj_idx = handle & OBJ_INDEX_MASK;
+       *obj_idx = (handle & OBJ_INDEX_MASK) - 1;
 }
--------------------------------------------------------------------------

I guess I'll do the same + 1 / -1 trick.
