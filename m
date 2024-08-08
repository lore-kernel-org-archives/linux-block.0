Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F71D554
	for <linux-block@vger.kernel.org>; Thu,  8 Aug 2024 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158252; cv=none; b=OKO3kYfG5Nnj1GqwkPfRSD6DKgvbyu5q9aZVLFBPOLDosCFD2VhCEYwPAcMzwBo8HmeFgrZYU3py4kFfpmyjQy2zfMbEPOy66CJeyi29ZSyno+lEbbMAkiuee+ouLNi4+EQbpfN990DrpBZAmQ1Nuz0yIeTdUyF28Nb9cwxSKoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158252; c=relaxed/simple;
	bh=SvHZf/C0tDGAUqgkrjBcxne6PiF7buBIIGKzZRPr0JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vh+3UNk3mAnQcP/GdB4pqletpaH1U8Pcvdnb9Nx+o+yt3ZEqUM5Wjjq/NCOn1n3lc/rm2zXpnrf8dl/IuJjOzMKTjp3py8jUVosbTTRYZ3K7wjaWnzibwqJVCb41Rya00f91b2Fg0esW1iu1W/MW6XmB3Dsax1G108aYH/aNVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QImrcImS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QImrcImS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PkaypJxHIExuieGjiWVM2I2C08w1opLrrrOI0ovrnyc=; b=QImrcImSdFqksIR6LD9pVFLcEB
	IVwGVze8l2mkkLsV7lgOij2KRqI6pJinhqOc3dHnFGvudDgyagySgr9gB3G7ql/ir7ritwTLxNbkE
	HuokL306SBnhbiNFI5YdiTxJALtc617ppvZDx9HVwGfxHVd910AtBDGUXX1yPBrhXXZp1QjcaTrpq
	t0eyD0ThISWY4vr+UfMtKdVC6XaiXzFSLSIbd4VGJeil3uAQTkgPNYPW2KXh2dpAssihl7HDoFa7L
	VYEHIjNiHU/+6s1z04gTyt4vTg9Y0uvJLiV/DlZi282yGCBlhJQq6dTeRRKAr748StCu62iANQI8R
	pyEwtt5g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scCAu-00000009gBL-0Br6;
	Thu, 08 Aug 2024 23:04:04 +0000
Date: Thu, 8 Aug 2024 16:04:03 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, kernel@pankajraghav.com
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v8 0/5] block: add larger order folio instead of pages
Message-ID: <ZrVO45fvpn4uVmFH@bombadil.infradead.org>
References: <CGME20240711051521epcas5p348f2cd84a1a80577754929143255352b@epcas5p3.samsung.com>
 <20240711050750.17792-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711050750.17792-1-kundan.kumar@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Jul 11, 2024 at 10:37:45AM +0530, Kundan Kumar wrote:
> User space memory is mapped in kernel in form of pages array. These pages
> are iterated and added to BIO. In process, pages are also checked for
> contiguity and merged.
> 
> When mTHP is enabled the pages generally belong to larger order folio. This
> patch series enables adding large folio to bio. It fetches folio for
> page in the page array. The page might start from an offset in the folio
> which could be multiples of PAGE_SIZE. Subsequent pages in page array
> might belong to same folio. Using the length of folio, folio_offset and
> remaining size, determine length in folio which can be added to the bio.
> Check if pages are contiguous and belong to same folio. If yes then skip
> further processing for the contiguous pages.
> 
> This complete scheme reduces the overhead of iterating through pages.
> 
> perf diff before and after this change(with mTHP enabled):
> 
> Perf diff for write I/O with 128K block size:
>     1.24%     -0.20%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
>     1.71%             [kernel.kallsyms]  [k] bvec_try_merge_page
> Perf diff for read I/O with 128K block size:
>     4.03%     -1.59%  [kernel.kallsyms]  [k] bio_iov_iter_get_pages
>     5.14%             [kernel.kallsyms]  [k] bvec_try_merge_page

This is not just about mTHP uses though, this can also affect buffered IO and
direct IO patterns as well and this needs to be considered and tested as well.

I've given this a spin on top of of the LBS patches [0] and used the LBS
patches as a baseline. The good news is I see a considerable amount of
larger IOs for buffered IO and direct IO, however for buffered IO there
is an increase on unalignenment to the target filesystem block size and
that can affect performance.

You can test this with Daniel Gomez's blkalgn tool for IO introspection:

wget https://raw.githubusercontent.com/dkruces/bcc/lbs/tools/blkalgn.py
mv blkalgn.py /usr/local/bin/
apt-get install python3-bpfcc

And so let's try to make things "bad" by forcing a million of small 4k files
on a 64k block size fileystem, we see an increase in alignment by a
factor of about 2133:

fio -name=1k-files-per-thread --nrfiles=1000 -direct=0 -bs=512 \
	-ioengine=io_uring --group_reporting=1 \
	--alloc-size=2097152 --filesize=4KiB --readwrite=randwrite \
	--fallocate=none --numjobs=1000 --create_on_open=1 --directory=$DIR

# Force any pending IO from the page cache
umount /xfs-64k/

You can use blkalgn with something like this:

The left hand side are order, so for example we see only six 4k IOs
aligned to 4k with the baseline of just LBS on top of next-20240723.
However with these patches that increases to 11 4k IOs, but 23,468 IOs
are aligned to 4k.

mkfs.xfs -f -b size=64k /dev/nvme0n1
blkalgn -d nvme0n1 --ops Write --json-output 64k-next-20240723.json

# Hit CTRL-C after you umount above.

cat 64k-next-20240723.json
{
    "Block size": {
        "13": 1,
        "12": 6,
        "18": 244899,
        "16": 5236751,
        "17": 13088
    },
    "Algn size": {
        "18": 244899,
        "12": 6,
        "17": 9793,
        "13": 1,
        "16": 5240047
    }
}

And with this series say 64k-next-20240723-block-folios.json

{
    "Block size": {
        "16": 1018244,
        "9": 7,
        "17": 507163,
        "13": 16,
        "10": 4,
        "15": 51671,
        "12": 11,
        "14": 43,
        "11": 5
    },
    "Algn size": {
        "15": 6651,
        "16": 1018244,
        "13": 17620,
        "12": 23468,
        "17": 507163,
        "14": 4018
    }
}

When using direct IO, since applications typically do the right thing,
I see only improvements. And so this needs a bit more testing and
evaluation for impact on alignment for buffered IO.

[0] https://github.com/linux-kdevops/linux/tree/large-block-folio-for-next

  Luis
