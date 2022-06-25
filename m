Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7CAC43334
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 03:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiFYDDe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 23:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiFYDDQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 23:03:16 -0400
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691148BECE
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 20:01:45 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id d129so4005063pgc.9
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 20:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z6y6/ZCQ+ksS9b9b8UAUb95S31pw8DPxb8F0Pz9Y3nk=;
        b=S4oRkbAA+mV0GayFd6JgyBFkFdgTIy+JpIBzdVi8hjGX2SwkR6yILeuz2lt22eGfl1
         sqokcwUvmXylOJbGMfjJ5j4W4NSNP1i5EysZZcxC2lw6UsMl/f8XD3UAHvHFuoMsbvt5
         a1/5jmq7QgM8PKAhzq8G/+I83yAV3K+KWBiSzHxuhSpEwOuxvofXD9NxbQG+7yMz+uSC
         wjtdXrWHyrjmt3U7u6jmh8NEVBBRF8RCU0Uib3vuNGU4IAzNVzfzgjV2HOg3jPhueDfW
         t3RJGD2/m1Osz6nSHyas/t5XnImb0Kf1RrEiB4rV+8bGsRNhEYryrNhLhRY8x8N9y+hN
         tCdA==
X-Gm-Message-State: AJIora+VzziyU2CEsBJ1jYwhziS+NtyNKuDTavcTmm/bppX8FqyWHWzf
        v4BEDtKvFo5zbsdP/nASoNg=
X-Google-Smtp-Source: AGRyM1t8Q1jHHHOyjppGS6Z9NpmGExH0TjuR05Z868f3okVSA6cc+FjKz9qDDqgbaYuFiwzqNfVYMQ==
X-Received: by 2002:a05:6a00:230c:b0:525:59f3:cbea with SMTP id h12-20020a056a00230c00b0052559f3cbeamr2370711pfh.11.1656126071065;
        Fri, 24 Jun 2022 20:01:11 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78649000000b0052531985e3esm2461362pfo.22.2022.06.24.20.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 20:01:10 -0700 (PDT)
Message-ID: <76660249-026a-7acd-3eb0-32703779f6d5@acm.org>
Date:   Fri, 24 Jun 2022 20:01:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 4/6] block: remove the extra gendisk reference in
 __blk_mq_register_dev
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220624052510.3996673-1-hch@lst.de>
 <20220624052510.3996673-5-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624052510.3996673-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 22:25, Christoph Hellwig wrote:
> kobject_add already grabs a reference to the parent, no need to have
> another one.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
