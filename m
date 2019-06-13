Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D27C31E49
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5474820665
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 16:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="PhPsF0ho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbfFMQ43 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:56:29 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44544 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbfFMQ42 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 12:56:28 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so23320454qtk.11
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=71JjQ0++Nn/tIbJf805Xd3bYk2GDMDOlmizyh54oIlQ=;
        b=PhPsF0howx1BXIS60wKPjCh8W/PRKLqefQR+hKp8JSNFbP/8OHbeSmFqc/NVrota05
         q0A89aDoAwgZRBaQqIlKcFIa+9SnecUpnmb8ucSpG//3u7U6uNHrsIvEhX21KoSXZmHn
         h7IZkWw9112Mvmq2cI9cxJVJBHk0eN3v0DhLScYuV14dtSP2OOiHVdMgG4KfklOY6Kfp
         ulAVUzOYCQk4cXoGgtlnhGhhoH50EmhkISUDZCrFuOsq3+kUahxBikV5ocs1jFUjqZbU
         +vCKpjLNfFzfmt1Y9ycP7DrRHyquRTY3NCcTkgD06Bd/tU1LcMkNjRiRxH47dbUfHd1C
         m49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=71JjQ0++Nn/tIbJf805Xd3bYk2GDMDOlmizyh54oIlQ=;
        b=ITaItWuMxqv0DPmwjljzE2CGGrSsVsejxe1e8JkJrCD+I0cJmij5U/GDg8uw18u90p
         m0NtRQdISyv4neOzbxfAUMfvQpdyfge2wv96ggKzHacClJpKcFzShDUECPiIvggEu3lS
         3cDpkK1qfMo4aTaGDDI2ocwAIQDSe7IuOfWa1m7/bgiz+7LahFZg0CUKNtMqMqvQzEHJ
         AfjC0T+wW88CIcQhSl+83Eq/Eia5M8KafmuD183QrB8JqTGWjMmnT6akC6NbR+380EjF
         dTYLY85ni8ZvrdeRWyhcMLReoFJSLH6HC0aizLfK5TXB6MZsNJwbgAhitfepfJhXCD0r
         H2CQ==
X-Gm-Message-State: APjAAAWDbxwqLtir9/pWgorNF0VYVsAoK5kFOqzC8GD4N2gDNYBz1o4d
        Y2PqBXPuhvSq5fL2KSx/4/oW4PaLEZrf2SQa
X-Google-Smtp-Source: APXvYqxvm/1x+uOHQmbQe+HipP6vG8pCR9Ljcz5etiT8phkfqs0Qg2nZSiJqe8MrZfVsVx3mfIBwbQ==
X-Received: by 2002:a0c:887c:: with SMTP id 57mr4388995qvm.192.1560444987337;
        Thu, 13 Jun 2019 09:56:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d1])
        by smtp.gmail.com with ESMTPSA id v41sm70332qta.78.2019.06.13.09.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 09:56:27 -0700 (PDT)
Date:   Thu, 13 Jun 2019 12:56:25 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH 1/2] nbd: fix crash when the blksize is zero v2
Message-ID: <20190613165625.ieugqgniplnuhr2q@MacBook-Pro-91.local>
References: <20190529201606.14903-1-mchristi@redhat.com>
 <20190529201606.14903-2-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529201606.14903-2-mchristi@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 29, 2019 at 03:16:05PM -0500, Mike Christie wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> This will allow the blksize to be set zero and then use 1024 as
> default.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> [fix to use goto out instead of return in genl_connect]
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---

Sorry I missed this second go around

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
