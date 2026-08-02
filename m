Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15F91DFFB
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785690708; cv=none; b=OtXBEqkVlSnEN+CTBNzla6/wv1tLzxdYWkv1OaSMZo1LWfBEmtXX/gdTUGotxh/Bv+RZonvhFl4fFrWfAsoKgTs/ENBEfzK1Y8/P0g4llLOcGc0BJ1T1fy5hTH/pQjJPymlWAceJqYfKSe0SLuuU6p1eeizrEyS3AFisH/yEYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785690708; c=relaxed/simple;
	bh=CMX0EZV2hWQxQLVH/UG8BA3cwwyHuQu0HjpjkTcAGc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIh5YqHhQdnr6ANL1WaH3r3b6I9xWXUNNbpaRpK/KU7jXUeeSeq+7yce/2qZYykn5xzYOugnlRoixju+gDKks0lHL+u3+kerbYr3G8FVbchOpS0UgEBD/uOoIgMEr8Z0gBjl1ZPHBWXvYM8rUqnVW22z2Po1LbuRPozK3KQ+mWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=o7m4ryRm; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="o7m4ryRm"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672CZ6EA3463105
	for <linux-block@vger.kernel.org>; Sun, 2 Aug 2026 13:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Ps1N
	dme4Z8yzxBPud+CccRFlofuGVlEw6M8+5+mc6s0=; b=o7m4ryRmqus5Rv8QbAnz
	4CYHEo8bq++0ujcZR0TaQTFtN6EbhSaYRUfJ0C4hEnh4bwoSX26kFqYmm7DTbUvH
	J/PVLHSsKzVLhstVzG6f3pufL1RgkiYTiDLcZJS/VWDxtd31u13cvhEoAUS4+oJ1
	Y4nZMqAe07k9r1/7cAy8WMTxWTM8Bvcw5dsp9X4JOSlVtGmj2gfME03vJqOYClju
	oEFR2P7CVJhhrWbrzAFLMUiQFrX+/+LxKazfFvATukQ4VmcxHkZ1TtqwYriytu+B
	o5UJ7XCxfxflyFRx+VrwDiwwkDYfGZLRQF+6WmIcOGIoNzceI8mR9FlmMLHwts9r
	KQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fscyp5kwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 02 Aug 2026 13:11:46 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfe3fa93bso24459941cf.2
        for <linux-block@vger.kernel.org>; Sun, 02 Aug 2026 10:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785690705; x=1786295505;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ps1Ndme4Z8yzxBPud+CccRFlofuGVlEw6M8+5+mc6s0=;
        b=nYtxeQE7wUGf5jAJqYNLyBmh4tTvm0aweA7yR+mqvCQ0Nwjel/f7xomfXliBy2zNET
         grXyJeL8nff3OuzIapRbnizwTYCxpN/lTq1oDkudQAn2i3pEdsaBhSDOZtvP0YDYnlwd
         psAqkD/Mu6tqbUMQ8ljZJ7vQqF4kEKBkVQKKLfg7V66J8C0ewRBN8rNqWeHG/YpST9yt
         HqaPc82X/ODJNMguR7t2xXwsJayFNSQHuytZEGRMKPByBT/XPRiLt6O4VyWsH+FLuIJ4
         f5VrXvUy5P8vVEG7u6ZtC3R19wj9U6K7rA0Ucbua2PkSsLtaqef8CRuUWUqbdfdSx6Mo
         Ju0g==
X-Gm-Message-State: AOJu0Yxsi9Wd6K4Iy+J+cltrK91omlYd/0XkGphhay90GeFqSG/Kv6Ls
	mzD/hnDj5gpbl+94iGJvM5372f3YHR3TvjkmbQ+XH/E98+dAplEIgPoiZBYrLb1mOpD2aL9sfk7
	oErQwbriQbXKMoZvFJN+BRZDlAO0O0IDPUAArWkNP5wKR7dKFWbfOP/PbxaYE
