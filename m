Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 12 Apr 2017 01:14:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 13/25] mtd: Convert to dynamically allocated bdi
 infrastructure
Message-ID: <20170412081406.GM9830@infradead.org>
References: <20170329105623.18241-1-jack@suse.cz>
 <20170329105623.18241-14-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170329105623.18241-14-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

> +	sb->s_bdi = bdi_get(mtd_bdi);
> +	sb->s_iflags |= SB_I_DYNBDI;

FTI, while I think this is a faithful conversion of the existing code,
the single bdi for all MTD devices looks rather bogus to me..

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
