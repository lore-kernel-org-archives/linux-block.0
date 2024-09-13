Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664111D86E0
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226800; cv=none; b=Hg5eIHFu8snLkp4J1dTOtDJO9nqYjGLKwZZoJxkGOw8bymKHZm3O8SYzumgKZJCgYnDLdmwVf5sL1xguXCgd3AVlXc/vOqYpFMIY+XmGBnn1sGrSUBRa0EhR2Hhd0aQ3WG0ga4w4znaAogZ/8TeoKzP7dOftxI6KSibZhG1KH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226800; c=relaxed/simple;
	bh=ZNUq125crCMNeyNW6G552SmIMwb+lpM4BHj5MVnWFRw=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=RMYLjka1+laVYY5YFSY6Iwulbx5ABxFTjyiDxQhL2YWZBnupgFLKHvETldGhrPjhJsD+HkH5ln3A46W8rMNcTWU5aQ2GzyMzMiRlPrCw5KT0orT1RmqfK5U0QlmUAebQPBXGQM6YmdhgZ4oIvuyUtB31xVFUUsARsknxFpxtceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Q/Ny8uX3; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q/Ny8uX3"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240913112629euoutp0147cd026160b4609baf1e059fec3e1242~0yh53w2Ik3149931499euoutp017
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 11:26:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240913112629euoutp0147cd026160b4609baf1e059fec3e1242~0yh53w2Ik3149931499euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726226789;
	bh=ev+GuL1Brr/9bTlEi8r/+HobCwnCoUIh8W9KxJUcWuE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Q/Ny8uX3xqBcLzAMKsptOI0tai2bRKetBLzc7ZxgyxzDIm5KfG6P9/OJ/kNTxhFy5
	 NAekN+a2CcVL5R7VrU4JS6Pn/WabfZdWpw75RcmxtTQzUcZuJns4Jm69DYswNNFr+C
	 ryNvrW0glPcnbk3SQClU32iyBBAWzDg/iE38nBDM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240913112629eucas1p22e155403dd322f4ea8f10764870eb9a4~0yh5oAdrf2743627436eucas1p2p;
	Fri, 13 Sep 2024 11:26:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 93.FE.09624.46124E66; Fri, 13
	Sep 2024 12:26:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240913112628eucas1p2320f405babd81c85e87a0d7b41d7a5f3~0yh5CWDAu2206022060eucas1p2y;
	Fri, 13 Sep 2024 11:26:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240913112628eusmtrp22653d7f7bae7e12d665ec500035490b3~0yh5BwSvB2051520515eusmtrp2R;
	Fri, 13 Sep 2024 11:26:28 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-98-66e42164b447
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 9F.80.14621.46124E66; Fri, 13
	Sep 2024 12:26:28 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240913112628eusmtip187c6a8969b9b9e97dc3808ba2823efc1~0yh4u41_03162531625eusmtip1I;
	Fri, 13 Sep 2024 11:26:28 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 13 Sep 2024 12:26:26 +0100
Date: Fri, 13 Sep 2024 13:26:26 +0200
From: Daniel Gomez <da.gomez@samsung.com>
To: John Garry <john.g.garry@oracle.com>
CC: Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<gost.dev@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, Pankaj Raghav
	<p.raghav@samsung.com>, Dave Chinner <dchinner@redhat.com>, Daniel Gomez
	<d@kruces.com>
