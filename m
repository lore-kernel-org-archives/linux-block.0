Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BEAC43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 16:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1C82087F
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 16:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfAGQFB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:05:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34270 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfAGQFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 11:05:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so382635pfg.1
        for <linux-block@vger.kernel.org>; Mon, 07 Jan 2019 08:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uEasHL6SDdz1CHixOMgEWhrUZ0I1xcXoW0K3+9fXe3w=;
        b=eO7B6NtrdhIBzcNwSd/z9JRMh2TBORYQNzVkVSTSE5TODRYXmRlTVAFevdpHmBPZ2s
         IvdEG18wXituxLLuk6W5LA+/VfdrbuqNGO6cHzkvk0A3KOjNX6tn7x11JVOU3ec0L39Y
         WJL0+KQzVxmdaat7AxvHb4CQhxRIPhaAGJaRrL5nZ/aiYo5XoEYutpdV/Ohcw0oaOJbv
         53eExEyE0lf7F90p6RcpyS9Nn6tJzxJ7B15UX+YF1WgreVpf2p3k/6+gI/nWZgQiBiKZ
         6fZ7vE6a3zUBePXysH70xQyX2o2i3zlqfirtZS2T3FFD6s9KNdODzFPRv5W2ByA6H0z+
         vAwQ==
X-Gm-Message-State: AA+aEWYUo1Yr2EMzNb64KYsy4E1Xa/kzovnkKrNEQGp1KhmW4aTdm3+h
        T/Jj0ItI/nLYY9LKQg/XZI10PxcNrN8=
X-Google-Smtp-Source: AFSGD/U2AXuJTuNhdb3yrLF/L8FB8CCyBQNPrPCDUM/GuTYjMfKoGmNEzP3s/3qod5OX7ORogJvFYw==
X-Received: by 2002:a62:644:: with SMTP id 65mr63685046pfg.161.1546877100315;
        Mon, 07 Jan 2019 08:05:00 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id r130sm120455577pfr.48.2019.01.07.08.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 08:04:59 -0800 (PST)
Message-ID: <1546877098.83374.9.camel@acm.org>
Subject: Re: [PATCH] block: don't show io_timeout if driver has no timeout
 handler
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        linux-block@vger.kernel.org
Date:   Mon, 07 Jan 2019 08:04:58 -0800
In-Reply-To: <bdd9b6f8-4358-5d2e-d744-b2a89d6d4c5a@kernel.dk>
References: <20190107125215.GA5039@192.168.3.9>
         <bdd9b6f8-4358-5d2e-d744-b2a89d6d4c5a@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-01-07 at 08:43 -0700, Jens Axboe wrote:
+AD4 On 1/7/19 5:52 AM, Weiping Zhang wrote:
+AD4 +AD4 If the low level driver has no timerout handler, the
+AD4 +AD4 /sys/block/+ADw-disk+AD4-/queue/io+AF8-timeout will not be displayed.
+AD4 
+AD4 The alternative would be to make it return an error when read/written
+AD4 instead of having this separate group code.

Hi Jens,

Christoph and I had asked Weiping to use a sysfs attribute group. See also
https://www.mail-archive.com/linux-block+AEA-vger.kernel.org/msg25841.html

Best regards,

Bart.
