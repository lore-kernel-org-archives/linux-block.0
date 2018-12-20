Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F7C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 19:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3627218FD
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 19:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="dt9F9Xtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbeLTTPN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:15:13 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:52282 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeLTTPN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 14:15:13 -0500
Received: by mail-it1-f169.google.com with SMTP id g76so3629234itg.2
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 11:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OhaYvzanBuKZ5KIeInBu3Mz77pWHis9cZrcrvIvIbvY=;
        b=dt9F9XtviMUHQ8wHEDyqJdSrDMnc+7ugY4pwuM0WNwnVZr4Eme/G8Y0aWd4BXOWnrz
         GG1uPLwO2IlTVOuz4oI7zafWVnyERCgQbdckYuZUzQKT19GSS6+rxxUdZvvKDCq1YWgt
         nrGYNI2I6mdNTPa/07fmqE96AZpvpLiH/ZDY4Hnb7dV3292P0Sr8HcH0JHi7TbgN/iKj
         W5FQhJ4avH5yP1qz0OW2kI54Gicz5TED/8qeblaXdhrqpSyexqk7h0qQveG5ywt32i4A
         uPo8kIK+2VXDtFP3h27zLMS424M+nVS1mv8pcZ6rV0uwS/i5udwdipNuQ8rx39tDy0BR
         y2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OhaYvzanBuKZ5KIeInBu3Mz77pWHis9cZrcrvIvIbvY=;
        b=PzU/B0n10SaVXrmENWmgobDjamzC4FAYskBPf7E7K+dEzU2zzzjfp21Q1F2Zs+bl3Z
         oWSDS71kkgOKb3wBjQjekkVZfaISjQoL+meojQEI2mNBfZ17axQeCDIlQf/ffQ8uxNDc
         Fy3J+/ieo2kISQr92cuTk40lmb2GCiN3ebcyVSu/8SdhoXivzsgBvzk9CmxNXf9YWurg
         ebQa3IuTSv6UPwiCZ8jg9SieTG0DhZ5yWVG7XR19ulE8KIs+kWYlvBUnIvzEeHLyvrwg
         8sblgEXd1Sqn1HsgwKAB3UMo+8FA6okOrGr+R9Au4S7VVebN0uBJR/ZN2mdicK3rjj0w
         1mlg==
X-Gm-Message-State: AA+aEWaTqRiy3crQC1ZhtP38ewddbeg4faXQlsqmhQBQx3ehsYdmqxrT
        5/yg2R7XgaxXILx5j0Q2oGpNUw==
X-Google-Smtp-Source: AFSGD/Voo43OcqNpUmuZSUgV6hHMKYaqxlUXjtxNFINxU+21b03j4+a/qWxEVo57IqHI3dKGFsQpbw==
X-Received: by 2002:a24:6115:: with SMTP id s21mr11213044itc.62.1545333312528;
        Thu, 20 Dec 2018 11:15:12 -0800 (PST)
Received: from vader ([2620:10d:c090:200::6:ec3d])
        by smtp.gmail.com with ESMTPSA id c25sm9707063ioa.86.2018.12.20.11.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 11:15:12 -0800 (PST)
Date:   Thu, 20 Dec 2018 11:15:10 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCHSET v2] Fix kyber hang
Message-ID: <20181220191510.GD11852@vader>
References: <20181220160149.4042-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220160149.4042-1-axboe@kernel.dk>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 20, 2018 at 09:01:47AM -0700, Jens Axboe wrote:
> Since the wrong kyber patch was included in the first one, here's a
> v2 with just that one line corrected.
> 
> First one adds the necessary sbitmap helpers for users to be able to
> do add_wait_queue() and list_del(wait_entry) type operations, and
> still work with the optimized wakeup checking.
> 
> Second one converts kyber to use it, fixing a hang with domain tokens.

Lame, I should've caught this on the original patch. For the series:

Reviewed-by: Omar Sandoval <osandov@fb.com>
