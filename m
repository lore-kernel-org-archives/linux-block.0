Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E73A5E91;
	Tue, 15 Sep 2026 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789444790; cv=none; b=glPOB1WeauuN2grQd+8PPMuTjlyhpECsYP6WfwT9P8TFz7NmSrhIwDMpkBBQfT7YooJf4/zkA9bmPQuM4y8uzL61Isa6MgSk8GYjbPxYRR4/gDdWbOJuOpluBtsgJ1gUV0X1DjoFCTsqrLyTRu6XSeVXiFOyQ6j7+0F3rDCAaHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789444790; c=relaxed/simple;
	bh=3i6DjEo+qc1q8RmPR77Wsg41nqFB+6O6hnb8uL4v7aI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DPpWTqkkWUSBFKI6TfZW6kFjKirgRkRJ2zr92vwiD2v6iF5YN5+PQ7pzhtH217eoizYMoRcJ3DM1IV7MSwaiSNzsrDsJ7EA1zOiy3X8g1l7yvXA/oi4pJH2cSV/MgkW5rPK+Dg61kw37gA0Dw6fwrsUoEsXsxG2w4rjdigf9jmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kjzgAp2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kjzgAp2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0511F000FF;
	Tue, 15 Sep 2026 03:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789444788;
	bh=P+yQWpukN/knPtOJgQNkfX9OLcd33cnh6zLsLwhJhp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kjzgAp2kjFItnvcD/iiVOdi3vYle8h6OkfTm2Pl4YLHuoIn/xWMFV+Fq2zNNJTV8+
	 tLIZ6zfMSMLpP3hqmitweLqKWdyK9udp1J1IawJrI7yrLGQ8hWdfBc8nqRn0RRRpxk
	 PvqnQN8UTJe14p0snkAGQ8VOr+BP9oshe3j8j6W8=
Date: Mon, 14 Sep 2026 20:59:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 willy@infradead.org, jack@suse.cz, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH v4 0/3] memcg,writeback: flush foreign bdev mappings
 separately
Message-Id: <20260914205947.5aab9d7261ef0f26ec8f3213@linux-foundation.org>
In-Reply-To: <20260914103119.1708452-1-sunjunchao@bytedance.com>
References: <20260914103119.1708452-1-sunjunchao@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 18:31:16 +0800 Julian Sun <sunjunchao@bytedance.com> wrote:

> Bdev inodes are routinely shared by multiple memcgs. Recording their
> owner wb as foreign can cause dirty throttling in one memcg to trigger
> writeback of unrelated file data belonging to that wb.
> 
> On one production machine, bdev mapping snapshots showed as little
> as about 10 MiB of dirty data. A queue snapshot of its owner wb showed
> 599 foreign-flush works, with an average requested writeback budget of
> 43 GiB per work.
> 
> In other words, a small amount of foreign dirtying in the bdev mapping
> can trigger owner-wide writeback requests, whose budgets averaged
> 43 GiB in this queue snapshot.

What is the overall runtime effect of this?  IOW, can we see some
before-and-after numbers?

> Following Jan's suggestion, this series records foreign bdev targets
> separately and flushes their mappings instead of their owner wbs. This
> preserves a way for dirty throttling to initiate bdev writeback while
> avoiding owner-wide writeback triggered by these records. The existing
> foreign-wb mechanism remains unchanged for other inodes.
> 
> Tracking is best effort: each memcg keeps a bounded set of device
> numbers without persistent device or inode references. Closed devices
> and devices with a busy open_mutex are skipped. Device removal and
> device-number reuse may race with lookup.
> 
> Flushes run asynchronously on a dedicated workqueue to isolate these
> frequently triggered tasks from existing workqueue users. If workqueue
> allocation fails, the existing foreign-wb mechanism remains in use.
> 
> Julian Sun (3):
>   block: introduce bdev_flush_by_dev()
>   memcg,writeback: flush foreign bdev mappings separately from owner wbs
>   writeback: record bdev targets in foreign writeback tracepoints
> 
>  block/bdev.c                     |  24 +++++++
>  include/linux/blkdev.h           |   1 +
>  include/linux/memcontrol.h       |  15 ++++
>  include/trace/events/writeback.h |  22 +++---
>  mm/memcontrol.c                  | 113 ++++++++++++++++++++++++++++---

I'd consider this a memcg patch, and not only due to the line counts.

Please cc linux-mm on memcg patchsets.
