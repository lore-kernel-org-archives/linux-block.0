Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B481DB94E
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 13:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235841; cv=none; b=mpUqurghADinTVaJWdTfAf69KIama0aICqkqOTN1xNxcC+EVjQw0FZLYVp5BsSCl+IJ5dA/cI2E6l8aPTjs6FEy/qxQ9hh0c8ctAhs3DtoY+wviEcyDygs9aSv3vmkHHBtX45qIdPDWdY3FqTwiq8cLtpHiM3eo5u8D5YYke2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235841; c=relaxed/simple;
	bh=D4tmFItH8l1hU7Qov4/TevlotYWStp7atjrXqpfIEMU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=qQioJEnbbIDQkLEKAqFmROkZn0Z0OmBeA/tYJG7rem/Lpw1Pd0TTa3j6VSomthzhFMW/LKNhRv0PMjjY01QUPLfFonjqsJofBctNtgnmjtAMW34SxGYSAfTsZYPUtvWGPq0g2RMPzSkc4Ork/oHCP98otbJQFOj9snTFkjgWBs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YHjfVM2n; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YHjfVM2n"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240913135716euoutp01df4b78bf1a4fb045f94a30a70a9e4d9f~00ljREm-60461804618euoutp01h
	for <linux-block@vger.kernel.org>; Fri, 13 Sep 2024 13:57:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240913135716euoutp01df4b78bf1a4fb045f94a30a70a9e4d9f~00ljREm-60461804618euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726235836;
	bh=aFVWYd8GwQqNSGLrOsMwuDZmyAAfxj/WbpVwIhoXioY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YHjfVM2nSqyeooguLskEAoZPN9Nj7Xslh64Ly8IZ5AUMBAi1hwau5+FlrWISIUEuZ
	 gIoVijKD/cOaMtK2wthWGlLgnL8HkydzIktGeVw/SPVUhQufgxvBnuZody68jH9oy8
	 k4v2HSRhOh20z+3aj5WFulcN/DfD4C5UKI8BvyLA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240913135715eucas1p1bbeb6787d0ae166cdb84154865ef20d3~00lirW-Vq0259302593eucas1p1R;
	Fri, 13 Sep 2024 13:57:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 8B.4F.09624.BB444E66; Fri, 13
	Sep 2024 14:57:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240913135715eucas1p28a9b7ad948650bcb40d3f8a887e73e56~00liP4QB40907809078eucas1p2o;
	Fri, 13 Sep 2024 13:57:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240913135714eusmtrp288310d96eb4484c1d64b80a3b1d178dd~00liO_dP11075910759eusmtrp2s;
	Fri, 13 Sep 2024 13:57:14 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-bd-66e444bb3c12
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C1.E8.14621.AB444E66; Fri, 13
	Sep 2024 14:57:14 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240913135714eusmtip18a948ed1c48d056683f5beaf2ab109e8~00lh76IwK3215332153eusmtip13;
	Fri, 13 Sep 2024 13:57:14 +0000 (GMT)
