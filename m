Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF46C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D544208E7
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 19:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XMgnm/mP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D544208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbeKPGDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:03:11 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:35406 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeKPGDL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 01:03:11 -0500
Received: by mail-pl1-f179.google.com with SMTP id v1-v6so2834563plo.2
        for <linux-block@vger.kernel.org>; Thu, 15 Nov 2018 11:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6AibTm0uxYeeJXmrXJoPAeCbRDx/BBqciOaP+l2v4TU=;
        b=XMgnm/mPQaiQQVEmT0X4RNU7DEhK3EwT8uWdyGsxmByH+WzW59NpA5L1H9XMn0X1hK
         3HsDJebxAkOEpCYcWMSUOJbkILQnYv1A3q3t85BNQaCBguZWa1WYXLbODmM3seXa9QIz
         soqX1R7Ii129J4gVi7UQ3kcLwtYkPJQTEGuJGbnem/9LhROMGzZWwD5kbZMDQoN6YzpQ
         fOI4Eg95QureAYTQ0hp5CbVadGTSc5KCBJKyIXfNVwKU6S36nlbdAolpXYNho20XKBbs
         Gv52A9H4P14KLCkXNzGRV/KSrGB/CfyD537ijDc7FXU3ats4bumZufdvxoO9bd9QgD73
         AXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6AibTm0uxYeeJXmrXJoPAeCbRDx/BBqciOaP+l2v4TU=;
        b=R/5T06WsWNLAbF5kOW46CSmC0XlpKkkkbXD3xQDqpb79xM95OvdKEZYbXhUh+LqDMC
         C27mx3BwRaGBJUcRBpHZZSeeUwfI0uNctrLoo0avlTm54rtXPYGlbLWDNiMCggipcX/K
         Rzjw8Ww3Dgr6GTasASAakT8YAtWa8JuFsISeMaYLCHVZrdclGXpZtEgpGosXRoB5NIs1
         OrICZfsP4o7erlXlDMbFsiByidnwCiwuyz2cRLsZMbLFbfuTMYr9LTF8WuvnGikRF8Gp
         ZYZxzsJJLk4W2uRn3GFeZ1IRpR2h09nxNSqOkrrFoyI2rU9p/epz+VbwTW1fmU4CZR4F
         tDJA==
X-Gm-Message-State: AGRZ1gJOpilfTSBfuqMHCDmD+6uNv+my39Jk1DhzECMxzjSQ7xU9HMkz
        szekAkd5lfez55FvE+MvYcLeqBZhYZc=
X-Google-Smtp-Source: AJdET5esU8bubpFoAE7uhGLXqbx9VSUA3YaMnG8mQAA90khEZnoE8P5uSgiPPBwDAwiNlZH1AclgaQ==
X-Received: by 2002:a17:902:187:: with SMTP id b7-v6mr7687052plb.150.1542311638680;
        Thu, 15 Nov 2018 11:53:58 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::11f6? ([2620:10d:c090:180::1:7813])
        by smtp.gmail.com with ESMTPSA id f6-v6sm35957986pfg.128.2018.11.15.11.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 11:53:57 -0800 (PST)
Subject: Re: [PATCHv3 0/3] scsi timeout handling updates
To:     Keith Busch <keith.busch@intel.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20181115175820.13391-1-keith.busch@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ccafef94-1b80-b496-b2d9-f66298660670@kernel.dk>
Date:   Thu, 15 Nov 2018 12:53:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115175820.13391-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/18 10:58 AM, Keith Busch wrote:
> The main objective is to remove the generic block layer's lock prefix
> currently required to transition a request to its completed state by
> shifting that expense to lower level drivers that need it, and removing
> the software layering violation that was required to use that mechnaism.

Looks good to me.

-- 
Jens Axboe