Subject: Re: [PATCH RFC] block: trace: add block alignment information
Message-ID: <20240913112626.mmr27xzxicyf37kh@AALNPWDAGOMEZ1.aal.scsc.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7f9079f-6f47-4a47-a327-98497bd33dfe@oracle.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BMURzHnXvv3r2tWXPbls7IiJJXLHnM3PGITLjGYxqGEQ0te1uxJbuW
	FZnGIz2kRNPayiNSKmEraic7zbZqqGTksZZmiR3mDq0e41XCOh799/l9z/d8z/meORQuMQlG
	UtGxuzl1rFzlR4qImw1fW6cqxr6Jmn6/mGFK2zNI5lPxZQHTwucLmQffqgFz2x7ItJnySMZ6
	rYVgKlqaccaW6QTMxaLxjDn5JbZwKFvY9J5kj5jtQratRcsaS1JI9kf6SwHb5bQTrMv8mGR7
	jKPDqA2ieQpOFb2HU08LjhRtMzSExjnX6FznBoSJQL8oFXhQkJ4Fa5KOEqlAREnoYgBrC18L
	0dALYEpGM0BDD4CnOlKwVED93tKeFoj0IgCteiv2z2TvLiDRUAHgrY+1hPsQgg6AZ9OzBW4m
	6UnQfNcodCdJ6YnQavFx+3HahMPbx3qB2+NFL4FfL/OYm8X0cni8/IMQsSe8e+bN70yclkFb
	9mnSnYPTPrBogEKyLzxclYu72YMOhgXPeBL1HAv1J68QiBPgvUo7hrjUAyZ9X4c4FNbdSwSI
	vSDfWClEPAr+qDn3x6+El8oNf3LiYO1zgwA9ylx4olmF5BDouGAjkDwM2j54opsNg1k3c3Ak
	i2FykiQTjDMMqmUYVMvwv5ZhUK3zgCgB3pxWE6PkNEGx3F6ZRh6j0cYqZVt3xhjBr+/VNNDY
	XQ3y+S6ZBWAUsABI4X5ScRbZESURK+T74jn1zs1qrYrTWIAPRfh5iwMUvpyEVsp3czs4Lo5T
	/13FKI+Ridjep6GvI0rTJ1RtaTNterX6IR7vishvyptj8Q9x3sD6RRts1cvDCdUyfsfKWkey
	o3hebkWIpz4wbNa61iFKh2v28Nb+nmUp/rOnbj0IyM/mjUFPG78kXHt70L6JLfPNO3Zo/Ysc
	vtOpq5D2RQDLE61+6eJLAWP0OZWC6uxnDyPTdPNd7VnxE/uvJuTo6uwHuk8c/yhbY5Crws7P
	6Xy1qqHpiWpKGSjZdd3KP+raSCic5kKvuLUdica09ozH75rrI+uzAn3mvniQJJixebv0jn/P
	GO+6gqh0KR0fdKdKEs2Xz7y6q3yPcIKjzzlClFDgub+vV2oJ160INg0ZV7ZAH15f40dotsmD
	JuNqjfwn2PKAFc0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7opik/SDFomClmsvtvPZvFtxTJW
	i7Ov5rJbXPi1g9Fi7y1ti8u75rBZHFl/lsVi89kzzBY3JjxltFi8XM1iX8cDJgduj6Wn37B5
	tOy7xe5x+Wypx6ZVnWwe/3sfsHp8fHqLxeP9vqtsHp83yQVwROnZFOWXlqQqZOQXl9gqRRta
	GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlzDrmUvA0uOL9/H/sDYwznLoYOTgk
	BEwk7nZrdzFycQgJLGWUOHZmCmMXIydQXEZi45errBC2sMSfa11sILaQwEdGiT/X5SEaNjNK
	zJvwiQUkwSKgKjGvdypYA5uApsS+k5vYQRaICGhIHDkkDVLPLLCLWWJv+xewBcICbhI/l71i
	ArF5Bbwleta9ZYdYcIVRom2lJURcUOLkzCdg85kF9CRuTJ3CBjKTWUBaYvk/DoiwvETz1tnM
	IDangJ3Eopuv2CBuVpSYMXElC4RdK/H57zPGCYwis5BMnYVk6iyEqbOQTF3AyLKKUSS1tDg3
	PbfYUK84Mbe4NC9dLzk/dxMjMLq3Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuGdxPYoTYg3JbGy
	KrUoP76oNCe1+BCjKTCEJjJLiSbnA9NLXkm8oZmBqaGJmaWBqaWZsZI4r9vl82lCAumJJanZ
	qakFqUUwfUwcnFINTHv54kWzBTdu28Fcezc2qFqbWyJP+2tbgddpn1PHlt2eIxapID3zf4+0
	Vvu1xu6/fpoW38Slg0t3pWVLHty/1HWTVKHM2715Wo5SjBqPfwbumxZmOKU2gyV8CWPzns9n
	9z/avVhY/RjjonbNrIIEsZfMVqc51u/32xx29lmwrs2et2lnlv32n/7+0qbfwltFYr9vnDL9
	y5YNh31l7z4TuLBX89PGP6qTK9R+bXI+WPLqlfoLIfnEHWV8Xtc259sE7zd79SqqUG3XWrkG
	gdXSzWvOsfioMa9bsPLoOqklIp93xN8WEvE+OVmUz+Psl/ssVyPDpH/u4Ypp9lb8LvFhusUU
	tZSHt3llp5RYiTdv/qbEUpyRaKjFXFScCACKGTIBdwMAAA==
