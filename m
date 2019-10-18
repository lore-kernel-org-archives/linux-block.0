Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA971CA9EA1
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 08:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FAD222C5
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 08:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393215AbfJRIBV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:01:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395397AbfJRIBU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 04:01:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46C6A69084;
        Fri, 18 Oct 2019 08:01:20 +0000 (UTC)
Received: from localhost (unknown [10.36.118.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FBCE1001DF0;
        Fri, 18 Oct 2019 08:01:19 +0000 (UTC)
Date:   Fri, 18 Oct 2019 09:01:18 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     nbd@other.debian.org, ebiggers@kernel.org, axboe@kernel.dk,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com
Subject: Re: [PATCH] nbd: verify socket is supported during setup
Message-ID: <20191018080118.GE3888@redhat.com>
References: <20191017212734.10778-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017212734.10778-1-mchristi@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 18 Oct 2019 08:01:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 17, 2019 at 04:27:34PM -0500, Mike Christie wrote:
> nbd requires socket families to support the shutdown method so the nbd
> recv workqueue can be woken up from its sock_recvmsg call. If the socket
> does not support the callout we will leave recv works running or get hangs
> later when the device or module is removed.
> 
> This adds a check during socket connection/reconnection to make sure the
> socket being passed in supports the needed callout.
> 
> Reported-by: syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com
> Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
> Signed-off-by: Mike Christie <mchristi@redhat.com>

I tested this patch to try to make sure it doesn't break typical
existing use cases of the kernel NBD client using Unix and TCP
servers.  I used a Fedora 30 virtual machine, nbdkit-1.12.8-1.fc30,
and the upstream kernel + your patch for testing.  I tested it using
loop-style commands similar to what I did in this talk[1] using
commands from the nbdkit manual[2].

Note I did *not* test the negative case, eg. NBD over a netlink
socket, as I have no easy way to test that.

Anyway, I can confirm that both Unix domain sockets and TCP to
localhost works fine with this patch, so:

Tested-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

[1] https://archive.fosdem.org/2019/schedule/event/nbdkit/
[2] http://libguestfs.org/nbdkit-loop.1.html

> ---
>  drivers/block/nbd.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 478aa86fc1f2..7bd9e92f6bb7 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -972,6 +972,25 @@ static blk_status_t nbd_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	return ret;
>  }
>  
> +static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
> +				     int *err)
> +{
> +	struct socket *sock;
> +
> +	*err = 0;
> +	sock = sockfd_lookup(fd, err);
> +	if (!sock)
> +		return NULL;
> +
> +	if (sock->ops->shutdown == sock_no_shutdown) {
> +		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
> +		*err = -EINVAL;
> +		return NULL;
> +	}
> +
> +	return sock;
> +}
> +
>  static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>  			  bool netlink)
>  {
> @@ -981,7 +1000,7 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
>  	struct nbd_sock *nsock;
>  	int err;
>  
> -	sock = sockfd_lookup(arg, &err);
> +	sock = nbd_get_socket(nbd, arg, &err);
>  	if (!sock)
>  		return err;
>  
> @@ -1033,7 +1052,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
>  	int i;
>  	int err;
>  
> -	sock = sockfd_lookup(arg, &err);
> +	sock = nbd_get_socket(nbd, arg, &err);
>  	if (!sock)
>  		return err;
>  
> -- 
> 2.20.1

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
