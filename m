Return-Path: <SRS0=JZWyce=AT=moysys.com=michael@eigbox.net>
Subject: Re: [PATCH v2] fs: pass the write life time hint to the mapped
 filesystem
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <2f7829a5-d47b-e6a0-cc10-8b534e9772ab@moysys.com>
 <20170918154939.GA13431@lst.de>
From: Michael Moy <michael@moysys.com>
Message-ID: <661c0a72-43c5-53bf-8f8d-4f95283ddc8d@moysys.com>
Date: Mon, 18 Sep 2017 14:06:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170918154939.GA13431@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: Michael Moy <michael@moysys.com>
List-ID: <linux-block@vger.kernel.org>

Thanks, I see that now.

What is the file hint using F_SET_FILE_RW_HINT used for?

It seems that if both are set, the one set first gets used
and, if only the file hint is set, it is not used at all.


On 9/18/2017 9:49 AM, Christoph Hellwig wrote:
> On Mon, Sep 18, 2017 at 09:45:57AM -0600, Michael Moy wrote:
>> The write hint needs to be copied to the mapped filesystem
>> so it can be passed down to the nvme device driver.
>>
>> v2: fix tabs in the email
> If you want the write hint for buffered I/O you need to set it on the
> inode using F_SET_RW_HINT.
>
> With your patch we'd magically move the file hint to the inode hint
> on each write.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
