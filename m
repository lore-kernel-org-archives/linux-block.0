Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1A1C3F2D1
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 01:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FC92207FD
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 01:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="yLKg1ZbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbgCEBf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:35:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45359 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgCEBf5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 20:35:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so1876386pls.12
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2020 17:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MWBxTBVyBawGGVRmXbELavgcbIojnxDVCCWuyKiswCw=;
        b=yLKg1ZbLF97TTdN/8Ij0wrvW/Au5gymv49TtRjrzhIUpdnNHXn3tB4BQl6X7CKbOO4
         7VELbNQvy9ZxXNuv+8pluxsTETP3R8f9f6GSBKNcWB0FuxZzUcz4L3/uWYUeHHaycIlo
         FM8yZ0HZXRrfMR5B6GCMcMtn3lKYF+d2u3WoOM11lV/Q9GTYZXtS0geCTqEkEAgNy7Lv
         ewHA8Er4ENxtpTuBFccQ9rhTWekLLzPmh7Ywry+Xa2HpYm2WxKFg+S7bDR5kp7hsNoC2
         k20fxGTrGv5Pe+3RpplEd4NnHVLr/OW1e4c5VSWdS4eVh37gjtLqZnHXwO9FDjq3aSO5
         C+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MWBxTBVyBawGGVRmXbELavgcbIojnxDVCCWuyKiswCw=;
        b=VdpP8fXE0BS4ieoZpn8chd0/QYgCf0rSHBw9+KyJpxiyL3qIc564iJeUcJ4xxmZcI7
         32sFBjJTjT8PMU0xxPW/HkdvGysqJU7BKmPpMYuFhP2z4+BOQLXuBkPAYB80HvqkGHj5
         SXNS2rLAtnu7ewAHsU9IQSnO752fP2qey2S9V9WlE9VKE8Fn7YuvWsSib894KtMDI05v
         V/jASzcU0GVUEt5uXK9DMFYQ4ndECHh1EkVuJtLaMOUJ38CwzCkOqQqqmurE3Oltwpvc
         XEsYV7CkU098aHVObAIm32soA6YI4PwgiOAadwLDIQhXPauUjO5jq55OWn+yud8O2rai
         XosA==
X-Gm-Message-State: ANhLgQ03N1sivQnSyNdq7PgOQIf11MXZXL0DUu5Cvv/t43WP0w1WXLnU
        rpXAg0bbSd9tawQSiD7vJdbMRw==
X-Google-Smtp-Source: ADFU+vugx3g1fv1w1XqhBKngRgRC0hMKVPGsDadWWjNcXt+M3hhFhYWM+qJczI5JvTF26Prd38vAyQ==
X-Received: by 2002:a17:90a:8d81:: with SMTP id d1mr5824523pjo.63.1583372155885;
        Wed, 04 Mar 2020 17:35:55 -0800 (PST)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id a31sm14586085pgl.58.2020.03.04.17.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 17:35:55 -0800 (PST)
Date:   Wed, 4 Mar 2020 17:35:54 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH blktests] nbd/003: improve the test
Message-ID: <20200305013554.GC293405@vader>
References: <20200224042728.31886-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224042728.31886-1-sunke32@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 24, 2020 at 12:27:28PM +0800, Sun Ke wrote:
> Modify the DESCRIPTION, remove the umount and add rm.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
>  tests/nbd/003 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/nbd/003 b/tests/nbd/003
> index 57fb63a..49ca30e 100644
> --- a/tests/nbd/003
> +++ b/tests/nbd/003
> @@ -7,7 +7,7 @@
>  
>  . tests/nbd/rc
>  
> -DESCRIPTION="mount/unmount concurrently with NBD_CLEAR_SOCK"
> +DESCRIPTION="connected by ioctl, mount/unmount concurrently with NBD_CLEAR_SOCK"
>  QUICK=1
>  
>  requires() {
> @@ -23,8 +23,8 @@ test() {
>  
>  	mkdir -p "${TMPDIR}/mnt"
>  	src/mount_clear_sock /dev/nbd0 "${TMPDIR}/mnt" ext4 5000
> -	umount "${TMPDIR}/mnt" > /dev/null 2>&1

Is the umount causing problems?

>  
>  	nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
> +	rm -rf "${TMPDIR}/mnt"

The test harness already removes the TMPDIR directory. Why is this
necessary?