X-CMS-MailID: 20240913112628eucas1p2320f405babd81c85e87a0d7b41d7a5f3
X-Msg-Generator: CA
X-RootMTR: 20240913085931eucas1p25bf5b7cb054cd5d9cc85b8b82097e997
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240913085931eucas1p25bf5b7cb054cd5d9cc85b8b82097e997
References: <20240912-add-blkalgn-block-trace-v1-1-335dd6eea557@samsung.com>
	<CGME20240913085931eucas1p25bf5b7cb054cd5d9cc85b8b82097e997@eucas1p2.samsung.com>
	<a7f9079f-6f47-4a47-a327-98497bd33dfe@oracle.com>

On Fri, Sep 13, 2024 at 09:59:08AM +0100, John Garry wrote:
> On 12/09/2024 21:48, Daniel Gomez via B4 Relay wrote:
> > From: Daniel Gomez <da.gomez@samsung.com>
> > 
> > Report block alignment in terms of LBA and size during block tracing for
> > block_rq. Calculate alignment only for read/writes where the length is
> > greater than 0. Otherwise, report 0 to indicate no alignment calculated.
> > 
> > Suggested-by: Dave Chinner <dchinner@redhat.com>
> > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > ---
> > This patch introduces LBA and size alignment information for
> > the block_rq tracepoints (block_rq{insert, issue, merge} and
> > block_{io_start, io_done}).
> 
> eh, shouldn't this belong in the description of the patch?

Yes. I'll move this to the commit message.

> 
> And I still don't know what we mean by alignment in this context.
> 
> From looking at the code, it seems to be the max detected block size
> granularity. For example, for a 64KB write at a 32KB offset, that would give
> a 32KB "alignment". But a 64KB write at a 64KB offset would be "64KB"
> alignment. While a 8KB write at 64KB offset would be 8KB "alignment". And a
> 24KB write at offset 0 is a 8KB "alignment", as 8KB is the lowest power-of-2
> which is divisible into 24KB. Is this a correct understanding?

That is correct. Do you think adding examples like yours can help to explain
this better? Below the same examples using fio with the trace output:


	sudo fio -bs=64k -size=64k -offset=32k -rw=write \
	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync
	
	sudo fio -bs=64k -size=64k -offset=64k -rw=write \
	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync
	
	sudo fio -bs=8k -size=8k -offset=64k -rw=write \
	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync
	
	sudo fio -bs=24k -size=24k -offset=0k -rw=write \
	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync

	fio-789     [000] .....  4455.092003: block_rq_issue: 259,0 WS 65536 () 64 + 128 none,0,0 |32768| [fio]
	fio-801     [000] .....  4455.474826: block_rq_issue: 259,0 WS 65536 () 128 + 128 none,0,0 |65536| [fio]
	fio-813     [000] .....  4455.855143: block_rq_issue: 259,0 WS 8192 () 128 + 16 none,0,0 |8192| [fio]
	fio-825     [000] .....  4456.235595: block_rq_issue: 259,0 WS 24576 () 0 + 48 none,0,0 |8192| [fio]


Also, the motivation behind this is explained in the LBS RFC [1] and I should
have included it here for context. I hope [1] and my description below helps to
explain what alignment means and why is needed:

