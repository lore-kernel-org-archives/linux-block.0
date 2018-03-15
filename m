Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:41895 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932395AbeCOP5v (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:57:51 -0400
Date: Thu, 15 Mar 2018 16:57:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/16] bcache: Make csum_set() implementation easier to
        read
Message-ID: <20180315155749.GA20994@lst.de>
References: <20180315150814.9412-1-bart.vanassche@wdc.com> <20180315150814.9412-15-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180315150814.9412-15-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 15, 2018 at 08:08:12AM -0700, Bart Van Assche wrote:
> +#define csum_set(i) ({						\
> +	const void *p = (void *)(i) + sizeof(uint64_t);		\
> +	const void *q = bset_bkey_last(i);			\
> +								\
> +	bch_crc64(p, q - p);					\
> +})

Having this as a macro is really ugly.  Any chane to turn this into a
proper function?
