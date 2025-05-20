Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546133DB;
	Tue, 20 May 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747745348; cv=none; b=UN2pTGRQIlR3xkv1mm8zU0DZw9Q/g0BkdN/7eHqeQ4mU1vVPj0Xz8ES5bPrUickUNoXpCyeGWThoRgKilL6gPxpSMer7iQSFy6kQ8w58RlMRPtIlJYHgKGtyza0IgC/sXDVm7ScMupkZniiSdbQZ3jMlOj60BgPEn25Je20xKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747745348; c=relaxed/simple;
	bh=VQDBPsLHY5vAHOV1GkrJDlyT52faK4qOTdtZdzevHZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsQeryA8SiMHrvtnJlPdMCR/j9x4A3QqKuva6UpQoyzvbJ4u73vqakqD3c/NRZxcNqPHOZabMMxE7XLEa0q55YxRUdtaR8ceaCbm4BHiCJTxSs6riSldfxD9yPkEarEpZnNaWgmH0G1HITgxWoe/o72+RrcBgs/hj2wTTCeQiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HSUqXjjM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HSUqXjjM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=P/0zir/vsEVLVFIUZqEN6yVH2hjFdaaLa5O0ROOOJRU=; b=HSUqXjjMvQapq4ljJ7UwCziGzC
	mVsg30aTt63aEJjFaRtac6Vv02AYJDhI2KD1IYZJtVUbAllhQfpdEM4HyFNBAC/JFwCMwVKk2ooaX
	hDqMCjaysxFuU9s+yWxL4MSXZEKstImr4XTxrFmGCQw1Ve85V2R+Qo7mXdCgXsQvFRUUH8Pp4JUx0
	mNk20kqp0eu/I50Pem/84cIz/bxjLyM/bdl6mfqIATt2hW1e3pXDuRR4ft4Wnlr4og1A6irIPXjmn
	xR7dv3njIVHwNW3RxQue+cqFyMZa4x7jha6fVh/aR2ZMQVKSpm6UHXj2fgSnlWm9PqJEMvuychdaC
	zE5MLDDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHMP2-0000000CvEB-1o86;
	Tue, 20 May 2025 12:49:04 +0000
Date: Tue, 20 May 2025 05:49:04 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Christian Hesse <mail@eworm.de>
Cc: "Xu, Lizhi" <Lizhi.Xu@windriver.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"christian@heusel.eu" <christian@heusel.eu>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>,
	"syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com" <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V5] loop: Add sanity check for read/write_iter
Message-ID: <aCx6QFZ1kiyB9ec0@infradead.org>
References: <20250519175640.2fcac001@leda.eworm.net>
 <20250520030051.177205-1-lizhi.xu@windriver.com>
 <20250520073901.6fdfbee4@leda.eworm.net>
 <BL1PR11MB5979C666DA3BC228C2C30E92869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
 <aCwlRMEuvvP31UGG@infradead.org>
 <BL1PR11MB5979EFA72DA54AB231D408CF869FA@BL1PR11MB5979.namprd11.prod.outlook.com>
 <20250520144622.3fd9592a@leda.eworm.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520144622.3fd9592a@leda.eworm.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 20, 2025 at 02:46:22PM +0200, Christian Hesse wrote:
> "Xu, Lizhi" <Lizhi.Xu@windriver.com> on Tue, 2025/05/20 12:27:
> > If it is a regular file, generic_ro_fops is used. In this case,
> > isofs supports read_iter. When a regular file has a writable attribute,
> 
> Just tested with an iso file where writable flag from loopback file inside
> was explicitly removed. No change.
> 
> > the problem will recur because isofs does not support write_iter.
> 
> We have two indications here that setup should happen in read-only mode:
> 
> * The underlaying filesystem is read-only
> * `losetup` is called with switch `--read-only`
> 
> I would expect both to make this happy.

Can you test this patch?

We historically allow a writable fd on block devices even when they
are read-only.  I suspect your use case is doing that and the new
check for write_iter is interfering with that:


diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b8ba7de08753..e2b1f377f585 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -979,9 +979,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (!file)
 		return -EBADF;
 
-	if ((mode & BLK_OPEN_WRITE) && !file->f_op->write_iter)
-		return -EINVAL;
-
 	error = loop_check_backing_file(file);
 	if (error)
 		return error;
