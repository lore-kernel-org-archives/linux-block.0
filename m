Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923853;
	b=CVeQM0QXyZyrlx/Kz+opp+pt6m14RPp2ZnjfTFSSvy+FKFHdX+LJaD5E9kf2sJKnQVXd
	 vnQrgmUnEctuYs8uw7F3ds3zaXMPl+6g92ar2Z4WRV3FLytbcAOHw1isr6xo1L2D25TN7
	 kJ9Mgjdw25BACxnb7wyDWnnjh80o0G28e19N3QDh3lQYQ8gv+cKR/4GlvvVfyedJzyOyS
	 JH2QwE7mFS7umOMgpVCqoGQxdohkgauILNR4ynxXJrWEb27IjE5C9MauOGDGf2kHhjpb5
	 I/+hweQdPKr/jSXJfZ3spbHQTpusZvTnmYM2HAwneBcz47GntkSLok23sTFtRJT1UXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923853;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=oHtd/pbTnvrVurwDdLnofK84OY4uScGFLO1awwqENQs=;
	b=zCmS4FTG2dtvIPPXO5txN2ThDZQ7TBGAvujTgFnap71mnY0TOAbtWAxbKYbetVqFrDQi
	 6izHmR/e9B/kDRi1cjVfRgrwzfx3noUoJBULKzAoZpMdVCmlDg5ESj0xYUSlASflgWc8Q
	 HKvhWLzFbVW0/fEc0hQvV1BY29wBOT+33Hrjx5Fw+6ccNFv0sHVbFLUAmxYSO5Y7+T8Ph
	 lTvznCof4AXad2EOby9tuQ36tXdvPOgukL2MUODsFU84eYPn/cWuRhGNsXJnNahYrig3j
	 yTpA3xahFmWx2N0g6FOY0ijKyBYyhCuxXaZqTUxRcQJSNcCnUs9+YXOB5x+/upKT7VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=CpC5ga6d;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E592606A32F;
	Tue, 17 Nov 2026 13:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E592606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=CpC5ga6d
Received: from [127.0.1.1] (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1B85220F7;
	Tue, 17 Nov 2026 14:55:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794923703;
	bh=cHwdwzNargfc3BeW78Sng/2AI2tSJgiS/RyUNFGs4no=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=CpC5ga6dMSesEiJ7rir/HGZ/EmCLaDwGe9KKBODAzTTQe9qb/FE9Z7pS1Vbob8EO5
	 nao8uNB0WdtbLekaQrGnC6Mm831Sne7+b68QlWZwm9QUd20Q1PvJd+O4zQlsTY7Gqt
	 7+BU3J/S+zF6WWD6zh/hZP6W1nQVuofFZqNsM/5Y=
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
Subject: Re: [PATCH v2 02/26] mm/fbatch: allow folios_put_refs() to skip
 xa_is_value() entries
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
In-Reply-To: <c441176c-33b7-c8f8-fb7f-51774e1fd853@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
 <c441176c-33b7-c8f8-fb7f-51774e1fd853@google.com>
Date: Tue, 17 Nov 2026 13:57:16 +0000
Message-Id: <179492383660.1554713.7829576009911841106.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=633;
 i=alen.karnil@ideasonboard.com; h=from:subject:message-id;
 bh=cHwdwzNargfc3BeW78Sng/2AI2tSJgiS/RyUNFGs4no=;
 b=owGbwMvMwCUWeK6p+sMV/3mMp9WSGLL+xLr5F3F9/Ne5sF+97axIV8yeF3s0wz/diZ8/a5390
 5kHXh7d0VHKwiDGxSArpsjy5ZDM9KU2K8IuaIZwwsxhZQIZwsDFKQATuXGY4Z8t//sVyvX7C61P
 +zM8UP0bNMPF/HDfq3l5rku3M389btfI8D/Z+eg+wWCmdwW3Zj7QWjAxdgdjH2+hx7515lF3j9i
 pXmABAA==
X-Developer-Key: i=alen.karnil@ideasonboard.com; a=openpgp;
 fpr=F4C21C97A53CA856D029540951CE827BF0D44F9E

On Wed, 09 Sep 2026 02:44:34 -0700, Hugh Dickins <hughd@google.com> wrote:
> Let folios_put_refs() (hence folio_batch_release()) skip xa_is_value()
> entries, and therefore remove unneeded folio_batch_remove_exceptionals().
> 
> It made some sense when introduced in 3.1 for shmem swap entries only,
> but workingset shadows popularized exceptional entries in 3.15, and it's
> silly for so many sites to be squashing exceptionals out of the fbatch,
> merely to suit an inadequacy in folios_put_refs().
> 
> [...]

Reviewed-by: Alen Karnil <alen.karnil@ideasonboard.com>

-- 
Alen Karnil <alen.karnil@ideasonboard.com>
