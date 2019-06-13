Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB2FC31E45
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4FD20851
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BdbquzIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbfFMPw7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:52:59 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:44026 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbfFMJFX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 05:05:23 -0400
Received: by mail-yw1-f66.google.com with SMTP id t2so8030906ywe.10
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=x0ZzQ6zhddjbYtlhBEnDE4FbpV9FV7QJBpYmxLzCeeM=;
        b=BdbquzIhYlkCjY/DsJF5VGOzC2GRNcuDIbtUXf2lL2RAz05KCkZK4nfASGaHHAX26S
         /On+v6WsYO08iSAz+WyOc6iGNg64ycRw+WfuwOtWnjFeOLiQa83sUl55Onhe6wQOIdfa
         LMZ4eNBrDZYnF+xs6o7cQ+ZAxyMOD6WIHVVBzv0uA9VMQILclhdUs8sbdsfV+ORnTFSr
         DFZF7rayRAB1kLT8f0Nuhkw+l1WpzlFC0drR1nBYc5n5XwI7l3N4L8Ggi+68GG4gsv+w
         sLnXB8P4hxbtbI1+0vg3aGDcdzOe9n5aYH/Fn25EyuXmA+7DUKVYLnwpygjoHGjnJofM
         AwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x0ZzQ6zhddjbYtlhBEnDE4FbpV9FV7QJBpYmxLzCeeM=;
        b=DzLBsnyCGy0HMG4X9wDntzLDIR36SCv6Vbe+YQse8e0Smjlm9jQrdVbxyTgQNry+Vf
         tHFMJFGfLK1r2MJm3Vf9vPh8jUtPKSuxrkhTvdGFMLPpfoLU+ckv4Kmmbx7L16U+x+sr
         96qsGlX/SkEB9BBJBOwhhtpcf0fT9Q9L5mhIx8vnzRCrfo7DtxVaa9A54O8VnmMoLxfE
         W8avTbEhzTOgpitzuqoc6wZcPdUMhnVRhqIbtzonGW7T/+FQJhjrnuTGb6kgnik2Xs/2
         rPgL2FRbfpeEj84ny33npBXzziCSg8j83iEY9Yl3qmcN6XRP0IaByVLdEhGj9qBJ1hes
         C8dw==
X-Gm-Message-State: APjAAAWlMVu9piPY79U7Yviti6jG9Gl11vRql7Ia9hchhrY7vEiXu7Yg
        LIYp614CB0khLxPv0aVWu0shcMFkYW+vUtuf
X-Google-Smtp-Source: APXvYqzYIqEHyVaIjZDwa1QLPHn2zYliGmku+obNDc5sQA2RVcflpeczj1rcF6On3zHlcc3ALq6scA==
X-Received: by 2002:a0d:f247:: with SMTP id b68mr44480862ywf.156.1560416721941;
        Thu, 13 Jun 2019 02:05:21 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-221.mycingular.net. [166.172.57.221])
        by smtp.gmail.com with ESMTPSA id k84sm591944ywk.74.2019.06.13.02.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 02:05:21 -0700 (PDT)
Subject: Re: [PATCH liburing] example/io_uring-test.c: Fix iovecs increment
To:     Stephen Bates <sbates@raithlin.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <5C501554-CE72-443C-88B1-FED5AC810554@raithlin.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <44807f8c-224e-cebc-f913-1e3de96e2631@kernel.dk>
Date:   Thu, 13 Jun 2019 03:05:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5C501554-CE72-443C-88B1-FED5AC810554@raithlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/11/19 7:37 AM, Stephen  Bates wrote:
> This example misses an increment though the iovecs array. This causes
> the same buffer to be filled from the block device every time. It would
> be good to fix this since it is one of the first examples a new-comer to
> io_uring is exposed too.

I hand applied this patch, it's coming through as encoded. But fix looks
good, thanks.

-- 
Jens Axboe