X-Gm-Gg: AR+sD11+h1IpTF405C7QE6G8Fe0tvRDyM5ZWQfaIAMj6QZD9DWDKkramrBDHYRkMEyt
	55TeFpUuGiuJesYsf1PjbDYr7HFkw5rxPUIyqqoUxeNHb1jwGjmBjypixaUatUFlAQNRBQ97Lql
	TnmkGFEIQVnkqxo0AxrTAnInttOpmiFY9phV7eUT6PySulQujKLgFiAXFjIYclsW8jR9AlYKvla
	fofBSIZ6jWpUhFUip1vAtDvqXmc1NZJK8cy02N3Hl1CZGEn6nfJWeReXLbVkH0eP12F31fl3NI4
	bKT0YmL2WAxBuI6tze2Vvrpi5msFpI1or82z5iXjl5k6AEHdkRqHt4L0pWl9EUr8vbbkXjm1KcU
	hh68FXt6AWotdsv1S3QGBEwx9Jf0Ckfd+XzJ2jAAxVyK/JQdzwglArKGW
X-Received: by 2002:ac8:6f0a:0:b0:517:8011:3a4b with SMTP id d75a77b69052e-52b5682e629mr147092591cf.21.1785690705032;
        Sun, 02 Aug 2026 10:11:45 -0700 (PDT)
X-Received: by 2002:ac8:6f0a:0:b0:517:8011:3a4b with SMTP id d75a77b69052e-52b5682e629mr147092151cf.21.1785690704534;
        Sun, 02 Aug 2026 10:11:44 -0700 (PDT)
Received: from [10.100.102.30] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b98284sm154307425e9.12.2026.08.02.10.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 10:11:43 -0700 (PDT)
Message-ID: <d30b6c9f-e479-4cca-8dfa-576d7562d2fc@columbia.edu>
Date: Sun, 2 Aug 2026 20:11:41 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: take i_rwsem for the direct I/O write fallback
To: Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260802-blkdev-fixes-v1-0-a82fc549fd74@columbia.edu>
 <20260802-blkdev-fixes-v1-2-a82fc549fd74@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260802-blkdev-fixes-v1-2-a82fc549fd74@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rLcVH5HkgzWOdaBa2hNY-ja1SZZloVKm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1NiBTYWx0ZWRfX6YAWieS3UsE/
 Q25EtMhA7DG0a5MsAWN2UaaDTcIeciWUjRkYcBB6H7ChZ2nkApW6nqqgY4av+Bck0725/BSIggf
 pCf8s0aT5e7UO5nChvs4wM1cu7Xtv+9MNB93xXAu4YIm7K+jh0UY
X-Proofpoint-ORIG-GUID: rLcVH5HkgzWOdaBa2hNY-ja1SZZloVKm
X-Authority-Analysis: v=2.4 cv=LJ9WhpW9 c=1 sm=1 tr=0 ts=6a6f7a52 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=S9fP7Kau7zZPj3qnxsEA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1NiBTYWx0ZWRfX7JkhCRbWlV2Z
 aPRKYtePO3J0SDI8HMHngxyc09d6NaBGbBnkr5M4lq7riq/YRioQSc5YcM4DUTeNOcJoKMoeK1Y
 KAA9MXyrOb4QdQqfQjVNQYmFPT3DiSTQ2Sy4sJTCiiHixxXyxNbLfs2pEuO7S8K+ZqM6CFmiPpD
 YuFM/7PrsLY9U7D9F3NDrbVJEQponJarNdPYOUJzTI8tjKS9K35fS7dt+ifLGHfZJKCIfrElAcr
 uhkcIRARBwZ0vyRFe8ry4wqkZGVY+pKZTjr0W0czL0UqW708UuO+ErKWkaWkFHQLbAovHSB1Pbq
 0ODLJrR+0Eak++MgQjrJHCVSMOuItGbei0r4Uib1hL8z4b/jDowgKeAwtNuZss2dBOFksgQzM+m
 l47+T2GbEmJ+004IcnsW+FaNdf2QYNIfK+UxFnwIiAJWC1rlL+X0rZXZzUZTsQ22K2ukqSOA1Xf
 /A4zZ3dr0q8gwbT1F3g==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 phishscore=0 bulkscore=10 impostorscore=10 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020156

