Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7748ECAAD5
	for <linux-block@archiver.kernel.org>; Mon,  5 Sep 2022 17:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiIERzC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Sep 2022 13:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIERzB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2022 13:55:01 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C401C1704B
        for <linux-block@vger.kernel.org>; Mon,  5 Sep 2022 10:55:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f24so9112780plr.1
        for <linux-block@vger.kernel.org>; Mon, 05 Sep 2022 10:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oMGczNNDnvQjhMlzadltZhTx6kCLg0d3lQU+dzOdk00=;
        b=4f9VNE3QHhF74oirW3Xm5YT6Z5IFvSEj5gD4lTkrK0JXgOO4NfEbFcAc72k53/HTaF
         fPwqjITi649PlkD/DLc4ugJ0PyZICzECgstdw6ebg6KFL5zsgIS/TSU2Mv+33EuqtxhC
         f/LPzzyOFrwxaDSyWh/5lT3HT1V79THSAK7q8wVBO1toQqAQX8YFvVlAtx4XwJzCz1fZ
         xhusl4SaN65Eh5REORD4JV7k4hPZV/TqBS9W5cX5I1UX9oPHDbgAs762CMF6CJl4qmVq
         4/nXPNvT/BJdYNteIDkb+1nQnPRoPeSUUDvgwubbbnhz4DrvZUJjITgH69FOFSUdmJ7y
         Hg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oMGczNNDnvQjhMlzadltZhTx6kCLg0d3lQU+dzOdk00=;
        b=ej8WJg3DCovkAihZ81T3epZHAHFR/1hyU9aje7gOaiByuF7lL8jYMOOiTlrl8SDRyC
         Rv3NT7WBkzXhzuuDsMacITFE1jXEp8DjytSM+NoUKM5wFelDiKhnZ/I3pCg/pb32Nl+g
         Vgo6xgYer4F4Rf2OLz7Ii+ukd9VBNzq30oQUbW2V1fs4kp32iqOghZH2IdWIUiaMXo+A
         3Yopj7HMxMkocApZl73ukkL2HgcyKoKJarNlK8G4ls4bFd3bFt7nTFJ5QsJg61pxdilU
         5n/yqBeo1ETg9t7CNj4I+hS+VE6Plzs+qWy9U4KttNptr7zgQPcXiWxHEidCa8zhJ1vq
         p/EA==
X-Gm-Message-State: ACgBeo3OqsaMYxfX03YxYowaNo+yvywbPQMK1O+8ktFVgXTKYxx3R089
        RlsRUPftYM8EvJZwjZvexF6A/w==
X-Google-Smtp-Source: AA6agR4Zfo2wzIoy/4ELYjXlw/YqjBdzzZVMytXGu7EWjMtl/52eaJQiyCI2flPR9ixZ0xD3T5PV6Q==
X-Received: by 2002:a17:902:bb8c:b0:172:74c9:62bd with SMTP id m12-20020a170902bb8c00b0017274c962bdmr50297464pls.87.1662400500263;
        Mon, 05 Sep 2022 10:55:00 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id o7-20020a656a47000000b004308422060csm6524186pgu.69.2022.09.05.10.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 10:54:59 -0700 (PDT)
Message-ID: <34abf867-93e7-c168-f5ec-289c72a020c5@kernel.dk>
Date:   Mon, 5 Sep 2022 11:54:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v4 2/4] io_uring: introduce fixed buffer support
 for io_uring_cmd
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>
References: <20220905134833.6387-1-joshi.k@samsung.com>
 <CGME20220905135848epcas5p445275a3af56a26a036878fe8a8bcb55f@epcas5p4.samsung.com>
 <20220905134833.6387-3-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220905134833.6387-3-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/22 7:48 AM, Kanchan Joshi wrote:
> @@ -76,8 +77,21 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>  {
>  	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
>  
> -	if (sqe->rw_flags || sqe->__pad1)
> +	if (sqe->__pad1)
>  		return -EINVAL;
> +
> +	ioucmd->flags = READ_ONCE(sqe->uring_cmd_flags);
> +	req->buf_index = READ_ONCE(sqe->buf_index);
> +	if (ioucmd->flags & IORING_URING_CMD_FIXED) {
> +		struct io_ring_ctx *ctx = req->ctx;
> +		u16 index;
> +
> +		if (unlikely(req->buf_index >= ctx->nr_user_bufs))
> +			return -EFAULT;
> +		index = array_index_nospec(req->buf_index, ctx->nr_user_bufs);
> +		req->imu = ctx->user_bufs[index];
> +		io_req_set_rsrc_node(req, ctx, 0);
> +	}

Should that buf_index read and assignment be inside the
IORING_URING_CMD_FIXED section?

-- 
Jens Axboe
