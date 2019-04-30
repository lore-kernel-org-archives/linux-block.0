Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021B0C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 22:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6AA220835
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 22:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dBInw4E8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfD3WNJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:13:09 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:43242 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3WNJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 18:13:09 -0400
Received: by mail-pf1-f181.google.com with SMTP id e67so7733471pfe.10
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=dBInw4E8cbFDrzlWGmF/1GurkiguGnJHVvJPfPh29KECO9EdXYzZV3pER2f+0a1y95
         UfFkIpIOdG9GP0/c8Iq38b8K/7DgWllRmzYz8JLoH96RpTAiPCknIZP2tmeDkOzA53Ve
         n6tAgHJ2Rth+Fcu6lp7mJdbYLuo81zinkNJiunwte2OSPmDUO3o0RlVd56e0rv2POsfq
         ZjmzXznNxqj8TI0d/eEVWZ8Uqmr5k2N7HLT0+tzd6SWyo9t6CZN0q/3B/+SQtEeNS3/l
         4Fy27H3L1hDqSeUBQ9IK66JbtF7hKgPHODlecucFXFqvEsiOCgNyOOwmXSO+hKLCxH1C
         /iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=t0/MRGhtz1f+vSDS8XWdYCwd70Dx3IRuX1wM67CW6qN2CnSANOiJ4FLBN90+fH5nYN
         eestL43b14wgyiVqj8Puwj7gidvMYoP+A1o0aPyTh3w/P7JIVR8RmziBt/f7Nl2XfEBI
         vvH/TgHX7MPELu8LqXI92sSxUVnQM477jIAtNDtH6tdvSE0tnFyT35Ci8+MMwSSrDkjV
         09YqZn5vVb4NfycLTSiOW7/6AX4Kn4tI5F8yq4nhZLu8WJwrBg0WIbb7be71QixhCyCe
         LMz02j1ZEvfb80z0T15hnBcfIFB++kbsoBvayEskSlkY/w/+ZGotF/yzg+x8s2MaSKQw
         u7dw==
X-Gm-Message-State: APjAAAV8nzWlsLUOeSB6N8rgJviLtaNX/SMGyJZ8sQSSSpJVe7ceS78w
        D4xF9x2sbqC2nvIuRH/nZBBSlAPxgahV1g==
X-Google-Smtp-Source: APXvYqzrYier0kGsqRA3yT8uVTjPaLI1XQHf7mMPJQ72LPwa0JkgDtZZlFNHcIzdJd2CJca2KBev+A==
X-Received: by 2002:a65:654c:: with SMTP id a12mr38403658pgw.101.1556662387884;
        Tue, 30 Apr 2019 15:13:07 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id u7sm39515866pgp.26.2019.04.30.15.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:13:06 -0700 (PDT)
Subject: Re: [PATCH] block: remove the unused blk_queue_dma_pad function
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20190430175616.26639-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7fabf8dc-32cc-df77-23f3-a1acafee55e5@kernel.dk>
Date:   Tue, 30 Apr 2019 16:13:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430175616.26639-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Applied, thanks.

-- 
Jens Axboe

