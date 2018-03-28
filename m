Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 28 Mar 2018 09:44:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, hch@lst.de, rdorr@microsoft.com
Subject: Re: [PATCH 2/3] iomap: iomap_dio_rw() handles all sync writes
Message-ID: <20180328074411.GD18726@lst.de>
References: <20180327070717.7107-1-david@fromorbit.com> <20180327070717.7107-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180327070717.7107-3-david@fromorbit.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

> +#define IOMAP_DIO_WRITE_SYNC	(1 << 29)

Actually based on the next patch can we rename this to something like:
IOMAP_DIO_NEED_SYNC?  That makes the usage a little more clear.
