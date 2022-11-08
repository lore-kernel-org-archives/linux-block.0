Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C2EC43217
	for <linux-block@archiver.kernel.org>; Tue,  8 Nov 2022 06:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiKHGxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 01:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiKHGxJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 01:53:09 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A917826AFD
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 22:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667890388; x=1699426388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sv0QBQ1Lup403ZEcu5Wbmvvjk9t3dp5Iv1Wpqcr247o=;
  b=ASmbWLffeoyD+wxyYxVw8oXuEki7PTf9sgiZksTLg0qV5ZShM/Xaq5Hl
   gVQ2cN/irk6P7fUwKojgMCeLqjZkiqYcoSs8cptmn/Q2PpU5IE0WlcYAE
   K4fIsvVBHrBGHmZxwEkdncO1pwUGHaHw0NsqrGgGUbDlKatVDiqxKlm6D
   6E02yZ5nOwkB2q0qirGfLpKty283Ca7kd90W32BieLbanJpcEp2IXnCgN
   wDjz5b67Pqwweu23Zo8SCg36vGqLHz9MdvSR0fii7qa+qRC9BTw1K7RGL
   r3GHcCllWIQpjyLKgbfKKuzAwswAU0EZAVYdx1nf91kaCDOpYseTwmmst
   A==;
X-IronPort-AV: E=Sophos;i="5.96,147,1665417600"; 
   d="scan'208";a="215735484"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 14:53:08 +0800
IronPort-SDR: J1SEXehh1GGZBuVE4+S+nRx7m+zJMEddx2SRH7BCUJ2sNmt74jhr3b0tW8RLtRpui1bjTPc3xL
 WTJf4iorN+24Z2DLFUDEcOkGfNtvi/wX/dkphPiq/DVsNZAFrxODyNwXAR4nW9HNyLf3ptIf3G
 I4LsAMLrEFxMU16WhJuFQQJTZYufizYYGu6xihkbRpu4RRtXwhwBp+b/UIG9LpjZBVcmsi5CUQ
 Jq/a/2VTlBjGgYZgOF0ZgLyfUkW//zc6krIxpTSqaLpHX32HnUX4+wEzND6GaGrqHcu0vBn5D9
 Vco=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:12:14 -0800
IronPort-SDR: KIHmSQEnOThn3advEsqMRYfCU9fzPZ97F1y2W4L2Y+2EODQJ/guMBwY0L59kskdc+uJn1siwyA
 8LoxQ/R7kGLLFqziKbG1JcRkXTWhnuIWRHPzHuBqpZvL91e6fJioCyAPqXcEDma4Yjefu/bBhO
 ehNXA5f5mmWVAHj0SbzE2DsxaKyvuIOvsNnylWtDdT3a2J7x3XTpH13zepEzjhcNjVPlCE8SJL
 U7kbI2hYvbWf/rics0mgFA1SwAHWDKAXom7SyES4kYJojtXb7+At4X5pIEoZXv8u/SmZxswL5i
 NJY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 22:53:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5zM76KBcz1RwtC
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 22:53:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667890387; x=1670482388; bh=Sv0QBQ1Lup403ZEcu5Wbmvvjk9t3dp5Iv1W
        pqcr247o=; b=k/nF+1thWCzx6NFBRwnbAnXdNzjvqFYp5cL0G8gyV57L2MVERBn
        BL2thCZgT1/nmpTudgMQAkuD9/0TI5nM9gxz2mAvz4/sAsLaemQo+QdOoHeBnFLS
        CuzidcGsIPuJSm3hyV6sj8Wr2p/kz9+VnnwdFOHvatUeoLKJq6yOCrn5aQgbv2uN
        nB5nKmp5Q/EG9HQmCzjmSpar/7ZEQzSBmCQxuuMOURidULWvSobarTNY/W3p3cHS
        CtJi6pmtEmB9USTTW91ljx/dNUuV60jyzgrjd/xtJlpCKzMztFn4PvY3w+5l72Ai
        D37xqBrzy0mtcRHvpUaMQ6OlvOqmbaMcbGw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mlc6JgBSy6z1 for <linux-block@vger.kernel.org>;
        Mon,  7 Nov 2022 22:53:07 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5zM61LJFz1RvLy;
        Mon,  7 Nov 2022 22:53:05 -0800 (PST)
Message-ID: <eec0b872-898e-e2a9-e93b-ad8b50766326@opensource.wdc.com>
Date:   Tue, 8 Nov 2022 15:53:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 1/2] virtio-blk: use a helper to handle request queuing
 errors
Content-Language: en-US
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org
References: <20221108040718.2785649-1-dmitry.fomichev@wdc.com>
 <20221108040718.2785649-2-dmitry.fomichev@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221108040718.2785649-2-dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/8/22 13:07, Dmitry Fomichev wrote:
> Define a new helper function, virtblk_fail_to_queue(), to
> clean up the error handling code in virtio_queue_rq().
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/virtio_blk.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 19da5defd734..3efe3da5f8c2 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -315,6 +315,19 @@ static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>  		virtqueue_notify(vq->vq);
>  }
>  
> +static blk_status_t virtblk_fail_to_queue(struct request *req, int rc)
> +{
> +	virtblk_cleanup_cmd(req);
> +	switch (rc) {
> +	case -ENOSPC:
> +		return BLK_STS_DEV_RESOURCE;
> +	case -ENOMEM:
> +		return BLK_STS_RESOURCE;
> +	default:
> +		return BLK_STS_IOERR;
> +	}
> +}
> +
>  static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
>  					struct virtio_blk *vblk,
>  					struct request *req,
> @@ -327,10 +340,8 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
>  		return status;
>  
>  	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
> -	if (unlikely(vbr->sg_table.nents < 0)) {
> -		virtblk_cleanup_cmd(req);
> -		return BLK_STS_RESOURCE;
> -	}
> +	if (unlikely(vbr->sg_table.nents < 0))
> +		return virtblk_fail_to_queue(req, -ENOMEM);
>  
>  	blk_mq_start_request(req);
>  
> @@ -364,15 +375,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  			blk_mq_stop_hw_queue(hctx);
>  		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>  		virtblk_unmap_data(req, vbr);
> -		virtblk_cleanup_cmd(req);
> -		switch (err) {
> -		case -ENOSPC:
> -			return BLK_STS_DEV_RESOURCE;
> -		case -ENOMEM:
> -			return BLK_STS_RESOURCE;
> -		default:
> -			return BLK_STS_IOERR;
> -		}
> +		return virtblk_fail_to_queue(req, err);
>  	}
>  
>  	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))

-- 
Damien Le Moal
Western Digital Research

