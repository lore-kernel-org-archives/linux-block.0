Return-Path: <joe@perches.com>
Message-ID: <56ee8810463b6c537ca0c10c9f82e6d922acd1f1.camel@perches.com>
Subject: Re: [PATCH] block drivers/block: Use octal not symbolic permissions
From: Joe Perches <joe@perches.com>
To: Jens Axboe <axboe@kernel.dk>, "Ed L. Cashin" <ed.cashin@acm.org>,
 Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg
 <lars.ellenberg@linbit.com>, Jiri Kosina <jikos@kernel.org>, Josef Bacik
 <josef@toxicpanda.com>,  linux-block@vger.kernel.org, Ilya Dryomov
 <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder
 <elder@kernel.org>, Philip Kelleher <pjk1939@linux.vnet.ibm.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Roger Pau =?ISO-8859-1?Q?Monn=E9?=
 <roger.pau@citrix.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
	nbd@other.debian.org, ceph-devel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org
Date: Wed, 23 May 2018 15:35:31 -0700
In-Reply-To: <6bf44255-145f-bf14-e254-860731ff9296@kernel.dk>
References: 
	<5e97a292c1ba38a6b5a0caa271d85dc3de1b2aa7.1527105857.git.joe@perches.com>
	 <6bf44255-145f-bf14-e254-860731ff9296@kernel.dk>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-05-23 at 15:27 -0600, Jens Axboe wrote:
> On 5/23/18 2:05 PM, Joe Perches wrote:
> > Convert the S_<FOO> symbolic permissions to their octal equivalents as
> > using octal and not symbolic permissions is preferred by many as more
> > readable.
> > 
> > see: https://lkml.org/lkml/2016/8/2/1945
> > 
> > Done with automated conversion via:
> > $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
> > 
> > Miscellanea:
> > 
> > o Wrapped modified multi-line calls to a single line where appropriate
> > o Realign modified multi-line calls to open parenthesis
> 
> Honestly, I see this as pretty needless churn.

btw:

There is currently a mixture of symbolic and octal
permissions uses in block and drivers/block

ie: 94 octal and 146 symbolic uses.

If this is applied, all would become octal.