[1] Subject: [RFC 00/23] Enable block size > page size in XFS
https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/

Tracing alignment information is important for high-capacity and QLC SSDs with
Indirection Units greater than 4 KiB. These devices are still 4 KiB in Logical
Block Size (LBS) but because they work at higher IUs, unaligned writes to the IU
boundaries can imply in a read-modify-write (RMW).

The graph below is a representation of the device IU vs an I/O block aligned/
unaligned.

    |--- IU Boundaries ----|      |-PS-|
a)  [====][====][====][====][····][····][····]--
    |                      |
b)  [····][====][====][====][====][····][····]--
    |                      |
c)  [====][====][====][====][····][====][====]--
    |                      |
d)  [····][····][====][====][····][····][····]--
    |                      |
LBA 0                      4
  
    Key:
    [====] = I/O Block
    [····] = Memory in Page Size (PS) chunks

a) I/O matches IU boundaries (LBA and block size). I/O is aligned.
b) The size of the I/O matches the IU size but the I/O is not aligned to the
IU boundaries. I/O is unaligned.
c) I/O does not match in either size or LBA. I/O is unaligned.

> 
> > 
> > The idea of reporting alignment in a tracepoint was first suggested in
> > this thread [1] by Dave Chinner. Additionally, an eBPF-based equivalent
> > tracing tool [2] was developed and used during LBS development, as
> > mentioned in the patch series [3] and in [1].
> > 
> > With this addition, users can check block alignment directly through the
> > block layer tracepoints without needing any additional tools.
> > 
> > In case we have a use case, this can be extended to other tracepoints,
> > such as complete and error.
> > 
> > Another potential enhancement could be the integration of this
> > information into blktrace. Would that be a feasible option to consider?
> > 
> > [1] https://urldefense.com/v3/__https://lore.kernel.org/all/ZdvXAn1Q*2F*QX5sPQ@dread.disaster.area/__;JSs!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXtYsRb3aY$
> > [2] blkalgn tool written in eBPF/bcc:
> > https://urldefense.com/v3/__https://github.com/dkruces/bcc/tree/lbs__;!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXthE7cfng$
> > [3] https://urldefense.com/v3/__https://lore.kernel.org/all/20240822135018.1931258-1-kernel@pankajraghav.com/__;!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXtqQ5uwAE$
> > ---
> >   block/blk-mq.c               | 29 +++++++++++++++++++++++++++++
> >   include/linux/blk-mq.h       | 11 +++++++++++
> >   include/linux/blkdev.h       |  6 ++++++
> >   include/trace/events/block.h |  7 +++++--
> >   4 files changed, 51 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 831c5cf5d874..714452bc236b 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -4920,6 +4920,35 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
> >   }
> >   EXPORT_SYMBOL_GPL(blk_rq_poll);
> > +u32 __blk_rq_lba_algn(struct request *req)
> 
> why use "algn", and not "align"?
> 
> "algn" is not a natural abbreviation of "alignment".

That's okay with me, changing the var name to a more natural abbreviation.

> 
> And why can't userspace figure this out? All the info is available already,
> right?

We are interested in the block alignment (LBA and size) at block device driver
level, not userspace level. That is, everything that is going out from the block
layer. Using the block tracing points currently available makes it block-driver
generic.

