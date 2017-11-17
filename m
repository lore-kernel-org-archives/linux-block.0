Return-Path: <BATV+9773502028072e7eb68b+5199+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 17 Nov 2017 09:23:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] apply write hints to select the type of segments
Message-ID: <20171117172349.GA22843@infradead.org>
References: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com>
List-ID: <linux-block@vger.kernel.org>


Next time please coordinate this with the block list and Jens, who
actually wrote the patch.

>   hints                     segment type
>   -----                     ------------
>   WRITE_LIFE_SHORT          CURSEG_COLD_DATA
>   WRITE_LIFE_EXTREME        CURSEG_HOT_DATA
>   others                    CURSEG_WARM_DATA

Normally cold data is data with a long lifetime, and extreme is colder
than cold, so there seems to be some mismatch here.