On 8/2/26 7:14 AM, Tal Zussman wrote:
> Commit c0e473a0d226 ("block: fix race between set_blocksize and read
> paths") closed a race between set_blocksize() and block device I/O: with
> large sector size support, set_blocksize() can change i_blkbits and the
> mapping's minimum folio order while a concurrent reader still holds a
> folio of the old, smaller order, leading to crashes. In particular, it
> made blkdev_write_iter() wrap buffered writes in inode_lock_shared().
> 
> However, the direct I/O fallback path was missed in that conversion.
> blkdev_write_iter() passes blkdev_buffered_write() as an argument to
> direct_write_fallback() with no lock held. A direct write that completes
> only partially then finishes as a buffered write with no protection.
> 
> This can cause a BUG by racing partial direct writes against
> ioctl(BLKBSZSET). Writer threads issue O_DIRECT pwritev() with a
> two-segment iovec whose second segment is an unreadable PROT_NONE
> mapping. The direct path then writes the first segment, fails to pin the
> second, and returns short, entering the fallback. A second thread keeps
> toggling the second segment's protection so that some fallbacks get past
> fault_in_iov_iter_readable() and reach the page cache, a third thread
> populates the page cache with folios of the current block size via
> pread() and readahead(), and a fourth thread toggles the block size
> between 512 bytes and 64K with BLKBSZSET. The minimum folio order only
> moves with block sizes above PAGE_SIZE, i.e. with
> CONFIG_TRANSPARENT_HUGEPAGE raising BLK_MAX_BLOCK_SIZE to 64K.
> 
> On a CONFIG_DEBUG_VM kernel this yields the following BUG:
> 
>   page dumped because: VM_BUG_ON_FOLIO(folio_order(folio) < mapping_min_folio_order(mapping))
>   kernel BUG at mm/filemap.c:858!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   RIP: 0010:__filemap_add_folio+0x860/0x8d0
>   Call Trace:
>    filemap_add_folio+0xc9/0x1f0
>    __filemap_get_folio_mpol+0x240/0x660
>    iomap_write_begin+0xa87/0xd70
>    iomap_file_buffered_write+0x304/0x6a0
>    blkdev_write_iter+0x255/0x510
>    do_iter_readv_writev+0x23d/0x3c0
>    vfs_writev+0x211/0x7d0
>    do_pwritev+0x121/0x190
>    do_syscall_64+0x121/0x630
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> The same workload also trips WARN_ON_ONCE(pos >= folio_pos(folio) +
> fsize) in iomap_trim_folio_range().
> 
> Fix this by calling blkdev_buffered_write() in the fallback path under
> inode_lock_shared(), matching the plain buffered-write branch. With the
> fix the same workload runs clean.
> 
> The reproducer used was written by an LLM, and is available at [1].
> 
> [1] https://gist.github.com/tzussman/69d06bc57d42a42989eb038b1b5aeb74
> 
> Fixes: c0e473a0d226 ("block: fix race between set_blocksize and read paths")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260730-blk-dontcache-v7-0-3e8e6850068d%40columbia.edu?part=5
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  block/fops.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 5b938f673d4f..26711cc239d5 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -763,9 +763,14 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  	if (iocb->ki_flags & IOCB_DIRECT) {
>  		ret = blkdev_direct_write(iocb, from);
> -		if (ret >= 0 && iov_iter_count(from))
> -			ret = direct_write_fallback(iocb, from, ret,
> -					blkdev_buffered_write(iocb, from));
> +		if (ret >= 0 && iov_iter_count(from)) {
> +			ssize_t ret2;
> +
> +			inode_lock_shared(bd_inode);
> +			ret2 = blkdev_buffered_write(iocb, from);
> +			inode_unlock_shared(bd_inode);
> +			ret = direct_write_fallback(iocb, from, ret, ret2);
> +		}
>  	} else {
>  		/*
>  		 * Take i_rwsem and invalidate_lock to avoid racing with
> 

I seem to have stumbled into a Sashiko rabbit hole of issues with IOCB_NOWAIT
and IOCB_ATOMIC here... [1].
I'll wait a day or two and send an update along with some additional fixes
I've spotted.

[1] https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2

