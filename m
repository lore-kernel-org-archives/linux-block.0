Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbdIFNqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 09:46:08 -0400
Date: Wed, 6 Sep 2017 06:46:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: mb@lightnvm.io, axboe@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <matias@cnexlabs.com>
Subject: Re: [PATCH 01/18] lightnvm: pblk: improve naming for internal req.
Message-ID: <20170906134607.GC3960@infradead.org>
References: <1504695071-25928-1-git-send-email-javier@cnexlabs.com>
 <1504695071-25928-2-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504695071-25928-2-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> -#define ERASE 2 /* READ = 0, WRITE = 1 */
> +/* READ = 0, WRITE (user) = 1 */
> +#define ERASE 2
> +#define WRITE_INT 3 /* Internal write. Not through write buffer */

enum {
	PBLK_READ,
	PBLK_WRITE,
	PBLK_ERASE,
	PBLK_WRITE,
};

please.  Don't abuse and overload the messy READ/WRITE macros in any
new code.
