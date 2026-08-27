Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A5411F90
	for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822221; cv=none; b=DW9vBoiQAmIj+M+B2i/z9+w+PldhLJW04Kg6U4NJ9/ZalTMrxqUTAzsq6SnFMU0XYvmdqhnAjTi422o6e4iKpkK0SbOHlrdUuabxOiVfIhF2iL8baA6Kn1odw6aX+we7HMhGJassVrIiHAbH/Tow+9/QLrWu/vGgakga2Vv9ZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822221; c=relaxed/simple;
	bh=5VfrgZkKynHJykbnugTUAuRm/lIC9QY5cTmsrhtNC2k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cm8sVaPWU5dreb0pkJLqjcmzOHMflNYGvEQ3JH76ZNfJL49IQZ8gbWQgvYDXQ7WgWb85Ago/NnpyczP5tWs4BwZYdOTZWdRICjKdKtCvdAn2dmyPae88raqutyPz+Y79YAzY6+xrBp7S+yJlloxhUuZ8sEA7MmeYrUIqZhHyyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSk8urBN; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSk8urBN"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66c4e9769bdso2657579d50.0
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 02:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787822200; x=1788427000; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wURAAqpmYnRm70wHLRDHhfOf5KYKWGXPLGAT3tMJ/w=;
        b=fSk8urBNEAkuiCBeBo8SyIw8Z9Njl+3rvjRUdLpXZytpltL9YV+ApmncSKJhsSTULG
         awxP4kNb1tC0v/GgHEJ8NHFcrKguTgEpwcSQIDOVDuObeIeYKLKUi8XJIwexy8hpI2gK
         Kat4E4FaIkNe/iXENpa31GKKX7YlYUcZETZ6ee4B6yKAUxtYXsewyisIQt+g19oRS8JE
         TZBLa0XEmUzKL0Zf7vr86YlY1fiVpj5inj1R03NWQbH6SRB9QMoa7+/xNyLNr3ed+B72
         zraFmfINVpNZyj6K4SgVd0fTzSaucr6SvAA/OEBfxcbMchrzTSvR/4VNgW98MotRcspY
         PgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822200; x=1788427000;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/wURAAqpmYnRm70wHLRDHhfOf5KYKWGXPLGAT3tMJ/w=;
        b=icE/4DnXHXsv1XhigKH9f+qmIyd5gEDPPeBzpuHcT3G+2ZTtdWHZkIrOQRy1/0azxw
         CrxGWMd1lMteMdNkpIC5rlF0pVIW1lCM1nhF+OViVxCnBMNmb8VNxhuC4StTlr36CqLh
         RctvGtUAhwMZrHQTLiu81NCGnwDU2yhgc+fyxabY0wny8O9eJa54HM59LGVe1pTiYOSM
         yrqqGGLzjrTSIk8haow4OZcylLk3wsdSYUIf+RUbzkjhJdhEw54Tj3EAA4beg4/B2UIL
         HWrIrlBungRuuUy+GPQ4nSdrfZJI/V4lWoyHnm68rNY6Ahb5wbcyEqX6mukPdkEczAzW
         NT5w==
X-Forwarded-Encrypted: i=1; AHgh+RpyDAcNtrT8kK5FK/TmdbXGOsZG9+kH4CZM0A3jBo5aIcKTzxf7yPBHWSvh+LKSWq1p8xKXL/6R0LomgA==@vger.kernel.org
X-Gm-Message-State: AFuF++mfcQZEv2WCtwnboxwoYxLDYbunKc2jQ6uwleOQ7zsi920BiPeA
	4sdppTGIqn2jDU9/MVwUOHjKlZG3XO4g/zikeYmMq8R3vY7lEC161sa8weeWP8d9Qw==
X-Gm-Gg: AR+sD13VBLokR1itVpKZhnk1AXbKfnjHn8Hvt5UThCdlNRI7G35XJv6CVlM22JgrTwn
	jD7HYZERsFf57zKxtGxgaM/EWHzRgBVCwSWVbUO4UOAwQO+lNfg17D54KCfqO09suRbIQkxcXOd
	BS7w49+U/KNWxDpOhvy2Yt6HVSBVrr6v8fqH7dShQBgru6o37gcmPxK9BmZl5YrZluAg7W9/44g
	RpfH9KBWqbOYQqrS4AAIf4utUArPtHiYTRZcsnln3lOtfy0WOVGL1+v+rGjkBLzO73TjgK1Bacx
	gcvwwtATbFqdkhZ4fKhHzSph3EXU7cYqmP2Zv9jibj+biILuluxQkGeUIc2PK2Q0giQpIrhqYy4
	8beeBHLraNuD7vy3ct3ZJmkZCQt3BO1XGyjRakCl62Qi9Hwrzee1Eb1cxIbI6J4Ug5VCTDC1PSA
	Soll9r4l/N0GQqWiFnFXnDgsID+d/OPy9wyK7hLnFhgHeg0t89nedb7RJIkeF+1u7r3cVp6gjj+
	Z1FoKH+z/ZzMEFHfnMfWatyNV771bJfhPq5wJomMd7+6zHj
X-Received: by 2002:a05:690e:150b:b0:668:568e:8618 with SMTP id 956f58d0204a3-66d256571a7mr4352551d50.1.1787822199153;
        Thu, 27 Aug 2026 02:16:39 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24721e47sm2631290d50.13.2026.08.27.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:16:38 -0700 (PDT)
Date: Thu, 27 Aug 2026 02:16:25 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH alt 13/25] mm/fbatch: no lru_add_drain() to
 collect_longterm_unpinnable_folios()
In-Reply-To: <5d42fbfa-1cc3-4161-8ba0-7318267576a1@kernel.org>
Message-ID: <e10bc806-f995-e48d-a24e-8872f0a71689@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <fbf3fa74-c646-8855-17e4-e8b35dfd9c14@google.com> <333bb765-a36d-e07e-d3c4-5ea2f1cadfcb@google.com> <5d42fbfa-1cc3-4161-8ba0-7318267576a1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Aug 2026, David Hildenbrand (Arm) wrote:
> On 8/24/26 16:55, Hugh Dickins wrote:
> > collect_longterm_unpinnable_folios() has no use for lru_add_drain() nor
> > lru_add_drain_all(), now that the per-cpu fbatch references are gone.
> > So remove the recently added lru_cache_drain_for_folio().
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > Alternate version for use once David Hildenbrand's two commits
> > here have been pulled from mm.git into linux.git for 7.3-rc1.
> 
> For 7.4 we expect another user of the helper in KVM guest_memfd code (the
> primary reason why we introduce the helper), so depending on when this series is
> ready it will just remove that user as well, or we'll need some coordination
> between trees.

Yes, I could supply an alternate alternate version, providing an empty
stub for lru_cache_drain_for_folio(), so Ackerley's and my series can
proceed (or not) independently. Later. But at present your patch or
patches seem to be in both mm.git and Ackerley's series (17/46),
but not yet in Linus's tree.

Hugh
