Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372AEC3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1378620857
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 13:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgDTNe3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:34:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34151 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgDTNe3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 09:34:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so3962348plm.1;
        Mon, 20 Apr 2020 06:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mjNECG0zUa98mbEEuBkvWe9Ieqz2VZ6WDWMOSc+uoj4=;
        b=cqb/jFzBB1HQjTjaDPfE54d2LTUwpv6zu1eiGOpPV3gpBkhmot6VlnvHC6h7oqgTVO
         /EEjuSDUXViO2ld35IUV8ekjaczxsnrsaMPWamq/l3bqJfzRzymXjJ67+y6zgwVTuoSI
         GODCG8C81hlooGU/KfU0mVQ5FVC2saaN7Qb4h4yXlUbbLGq3PkmkSUepLto7HQuTIS41
         /lwp49flMfl1YAokHBhKp0JS2CC2l/722VpR8ND54gvkTRTZOP8L3AUtUNOAEqOvnuUZ
         uZT/0uI/ab4EsR/lSlnkFsK6IcWtumoEzXJzBB/xjVfbW9ATmIf0oTQRdFEkHNf85RB5
         +LKA==
X-Gm-Message-State: AGi0PuYUVhQXB3rNRD6r+M4QNyFlYQ0xhVDqss/nyIjTdPYxhDdogk2H
        8FazRCmZME1OLlPO4nmWIge4Gg2XYrU=
X-Google-Smtp-Source: APiQypLiTjAOOTMhMi73MBfvJzkDDzdD3K1JRvqWj1zfyAfnK4efY8DeenczBbc5+l2iDJffGN4tmg==
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr21327906pjb.143.1587389668077;
        Mon, 20 Apr 2020 06:34:28 -0700 (PDT)
Received: from [100.124.9.192] ([104.129.199.10])
        by smtp.gmail.com with ESMTPSA id c1sm1127223pfc.94.2020.04.20.06.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 06:34:26 -0700 (PDT)
Subject: Re: [PATCH 2/4] loop: Factor out configuring loop from status.
To:     Martijn Coenen <maco@android.com>, axboe@kernel.dk, hch@lst.de,
        ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, Chaitanya.Kulkarni@wdc.com
References: <20200420080409.111693-1-maco@android.com>
 <20200420080409.111693-3-maco@android.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <50090c2e-d882-507f-43a7-5ed76c36390c@acm.org>
Date:   Mon, 20 Apr 2020 06:34:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200420080409.111693-3-maco@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/20 1:04 AM, Martijn Coenen wrote:

No trailing dot at the end of a patch subject please.

>   static int
> -loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
> +loop_set_from_status(struct loop_device *lo, const struct loop_info64 *info)
>   {
>   	int err;
>   	struct loop_func_table *xfer;
>   	kuid_t uid = current_uid();
> +
> +	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
> +		return -EINVAL;
> +
> +	err = loop_release_xfer(lo);
> +	if (err)
> +		return err;
> +
> +	if (info->lo_encrypt_type) {
> +		unsigned int type = info->lo_encrypt_type;
> +
> +		if (type >= MAX_LO_CRYPT)
> +			return -EINVAL;
> +		xfer = xfer_funcs[type];
> +		if (xfer == NULL)
> +			return -EINVAL;
> +	} else
> +		xfer = NULL;
> +
> +	err = loop_init_xfer(lo, xfer, info);
> +	if (err)
> +		return err;
> +
> +	lo->lo_offset = info->lo_offset;
> +	lo->lo_sizelimit = info->lo_sizelimit;
> +	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
> +	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
> +	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
> +	lo->lo_crypt_name[LO_NAME_SIZE-1] = 0;
> +
> +	if (!xfer)
> +		xfer = &none_funcs;
> +	lo->transfer = xfer->transfer;
> +	lo->ioctl = xfer->ioctl;
> +
> +	if ((lo->lo_flags & LO_FLAGS_AUTOCLEAR) !=
> +	     (info->lo_flags & LO_FLAGS_AUTOCLEAR))
> +		lo->lo_flags ^= LO_FLAGS_AUTOCLEAR;
> +
> +	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
> +	lo->lo_init[0] = info->lo_init[0];
> +	lo->lo_init[1] = info->lo_init[1];
> +	if (info->lo_encrypt_key_size) {
> +		memcpy(lo->lo_encrypt_key, info->lo_encrypt_key,
> +		       info->lo_encrypt_key_size);
> +		lo->lo_key_owner = uid;
> +	}
> +
> +	return 0;
> +}

Please add a (one line?) comment above this function that explains the 
purpose of this function. Is the purpose of this function perhaps to 
initialize loop device parameters based on the information received from 
user space (the 'info' argument)?

Thanks,

Bart.
