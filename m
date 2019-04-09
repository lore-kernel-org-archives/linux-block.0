Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4313BC10F0E
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 14:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9FB20830
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 14:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ak6IK383"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfDIOSi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:18:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36792 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIOSi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 10:18:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so9383004pgc.3
        for <linux-block@vger.kernel.org>; Tue, 09 Apr 2019 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+0KBYnxCP0emln00of/4znNjdiLCBDYNUSRawZB4rrA=;
        b=ak6IK383x1NcTXUH42zXYuAuunb4NX80b0JVCHnAWgOYFwiqkmVx6ywWEngWFHoKrs
         00IrFjkPCLZeBXPcXCPHzliHU+AkyC1kK9xJUaS7XbJBo1/WBdVhAE5WCCZR78VsMHm1
         3wpP4D+S4E8Fe8p/iANDIyTGd7HttdpaJU+1Xy/rofdrN485l1yVBHcJigfsEYYw1NyH
         kGlg9kUN9d+bCOJez4/Qut+gMBx+xzlTOglo/okfE8E0nZ53w2DfSQ+GERasSNiyjj2+
         L3tB/XuXw+ftQ611m84DH7bl2Y2E+PN3ek1025jlVeEcKTEEoPEfWEKswQ/bUzdaDn+8
         6FoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+0KBYnxCP0emln00of/4znNjdiLCBDYNUSRawZB4rrA=;
        b=IGeipKI1JyfciaknmHi6S1zSstLHmHWYVyz7zQjV5yrsSRXZEO8hNUJBnnpRZgzNGs
         I/NmDpX83OvaFXj3bAKXejQFWaXWazdJrhx4miRKtxGDayp1pJtrpf5Lxd7FwvuJ2h2G
         En9lYtGZz2Dakj4OeNBNpIz1yYgwUcz9hhMhYrKPp2r61wTUjejpZfeRQsoG0rjKLq11
         sJUm7ww+7Osm65XXmlbfS7C3PtEvH924CSE6n3swQ61i+mHAZv93Rmttz/eOd2B9ycr2
         P4D0ni6OremjGCZfcSWJpcuRM/NKY6b9BupC1ZTdk5XXRduRUMnTH7D6PxGq5M+rI4R9
         svXA==
X-Gm-Message-State: APjAAAXODkXjZorRwe0d7y2Xff3EptZrdSihtoSQ7gTB4AXUSoUsUCUe
        nhsrIqo2RwZ85GW69IPHeqRcGUSgQlrhww==
X-Google-Smtp-Source: APXvYqyWQ5Vap7GBNe+X+gWyzvpSULJW1I5vv1H0yq1JUFhFhuujvGOEfMxsRfyDEcVzmKf9wlJMQA==
X-Received: by 2002:a63:ed4f:: with SMTP id m15mr33960874pgk.387.1554819517351;
        Tue, 09 Apr 2019 07:18:37 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 129sm23322329pgc.24.2019.04.09.07.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:18:36 -0700 (PDT)
Subject: Re: [PATCH] block: null: Add documentation for "zone_nr_conv" param
To:     Minwoo Im <minwoo.im.dev@gmail.com>, linux-block@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190407081938.20318-1-minwoo.im.dev@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8b279b3b-9591-a475-7316-29c726c27f8a@kernel.dk>
Date:   Tue, 9 Apr 2019 08:18:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407081938.20318-1-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/19 2:19 AM, Minwoo Im wrote:
> zone_nr_conv module parameter was introduced by a commit
> ea2c18e1("null_blk: Add conventional zone configuration for zoned
> support").
> 
> This patch describes "zone_nr_conv" module parameter to the document.

Applied, thanks.

-- 
Jens Axboe

