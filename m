Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C7EC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C172184D
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="agp9X8GO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfCTUUB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:20:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46446 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfCTUUB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 16:20:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so2470585pfj.13
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 13:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MJlS70bfAWl/TOjxSvrrx+kgfuN9Gjbfih+DInapuUs=;
        b=agp9X8GOK5psCjnvgMx/aFNKd9xtNrwUJwBQ04GC3TKP2GMJeyud6WQtMStl1gaoED
         SSTWsYYG45v+uXV2mw0hf/jzzoaYMkZkx3IZe843m7jsDLeBmXVD6KKZAmZVcIbf4wRK
         1g/tjKhNrYb6IPamaHZl2H6fseqUKxvCvjWohka4Y39IozNyMSsf3zG0udbqXe14ILnS
         Po5OZyUB84SXxhDWPrIyFzYN3q/KBhw9xFRyFzEi6a88aAxqCe9NqK6BWbZxJ5RorD6Q
         10IrmxRKl0Jaf0SnjMpe6cu9+st6o2WHW6MZ0KOKT1j3eHHY67pQhGJPEfNwIQ4/hXY0
         mL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MJlS70bfAWl/TOjxSvrrx+kgfuN9Gjbfih+DInapuUs=;
        b=Q5vLSpQ+98OHvXw6ujHY1WIuBKlNgqG44e/cdHiYPDUg/bKPm6GPR05+9A6nfVdVjL
         MoeSnM6ASNqgjAc0iTlSGAlqAOOMwxMXi20NfH5gHNiyuQ5YkskBii/koRQy2GfdFSFh
         E2LKgg7AG70zXD84tKV7o3OUSRKwBfygZnqEPy+WBcD6Y59f0QLUvLW+z1T3urEU4dg1
         6dUK2WARn7CfcRmjZz5A1PUGN5STDn7cSfllWmvqQAgY697cSetTxScf0qHGyW0Phsq/
         X6fYA1q+IozTk2ssNUIjHUjgeowkC+RpGMoAXgcfn9WT82peWywYSuyZ0HuBR5mjXIgK
         hAEg==
X-Gm-Message-State: APjAAAW/meps8DKUWXe/MHxgfJzCoPLZRRv4nAY+v6ngm+jbH2BcOcn9
        VuPw/UeqoWxKQ2uYbOeZtzruew==
X-Google-Smtp-Source: APXvYqzW9lDNq5dcMB1kDlClGqRPK0BNzHLw9/N/ZDbtFbbIwEw+R8AA7Nbi/KcuIt7/bqqm31Eb3Q==
X-Received: by 2002:a62:b415:: with SMTP id h21mr9497606pfn.26.1553113200892;
        Wed, 20 Mar 2019 13:20:00 -0700 (PDT)
Received: from [10.155.59.239] (96-86-215-89-static.hfc.comcastbusiness.net. [96.86.215.89])
        by smtp.gmail.com with ESMTPSA id m69sm6320479pfi.151.2019.03.20.13.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:20:00 -0700 (PDT)
Subject: Re: [PATCH] block: Unexport blk_mq_add_to_requeue_list()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
References: <20190320201437.36672-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <212768a0-0f62-c01b-0ec1-e7d238cc6db1@kernel.dk>
Date:   Wed, 20 Mar 2019 14:19:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190320201437.36672-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/20/19 2:14 PM, Bart Van Assche wrote:
> This function is not used outside the block layer core. Hence unexport it.

Applied, thanks.

-- 
Jens Axboe

