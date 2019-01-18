Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2A1C43444
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 04:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE392087E
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 04:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Hs8xxZVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfAREWB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:22:01 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:43292 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfAREWA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 23:22:00 -0500
Received: by mail-pg1-f179.google.com with SMTP id v28so5417967pgk.10
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 20:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SIlPpI+xqS202WJQwxgXFlRMI+IiYvgdSwwPnhOt1vw=;
        b=Hs8xxZVLRQ9nKfqbEBWalOdJOZ0Hk+sU4EhCfHyDwPgrBLl9WZcfwtuWXsCENnGGDv
         EzdOJoz96Z+8/4g8M+xeJw8exnEM4+DhyuGRFr0RmvWqh3bUMPDHauMD8eWyaKNQRXvL
         Yd1GpiCx5CoypLq0Jywfkts+AnIwN2kd3gxf+2n1IKI1y+S+H8lSc6KLQN+y55dww2R0
         muSvuQGmIN3P/KNu4nEfts3/ljXCDlFzPrXYe4oj8FPJvyi70fmnJdG478+jt23ZQXuY
         L87CaIilL0DLPHD/cYFDZ5e5orl8mVxm8tq4DvUzIfITC0N9yss9g1kpdtgX0z2geYWt
         cscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SIlPpI+xqS202WJQwxgXFlRMI+IiYvgdSwwPnhOt1vw=;
        b=qOyjlledz+ZM/nM2AG+ZujRZSCAT2ZK9mSjy315aaZTvoHuLkrDAoo2IsVqRrI2Et1
         W2PAJHb0M1U6CDIRO5naXTarv0aRsQyJO4DsQaUc0sP85h4khtxKHvQs8Vf+y//oUS/T
         AJMaB73J/hJ46stpsNakSCMavOMy0ZjOO7emtONfi4RAwG++i87Y0eVqeHtH50ZzSap7
         kFncQhoAoMdlPtfe6ER7CO1ohUkczboanfHven64H4v/gt/2VnnegZ9Aw3TDDP01Ia5k
         ggh0RzG2iry09nYELY7bUTI4L+th6BEFTnWY6YfwlVWLJ31Rz3NtxgxLMPEONQqSK6DO
         VCSQ==
X-Gm-Message-State: AJcUukci9M8oyBH1b/CCfa/r60fxIryINxJOx5UV1YATokdr6Oo0cwV5
        16ndy4+daxnsG5RN3Xk6rl4RUL4RAw8A7Q==
X-Google-Smtp-Source: ALg8bN4c3Y07fVwXyCnpJpKZUPR2XjNjuG6XBD3jMBm0kgc6/t6SIk+UE7rqgBlbPCyAf3spiK2ysQ==
X-Received: by 2002:a62:4d81:: with SMTP id a123mr18312631pfb.122.1547785318942;
        Thu, 17 Jan 2019 20:21:58 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z186sm4285907pfz.119.2019.01.17.20.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 20:21:57 -0800 (PST)
Subject: Re: [patch 1/9] block: Cleanup license notice
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
References: <20190117231416.111952141@linutronix.de>
 <20190117231500.874215239@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c66207a9-c18c-cd54-fd2a-1703c7bf1b57@kernel.dk>
Date:   Thu, 17 Jan 2019 21:21:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117231500.874215239@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 4:14 PM, Thomas Gleixner wrote:
> Remove the imprecise and sloppy:
> 
>   "This files is licensed under the GPL."
> 
> license notice in the top level comment.
> 
> 1) The file already contains a SPDX license identifier which clearly
>    states that the license of the file is GPL V2 only
> 
> 2) The notice resolves to GPL v1 or later for scanners which is just
>    contrary to the intent of SPDX identifiers to provide clear and non
>    ambiguous license information. Aside of that the value add of this
>    notice is below zero,

Applied, thanks Thomas.

-- 
Jens Axboe

