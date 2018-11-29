Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3815AC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F021E213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJY2VxSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F021E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeK3DAt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:00:49 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41276 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbeK3DAt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 22:00:49 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so2465929qto.8;
        Thu, 29 Nov 2018 07:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=04/qz8pdLsU4owCgN/+S4NzXW745Zs/GT+VihcKn1BQ=;
        b=CJY2VxSK69Lg9Fxe33/Pl6m98z94gClHNtHo3zML+d7D+WHR3JBPoca+2RE1SniLgc
         GFXFXftY39J0B2i5o7xanPFKCGwwHmyGnwtLBVr1iUDPP9aKOqX6trn+dHjVIJk8Lwf7
         M9l/DBz/LFKcvMrtjq/c4KMBgdUzfwd/K3MCG8PRWV5cCZZgRIEVOXFx/DAqxelqpiMv
         uQ1heHDh/155GWT8oN8ZK8pdWBQ957IdVyxn8+fZODsOGAoJBxjPv20If7s95a60PN8p
         KJVcFSicEDJK4NkGAwBpBwaUBrZ09gU/Qzi23EgUuiUUdIzADQcJK15dRNNp16Ope25A
         9aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=04/qz8pdLsU4owCgN/+S4NzXW745Zs/GT+VihcKn1BQ=;
        b=EVbqcXPOwrJ8S9O7Qsi+kFGdBgBlH5f3WgzTMOjGGjzblj3XMB75YbX5NBMmOlQDVg
         fNagy967CP6rYGYJ+gSe93tjm7DM2LDWtNeHKFii2H/gqKW52Fa9FAiRTX7s5HHDhQCr
         In9dzHOPwfwgnFtggQYMtwf4J+Co3E247iCWnqTmTzf0QM1V5/J7+e0H/q7Nxu2FA0N2
         cNQy1+bPBaxz4HKYH4H/O4nd/SpOMdEKsZoCWy0JTuVYCZcPAjoppNtAqmjbwKo6MRFm
         OYadjFqSG3Q7JiOPJybfRodWntrQ+R3IPyx2KVcz2i1CgYKyEHPS5f8xUxc5Mh1zKw2d
         wKdw==
X-Gm-Message-State: AA+aEWYog04mP4JmpiTRLTKOz947M6oswO5/fLp43yBZuyK2kv915XkQ
        uquEbCn7YRVAQ2YJevnazgc=
X-Google-Smtp-Source: AFSGD/W4BRgfGQKgu7dKivTw+AmrediSAO8cSafg0/HO1LUZxagar+D5t9Zaso+pwHQkqf6B8iURWQ==
X-Received: by 2002:ac8:1add:: with SMTP id h29mr1884607qtk.258.1543506899825;
        Thu, 29 Nov 2018 07:54:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:c5f4])
        by smtp.gmail.com with ESMTPSA id k6sm1805946qkk.60.2018.11.29.07.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 07:54:59 -0800 (PST)
Date:   Thu, 29 Nov 2018 07:54:56 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] blkcg: remove bio_disassociate_task()
Message-ID: <20181129155456.GF2509588@devbig004.ftw2.facebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-12-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-12-dennis@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 04:19:44PM -0500, Dennis Zhou wrote:
> Now that a bio only holds a blkg reference, so clean up is simply
> putting back that reference. Remove bio_disassociate_task() as it just
> calls bio_disassociate_blkg() and call the latter directly.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
