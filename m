Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E6DC6379F
	for <linux-block@archiver.kernel.org>; Sat, 11 Feb 2023 17:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBKRNl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Feb 2023 12:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBKRNk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Feb 2023 12:13:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381C1BDB
        for <linux-block@vger.kernel.org>; Sat, 11 Feb 2023 09:13:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id be8so9686283plb.7
        for <linux-block@vger.kernel.org>; Sat, 11 Feb 2023 09:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676135619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/4oDiUV4pEpw2exK7b92/tNXC0d/VoaubyD3eCGRAw=;
        b=CdlUsmcf9T8lc6YJCVpYkVjK+fxvTNh0AyyzxdlMuPLRc7rQR+OyPRTjPw8f9ZfVKD
         7dJwBlTIibNnMUXo52zwVNYwEoOwmNg/k7F6SXEk3nUdL6OG8ye0BXjO77/qsbMpU90z
         TJNN92VYCd9ADIEpMm1hfrvGbR2r0kNh94+GO0t/8VrhitFdWo+yxt53R460DfNHv5mD
         tNjMd5XdlbmIYfvh1aOUFPLxcrbruUxvlfvh61JlMJ/2UvQGB0u4FHsfFYS9SkfLiGSg
         /DERSnKywxV5+LnQ9kbQbyDffjt5FkizE2wcRFDXLPLmmRZgAG3LSsr+q91DdD09Rgai
         xI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676135619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/4oDiUV4pEpw2exK7b92/tNXC0d/VoaubyD3eCGRAw=;
        b=0CDGwsOkVfmBM4z+t7bh3f9Wlu7BNsfWWr7K5Eo+vMAqo38BuNXPZfiv3cmgGaMQd/
         LKTxWVdmwtwlwuNjwnsNOQlrEJ+/+qP+ooEqhr9MJRVN3IcVKKYcOk8Flofb2M83zz2V
         suZPfaOXT2Q96LbJDYhXR17zHtpc0FuniaCxMfwWmjcAHMB0M7Z1J8fCvApTGeO6HIYZ
         wgUurSnx35kSdj/XQrXfPZ6l+Pr50ngm3ACDWIMX9j4G4TECn2KLkB+fqbRZ89jvj3Id
         q+FJFZaXaufrdxe9LN9W/+fqbAruj2c/zw2L73/XMD+5yU9wX0hBow1yBZh5ofNEIBQ/
         RpvQ==
X-Gm-Message-State: AO0yUKXqukEUs/RmvsZAttRcS1GisLsAlTXjSUQpE7FOxKYZ7Yw8yi7D
        PG1TR5909UsU2MVocE1YnZRweA==
X-Google-Smtp-Source: AK7set+YNTkWJk9Lmdb4OTLCXCa5YKs46dJ7jgznn/TRFbVfb0VjRKwRsgPh+pCS7DOF566PQnsgvA==
X-Received: by 2002:a17:903:32d1:b0:19a:9269:7d1 with SMTP id i17-20020a17090332d100b0019a926907d1mr825898plr.4.1676135618935;
        Sat, 11 Feb 2023 09:13:38 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jn14-20020a170903050e00b00199025284b3sm5213418plb.151.2023.02.11.09.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 09:13:38 -0800 (PST)
Message-ID: <7323fbef-4790-3975-9c43-7ba4b7809c33@kernel.dk>
Date:   Sat, 11 Feb 2023 10:13:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/4] io_uring: add IORING_OP_READ[WRITE]_SPLICE_BUF
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Christoph Hellwig <hch@lst.de>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
References: <20230210153212.733006-1-ming.lei@redhat.com>
 <20230210153212.733006-4-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230210153212.733006-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/23 8:32?AM, Ming Lei wrote:

One more comment on this.

> +static int __io_prep_rw_splice_buf(struct io_kiocb *req,
> +				   struct io_rw_splice_buf_data *data,
> +				   struct file *splice_f,
> +				   size_t len,
> +				   loff_t splice_off)
> +{
> +	unsigned flags = req->opcode == IORING_OP_READ_SPLICE_BUF ?
> +			SPLICE_F_KERN_FOR_READ : SPLICE_F_KERN_FOR_WRITE;
> +	struct splice_desc sd = {
> +		.total_len = len,
> +		.flags = flags | SPLICE_F_NONBLOCK | SPLICE_F_KERN_NEED_CONFIRM,
> +		.pos = splice_off,
> +		.u.data = data,
> +		.ignore_sig = true,
> +	};
> +
> +	return splice_direct_to_actor(splice_f, &sd,
> +			io_splice_buf_direct_actor);

Is this safe? We end up using current->splice_pipe here, which should be
fine as long as things are left in a sane state after every operation.
Which they should be, just like a syscall would. Just wanted to make
sure you've considered that part.

-- 
Jens Axboe

