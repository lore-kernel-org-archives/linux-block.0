Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E51CB319
	for <linux-block@vger.kernel.org>; Tue,  1 Oct 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798391; cv=none; b=pVOAtNiB7j7zqS6GAXhu3k/bm6knObWbzebW6GgqnCHwFJkMZ6F2dnV7ZQfnjvr5kiYl6D5naJI++3Lj4KTG6s4NIR1Ms+9aZoV1fAG2NjDPzgW/LS5CXHaXcEOxKznSmwCfDhkndpQUDu7otjro6HxEmFRXF/+ILz27re6SCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798391; c=relaxed/simple;
	bh=11PpSItmRGySzj00xJglCXM6oonw2tTyyfHs+bvH3b4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DabzDxpLal3JLbz/3adFkzfmT3RB5YvRjmGHb8WYbeRmWymRxlkom6TFwnJW9PJvXdljDIZowBvuiTYtPo92fwIqSWb/vH0bCGsCqQWElEZsUOhduqjZkivVRFqoSjfegEMo43EY5Cd/Skt8p/8lr8UwyxJy2AEdVnvdtX41Osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFRB5O2w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFRB5O2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727798388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt9oSZjvdyhRuHwvrHhqU4iZrMh4nx/ABAlEg/T7YoM=;
	b=ZFRB5O2wMUYwJJcSlT+WvwvbLdCPoJgjyby2x+7X65B0qnVNH8jQ3jRlkU5o1ebonoh1cc
	XRbLBzF3KlwRkNfhzY8tjJsW7QJLeA7BQn9r1Y/bo9cArc1W1e8e2AktdFUc9EYqk5Y7mW
	dJZjdoG2lbimBJRa32oCxGRIT3QBllk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-QeydaRDiPny48c0ZzMZawA-1; Tue, 01 Oct 2024 11:59:48 -0400
X-MC-Unique: QeydaRDiPny48c0ZzMZawA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa8af04feso582599839f.1
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2024 08:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798387; x=1728403187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pt9oSZjvdyhRuHwvrHhqU4iZrMh4nx/ABAlEg/T7YoM=;
        b=SMjCc+PbDwKPbYltyO1jAp12N1Z9ij+ZJ+dua4a/1IavkGxJezemyHIYkhmBh50mRb
         xLb9EncEhfswEqgnKWHdmNsc2khR2GEHgHX8xd6vnsFrsjjlAA5+DMdQxAuAbn1H5sTQ
         kUVcBdUOh4eJ2akycJxYIUQAJ8cBkwNh/AsMCKAJMpJcrbnUUghJX7FAaf8U2o7SGylg
         qlB5bu7nBfGFTIA8SmnVBYPFGG6kwNaotXkkGHI5mqUdlsuQX7Pey+oBmx8Re64oegCX
         VBb26pZW8HjjQfyNC2mc50kGHWM79YoufU59j/soRL5IHc+4Su9ECN/ksvwI9e7bCZf2
         ZPTA==
X-Forwarded-Encrypted: i=1; AJvYcCWaFxwDxJRORvwDt/mjkB5rZe83bCOueiGoAsxz8cOVAkfceFIDRR2yXNRE4Ab51rTox4zf742zlwqPbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWgCE+ovpJb2UgzyiK8pDRUUPgPpz/WPD06eXAvL8IsniqSjcm
	HvdoUityEIERjChvkFSobG+vvhOdtf7jEFKXoc4q0xUdkRzi9EZ6lTaaSBeNurziNBBxrKF6eSJ
	E5thZ8goEYdCK25A91zrSmKexAafdS/xFkkPui3rU+TdpViYyJ50YewP5eLwtqZ7F5wY4Wm7GQ5
	uOzQYmXSINkePeU9NYHDFtqtMSiCne0WJ0Jn0=
X-Received: by 2002:a05:6e02:152a:b0:3a0:8c68:7705 with SMTP id e9e14a558f8ab-3a3451bc28cmr149151795ab.21.1727798386987;
        Tue, 01 Oct 2024 08:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6zi7QQok5nJey8sLlkc3K21xS/RR0PDZXUOpDiWCzSuNPV1QxvuJCOwNSARtr7Nq0bHmyFNzQFCLV5U6pIt0=
X-Received: by 2002:a05:6e02:152a:b0:3a0:8c68:7705 with SMTP id
 e9e14a558f8ab-3a3451bc28cmr149151565ab.21.1727798386637; Tue, 01 Oct 2024
 08:59:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001140245.306087-1-nilay@linux.ibm.com>
In-Reply-To: <20241001140245.306087-1-nilay@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 1 Oct 2024 23:59:34 +0800
Message-ID: <CAHj4cs9Avm=CGfnJrwB5LJvXiW9-soozMhjYhWFAmdUPe_OyKQ@mail.gmail.com>
Subject: Re: [PATCH] mm, slab: fix use of SLAB_SUPPORTS_SYSFS in kmem_cache_release()
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org, vbabka@suse.cz, 
	akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, 
	42.hyeyoo@gmail.com, shinichiro.kawasaki@wdc.com, axboe@kernel.dk, 
	gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 10:03=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
> The fix implemented in commit 4ec10268ed98 ("mm, slab: unlink slabinfo,
> sysfs and debugfs immediately") caused a subtle side effect due to which
> while destroying the kmem cache, the code path would never get into
> sysfs_slab_release() function even though SLAB_SUPPORTS_SYSFS is defined
> and slab state is FULL. Due to this side effect, we would never release
> kobject defined for kmem cache and leak the associated memory.
>
> The issue here's with the use of __is_defined() macro in kmem_cache_
> release(). The __is_defined() macro expands to __take_second_arg(
> arg1_or_junk 1, 0). If "arg1_or_junk" is defined to 1 then it expands to
> __take_second_arg(0, 1, 0) and returns 1. If "arg1_or_junk" is NOT define=
d
> to any value then it expands to __take_second_arg(... 1, 0) and returns 0=
.
>
> In this particular issue, SLAB_SUPPORTS_SYSFS is defined without any
> associated value and that causes __is_defined(SLAB_SUPPORTS_SYSFS) to
> always evaluate to 0 and hence it would never invoke sysfs_slab_release()=
.
>
> This patch helps fix this issue by defining SLAB_SUPPORTS_SYSFS to 1.
>
> Fixes: 4ec10268ed98 ("mm, slab: unlink slabinfo, sysfs and debugfs immedi=
ately")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs9YCCcfmdxN43-9H3HnTYQsRtTYw1Kz=
q-L468GfLKAENA@mail.gmail.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

Tested-by: Yi Zhang <yi.zhang@redhat.com>

> ---
>  mm/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index f22fb760b286..3e0a08ea4c42 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -310,7 +310,7 @@ struct kmem_cache {
>  };
>
>  #if defined(CONFIG_SYSFS) && !defined(CONFIG_SLUB_TINY)
> -#define SLAB_SUPPORTS_SYSFS
> +#define SLAB_SUPPORTS_SYSFS 1
>  void sysfs_slab_unlink(struct kmem_cache *s);
>  void sysfs_slab_release(struct kmem_cache *s);
>  #else
> --
> 2.45.2
>


--=20
Best Regards,
  Yi Zhang

