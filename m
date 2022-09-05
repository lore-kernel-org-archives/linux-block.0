Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81EEC6FA83
	for <linux-block@archiver.kernel.org>; Mon,  5 Sep 2022 17:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiIERzg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Sep 2022 13:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiIERxo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2022 13:53:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED0C5F132
        for <linux-block@vger.kernel.org>; Mon,  5 Sep 2022 10:53:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so9194630pji.1
        for <linux-block@vger.kernel.org>; Mon, 05 Sep 2022 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zeGc0vwJDgBIJyeNrQDrz976x5n1fo0aH2VcrMu6kPU=;
        b=3TzLFPJsgQVoyzIEgelyj96PTJ9RA2qoPFKMvnvgNEGKK3Xg7EfO0JMiwAXt32iElf
         vfYSQMKS+7btTv0zYBL+JqK4B164T+u6A4q65qijRqZyjFwAkIJp873GODXmEqUbmCCl
         a4PU+gLa9IJVBoluV1WyE8I2Zq7+YUslviqLsKLMihwruNHwSorxpHp+7VzMqUYi3TBx
         YFyW7ALBsYtKGUQT/cNuSBySGtF5RFshRyz4JQlfcDDqnfeOdKj2rIW3G6/Iq+Iicinq
         dqOHLOCjuAfw7X/gYLQhSZJIUxQsokZNds8p706H8863+sWLzEVugxnU1gj8eVaU8mZ3
         4+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zeGc0vwJDgBIJyeNrQDrz976x5n1fo0aH2VcrMu6kPU=;
        b=PCimA0WaXL9qCfDnleJspOi+CPKetgDZQ8LJIf1qMNpGso9GgISXdYF5yhDmLUiNDP
         hK59GazTEiUfwPi/0dITGRJtjYLdHLcLEUVb4R51VDmV6gdSoJND+IRE8aKN3X4PXhO3
         RJd3sXQleaGjuEc7bKYKqyuKD/SLRtT3j21CG4AcxQ2yaEqeJJNQr6+PG3aiaUe6Rh70
         x4Bd/HmimyZ664Td6mz4yuhQtvKg5B8pG8cY1NEKm1e3hcZZdcYqT/26Ffm9M9QOLOW7
         NuqJkUkFzR3UvVRv0ssnZSG3B/cVlhYGRQdYkFiIlhgvme4yezPpQ3dxkvMlTG4N4Q/e
         4mrQ==
X-Gm-Message-State: ACgBeo3HqJ3WXyvAHYibOM7kJVMYd8M8JDs4KUFJXaaYWAmeViRdGfac
        9sxX+2dzeD7FA40So+rfy6YM4w==
X-Google-Smtp-Source: AA6agR7DiMNf6wfT4ZoG5rsHUmL/ehmUhw+ETrtpWSzJRoiOawk/VgiGVH9Vb1lT8IaVGei10sbUSg==
X-Received: by 2002:a17:902:e848:b0:176:c746:1f69 with SMTP id t8-20020a170902e84800b00176c7461f69mr1501581plg.125.1662400422716;
        Mon, 05 Sep 2022 10:53:42 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u67-20020a626046000000b00537e1b30793sm8331899pfb.11.2022.09.05.10.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 10:53:42 -0700 (PDT)
Message-ID: <5a0f98a5-8710-0719-91e6-e75af1818b1b@kernel.dk>
Date:   Mon, 5 Sep 2022 11:53:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH for-next v4 1/4] io_uring: introduce
 io_uring_cmd_import_fixed
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>
References: <20220905134833.6387-1-joshi.k@samsung.com>
 <CGME20220905135846epcas5p4fde0fc96442adc3cf11319375ba2596b@epcas5p4.samsung.com>
 <20220905134833.6387-2-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220905134833.6387-2-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/22 7:48 AM, Kanchan Joshi wrote:
> @@ -124,3 +125,13 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
>  
>  	return IOU_ISSUE_SKIP_COMPLETE;
>  }
> +
> +int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len,
> +		int rw, struct iov_iter *iter, void *ioucmd)
> +{
> +	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
> +	struct io_mapped_ubuf *imu = req->imu;
> +
> +	return io_import_fixed(rw, iter, imu, ubuf, len);
> +}
> +EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);

Oh, and since we're probably respinning this one anyway, I'd do:

int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
			      struct iov_iter *iter, void *ioucmd)
{
	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);

	return io_import_fixed(rw, iter, req->imu, ubuf, len);
}
EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);

to both fix the indentation and get rid of the 'imu' variable that isn't
really necessary.

-- 
Jens Axboe
