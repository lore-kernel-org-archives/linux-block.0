Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977D3B3BEF;
	Tue, 15 Sep 2026 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452372; cv=none; b=qUOfJXAt9qCGsiU4FTFWNlgFpPf3dDXlqOmM4dCcoGicq915arD0qbTTKoNH42iFEMFtEXEVRhmH6d7E4a/e7zx5SrNsNdTjePHaHhISYWcdgyWVJptJT+OGadLR1rs1+40ZXaBriy3N0elFKTYkWxfXdAVbeHzyk7FUPjGz8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452372; c=relaxed/simple;
	bh=2v+ULD5t7ipuvDvm9JZEARuryVzaHIWp+GPpJI99Mhc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Com6QLn3tLzYfQyjqkJvO6EdmIzwurYYfGxLoS/jWGL2J3AJf1x46op6ZUjZZt3AQk0rhxV5fk7FunKW0034EYLvcslAa5PKlUQemg/CnRfWvOqFvgPdEqTbjkywGxMXbIVCNJ6iEkCni8+PdaB6HKO9nySjNJLvjvLK1FVpIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q5OCUJ/k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q5OCUJ/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C759F1F000FF;
	Tue, 15 Sep 2026 06:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789452368;
	bh=+xxEqhiF3vxSUzq5Nt+Fw5y6mQaekGAywZHRtZkajCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q5OCUJ/kGbEIlPHjL+9OEi6LGcdhCpjjZZQTNUXyD88CAOMW3kdJ+01jkWAGYgzlb
	 SZ1Sbx3y1iaUM46yvjh4tGuLVqjq2Mc8kSFFdufzUIMfJ3Lf0tFRecpdV6T6TIJbzQ
	 SN9YZOUDRIg5rPIBwxlsW+tNZ5yNfm4uuUKjmNXo=
Date: Mon, 14 Sep 2026 23:06:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 willy@infradead.org, jack@suse.cz, rostedt@goodmis.org, tj@kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 0/3] memcg,writeback: flush foreign bdev mappings
 separately
Message-Id: <20260914230607.9e4d74933bb589eeef435e8d@linux-foundation.org>
In-Reply-To: <eba0295b-268a-4573-aeeb-de79b9ca6063@bytedance.com>
References: <20260914103119.1708452-1-sunjunchao@bytedance.com>
	<20260914205947.5aab9d7261ef0f26ec8f3213@linux-foundation.org>
	<eba0295b-268a-4573-aeeb-de79b9ca6063@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 13:35:18 +0800 Julian Sun <sunjunchao@bytedance.com> wrote:

> > 
> > What is the overall runtime effect of this?  IOW, can we see some
> > before-and-after numbers?
> 
> I tested this series using a QEMU/KVM VM with 4 vCPUs, 8 GiB RAM,
> cgroup v2 and ext4. Virtual NVMe write bandwidth was capped at
> 200 MiB/s.
> 
> A fio job repeatedly overwrote a preinitialized 256 MiB file using
> 64 KiB buffered writes, at 64 MiB/s, for 9 GiB of logical writes.
> Four memcgs, each with memory.high=32 MiB and io.max=2 MiB/s, generated
> metadata and buffered writes to trigger dirty throttling and foreign
> flushes. Concurrently, foreground fio performed 16 GiB of sequential
> direct writes using 1 MiB requests and queue depth 32. Normal periodic
> writeback remained enabled.
> 
> Three comparison pairs, with alternating execution order, produced:
> 
> Run  Kernel   File I/O (GiB)  Time (s)  BW (MiB/s)  p99 (ms)
> 1    base              7.19    114.74      142.79      1434
> 1    patched           1.57     88.62      184.87       480
>       change         -78.22%   -22.76%     +29.47%   -66.52%
> 
> 2    base              5.13    103.59      158.16      1434
> 2    patched           1.74     88.65      184.81       497
>       change         -66.06%   -14.42%     +16.85%   -65.35%
> 
> 3    base              6.14    109.27      149.94      1434
> 3    patched           1.73     88.68      184.75       480
>       change         -71.77%   -18.85%     +23.22%   -66.52%
> 
> File I/O is completed block I/O matching the overwritten file's extents,
> including final sync, not requested writeback budgets. The other metrics
> are for the foreground workload.
> 
> Across these runs, mean file write I/O decreased by 72.7%, foreground
> bandwidth increased by 23.0%, and completion time decreased by 18.8%.

Thanks.  This is super-important info so please condense, summarize and
emphasize this result in the [0/N].

How real-world is this test case?  I assume people won't see gains like
this in anything they normally do?  I assume this is long-standing
behavior, so if misbehavior like this was regularly being observed then
we'd have fixed it by now.

> > 
> > I'd consider this a memcg patch, and not only due to the line counts.
> > 
> > Please cc linux-mm on memcg patchsets.
> Sure, will do.

Great.  Please update that [0/N] as indicated - help readers understand
the expected real-world impacts.  Then send us a v5 and I'll get to
work helping to deliver this to our users.

