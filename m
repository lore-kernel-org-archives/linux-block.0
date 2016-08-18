Return-Path: <sergey.senozhatsky.work@gmail.com>
Return-Path: <sergey.senozhatsky.work@gmail.com>
Date: Thu, 18 Aug 2016 11:36:33 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Fam Zheng <famz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-block@vger.kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	Paul Mackerras <paulus@samba.org>, linux-mtd@lists.infradead.org,
	"Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	virtualization@lists.linux-foundation.org,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Nitin Gupta <ngupta@vflare.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 15/15] block: Add FIXME comment to handle device_add_disk
 error
Message-ID: <20160818023633.GC500@swordfish>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
 <1471418115-3654-16-git-send-email-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471418115-3654-16-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On (08/17/16 15:15), Fam Zheng wrote:
[..]
>   (
>     rc = device_add_disk(e1, e2, e3);
>   |
>   + /* FIXME: handle error. */
>     device_add_disk(e1, e2, e3);

or use __must_check for device_add_disk() function?
/* which is _attribute__((warn_unused_result)) */

	-ss
