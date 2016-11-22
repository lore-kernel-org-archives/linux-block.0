Return-Path: <linux-block-owner@vger.kernel.org>
Received: from latin.grep.be ([46.4.76.168]:57495 "EHLO latin.grep.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754238AbcKVRfY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2016 12:35:24 -0500
Date: Tue, 22 Nov 2016 18:19:11 +0100
From: Wouter Verhelst <w@uter.be>
To: Josef Bacik <jbacik@fb.com>
Cc: axboe@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, alex@alex.org.uk,
        nbd-general@lists.sourceforge.net
Subject: Re: [PATCH][V4] nbd: add multi-connection support
Message-ID: <20161122171911.bvzlhli24lscbqa3@grep.be>
References: <1479414450-7999-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479414450-7999-1-git-send-email-jbacik@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Josef,

[cc to nbd-general added]

On Thu, Nov 17, 2016 at 03:27:30PM -0500, Josef Bacik wrote:
> NBD can become contended on its single connection.  We have to serialize all
> writes and we can only process one read response at a time.  Fix this by
> allowing userspace to provide multiple connections to a single nbd device.  This
> coupled with block-mq drastically increases performance in multi-process cases.
> Thanks,
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
> V3->V4:
> -Fixed a problem where fast completes (or early completes) would crash because
>  we were still accessing the bio's on the submit side.
> -Added a flag to disallow multi-connection support if the server doesn't
>  explicitly allow for them.
[...]
> +		if (num_connections > 1 &&
> +		    !(nbd->flags & NBD_FLAG_CAN_MULTI_CONN)) {
> +			dev_err(disk_to_dev(nbd->disk), "server does not support multiple connections per device.\n");
> +			goto out_err;
> +		}

I'm not sure whether the kernel needs to check this. I agree that the
flag can be useful, but it's probably something for userspace to check,
rather than for the kernel; I could imagine a --force parameter to be
useful in some corner cases.

Having said that, implementing such a parameter could also be done by
artificially adding particular flags, so I'm certainly not opposed to
this.

[...]
> +#define NBD_FLAG_CAN_MULTI_CONN	(1 << 6)	/* Server supports multiple connections per export. */

NAK, that is already specified in the protocol spec at
https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md to be
NBD_FLAG_SEND_WRITE_ZEROES. Bit 7 is also taken already, so please use
bit 8 instead.

(I'll reserve that bit in that document to be "export is multi-conn safe" in a
minute)

-- 
< ron> I mean, the main *practical* problem with C++, is there's like a dozen
       people in the world who think they really understand all of its rules,
       and pretty much all of them are just lying to themselves too.
 -- #debian-devel, OFTC, 2016-02-12
