Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097BC3205
	for <linux-block@vger.kernel.org>; Fri,  8 Mar 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709915563; cv=none; b=lRWsoENRgNUrdak1n822LUPLmFGpBi3ZM3SW0UjnmmlOwVpxDYHNwSquEYLkL5qWrqiJWVkXZuBQt28Ce9BMIE9/TTKufGl73wnj3UMX+8siRZIvl2Su909grZ7P01jlSFjSVRgWmhiA10UYtna17USUKrEb5u2NIjkfc6JEXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709915563; c=relaxed/simple;
	bh=gd6Sxjdr57kFNJdJzGgYm5a/F1ma0tRWs1BpE8XvNMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBGdcfvy1qkLSeJ95qUE4tomU9lBEXptHwxWxAZmYq+4Y28UU1EVfABg8jyf/kDVd/KOvQbRIXB8vIJODWl37JmcmqXR3Lsuixogmh9qqyo4aH9qSXxjV86viqXmVSPAydhNcXZ4brIOjYrb+SQ76GYMnMQGfEw8E2e6yGcJC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5767268BEB; Fri,  8 Mar 2024 17:32:38 +0100 (CET)
Date: Fri, 8 Mar 2024 17:32:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Saranya Muruganandam <saranyamohan@google.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	sashal@kernel.org, Ming Lei <ming.lei@redhat.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: regression on BLKRRPART ioctl for EIO
Message-ID: <20240308163237.GA17159@lst.de>
References: <CAP9s-SrvNZROseNkpSL-p-qsO0RT6H+81xX4gg-TV71gQ_UbYA@mail.gmail.com> <20240212154411.GA28927@lst.de> <CAP9s-Sr3_GVYBv-XObPRC9L27jJoQqX40d8g3gysEmy6VdQS1Q@mail.gmail.com> <CAP9s-So3NkfexGOQ2ogt5duaCevbWXb3wJf_zyB2F+eotBmg6w@mail.gmail.com> <CAP9s-Sp+H8rBUyAURpKOu9ZuiU_GRTmqc+ksoiJx_xHdfFHqig@mail.gmail.com> <27bff287-049d-5bbb-2392-fd5f099bed3c@huaweicloud.com> <CAP9s-SrXvm5MfhXCMBYfsEv9xKWqvkkLp2ZjndYrJ65m5x8M_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP9s-SrXvm5MfhXCMBYfsEv9xKWqvkkLp2ZjndYrJ65m5x8M_w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 07, 2024 at 10:14:05AM -0800, Saranya Muruganandam wrote:
> > I think we can fix this by returning error from bdev_get_whole() if
> > bdev_disk_changed() failed, this will cause that open disk to fail now,
> > however, I think this can be acceptable.
> 
> Thanks for the response!
> I agree this would fix the regression for the ioctl.
> However, since returning an error from blkdev_get_whole is new
> behavior, I wasn't sure what all parts it affects.
> 
> So this is just a ping to let you know that I am also waiting to hear
> from Christoph.

I'd hate returning a failure and changing the interface, but I haven't
come up with anything better yet.  Let me thing about this a bit more.
