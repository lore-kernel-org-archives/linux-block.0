Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	STOX_REPLY_TYPE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE12C10F0E
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 07:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63A321738
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 07:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zadara-com.20150623.gappssmtp.com header.i=@zadara-com.20150623.gappssmtp.com header.b="SigpUBdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbfDGHmp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 03:42:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44218 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfDGHmp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 03:42:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id y7so12599842wrn.11
        for <linux-block@vger.kernel.org>; Sun, 07 Apr 2019 00:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zadara-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:from:to:references:in-reply-to:subject:date:mime-version
         :content-transfer-encoding:importance;
        bh=Kyuz6KlMniBBxyXYYunx0UzEgGAFNCv2tJHab4EH9gA=;
        b=SigpUBdDmRnK0wYY9isZPR3q/MzuJY/E21u12OJuY0ufUPCUW48JwXoJgkciVId7WQ
         +XxscmDfvtsNE59uITk+9u7w1yjAZA+f+/M6EBdTxmb+yF5LmQ6KjrfLJkZu3Mrm0aRW
         k0iE1n9fG1go4OeILoxW+fIdP7CO91dDuOPbovmFz9VSbG5lnajiDNfWz7VSY5u3BgR3
         JqaOR8hapLRSnvEzfZhycySvTR4IW3TsTB6fCsg28MebZji/8e9dYjoYoIz8Jl2Y53jP
         iUp4Z+U1sKREsoe7T5m3X0JvNoQ35hKAyZNdaZ/IdbdcYBc1ICa+Wu5R54B9uWL5VoYC
         jw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:to:references:in-reply-to
         :subject:date:mime-version:content-transfer-encoding:importance;
        bh=Kyuz6KlMniBBxyXYYunx0UzEgGAFNCv2tJHab4EH9gA=;
        b=mmlH001JHt+j4q+2KkfAyWQBTisNJMorJPkn5IPLwc3bF3D+991H81R+eGT65Kc9aO
         2yRasPgeLvFPj4SV6JuD4hcyNRoNp6D3Dh6z0uQoOlcefKzr0SVmtZHcZT5VPbWYvvEs
         SPAKecIllc8P5LDrOggqZhW+eo44wxFaJnpFX/a7sU90CXCoOhEZZPNJLAHpBwY0O/9Y
         9KJiKtnIwn+f+lwESjM4PXOejomPU5rRjNh4DxYxHwCry6cxac6WbBUlSop4yuNFGqnk
         Byz7PmXfrqVXTN/s/3bkHW6TLglvvRSbbEJYvAoypsV6GsPEgHtHK48DuvzXWypHM0++
         3asQ==
X-Gm-Message-State: APjAAAU7nO+eSTJgnke0QwAvUMifI/N5Iy9Dxld673b87hXxVpWhZjPv
        D8Nr/AY2k+qAytDf5z8Jq+/Tc38/Sf4=
X-Google-Smtp-Source: APXvYqxe5Iik944RLPe3wn5sgFItseX9406buZe8o+/3dDOsPt+Umc0BiZmXOPmCxBTBTzDzQnailQ==
X-Received: by 2002:adf:f984:: with SMTP id f4mr9504618wrr.97.1554622963102;
        Sun, 07 Apr 2019 00:42:43 -0700 (PDT)
Received: from alyakaslap ([82.166.81.77])
        by smtp.gmail.com with ESMTPSA id t24sm9945316wmi.10.2019.04.07.00.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 00:42:42 -0700 (PDT)
Message-ID: <94FC8D439FF843929970BC6F6F99A4CC@alyakaslap>
From:   "Alex Lyakas" <alex@zadara.com>
To:     <linux-block@vger.kernel.org>, "Jens Axboe" <axboe@kernel.dk>
References: <1554555800-14392-1-git-send-email-alex@zadara.com> <ae3ac0dc-92ef-36f9-ff0d-ef41e6deacb1@kernel.dk>
In-Reply-To: <ae3ac0dc-92ef-36f9-ff0d-ef41e6deacb1@kernel.dk>
Subject: Re: [PATCH] block: preserve BIO_REFFED flag in bio_reset()
Date:   Sun, 7 Apr 2019 10:42:40 +0300
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3528.331
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3528.331
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Can we perhaps backport this to stable kernels as well? In particular, to 
long-term kernel 4.14.

Thanks,
Alex.


-----Original Message----- 
From: Jens Axboe
Sent: Saturday, April 06, 2019 9:58 PM
To: Alex Lyakas ; linux-block@vger.kernel.org
Subject: Re: [PATCH] block: preserve BIO_REFFED flag in bio_reset()

On 4/6/19 7:03 AM, Alex Lyakas wrote:
> Commit dac56212e8127dbc0bff7be35c508bc280213309 titled
> "bio: skip atomic inc/dec of ->bi_cnt for most use cases"
> made __bi_cnt dependent on the new BIO_REFFED flag.
>
> bio_reset() does not reset __bi_cnt, but it does reset the BIO_REFFED 
> flag.
> But __bi_cnt depends now on the BIO_REFFED flag, so bio_reset()
> needs to preserve this flag.

Looks good to me, applied, thanks.

-- 
Jens Axboe

