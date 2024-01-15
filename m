Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF892168CE
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWvwirW5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705323448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ltWg76fzJ09dpizAOzuCHqBRC4qeYPGA7mst/OlP3nI=;
	b=DWvwirW52NVKVuuCHUXmFlVxQhqMca9pNIF6vXGFlli4n+wgpv9aKKVHaOnAL8HLlhSBgW
	Nnr27WN0Iqcp/I48XgF5dzpmMM4aJGdFNUsXba2iKy3XZzRl88OHrm0Ti2r5wIO81VxHh8
	UVdE8gSwK5eosli7+zEqs4PoWlraFoY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-wC7gr7Z5OLmI0qw29xUGQw-1; Mon, 15 Jan 2024 07:57:25 -0500
X-MC-Unique: wC7gr7Z5OLmI0qw29xUGQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 452F583B86C;
	Mon, 15 Jan 2024 12:57:25 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.22])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C7C5111D785;
	Mon, 15 Jan 2024 12:57:24 +0000 (UTC)
Date: Mon, 15 Jan 2024 13:57:22 +0100
From: Karel Zak <kzak@redhat.com>
To: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: PROBLEM: BLKPG_DEL_PARTITION with GENHD_FL_NO_PART used to
 return ENXIO, now returns EINVAL
Message-ID: <20240115125722.bwumutabu4itbrho@ws.net.home>
References: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Mon, Jan 15, 2024 at 01:13:49PM +0100, Allison Karlitskaya wrote:
> hi,
> 
> [1.] One line summary of the problem:
> BLKPG_DEL_PARTITION on an empty loopback device used to return ENXIO
> but now returns EINVAL, breaking partprobe

 Note that partx from util-linux also assumes ENXIO, and this errno is
 interpreted as non-error ("ignore this partition").

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

