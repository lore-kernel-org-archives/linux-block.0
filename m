Subject: Re: [PATCH] block: clear all of bi_opf in bio_set_op_attrs
To: Christoph Hellwig <hch@lst.de>
References: <1479741498-12592-1-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@fb.com>
Message-ID: <c09d1382-724e-f101-ea1f-5764234a516a@fb.com>
Date: Mon, 21 Nov 2016 09:35:30 -0700
MIME-Version: 1.0
In-Reply-To: <1479741498-12592-1-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/21/2016 08:18 AM, Christoph Hellwig wrote:
> Since commit 87374179 ("block: add a proper block layer data direction
> encoding") we only or the new op and flags into bi_opf in bio_set_op_attrs
> instead of clearing the old value.  I've not seen any breakage with the
> new behavior, but it seems dangerous.
>
> Also convert it to an inline function to make the argument passing
> safer.

Agree, this is safer. Applied for 4.10.

-- 
Jens Axboe
