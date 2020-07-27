Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E32C433ED
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 16:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FFD206E7
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 16:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AJgFVAeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgG0QZp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgG0QZo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 12:25:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16E5C061794
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 09:25:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so9768823pjb.2
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PgFDMWbXvBiEOAL8M87yEjCfGoE6x1y/jQ7//nauM8k=;
        b=AJgFVAeqNc0eTNWKlRiSdboLLmWGtucMVtlkCPLfxpBGGAOOTw7XJMakcq6cwtXPte
         LEWZgdT2NaR/JInb5XxIN5Smg+ng7vi9zQeZMCLwjk1ov8i28QxqN+dvgNRo6VfRyAGc
         GBFvwT83gAamdChAgmQR7vLsWjeOfx5Uw2LjnV++DPbvKy39G2ymgTSAdCMm2x6Our1I
         94YsqiAYqbGhTjUwF1TYPnjl7nZPE4pLK5AeHvUmbBHlUPuq7gkHP2amjZG1T8c4njdx
         M1wCjXnOwFI6Xm2Go58ZuKECCu6Tjw7+nmjJ0ZRUF/3Eill1r/Y0cYhEGxbrQi2p6703
         1Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PgFDMWbXvBiEOAL8M87yEjCfGoE6x1y/jQ7//nauM8k=;
        b=mB96rGxskeNOAjiT3d1c5RHEAOaGtCiFczSmUItvl5VEBiFDWB4ExUC426gZAW3NrK
         nwsdlolyVwiUJP7Lbk0nMb3Hmq4/dCgB0eu+pPFnpjo1DRnmxI5rX9ryZR1WiB0/5LAI
         yjHTOchf6rswb0trJh5fkKu73MjwCLRDD+d5OpmBtl+uCl1W3Qju2j929bqs/tgn2vYH
         2kvrF4qflpvW+s6d2DwqcwWeVp/UXUZ7jdB+Lu8rM1hrTGg5MRFx7lEHdSvGLcytiWoK
         dG/LzZlc0LyrnnBoti6g6XbUjM6AfWiD+kKdGCGMld35wGymwGqk6OfhV4kxNAT7XzFS
         jIIw==
X-Gm-Message-State: AOAM533HvFPcv34CHgk6+1dj7reckHAB+NoIwlUplLSj2bsVUVZ6/+1W
        rBycqSYJAihleXWzChqC3OCMF8mr7NE=
X-Google-Smtp-Source: ABdhPJzhbpBDCDrPt1P1xzvTKEDPhAXqIMc+mtjQuLAEnv/alhrt/rhN2nq6GrLuC3iTTLwresjkGw==
X-Received: by 2002:a17:902:900b:: with SMTP id a11mr19177442plp.315.1595867144116;
        Mon, 27 Jul 2020 09:25:44 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v15sm15621045pgo.15.2020.07.27.09.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 09:25:43 -0700 (PDT)
Subject: Re: [Linux-kernel-mentees] [PATCH] block/scsi-ioctl: Prevent
 kernel-infoleak in scsi_put_cdrom_generic_arg()
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200727161932.322955-1-yepeilin.cs@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <78d90a98-7bd5-1604-cc27-90842c365ecf@kernel.dk>
Date:   Mon, 27 Jul 2020 10:25:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727161932.322955-1-yepeilin.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/20 10:19 AM, Peilin Ye wrote:
> scsi_put_cdrom_generic_arg() is copying uninitialized stack memory to
> userspace due to the compiler not initializing holes in statically
> allocated structures. Fix it by initializing `cgc32` using memset().

Could also just add the appropriate pad, so the compiler does the
right thing.


diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index ef722f04f88a..72108404718f 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -651,6 +651,7 @@ struct compat_cdrom_generic_command {
 	compat_int_t	stat;
 	compat_caddr_t	sense;
 	unsigned char	data_direction;
+	unsigned char	pad[3];
 	compat_int_t	quiet;
 	compat_int_t	timeout;
 	compat_caddr_t	reserved[1];

-- 
Jens Axboe

