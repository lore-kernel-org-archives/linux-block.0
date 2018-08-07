Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] target/loop: depend on SCSI
To: Christoph Hellwig <hch@lst.de>
Cc: rdunlap@infradead.org, keescook@chromium.org,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180807074222.22972-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c9f333a5-0dbc-ea44-6a8f-546216c85ff9@kernel.dk>
Date: Tue, 7 Aug 2018 07:57:59 -0600
MIME-Version: 1.0
In-Reply-To: <20180807074222.22972-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/7/18 1:42 AM, Christoph Hellwig wrote:
> The target loopback driver is a low-level driver for the SCSI subsystem,
> and as such needs to depend on it.

Applied, thanks.

-- 
Jens Axboe