Received: from localhost (106.110.32.87) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 13 Sep 2024 14:57:13 +0100
Date: Fri, 13 Sep 2024 15:57:13 +0200
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
Message-ID: <20240913135713.vzevruukayd3o7cj@AALNPWDAGOMEZ1.aal.scsc.local>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77f6fd38-e216-47cf-8ceb-930395614aca@oracle.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djPc7q7XZ6kGXy7IWSx+m4/m8W3FctY
	Lc6+mstuceHXDkaLvbe0LS7vmsNmcWT9WRaLzWfPMFvcmPCU0WLxcjWLfR0PmBy4PZaefsPm
	0bLvFrvH5bOlHptWdbJ5/O99wOrx8ektFo/3+66yeXzeJBfAEcVlk5Kak1mWWqRvl8CV8f11
	J3PBYreKi7OuszYw/jPtYuTkkBAwkTi6qp+xi5GLQ0hgBaPE2o93WCGcL4wST+ZtYYFwPjNK
	tG06xQTT8uPhUnaIxHJGiVndZxjhqj5M3coM4WxmlPh94jgjSAuLgKrE7gVHWUFsNgFNiX0n
	NwG1c3CICGhIHDkkDVLPLLCLWWJv+xewemEBN4mfy14xgdTwCnhLXH2qDhLmFRCUODnzCQuI
	zSygJ3Fj6hQ2kBJmAWmJ5f84IMLyEs1bZzOD2JwCdhK3WxvYII5WlJgxcSULhF0rcWrLLSaQ
	tRICqzklGuc2skIkXCRaHvRB2cISr45vYYewZST+75wP9X26xJJ1s6AGFUjsuT2LFeQGCQFr
	ib4zORBhR4n7C2+wQIT5JG68FYQ4jU9i0rbpzBBhXomONqEJjCqzkPw1C8lfsxD+moXkrwWM
	LKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECE9jpf8c/7WCc++qj3iFGJg7GQ4wSHMxK
	IryT2B6lCfGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTBV
	fzS9veqRcEio/G+GXQnM1kcylJgL66v0ZXsy8w7YfygUVd78asN0n7mTpa+Zn2/huBd4aV6u
	/yTzQ/uv2Hb6bz38IZvN9H1+8xnr3cE/g5LXczqytrPoz9Ji4Vj/XvPANYe83z2/Ljy5WTtz
	15+5MpXPMmL3TOq8pfjM5UR8CJNmVMJZ0fSgtxz2k1KNt9h29s3Lc7tzfXqI22yBlNgr8sW/
	Hf9b2jH9ZOM8tGFH1uwTc59O2uPpW192dhbbjheTH19fWiUzw6E4M0L8773AEy7fvBrfvX+p
	WJR3YVF++u9dC7VdBKWX5HBvMpbz/72kyemY67ogMUWZw6bb3vPLLv1QOZ876XjRnoKtSyYp
	sRRnJBpqMRcVJwIAPzOZ6s8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7q7XJ6kGfQdNLBYfbefzeLbimWs
	FmdfzWW3uPBrB6PF3lvaFpd3zWGzOLL+LIvF5rNnmC1uTHjKaLF4uZrFvo4HTA7cHktPv2Hz
	aNl3i93j8tlSj02rOtk8/vc+YPX4+PQWi8f7fVfZPD5vkgvgiNKzKcovLUlVyMgvLrFVija0
	MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL+P66k7lgsVvFxVnXWRsY/5l2MXJy
	SAiYSPx4uJS9i5GLQ0hgKaPE23P72SESMhIbv1xlhbCFJf5c62KDKPrIKPH+8yKwIiGBzYwS
	v44Lg9gsAqoSuxccBWtgE9CU2HdyE1ANB4eIgIbEkUPSIL3MAruYJfa2f2EEqREWcJP4uewV
	E0gNr4C3xNWn6hDzTzFJTH70jwmkhldAUOLkzCcsIDazgJ7EjalT2EDqmQWkJZb/44AIy0s0
	b53NDGJzCthJ3G5tYIO4WVFixsSVLBB2rcTnv88YJzCKzEIydRaSqbMQps5CMnUBI8sqRpHU
	0uLc9NxiQ73ixNzi0rx0veT83E2MwAjfduzn5h2M81591DvEyMTBeIhRgoNZSYR3EtujNCHe
	lMTKqtSi/Pii0pzU4kOMpsAQmsgsJZqcD0wxeSXxhmYGpoYmZpYGppZmxkrivG6Xz6cJCaQn
	lqRmp6YWpBbB9DFxcEo1MPX8eDabt/2tzK4SIxOPr69sbOUU0zUZHi9MmxjnbqwiJ2fJeLMo
	RWnvLm5f+ZPyUXMsJ9m5Bk/5pjkne/V0b3GPSqmDh57kly8tSbRT25x+SzNrQsObQJl4s1P/
	738tF017kDHJWFgy6HtMuqvx8YSPv+1C7gvHsHLufnTvBo9Ay1Z/pmeFx24or3mZ6fg47bdv
	7o3pmRe0TPJUeR/vtK9dec9+qsDfq1saZpnz+cy0XrcsoHufzve8A82vZG9fupR+YumpHinu
	jJ5VYkae3IrampdXpMzZ9IfhqEBfoXrAMj/3SscJL6Z3ri//+j/KvtPs0GS9W+aFhXV5ndPa
	w4+9eBy1LthHxLDo1r/NSizFGYmGWsxFxYkA5sbflHkDAAA=
X-CMS-MailID: 20240913135715eucas1p28a9b7ad948650bcb40d3f8a887e73e56
X-Msg-Generator: CA
X-RootMTR: 20240913085931eucas1p25bf5b7cb054cd5d9cc85b8b82097e997
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240913085931eucas1p25bf5b7cb054cd5d9cc85b8b82097e997
References: <20240912-add-blkalgn-block-trace-v1-1-335dd6eea557@samsung.com>
	<CGME20240913085931eucas1p25bf5b7cb054cd5d9cc85b8b82097e997@eucas1p2.samsung.com>
	<a7f9079f-6f47-4a47-a327-98497bd33dfe@oracle.com>
	<20240913112626.mmr27xzxicyf37kh@AALNPWDAGOMEZ1.aal.scsc.local>
	<77f6fd38-e216-47cf-8ceb-930395614aca@oracle.com>

