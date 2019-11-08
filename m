Return-Path: <SRS0=T+5Q=ZA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F36C5DF60
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 14:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA8A21D6C
	for <linux-block@archiver.kernel.org>; Fri,  8 Nov 2019 14:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gpk3+ULf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfKHOA1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:00:27 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33855 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfKHOA1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Nov 2019 09:00:27 -0500
Received: by mail-io1-f65.google.com with SMTP id q83so6472757iod.1
        for <linux-block@vger.kernel.org>; Fri, 08 Nov 2019 06:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KEuhZ33eIV/glmtuQ5poEJOSDRMIrF2oY+6h0/MtVAA=;
        b=gpk3+ULfInJYqzl3rYrWaDELsYsXgwdFE3j2+S5035oR+iomWsv37XKBYxg2OVPjK7
         iVxokJY3RG4KNjq2TTDO8iw5zli1Iatg4K+3h5rDh5MzMLVyg/VsRi8sXAS2FDQL5k6b
         cDG5ISCHTJsk+ToRMhF4UgfoqwCBtq/BwUEhEh4v3vNM4YuavV4iueYUJDKbs4tGG+8n
         Jt8n2Kp6aMr0T3S0byde05KiMIoBuSC+9eqS0EwE6gEN1XcgX1UHgCh4UHuS24Dl2QXI
         RB8HyptKgwlP5XPYNS46S4sfXwb8cquxN9e7pvW7S52+AnLHn4o7BJpsRLhaix4PEuzw
         Vxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KEuhZ33eIV/glmtuQ5poEJOSDRMIrF2oY+6h0/MtVAA=;
        b=JdM7NeBSAP4r66YqBTfK+VsrHOB7mutn4MQ2G0ZnzwWhh8iStk5S9QvTBCp7+/8phv
         s2M7hwWbwl83QapgAzTFYGEdupGH4I0JVRNeAhICboKgFEVeOEtsmDD7d6s7elh7ouU6
         Wb7U9WR8voetGYQXg3MYNtSelsGJHm8RXPm+y88NIF2tAPGcGXVicQ/n4AYzHvBLgbFv
         TSKaDUN1GSXT+3ZdbI+GYnQhuC7MXrUzubxn6xwoRpNa0/SIeL1BHRdnLEXAgdewEFF4
         L7/H2yDYKoAVFU+ORnOusTHIPwDeVWWWhbxak/4Dx7U37bcFb9jaTMBp3y/iNebbZ3R1
         Sqbw==
X-Gm-Message-State: APjAAAXFvjBA/0hoCyltPqIEMTPH7ZiNWf+1DNMpYsfXSTandMrxyhel
        em8+fzCaKMm9weY8NNhSMYiYzpzJLz8=
X-Google-Smtp-Source: APXvYqwob9FkYol+7aGgOb3rQGHbggXEkkQstkcSHbqJ62kEtBHRkoLcW6tA9NvcG1QWWcPsD34Z1w==
X-Received: by 2002:a6b:f415:: with SMTP id i21mr1853377iog.109.1573221625819;
        Fri, 08 Nov 2019 06:00:25 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c5sm461109ioc.26.2019.11.08.06.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 06:00:24 -0800 (PST)
Subject: Re: [PATCH 0/2] block: two fixes on avoiding bio splitting
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20191108101528.31735-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f313803-95ab-632b-aaf1-6957ca58aabc@kernel.dk>
Date:   Fri, 8 Nov 2019 07:00:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108101528.31735-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/8/19 3:15 AM, Ming Lei wrote:
> Hi,
> 
> The 1st patch fixes kernel panic issue which is caused by not
> splitting bio.
> 
> The 2nd patch requets to change the limit as SZ_4K instead of
> PAGE_SIZE which can be big enough to break some devies.

Both changes make sense to me, applied, thanks.

-- 
Jens Axboe

