Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96ACC169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 15:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A471A2175B
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 15:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZkcErlsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfBFPqJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:46:09 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:37317 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFPqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 10:46:09 -0500
Received: by mail-it1-f178.google.com with SMTP id b5so7331371iti.2
        for <linux-block@vger.kernel.org>; Wed, 06 Feb 2019 07:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VvgpR/ZkHB/ExkeKh0TS31Jbr+JsCl3b7/J/JOcgabw=;
        b=ZkcErlsTo2YDiOR6V3XoD0PlZ7pmNwd8NbV1eytY9On8ElkllGDADbaGHlGEphVaP7
         lyNeQr7r0PcOXywaoT93EAn7KPSg9BHu1K+omtMrO+KTX2p1W80glUdPxY4BYE2feRvB
         fkPi6rSOZxcl6bN2EAqZ/JLsn/biFhfTdibubdICKKMSwIBjXgccjYDP46udjgYhUI0W
         D/nVbE6we/FBmg04i4tRrXGA84v3n8PdfZ+h7O2CWPtPgC/HtpV4IR6nA+XFF6g6Gkun
         J3GeKlvaqeEI+13+o0mU1lwzAD/O6CQpNbe1uqWG1O6R79R5UA0qXY6+z2GIcchW2zFr
         ix/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VvgpR/ZkHB/ExkeKh0TS31Jbr+JsCl3b7/J/JOcgabw=;
        b=jI5rbDppnLFpraMsHeRQOs7nxatKqcsHVV151SSKXynS4SmabaEzsosRQFYi9AVElt
         tyB/f2axHppswyI9ZaRxT6yEOTweULj3DYUepGlq9Ly93jvJNzA+hGeBuholDxAUb9Ey
         9f8U/rA3eSO8H7D2qkZv9+TuAjfBWUGLTYvWIuZ9jU/YLJdPW9hBZnq8B1bKmPSu5/Mi
         XpyZNyFG6Y+DxavFkby/eYFXK9EIQ4Wn6zZavvPlI5YC7ufg4yhE/gqL4QzpwhDFzywj
         YRZ7IVFWLqHrg0x3Re+vB/cQKEbbo2nAdRt79yg32+Xm1BuIhmaGYJvzadk6gzQ5fEvN
         VoPA==
X-Gm-Message-State: AHQUAuZTe4dShw2FWSvxv8OT1+w04yUXWzEH2LLR2m3hljf6QOAE+ytN
        UqoSlQOh70APDY/XjgwEzG1NTA==
X-Google-Smtp-Source: AHgI3IbZ3GkjIRRpQAUfnwVyBqoKxCYPrDgNwknP+KX0LEhNPcm6q/sTugjmRdg0YtUeYAvAlKdPfQ==
X-Received: by 2002:a05:660c:b43:: with SMTP id m3mr2475573itl.126.1549467968209;
        Wed, 06 Feb 2019 07:46:08 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k4sm2942779ioj.33.2019.02.06.07.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 07:46:07 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 5.0
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190206153828.GA14994@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <57c9a73b-88a7-23fe-7b4c-756932a957b7@kernel.dk>
Date:   Wed, 6 Feb 2019 08:46:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206153828.GA14994@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/19 8:38 AM, Christoph Hellwig wrote:
> The following changes since commit ec51f8ee1e63498e9f521ec0e5a6d04622bb2c67:
> 
>   aio: initialize kiocb private in case any filesystems expect it. (2019-02-06 08:04:22 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.0
> 
> for you to fetch changes up to 5c959d73dba6495ec01d04c206ee679d61ccb2b0:
> 
>   nvme-pci: fix rapid add remove sequence (2019-02-06 16:35:33 +0100)
> 
> ----------------------------------------------------------------
> Keith Busch (2):
>       nvme: lock NS list changes while handling command effects
>       nvme-pci: fix rapid add remove sequence
> 
>  drivers/nvme/host/core.c |  8 +++++++-
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  | 22 ++++++++++++----------
>  3 files changed, 20 insertions(+), 11 deletions(-)

Pulled, thanks.

-- 
Jens Axboe

