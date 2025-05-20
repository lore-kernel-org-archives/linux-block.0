Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8825CC73;
	Tue, 20 May 2025 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747723593; cv=none; b=Ouo6nox9216eIFv1sGrLD6tvlNyC0kt83RgD/kJcXo8Rq4oO02Zls5CtFVUEsG/nxy8u219NdpSWZ9xt3I9UdWNBS6N+TaQHHl9FMcvbRIZrR5szahUxElZ6sJLJ7Z/1lkeWR4ocHxcZTuyqBbpDif59lpn3AtsYgmt7dD94x2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747723593; c=relaxed/simple;
	bh=JudMT2w5US/bJZIkaIQyESZDTMRoAmGcIF484L1EfsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jhk3ygOZSGCyhevFUwiNwvzkgRWdkXFah5C/eBjwHnhsBrqKUWTWsNVohvskUAjWT4Up19mBsJfg1DrkaN+C8XAWl9UmUEFgjqNLgIvxG1q4TTWIUIaflJ/9Zc0IAt317JT2EKS3fdxxi+qOMnKMcW3Lbj9C2ESu+9ofbDkYK/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZoqpEu0N; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZoqpEu0N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4Wj1nUOpZrmLk3DO5jbnDDX0+abXELMKQGPcACkmB7g=; b=ZoqpEu0N7IQ/n9C2qzg/gY4i2I
	B9eahAZgGMuzjp91zfTx48v5xqSsVMZABILktFU427pvn9OgofUoo7Ma+7b2imwYRjnSZ4Tty6LPW
	4cmydzv14hoDe1QRJ4VPAxgOq7zoLfhDeB20nDUFRoLn0MoIEvhVRZsvL2DSrdEkdyMI9dyGlOfHl
	b2CKpMafpzVwfneJdX2GoHyOMjITfMWCnHVTo4PORN+EThJykezkE65Iz8p4ACIhbIW46C7GcuHvH
	0uF7XeD8oiTqI+EAHLLMAtu3JDUV5ixDyphps9NP46iXUdCZe5aZYc8hmM71kXeBi+BCVyt0LQ6Cr
	+WFpdMRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHGk8-0000000BlIa-1Djs;
	Tue, 20 May 2025 06:46:28 +0000
Date: Mon, 19 May 2025 23:46:28 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: "Xu, Lizhi" <Lizhi.Xu@windriver.com>
Cc: Christian Hesse <mail@eworm.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"christian@heusel.eu" <christian@heusel.eu>,
	"hch@infradead.org" <hch@infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com" <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH V5] loop: Add sanity
 check for read/write_iter
Message-ID: <aCwlRMEuvvP31UGG@infradead.org>
References: <20250519175640.2fcac001@leda.eworm.net>
 <20250520030051.177205-1-lizhi.xu@windriver.com>
 <20250520073901.6fdfbee4@leda.eworm.net>
 <BL1PR11MB5979C666DA3BC228C2C30E92869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5979C666DA3BC228C2C30E92869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 20, 2025 at 06:29:48AM +0000, Xu, Lizhi wrote:
> I figured out your steps to reproduce, and yes, this problem will occur if you do losetup with a file in a filesystem that does not support read_iter, which is what this patch does.

isofs does support read_iter, without that it would not have worked
before either. That is not the problem.  It must be related to
the FMODE_WRITE check - i.e. we have a writable FD here, but a file
system that does not actually supports writes.  Which honestly feels
weird, but we'll have to figure it out to unbreak these setups.

