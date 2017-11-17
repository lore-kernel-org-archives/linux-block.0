Return-Path: <jaegeuk@kernel.org>
Date: Fri, 17 Nov 2017 10:36:54 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, Chao Yu <yuchao0@huawei.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] apply write hints to select the type of segments
Message-ID: <20171117183654.GA77642@jaegeuk-macbookpro.roam.corp.google.com>
References: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com>
 <20171117172349.GA22843@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171117172349.GA22843@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On 11/17, Christoph Hellwig wrote:
> 
> Next time please coordinate this with the block list and Jens, who
> actually wrote the patch.

Got it.

> 
> >   hints                     segment type
> >   -----                     ------------
> >   WRITE_LIFE_SHORT          CURSEG_COLD_DATA
> >   WRITE_LIFE_EXTREME        CURSEG_HOT_DATA
> >   others                    CURSEG_WARM_DATA
> 
> Normally cold data is data with a long lifetime, and extreme is colder
> than cold, so there seems to be some mismatch here.

It was wrong description and I fixed it which matches to implementation.

The below description was merged:

WRITE_LIFE_SHORT          CURSEG_HOT_DATA
WRITE_LIFE_EXTREME        CURSEG_COLD_DATA
others                    CURSEG_WARM_DATA
