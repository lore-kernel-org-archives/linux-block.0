Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923852;
	b=gX+mu3bSdGT+oLsXJyYRJFeoStLJInCC1SeIxrbzhabdyDPyzsdt2dkNFatBUqd1Gx2Z
	 No4c/sfv3jPHnlPgE+hXSH6mblg6/PNGW8CXaqDvoeOOZX7Yu3zsJJkm4EIk4DP+T/t4f
	 XDRaQElWyfvIOwBPi2uS4mFFUZBNkl4lsGI1QHRlU1XCocsBE2Y2ntjsqd+QNXIwIm/+p
	 S+jQQCTRwC6T2YCgbKfxnf0I+FO9BMkb2beouAaXU+N4sUfvyHCGf4ieoAOAtMZg5FI0x
	 1PFAM+KHbbgnXU1Gg3lv11Ho8DCnO1JGbECiu8mOsqPGyOfNO0X5ruUch4GHgJYpUyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923852;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IZO31/vr2Anb44jHz73z1goyYJ+XECbiZPGQcJjHi+w=;
	b=RVqBNMcpZ0HXy1IR/Mg5t2fjo0KzMJ3FJ3VZ5MPnPiV4deyRlNIlokaADZ3dEm7MpkKZ
	 dcrlTKi6M7tkYyKRKAAUvIZ/Cp0Ckma7S5WIkhGstIGA9ptq09GuzpTnwT/k7uBoqDKwf
	 24cr8zxcfcVUMn6fpXcw6NhPKkhFDVyhpiJe+hayICNY/RAYnXkOyLIseZhXwRVm6rxp7
	 dQEZJIDLzOvirv2qJRowDH2LfEY9aqmISpC5EmCkn5OTyMUsjEOx17n01ZrACJZT+b45j
	 txQoYfeXZhWVi1sZ59G2zUCM1vG4tmB20WQTgc+CDx7wPy7EySiLLxxCd1EkyD1qWIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=IuWBwW7q;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E4606A337;
	Tue, 17 Nov 2026 13:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 642E4606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=IuWBwW7q
Received: from [127.0.1.1] (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 943552022;
	Tue, 17 Nov 2026 14:55:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794923701;
	bh=WswJsxOBSsQrRCuzWGEZVgUOgcENdjhgoOrLkxfZu7g=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=IuWBwW7q9h0R86JgDPK3HAdIyVwqXjg/oKFsAkynRxGipq8FGkyDlaL1TAqtTZwBK
	 icBRF+jK4TTQmjav2G4ZjJWfMwz9MpUJSbgQsPq2t4qZCZMoAwSh7/HlFDs0ipPJD7
	 CQVQLfRJtmq3sVaxWVzduyy4lmztFbar2vVYy5v0=
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/26] mm/fbatch: remove !CONFIG_SMP special case of
 folio_activate()
From: Alen Karnil <alen.karnil@ideasonboard.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Ackerley Tng <ackerleytng@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Binbin Wu <binbin.wu@linux.intel.com>, 
 Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Christoph Lameter <cl@gentwo.org>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
 Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
 Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
 Mel Gorman <mgorman@techsingularity.net>, Miaohe Lin <linmiaohe@huawei.com>, 
 Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Peter Zijlstra <peterz@infradead.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Rik van Riel <riel@surriel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
 Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <b482561f-6620-d41d-eea0-a7f2a05cc444@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
 <b482561f-6620-d41d-eea0-a7f2a05cc444@google.com>
Date: Tue, 17 Nov 2026 13:57:16 +0000
Message-Id: <179492383659.1554713.15351223817355202820.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=634;
 i=alen.karnil@ideasonboard.com; h=from:subject:message-id;
 bh=WswJsxOBSsQrRCuzWGEZVgUOgcENdjhgoOrLkxfZu7g=;
 b=owGbwMvMwCUWeK6p+sMV/3mMp9WSGLL+xLpKT1rRd/LkvLUFx7cL7duefH5e5znmZoZ/rsbXd
 51KF3/k31HKwiDGxSArpsjy5ZDM9KU2K8IuaIZwwsxhZQIZwsDFKQATUZ/LyNAgsrBHxWvG4TvH
 kmXZj29gtHjFfeC5V2sN0/X0VK0gpjsM/wOuF9jorHkwO9PKXmK9lK75yof+Rpz/5/0/ZT25T2K
 vAgMA
X-Developer-Key: i=alen.karnil@ideasonboard.com; a=openpgp;
 fpr=F4C21C97A53CA856D029540951CE827BF0D44F9E

On Wed, 09 Sep 2026 02:42:10 -0700, Hugh Dickins <hughd@google.com> wrote:
> 3.0 commit eb709b0d062e ("mm: batch activate_page() to reduce lock
> contention") brought in an ifdef CONFIG_SMP around activate batching:
> https://lore.kernel.org/linux-mm/20100805140755.501af8a7.akpm@linux-foundation.org/
> shows a sensitivity to bloat that day, not any incompatibility with UP.
> 
> No other batching here has a UP alternative, and it's a bit confusing:
> simplify mm/folio.c a little by removing it now.
> 
> [...]

Reviewed-by: Alen Karnil <alen.karnil@ideasonboard.com>

-- 
Alen Karnil <alen.karnil@ideasonboard.com>
