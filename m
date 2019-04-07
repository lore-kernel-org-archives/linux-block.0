Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98FBC282DA
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 00:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A915520B1F
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 00:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ssNMnh4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfDGAOA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 20:14:00 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37752 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDGAN7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 20:13:59 -0400
Received: by mail-qk1-f194.google.com with SMTP id c1so5991582qkk.4
        for <linux-block@vger.kernel.org>; Sat, 06 Apr 2019 17:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xpLDkw+BUdZ0Aj8067Cc92iF94gR3dOyLGJxS0j9kLY=;
        b=ssNMnh4Ux5zm12pMOJInWXjgczb1a71FwaOwUL5r9ybbVVoubuFUPDUG20DJAenx9t
         ihKq1PkZPTJuGuRbptQS7gu5/NsIAsu81SozFMXxAFgjd75YRPs0PuC2sR0QmzQHzPg0
         g8HEeztXHSAQ2CnTTAkTluPeF0TfrJKRdoFE8SP+7ri8MDHQ6lY+xb8w32Ye30CeoBSo
         OzZ5WotSF7Y0Uyu9z4eBdSCLg3GqrfjH0QfVbeVlDQqGvBmgckJFjqn9iuhdXGhIKNd9
         aiwku8Dlc6vshk/R41UA94Zvubqv0fH9SfvxKo6qG0kJm3EkygzVzrRxa7Z5dD3fhG/6
         ZZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpLDkw+BUdZ0Aj8067Cc92iF94gR3dOyLGJxS0j9kLY=;
        b=D9Bzm4zY13DetuhdoMIkWMm+X+bA/P7+5u+2O9ke+tSvmhpP6UjBr7J/aGP7WFfIiJ
         AceiJo0VATCi8RmJZT3yr7Wuf97WIkeTmcQMbUEXbIQ5K0NUUQxKJPgLwGDhgYQePVDt
         foP7JGehKWojoAx7mXDspDmYjm263v+LQqiFs6h3e6N5pWdiuCqyp/Oyu12B7Dct5hf1
         O1jSMYXMM1T2MVl9pcUgibNm7gNGJ3Pxx7WCM7gWRhu7rJe8AtjsKIF+aEmBQJt4Ir1P
         C9I4lZA7gBv34ivz9N/PPYDZd5s2nxTo28JStnexL3b/sq5gm8J0Ht6pRpoPMWLgnsvu
         ABZg==
X-Gm-Message-State: APjAAAW9qhoaklkMAUsOXI4Qv13pVOugI0LH+0EWiZ0Gj2uBek29tzFy
        DaqgMIZupengEcBl2i+dJL1J+g==
X-Google-Smtp-Source: APXvYqyskA+ifTEpO2ehgVnIwr9CZmubBcIqLpE8D/C1XUG20vKjKG0jSm423CqHZrrP29natDJIOA==
X-Received: by 2002:a37:6814:: with SMTP id d20mr17113928qkc.102.1554596038610;
        Sat, 06 Apr 2019 17:13:58 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f20sm16471992qtk.14.2019.04.06.17.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 17:13:57 -0700 (PDT)
Date:   Sat, 6 Apr 2019 20:13:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Matt Mullins <mmullins@fb.com>
Cc:     hall@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [PATCH bpf-next v2 3/5] nbd: add tracepoints for send/receive
 timing
Message-ID: <20190407001355.4zyulck2z2vggqbi@MacBook-Pro-91.local>
References: <20190405235506.29236-1-mmullins@fb.com>
 <20190405235506.29236-4-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405235506.29236-4-mmullins@fb.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 05, 2019 at 04:55:04PM -0700, Matt Mullins wrote:
> From: Andrew Hall <hall@fb.com>
> 
> This adds four tracepoints to nbd, enabling separate tracing of payload
> and header sending/receipt.
> 
> In the send path for headers that have already been sent, we also
> explicitly initialize the handle so it can be referenced by the later
> tracepoint.
> 
> Signed-off-by: Andrew Hall <hall@fb.com>
> Signed-off-by: Matt Mullins <mmullins@fb.com>
> ---
>  drivers/block/nbd.c        |  8 ++++
>  include/trace/events/nbd.h | 92 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 7393d04d255c..d3d914620f66 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -513,6 +513,10 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
>  	if (sent) {
>  		if (sent >= sizeof(request)) {
>  			skip = sent - sizeof(request);
> +
> +			// initialize handle for tracing purposes
> +			handle = nbd_cmd_handle(cmd);
> +

Don't use c++ style commenting.

>  			goto send_pages;
>  		}
>  		iov_iter_advance(&from, sent);
> @@ -536,6 +540,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
>  		(unsigned long long)blk_rq_pos(req) << 9, blk_rq_bytes(req));
>  	result = sock_xmit(nbd, index, 1, &from,
>  			(type == NBD_CMD_WRITE) ? MSG_MORE : 0, &sent);
> +	trace_nbd_header_sent(req, handle);
>  	if (result <= 0) {
>  		if (was_interrupted(result)) {
>  			/* If we havne't sent anything we can just return BUSY,
> @@ -608,6 +613,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
>  		bio = next;
>  	}
>  out:
> +	trace_nbd_payload_sent(req, handle);
>  	nsock->pending = NULL;
>  	nsock->sent = 0;
>  	return 0;
> @@ -655,6 +661,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>  			tag, req);
>  		return ERR_PTR(-ENOENT);
>  	}
> +	trace_nbd_header_received(req, handle);
>  	cmd = blk_mq_rq_to_pdu(req);
>  
>  	mutex_lock(&cmd->lock);
> @@ -708,6 +715,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>  		}
>  	}
>  out:
> +	trace_nbd_payload_received(req, handle);
>  	mutex_unlock(&cmd->lock);
>  	return ret ? ERR_PTR(ret) : cmd;
>  }
> diff --git a/include/trace/events/nbd.h b/include/trace/events/nbd.h
> index 5928255ed02e..eef476fef95a 100644
> --- a/include/trace/events/nbd.h
> +++ b/include/trace/events/nbd.h
> @@ -7,6 +7,98 @@
>  
>  #include <linux/tracepoint.h>
>  
> +TRACE_EVENT(nbd_header_sent,
> +
> +	TP_PROTO(struct request *req, u64 handle),
> +
> +	TP_ARGS(req, handle),
> +
> +	TP_STRUCT__entry(
> +		__field(struct request *, req)
> +		__field(u64, handle)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->req = req;
> +		__entry->handle = handle;
> +	),
> +
> +	TP_printk(
> +		"nbd header sent: request %p, handle 0x%016llx",
> +		__entry->req,
> +		__entry->handle
> +	)
> +);
> +

These are all the same, use DECLARE_EVENT_CLASS() and then just DEFINE_EVENT()
for each individual event.  Also no pointers, we don't want to leak pointers to
userspace for stuff.  Thanks,

Josef