On Fri, Sep 13, 2024 at 01:08:34PM +0100, John Garry wrote:
> On 13/09/2024 12:26, Daniel Gomez wrote:
> > On Fri, Sep 13, 2024 at 09:59:08AM +0100, John Garry wrote:
> > > On 12/09/2024 21:48, Daniel Gomez via B4 Relay wrote:
> > > > From: Daniel Gomez <da.gomez@samsung.com>
> > > > 
> > > > Report block alignment in terms of LBA and size during block tracing for
> > > > block_rq. Calculate alignment only for read/writes where the length is
> > > > greater than 0. Otherwise, report 0 to indicate no alignment calculated.
> > > > 
> > > > Suggested-by: Dave Chinner <dchinner@redhat.com>
> > > > Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
> > > > ---
> > > > This patch introduces LBA and size alignment information for
> > > > the block_rq tracepoints (block_rq{insert, issue, merge} and
> > > > block_{io_start, io_done}).
> > > 
> > > eh, shouldn't this belong in the description of the patch?
> > 
> > Yes. I'll move this to the commit message.
> > 
> > > 
> > > And I still don't know what we mean by alignment in this context.
> > > 
> > >  From looking at the code, it seems to be the max detected block size
> > > granularity. For example, for a 64KB write at a 32KB offset, that would give
> > > a 32KB "alignment". But a 64KB write at a 64KB offset would be "64KB"
> > > alignment. While a 8KB write at 64KB offset would be 8KB "alignment". And a
> > > 24KB write at offset 0 is a 8KB "alignment", as 8KB is the lowest power-of-2
> 
> note: I meant "8KB is the largest power-of-2"

8KB will be the largest unit at what a device can operate at, for that
particular I/O.

> 
> > > which is divisible into 24KB. Is this a correct understanding?
> > 
> > That is correct.
> 
> So maybe it's me, but I just find it odd to call this information
> "alignment". To me, what you are looking for is largest block size
> granularity.

More suggestions are welcome. What about just I/O granularity? Does the term
imply LBA and size?

> 
> > Do you think adding examples like yours can help to explain
> > this better?
> > Below the same examples using fio with the trace output:
> > 
> > 
> > 	sudo fio -bs=64k -size=64k -offset=32k -rw=write \
> > 	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync
> > 	
> > 	sudo fio -bs=64k -size=64k -offset=64k -rw=write \
> > 	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync
> > 	
> > 	sudo fio -bs=8k -size=8k -offset=64k -rw=write \
> > 	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync
> > 	
> > 	sudo fio -bs=24k -size=24k -offset=0k -rw=write \
> > 	-direct=1 -filename=/dev/nvme0n1 -iodepth=1 -ioengine=sync -name=sync
> > 
> > 	fio-789     [000] .....  4455.092003: block_rq_issue: 259,0 WS 65536 () 64 + 128 none,0,0 |32768| [fio]
> > 	fio-801     [000] .....  4455.474826: block_rq_issue: 259,0 WS 65536 () 128 + 128 none,0,0 |65536| [fio]
> > 	fio-813     [000] .....  4455.855143: block_rq_issue: 259,0 WS 8192 () 128 + 16 none,0,0 |8192| [fio]
> > 	fio-825     [000] .....  4456.235595: block_rq_issue: 259,0 WS 24576 () 0 + 48 none,0,0 |8192| [fio]
> > 
> > 
> > Also, the motivation behind this is explained in the LBS RFC [1] and I should
> > have included it here for context. I hope [1] and my description below helps to
> > explain what alignment means and why is needed:
> > 
> > [1] Subject: [RFC 00/23] Enable block size > page size in XFS
> > https://urldefense.com/v3/__https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/__;!!ACWV5N9M2RV99hQ!NoMpDxzuA5uKlv0RAWE5UtOQKOrNB2zv8PHmOLWxfGCEzw5WpyyvonfhcMi0REPjCgF8pgBvEO9kyhTPO8z1$
> > 
> > Tracing alignment information is important for high-capacity and QLC SSDs with
> > Indirection Units greater than 4 KiB. These devices are still 4 KiB in Logical
> > Block Size (LBS) but because they work at higher IUs, unaligned writes to the IU
> > boundaries can imply in a read-modify-write (RMW).
> 
> Yes, I get that this might be important to know.
> 
> > 
> > The graph below is a representation of the device IU vs an I/O block aligned/
> > unaligned.
> > 
> >      |--- IU Boundaries ----|      |-PS-|
> > a)  [====][====][====][====][····][····][····]--
> >      |                      |
> > b)  [····][====][====][====][====][····][····]--
> >      |                      |
> > c)  [====][====][====][====][····][====][====]--
> 
> is there meant to be a gap at page index #4?

