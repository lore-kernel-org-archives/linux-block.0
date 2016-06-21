Return-Path: <mchristi@redhat.com>
Subject: Re: [PATCH 3/3] block: shrink bio size again
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
References: <1465829315-23137-1-git-send-email-hch@lst.de>
 <1465829315-23137-4-git-send-email-hch@lst.de>
Cc: linux-block@vger.kernel.org
From: Mike Christie <mchristi@redhat.com>
Message-ID: <19114e2d-a827-2a15-f56e-2e787d0e5599@redhat.com>
Date: Mon, 20 Jun 2016 19:35:06 -0500
MIME-Version: 1.0
In-Reply-To: <1465829315-23137-4-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 06/13/2016 09:48 AM, Christoph Hellwig wrote:
> The recent ops split grew the bio by adding the new ioprio field.
> Shrink it again by using a 16-bit field for the bi_flags value and
> filling the holes near the beginning of the structure.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Christie <mchristi@redhat.com>
