Return-Path: <linux-block-owner@vger.kernel.org>
Received: from silver.sucs.swan.ac.uk ([137.44.10.1]:57465 "EHLO
	silver.sucs.swan.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbcFOV0T (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Wed, 15 Jun 2016 17:26:19 -0400
Date: Wed, 15 Jun 2016 22:26:17 +0100
From: Sitsofe Wheeler <sitsofe@gmail.com>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	axboe@fb.com, snitzer@redhat.com, martin.petersen@oracle.com,
	hch@infradead.org, Kernel-team@fb.com,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V2] block: correctly fallback for zeroout
Message-ID: <20160615212617.GB5410@sucs.org>
References: <20160606223357.GA52883@shli-mbp.local>
 <20160607045049.GA10921@sucs.org>
 <20160607145824.GA84027@shli-mbp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160607145824.GA84027@shli-mbp.local>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jun 07, 2016 at 07:58:25AM -0700, Shaohua Li wrote:
>
> I didn't follow. io_err is only and always set when ret == 0. io_err is
> meanless if ret != 0, because that means the disk doesn't support discard and
> we don't dispatch discard IO. why should we initialized io_err to 0?

My mistake - I confused what !ret would mean.

Unfortunately the V2 patch no longer cleanly applies to the latest
kernel (db06d759d6cf903aeda8c107fd3abd366dd80200 ) so I can't easily
test it there.

-- 
Sitsofe | http://sucs.org/~sits/
