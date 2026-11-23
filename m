Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426828;
	b=hlPGzuvJqzENij5iIJuUEoRtwlRcQMw7ou13dOhvLFVUjKG6IsYLqg9daWlA32+gpJo7
	 8Vd8nDBVXh8ElNlZoFjK44E33oz6YqT67muvAocprRo7fSqN7olwDO+6HUofsNhhUs12h
	 qV8VUR7gkaQUgECdgj8AwgS3pi2UyWqREIp76ARLfc+qjENqk9D7wGw1CBxaSejwISb+W
	 5ideRmyX9ZvcJydHbwW9Z4GbS2uc3FVln5eQD/MFwi1Mo9fh+TTCCZz27xiDT8mNu++CU
	 WnvgmC5ANVpdlbTWAKAyYJZWrJlmLPIfGAZbyUlthvZhtTLzTH4ZS5GTHxjcZYds+OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=thx09sK5axuy1Mqno0O+zJDzS2jXR+z5TmxbMTktwk0=;
	b=rZvNQdZTH6WZ/pnIkTQZ54zjTjVaTKhVx+1qhwP8D0SON1LI720ZXKQwN3VIWJe0xnut
	 Zo35dSB8wRJ8NJ1s8iW0HEgo3sTJcwt0IO1GofZuRFOEzVq5/GlGKGDuxdmJyAI2VXKJ3
	 Y4Dbk/dtBw9PTpujiEYiEzTGfRSh3EBRqWe7r/v5FOENuGmbBO85qsJkSM+VPS2tU38f5
	 K8apYhXw2BHIkVu6o4hjJL1JHBL4AIEi5TZTkDJR/3yDWiwZjK3O4SM5HMFPq2fsxt6yO
	 8OLSyxj46v/4F1CbJgD2rvk5FWb8PlbAPwdVnacimt48bZcc5RsKA1qjM2QRMopCY7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="piDKX/x+";
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48189606A327
	for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 09:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48189606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=piDKX/x+
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c6a0abc2eso3093744d50.0
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 01:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795426827; x=1796031627; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thx09sK5axuy1Mqno0O+zJDzS2jXR+z5TmxbMTktwk0=;
        b=piDKX/x+zSivG1JjCcMp0ylCzOK+uPgZfR8gWTDeVcnNbIjSW62b/6eBaPu+cMWWqt
         gZVrswxtbdBy9IVRKyGYvemM5nO7zzKrmbzjA9JouMA1+M0NsPR+0XbUbi5dRiBqU2Si
         hlt7jGC3ecvkfqTYPMEwNrHg9CUkTwgyjT2w/dbrDhsw9uzRYFaQ0tvFlOLMvULjofzH
         DWM5Fefly3gSdV+nraMLUYri7Yp/iCBXjiLvL40fOJs1qIvY05MSya4nAKjcGzSBDd/T
         QSG7C5S9MfDpIDJy1XVCxaUnN4bh3JOqlZuJ1582NshQshH+AFkpy86jJG6nrOGKyaWL
         6z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426827; x=1796031627;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=thx09sK5axuy1Mqno0O+zJDzS2jXR+z5TmxbMTktwk0=;
        b=BS3VMduiNAJRR+MmQRR/FlXjaR5HjlFYh7cag9bZzl2JF3jzLtBE+a4yJe5P0DYDzO
         dwX5dY0zr59Tmw5Qd3AJ5ggW76mYQ0hXj2UlSmTaFPQTy26nfYMfLx+8G3JUumNnjFkU
         659CMx2xkhVheIuaB7wOYkRZnXFTitNIIma/r3b/qMNsaxLKvsDUyP1LxvKNTgAaMI+x
         4v3i+ZWLUDDHP/4TnhHnuXYB5LXTbUFoKWs6+Jd8DTKaj080JpFio72AXZmx/fTRX/7M
         yKI5GlXhHHHjFaJtM4mPTmMGRdi6ZPI/BfgT7SMwznJvZM91vABx6iPxT62cMBSmSKPH
         XPIw==
X-Forwarded-Encrypted: i=1; AL+hErHp6gKH3rCne9EunhqKKZhKklOuuIhL8bGZfJkjeZS5HPBiZgsbU5TVHNg5u3BAutMhhdx4CqttVPRvig==@vger.kernel.org
X-Gm-Message-State: APuU4Z+qtoPIutR0rDHDMHydH1yz09OaNuRm3uW3n4Azx3dZehIUIn6Z
	5WyyZghPNTebISfAl5SO1bIus1Rp6ELmSeiOTiYlkMmLjqB7yp+T2r/2ZgsY4Pfn8Q==
