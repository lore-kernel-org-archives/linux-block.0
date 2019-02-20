Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7AEC43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0257120880
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 18:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="B3ygyXax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfBTSDb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:03:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35299 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTSDa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 13:03:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so12261027pgs.2
        for <linux-block@vger.kernel.org>; Wed, 20 Feb 2019 10:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xSZ++H21u3hwM9btAvbwwQfBiosPTj4gzIpd/HIg8MQ=;
        b=B3ygyXaxz8WG4/MAINGIHqBLA2s2SlDyFZ/T1ooLFhaq2IIDj2KWSjUOlKkOACjFJA
         fOWob0igkyhzlhKtfFS6xo7rjwyky+tV6CBPKohnbBXEktmmcYTIMNw0d0kq9iegr1Zl
         i9E0JOMApryXj5LyakMr7in9JaBl4qlwgGJENYYzweH5rRdd9o2yX1AME7SWF+1Zxbbx
         pk1Pr9HPG3dEIM1rBXlcSEx6ozU+lvejSMy9TGj5v6YGcL0SOO1CDKwrsM2nTNLCwC71
         8Csj7/w4IMaTBO8euHkdzdhVGzIo5hnRvz2baLpd4zvqahHqsYPQpO/Emn0CBBJK2VFf
         DVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xSZ++H21u3hwM9btAvbwwQfBiosPTj4gzIpd/HIg8MQ=;
        b=Dcc/6OFZ2iEeE1b6CA7TkLviPjAkcCq892fNN0XMgsDucOPCZLADARfFLhp+6MJKKX
         4EDyFneW/6JXVF828JWQN4hcKNbIBE3pKq/pmfbqX2jjWGnmJZGkCruei+AmqXWNYfbo
         NIFZd78EkQLbVuhNSPROjohW94Lqlan2rN5fC157nPkjAvPhuNir5aeUgpmtZKaVW8O8
         eWqfJ+ILMcN9zLGsun8YUrnaTkgfiUIHkz8B/sCWuhMJdqJ73sOhhag+/iYCWd08Kerl
         ZSAbyeNbuNZefpiAiRBV2s6wfGczbTlh2Tq8oN7aXH8VJxfAF3lFWOaB0mjae+UOaYH1
         OMdQ==
X-Gm-Message-State: AHQUAuYjdU6kTFKmZfKrIk+Q94Aaz4pepZ0DU5CoRFuurNKEL+KOAAtQ
        tlQP7tkFM2FEWtpO1t2s1K9Faw==
X-Google-Smtp-Source: AHgI3IYiW5+DIPkgYXOlFTOimA3SOxZLx3j4oQGAUdfqo119rFFDMul9MRccDLGeBws0VhFtJiijZg==
X-Received: by 2002:a63:c0e:: with SMTP id b14mr34264269pgl.236.1550685809538;
        Wed, 20 Feb 2019 10:03:29 -0800 (PST)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id z67sm14091025pfi.152.2019.02.20.10.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 10:03:28 -0800 (PST)
Date:   Wed, 20 Feb 2019 10:03:27 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH BLKTESTS V2 1/3] nvme/002: fix output format
Message-ID: <20190220180327.GA8325@vader>
References: <1550607835-11755-1-git-send-email-chaitanya.kulkarni@wdc.com>
 <1550607835-11755-2-git-send-email-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550607835-11755-2-git-send-email-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 19, 2019 at 12:23:53PM -0800, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  tests/nvme/002.out | 4996 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 2498 insertions(+), 2498 deletions(-)
> 
> diff --git a/tests/nvme/002.out b/tests/nvme/002.out
> index aa71d8f..abecda5 100644
> --- a/tests/nvme/002.out
> +++ b/tests/nvme/002.out
> @@ -1,11 +1,11 @@
>  Running nvme/002
>  
> -Discovery Log Number of Records 1000, Generation counter 1000
> +Discovery Log Number of Records 1000, Generation counter 2000
>  =====Discovery Log Entry 0======
>  trtype:  loop
>  adrfam:  pci
>  subtype: nvme subsystem
> -treq:    not specified
> +treq:    not specified, sq flow control disable supported
>  portid:  X
>  trsvcid: 
>  subnqn:  blktests-subsystem-0

[snip]

Why did this output change? An nvme-cli change, or a kernel change, or
something else? And will this now fail with older versions of nvme-cli
or the kernel instead?