> 
> > +{
> > +	u32 lbs = queue_logical_block_size(req->q);
> > +	u32 lba_shift = ilog2(lbs);
> > +	u32 lba = req->__sector >> (lba_shift - SECTOR_SHIFT);
> 
> req->__sector is a u64 - is it safe to store the shifted value in a u32?
> 
> > +	u32 len = req->__data_len;
> > +	u32 algn_len = len;
> > +	u32 algn_lba = len / lbs;
> > +	u32 alignment = lbs;
> > +
> > +	if (is_power_of_2(len) &&
> > +	    blk_rq_lba_aligned(len, algn_len, lba, algn_lba))
> > +		return len;
> > +
> > +	algn_len = lbs << 1U;
> > +	algn_lba = algn_len / lbs;
> > +
> > +	while (algn_len < len) {
> > +		if (!blk_rq_lba_aligned(len, algn_len, lba, algn_lba))
> > +			break;
> > +
> > +		alignment = algn_len;
> > +		algn_len = algn_len << 1U;
> > +		algn_lba = algn_len / lbs;
> > +	}
> > +
> > +	return alignment;
> > +}
> > +
> >   unsigned int blk_mq_rq_cpu(struct request *rq)
> >   {
> >   	return rq->mq_ctx->cpu;
> > diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> > index 8d304b1d16b1..02959fbd5e28 100644
> > --- a/include/linux/blk-mq.h
> > +++ b/include/linux/blk-mq.h
> > @@ -740,6 +740,17 @@ void blk_mq_free_request(struct request *rq);
> >   int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
> >   		unsigned int poll_flags);
> > +/* The alignment of the block in terms of LBA and size */
> > +u32 __blk_rq_lba_algn(struct request *req);
> > +static inline u32 blk_rq_lba_algn(struct request *req)
> > +{
> > +	if ((req_op(req) != REQ_OP_WRITE) && (req_op(req) != REQ_OP_READ) &&
> > +	    !(req->__data_len))
> > +		return 0;
> > +
> > +	return __blk_rq_lba_algn(req);
> > +}
> > +
> >   bool blk_mq_queue_inflight(struct request_queue *q);
> >   enum {
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index bf1aa951fda2..28557987daa8 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -1433,6 +1433,12 @@ static inline int blk_rq_aligned(struct request_queue *q, unsigned long addr,
> >   	return !(addr & alignment) && !(len & alignment);
> >   }
> > +static inline bool blk_rq_lba_aligned(u32 len, u32 algn_len, u32 lba,
> > +				      u32 algn_lba)
> > +{
> > +	return !(len % algn_len) && !(lba % algn_lba);
> > +}
> 
> why in blkdev.h? It is only used in block/blk-mq.c

There's a blk_rq_aligned in blkdev.h already and used in blk-map.c that checks
for dma and pad alignment. I can move it to blk-mq.h if that fits better.


> 
> > +
> >   /* assumes size > 256 */
> >   static inline unsigned int blksize_bits(unsigned int size)
> >   {
> > diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> > index 1527d5d45e01..ba3764214dc7 100644
> > --- a/include/trace/events/block.h
> > +++ b/include/trace/events/block.h
> > @@ -202,6 +202,7 @@ DECLARE_EVENT_CLASS(block_rq,
> >   		__array(  char,		rwbs,	RWBS_LEN	)
> >   		__array(  char,         comm,   TASK_COMM_LEN   )
> >   		__dynamic_array( char,	cmd,	1		)
> > +		__field(  unsigned int,	algn			)
> >   	),
> >   	TP_fast_assign(
> > @@ -210,20 +211,22 @@ DECLARE_EVENT_CLASS(block_rq,
> >   		__entry->nr_sector = blk_rq_trace_nr_sectors(rq);
> >   		__entry->bytes     = blk_rq_bytes(rq);
> >   		__entry->ioprio	   = rq->ioprio;
> > +		__entry->algn      = blk_rq_lba_algn(rq);
> >   		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
> >   		__get_str(cmd)[0] = '\0';
> >   		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
> >   	),
> > -	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u,%u [%s]",
> > +	TP_printk("%d,%d %s %u (%s) %llu + %u %s,%u,%u |%u| [%s]",
> >   		  MAJOR(__entry->dev), MINOR(__entry->dev),
> >   		  __entry->rwbs, __entry->bytes, __get_str(cmd),
> >   		  (unsigned long long)__entry->sector, __entry->nr_sector,
> >   		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
> >   				   IOPRIO_CLASS_STRINGS),
> >   		  IOPRIO_PRIO_HINT(__entry->ioprio),
> > -		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->comm)
> > +		  IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry->algn,
> > +		  __entry->comm)
> >   );
> >   /**
> > 
> > ---
> > base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
> > change-id: 20240912-add-blkalgn-block-trace-71e8ab6708f1
> > 
> > Best regards,
> 