Sorry, that's a copy+paste error. c) can be ignored. 

> 
> >      |                      |
> > d)  [····][····][====][====][····][····][····]--

d) is c)


> >      |                      |
> > LBA 0                      4
> >      Key:
> >      [====] = I/O Block
> >      [····] = Memory in Page Size (PS) chunks
> > 
> > a) I/O matches IU boundaries (LBA and block size). I/O is aligned.
> > b) The size of the I/O matches the IU size but the I/O is not aligned to the
> > IU boundaries. I/O is unaligned.
> > c) I/O does not match in either size or LBA. I/O is unaligned.
> 
> what about d)? Not aligned to IU, I assume.

Yes, c) description is meant for d).

So for clarity, the correct graph is:

    |--- IU Boundaries ----|      |-PS-|
a)  [====][====][====][====][····][····][····]--
    |                      |
b)  [····][====][====][====][====][····][····]--
    |                      |
c)  [····][····][====][====][····][····][····]--
    |                      |
LBA 0                      4

a) I/O matches IU boundaries (LBA and block size). I/O is aligned to IU boundaries.
b) The size of the I/O matches the IU size but the I/O is not aligned to the
IU boundaries. I/O is unaligned.
c) I/O does not match in either size or LBA. I/O is unaligned.

Using I/O granularity term:
a) 16k I/O granularity
b) 4k I/O granularity
c) 8k I/O granularity

> 
> > 
> > > 
> > > > 
> > > > The idea of reporting alignment in a tracepoint was first suggested in
> > > > this thread [1] by Dave Chinner. Additionally, an eBPF-based equivalent
> > > > tracing tool [2] was developed and used during LBS development, as
> > > > mentioned in the patch series [3] and in [1].
> > > > 
> > > > With this addition, users can check block alignment directly through the
> > > > block layer tracepoints without needing any additional tools.
> > > > 
> > > > In case we have a use case, this can be extended to other tracepoints,
> > > > such as complete and error.
> > > > 
> > > > Another potential enhancement could be the integration of this
> > > > information into blktrace. Would that be a feasible option to consider?
> > > > 
> > > > [1] https://urldefense.com/v3/__https://lore.kernel.org/all/ZdvXAn1Q*2F*QX5sPQ@dread.disaster.area/__;JSs!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXtYsRb3aY$
> > > > [2] blkalgn tool written in eBPF/bcc:
> > > > https://urldefense.com/v3/__https://github.com/dkruces/bcc/tree/lbs__;!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXthE7cfng$
> > > > [3] https://urldefense.com/v3/__https://lore.kernel.org/all/20240822135018.1931258-1-kernel@pankajraghav.com/__;!!ACWV5N9M2RV99hQ!P1ZM_E9uBSDLzz6M0dLc_vgEGWEY2HPBXJvEJLWp7w0l_G_r9Gvkm2kQiN586NSIH-JMx_YiCFy_6qdklHFY3pXtqQ5uwAE$
> > > > ---
> > > >    block/blk-mq.c               | 29 +++++++++++++++++++++++++++++
> > > >    include/linux/blk-mq.h       | 11 +++++++++++
> > > >    include/linux/blkdev.h       |  6 ++++++
> > > >    include/trace/events/block.h |  7 +++++--
> > > >    4 files changed, 51 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > index 831c5cf5d874..714452bc236b 100644
> > > > --- a/block/blk-mq.c
> > > > +++ b/block/blk-mq.c
> > > > @@ -4920,6 +4920,35 @@ int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
> > > >    }
> > > >    EXPORT_SYMBOL_GPL(blk_rq_poll);
> > > > +u32 __blk_rq_lba_algn(struct request *req)
> > > 
> > > why use "algn", and not "align"?
> > > 
> > > "algn" is not a natural abbreviation of "alignment".
> > 
> > That's okay with me, changing the var name to a more natural abbreviation.
> > 
> > > 
> > > And why can't userspace figure this out? All the info is available already,
> > > right?
> > 
> > We are interested in the block alignment (LBA and size) at block device driver
> > level, not userspace level. That is, everything that is going out from the block
> > layer. Using the block tracing points currently available makes it block-driver
> > generic.
> 
> I am just saying that the information already present in the block trace
> point can be used to get this "alignment" info, right? And userspace can do
> the work of reading those trace events to find this "alignment" info.

So, maybe this is better to have integrated in blktrace tool?

> 
> Thanks,
> John
> 
