Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3F9C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DB02147C
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 20:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="xReRO6BY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfCKUWS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:22:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34179 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfCKUWS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 16:22:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so1910294pgq.1
        for <linux-block@vger.kernel.org>; Mon, 11 Mar 2019 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DufFRuraGMRryh1jxXAAT7l9ZzH4PqsqbsFz/HIGUss=;
        b=xReRO6BYfEWVtu/h7Xn2hRizZ3DK/Y3OaFg5AZq3GT1Dl99JQ25cCLl1kLmsM8lb5g
         9s1EtNfP5Eqjsk0MEbeQPijCqA4DFGTFmRnqT7pP6mhBFstrFOL0TN3bWMmS3L3fC/ON
         pky0oVWAssVjWN2Vfgf5vB4KTZhdJInW7w8g3F1HHhZdHY1WAeEZKUC2V3zrx163IVbW
         C4phCzETUfm4Gn0Jjqno1NNrTlkoaO04Y5kAW3SLgGqJ03YCwNvnLqpAobGdQucIzsRd
         FhojckztyT1t7G3rBoq0KoCJK9W4WmF7skj9ePYFJXn01DTecWJMJuC6in2Qars5iGdX
         GYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DufFRuraGMRryh1jxXAAT7l9ZzH4PqsqbsFz/HIGUss=;
        b=RxgYiLPBBOY280tB8TxByxuAIPWXzHq7cHvvRFFpciQswZtVGsGpj0NZbZso18m6Vh
         U5f8Qr0YfbC2b8vcLnmVCTN1x4QhVJrkl6lyD8BWZGfMv4M5udV53riwjaSf3Zm9HMNT
         8bDA3FNFlEDxhO+yrBYLL+cyXZ+2rF4JSYDMhFE+CMR8rFPx+xUPvIWQ3PFKDqxBnoNy
         XYTH9FlZMegmlgPPPl0WfXkfa2qHNj+qbiftL3XLGmXsAYo6/rohTwHdrm1QlaxaLiSg
         eHOQaUxaVGEZRcCcUS8v/75QW8uL5qpJrwLwTiu298IBz6UnUnF6myw2WhVsFOvZi5MV
         m4dQ==
X-Gm-Message-State: APjAAAUehIo3sB4bS/HSkjAQzVY6ruL+ARghBIwHvDQ/D0P+bS89VV2x
        iFPtTGs+9iYy+R/s8HGTMyAWhuy9gpA=
X-Google-Smtp-Source: APXvYqxcD74kxNf3jndH4jvAwE+r8sFc7UvInZBeCaytNNPawvxM9oMACvWtNTwU9Z3vx0k01Qj7bA==
X-Received: by 2002:a62:4214:: with SMTP id p20mr9293066pfa.204.1552335737327;
        Mon, 11 Mar 2019 13:22:17 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::1:4c93])
        by smtp.gmail.com with ESMTPSA id m8sm13895139pgr.82.2019.03.11.13.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 13:22:16 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:22:16 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     osandov@fb.com, linux-block@vger.kernel.org,
        shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests] Fix the failure case which will exit with 0
Message-ID: <20190311202216.GB30813@vader>
References: <20190305033319.6825-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305033319.6825-1-yi.zhang@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 05, 2019 at 11:33:19AM +0800, Yi Zhang wrote:
> The return value of a failing test was masked by the zoned test check.
> Make sure to return either the original or zoned run failed value.
> 
> Fixes: e840e15 ("config: Introduce RUN_ZONED_TESTS variable and
> CAN_BE_ZONED flag")
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

Thanks for the fix, applied.
