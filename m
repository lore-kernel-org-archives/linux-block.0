Return-Path: <prvs=3220bc9856=jbacik@fb.com>
Message-ID: <1487257605.16181.0.camel@fb.com>
Subject: Re: [PATCH V2] nbd: ref count the socks array
From: Josef Bacik <jbacik@fb.com>
To: <linux-block@vger.kernel.org>, <kernel-team@fb.com>,
        <nbd-general@lists.sourceforge.net>, <axboe@kernel.dk>
Date: Thu, 16 Feb 2017 10:06:45 -0500
In-Reply-To: <1486566305-10039-1-git-send-email-jbacik@fb.com>
References: <1486505453-2976-1-git-send-email-jbacik@fb.com>
	 <1486566305-10039-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-02-08 at 10:05 -0500, Josef Bacik wrote:
> In preparation for allowing seamless reconnects we need a way to make
> sure that we don't free the socks array out from underneath
> ourselves.
> So a socks_ref counter in order to keep track of who is using the
> socks
> array, and only free it and change num_connections once our reference
> reduces to zero.
> 
> We also need to make sure that somebody calling SET_SOCK isn't coming
> in
> before we're done with our socks array, so add a waitqueue to wait on
> previous users of the socks array before initiating a new socks
> array.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Actually turns out I need to do this slightly differently to deal with
the netlink device addition interface, so I'm just going to drop this
altogether and do it the other way rather than reworking it in another
patch.  Thanks,

Josef
