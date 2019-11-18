Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB257C432C0
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 16:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7590021850
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 16:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wIWRf+DF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfKRQtw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:49:52 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:36140 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfKRQtv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 11:49:51 -0500
Received: by mail-io1-f48.google.com with SMTP id s3so19554988ioe.3
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 08:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Npm+LPjcfekp1h7BNy+iWkDSTDCBVa6Eu5QuB0i5zRw=;
        b=wIWRf+DFQdMrUJvkR6R0clZkgItiHv7Rkt2hoKLuGMF8VjKriFgShtKwtEtHFAk2bA
         N5BZKEGt67J5/T1hbLD/HjvTOcujd5KJr0gxQZqRuwU0gAh7HltjsFoHhB5Z/eF0fiBQ
         Fpohg345FVF3Or3TgHuGRYy+IqYcPFHh3eJ078YWLupMc1zqaURsWVxIJJIUgDFZwXM1
         y9P1QofQDiQUeH451IzG5Mvka3lB46Y9xIjQx+hk14RyyLKksq6GGJQbom3/Kn0HmkJ5
         RcYpgwurEPi/XSGfTuNuatFFLJsIKSG0ItaCXse4lxSfQILYBpCC7CPJimmkkJBEccoI
         6iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Npm+LPjcfekp1h7BNy+iWkDSTDCBVa6Eu5QuB0i5zRw=;
        b=pP3CvGKHsDDAjD6A0bPWuZED+nC05NhzxByOU0VY2aEq8qs8nrZVu09Km1sKrnu1nA
         vQnerDndgot0sMv5JH8vndEHagIzpprUyTbM6aRTRMMbWzNMBTozKc1ercrzVtnzCLlV
         qYwsPXfEgq66ZAU/qV0Zbj+1xFlZ2W3+pyS5ACq2APrWYwJcCbpPY6B2vjrbje2fiOsU
         1TbgwcXY2Sh28f7pX7nU8B0gefQBCBvuchCM1L4L9EejREywP3VMaFDqt5quFnRYRsCj
         dBrODH5cUpynbkGfVD6hyJbRGS9K6H8q5nMTlmv+IA3TlcRFiCB3QYJ8zWIe7Gjy+CRu
         8vkg==
X-Gm-Message-State: APjAAAXQYW3YzIeHAETLsen1dWYfSLrKnPov1Mo+w/yX9f6kKek5xNzO
        AmKmHdLQrp9FvOQMD9M0NVb1ag==
X-Google-Smtp-Source: APXvYqxIogHhM1MaXD9te/iiEnix9UCXP5LYnJFDigIr4aZ3D/K1WA7K6JTVswsJvPnfnMRhixjHdg==
X-Received: by 2002:a6b:7846:: with SMTP id h6mr9293746iop.33.1574095789474;
        Mon, 18 Nov 2019 08:49:49 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w6sm3652809iol.12.2019.11.18.08.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 08:49:47 -0800 (PST)
Subject: Re: [PATCH] block: sed-opal: Introduce SUM_SET_LIST parameter and
 append it using 'add_token_u64'
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>,
        linux-block@vger.kernel.org
Cc:     Scott Bauer <sbauer@plzdonthack.me>,
        Jonathan Derrick <jonathan.derrick@intel.com>
References: <20191108230904.7932-1-revanth.rajashekar@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d2829394-321f-c464-977e-d5b6f957b65b@kernel.dk>
Date:   Mon, 18 Nov 2019 09:49:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108230904.7932-1-revanth.rajashekar@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/8/19 4:09 PM, Revanth Rajashekar wrote:
> In function 'activate_lsp', rather than hard-coding the
> short atom header(0x83), we need to let the function
> 'add_short_atom_header' append the header based on the
> parameter being appended.
> 
> The paramete has been defined in Section 3.1.2.1 of
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-Opal_Feature_Set_Single_User_Mode_v1-00_r1-00-Final.pdf

Applied, thanks.

-- 
Jens Axboe

