Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19D6C433E9
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 14:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8554B64DDB
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 14:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhA1OdM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 09:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbhA1Oc6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 09:32:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA18C0613ED
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:32:18 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id jx18so4406467pjb.5
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 06:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=w1BvBD9kl+2UUEgVz4BMIkzg7Nnk07qwd/DXZcjmSNg=;
        b=zg/HAee2WwyENA4udTKPyTmFZMoNhwiFIp8TPkx+zlfNwhcmfwALmnv8Y8jjLV26+O
         SGW+iW9tGje/6itoQZHWFwmZaKY3gGguptwYIAIh0qzPZZJOCjpI0BhUjjo0I+XopycB
         zZHrgiJmhXIhMTc/8Z/kh09odkd58NHSRGGoxEoNaLq+geLbiSKmfUrvKX+wTCQVXfdi
         dZYxiEzGP7rPGywDEN1hBYSI/Ngrsqda3CrE1E3319VygH0SrEjCzqJDZuCwu4agj2RW
         MG4adBhEgVg93sVFjHMMNQ6789BNIc5OTjbzgJoOybDpiu/Eb7IB0bXq54dru4jO7z37
         dFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w1BvBD9kl+2UUEgVz4BMIkzg7Nnk07qwd/DXZcjmSNg=;
        b=U0WUt14N6z55a9WO+yQU+0ZOhAudPLigv91z+RtiiMPPmO4Qj+0cjzSzobNOJjdDyI
         Qo9JBi00vtPCBFm1FvXOpCE4Lr0lIPjqS82N97CcvDTWI20BOWaYHyuZBKaVcQHfDinU
         zBHylEqVolvex5oAqt8vuvImHSia2CbYbAaaQkYMaZ6UNCHX8s+w8KA7MtK0fO5zBGr8
         SvoOyIgEiyjlzsCo3YyffRDVDgP+JeeTmgWJijFdB0q6KZtrr04j5l7K0HLX49shORuG
         ylZbj7dukK50/1ZHlTkABb4HQlap7UySTUF204MTHlOJYKaKyIRj/UiZ6RMBlGMT/Erz
         VA4A==
X-Gm-Message-State: AOAM530PsN+sZgabG3lZuFHVfhmOMu2rBIOGswLCVocrUUdusy2VrpUL
        1nhUdOfBJR+XG7OeP2jv6h/DUWExawqpbA==
X-Google-Smtp-Source: ABdhPJwA6vUnoOLBL2TBjI8YJ7Ez09E6r12Hrppa7uJbasSz8sxeTZLd/xAFYvsStbC414bXstWFlw==
X-Received: by 2002:a17:902:7d84:b029:db:feae:425e with SMTP id a4-20020a1709027d84b02900dbfeae425emr16486472plm.43.1611844337863;
        Thu, 28 Jan 2021 06:32:17 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id gw20sm5418425pjb.55.2021.01.28.06.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 06:32:17 -0800 (PST)
Subject: Re: [PATCH] block: fix bd_size_lock use
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20210128063619.570177-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0132fd7d-ad9e-968f-28e9-fd7a9b26a365@kernel.dk>
Date:   Thu, 28 Jan 2021 07:32:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128063619.570177-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/21 11:36 PM, Damien Le Moal wrote:
> Some block device drivers, e.g. the skd driver, call set_capacity() with
> IRQ disabled. This results in lockdep ito complain about inconsistent
> lock states ("inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage")
> because set_capacity takes a block device bd_size_lock using the
> functions spin_lock() and spin_unlock(). Ensure a consistent locking
> state by replacing these calls with spin_lock_irqsave() and
> spin_lock_irqrestore(). The same applies to bdev_set_nr_sectors().
> With this fix, all lockdep complaints are resolved.

Applied, thanks.

-- 
Jens Axboe

