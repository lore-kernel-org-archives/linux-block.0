Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A752EC388F7
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 16:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B70D24641
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 16:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fv4QiOX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897473AbgJVQjB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Oct 2020 12:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897386AbgJVQjB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Oct 2020 12:39:01 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39851C0613CE
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2020 09:39:00 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id p16so2307548ilq.5
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2020 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XabwvqT4ScK/GFmYuC/wQR/uIais57ndBXLbMLsPdYE=;
        b=fv4QiOX9WiQeZG5MG/l94UgY1pb7DuLRznqepX77ueBbr0C97KgS0Eqf4JsJtKwTve
         3qeXRkz/60Jud0kSxdufk8FeXwwHVs9ACz+xs23lxcucBabYut2ZMOx/5M3ayIgbBEuL
         EAYUlNP0S+2Y1rY+2+fg+NA9nmA4i3BnmitFI/XnyQQn/pVynQuins+HMBFd6i5UxBIQ
         UDCRqpDF6PJHlpBwHYFS7tAIsDtfZtfzSin1ECZWv7t2NROXa43Kki/U//QM2qeM0QT8
         qESvMrfPuUgc2Lr24aJc0c/WRLAOc8CpEfzh0ecp0x+na19O16Ux6o+M9At+19JQX/oY
         6vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XabwvqT4ScK/GFmYuC/wQR/uIais57ndBXLbMLsPdYE=;
        b=MEPI6rbCbFa2jhKxIwkuL75wd4N7xv8jJ+kXQ6Njk2RW3d0pe+HsKWuLazSWE53wCW
         QP/mGhjaQbAzol9Z6KCqg2+2udo+6HSQKGKxIkjBwfqBRPlZ4aQKV/K0Wara0Avlr5z7
         JytE8++BF4cpWUXkLL45tNaWFwXy4BBF3JdeEusVHB4IRWYl/Li0ZYvidc+ksv0FctTF
         NGtUo0Yh4lbC+ASlMjhITFsPpYxiR6tIgX/yZyeQY+qcho/d6pycZwLKxg7QQSf/P8tk
         tEAT0jTh3uJePg1F6ZFKrj3HmqbAdILMlh0fFefrWZtP5Ov01RrXxdmkYsoncBTpQijP
         tOlw==
X-Gm-Message-State: AOAM531rXa5sNoxUPCXbV0GdfiqSKaZSsvd6NQRlMeJmL1GxtyOzFIy4
        ykmnF+yky57I3aqzSOVSpaUMBQ==
X-Google-Smtp-Source: ABdhPJytx6VrLGfvqGldVLmqwiKaSXbOVnfHW36tsO5advVBhA7LdyM0zkqD9kJgO6ikU4en9YG86A==
X-Received: by 2002:a92:1801:: with SMTP id 1mr2466133ily.219.1603384739544;
        Thu, 22 Oct 2020 09:38:59 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 18sm1302784ilg.3.2020.10.22.09.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 09:38:59 -0700 (PDT)
Subject: Re: [PATCHv2] null_blk: use zone status for max active/open
To:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
References: <20201022154739.1694152-1-kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a4ad08a2-57e7-ffdf-f5c3-2658675198df@kernel.dk>
Date:   Thu, 22 Oct 2020 10:38:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201022154739.1694152-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/22/20 9:47 AM, Keith Busch wrote:
> The block layer provides special status codes when requests go beyond
> the zone resource limits. Use these codes instead of the generic IOERR
> for requests that exceed the max active or open limits the null_blk
> device was configured with so that applications know how these special
> conditions should be handled.

Applied, thanks.

-- 
Jens Axboe