X-Gm-Gg: AZFdTZdrWTXUtppikbPZtA6ueW32/jfgi6ran0k/+luQZEfB9ehMes+OtqesQx0e6GN
	soQSM1M9Plka40ELWEsTesvVOe+/ayw+V6sZbhSZLElsDz17sm9xfA75+JfzT/exIrO7vxbAH/C
	T4D+14tZ2AvQU45OvCBMdS/xZ4bw4ch1reY7xAByyGNokdZkhX0JOyud5hQL3HfaagVyPBmZQg1
	40DGKWs0DGD/r1yoH0jloD1XHgGrZiDUyT+R7va4mGlHnLinmUtT62Ymoy2S4xogtJiuk5qcINh
	tEnaXfipwg5Sn/3hzKDsMZZv3tu+rIwzrucLggOBFTLn7UAWYTYnpSC+LY14b9dCUKkW8/7Tlro
	ni9sHHREP0W3KwvtxFrFwTI+hLAvYiHeaSmsOccoupCF1myg25xyejuPXP3T261ojluEeSI8vvC
	wnMp2Fm9Qd6+28X6yITexntR72uoQIe2CUVOCMOTz3W3aBDYPid5WTRh6rA9s8nTDkb9c+Y1hOw
	tJ154zMxg2RfKOga/MsGBApHI4hT0BUWVKcxL+MkMeXRhew0MH20CsgqjFA8z6CJbLSTxk9AlUp
	4bMn7GQFaUkj8Oc0ZUdaUUQJFsyE4LhcXcZpUzJl5WL5IcAWhjwwzwh61Tpwtk963LXUaU3yvkG
	kFtVgIZliXG3OwbBPS2haI9U1
X-Received: by 2002:a05:690e:bc2:b0:67c:70cf:c90e with SMTP id 956f58d0204a3-67df443b020mr3503639d50.39.1795426826585;
        Mon, 23 Nov 2026 01:40:26 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33105fesm5150875d50.7.2026.11.23.01.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:40:25 -0800 (PST)
Date: Mon, 23 Nov 2026 01:40:09 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Alen Karnil <alen.karnil@ideasonboard.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
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
Subject: Re: [PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()
In-Reply-To: <179492383658.1554713.9260140415931487684.b4-review@b4>
Message-ID: <db50635f-5f02-73a2-83b3-8ec7dc980b56@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com> <179492383658.1554713.9260140415931487684.b4-review@b4>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Nov 2026, Alen Karnil wrote:
> On Wed, 09 Sep 2026 02:39:08 -0700, Hugh Dickins <hughd@google.com> wrote:
> > mm/fbatch: drain lru_add_drain() and _all()
> > 
> > [PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()
> > 
> > This series was prompted by lru_add_drain_all() appearing in watchdog
> > backtraces: not to blame, but blocked on an unresponsive CPU to run
> > its workqueue. lru_add_drain_all() is a heavyweight operation, which
> > we often hope to avoid by a much lighter lru_add_drain(); but even
> > those local drains can aggravate the lruvec lock contention which
> > per-cpu fbatches are intended to ease.
> > 
> > [...]
> 
> Tested-by: Alen Karnil <alen.karnil@ideasonboard.com>

Thank you, Alen, that's very encouraging and helpful - though I think
it would be too presumptuous of me to add your Tested-by tag to each
of the 26: I'll just add your Reviewed-bys to 01 and 02, thanks.

You may be wondering what became of the series: it's good, and I did
rebase it to 7.4-rc2, folding in JP Kobryn's fine improvement (thank you)
to __page_cache_release(), and Kiryl's !folio_test_unevictable() safety
in lru_add_del_folio().

But found there was already a conflict in folio_batch_move_lru() in
mm/core.git, which would make several of the rc2-based patches not
directly applicable there; then saw David's "MM: Firefighting mode"
mail, which confirmed what was becoming apparent, that it would be
more helpful not to repost the lru_add_drain() series this cycle,
but rather attempt to review the current fixing activity (I've tried,
but just cannot keep up with all that David, Lorenzo and others have
been achieving).

I intend to post again around 7.5-rc1 or -rc2: I'm probably naive
to hope that the fixing frenzy will be less by then, but I'd better
go ahead with a repost then, whatever the situation.

Hugh
