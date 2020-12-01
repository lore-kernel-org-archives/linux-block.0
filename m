Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77667C64E7A
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 14:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1648520705
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 14:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJDGOZ4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391557AbgLAOGs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Dec 2020 09:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391264AbgLAOGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 09:06:47 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD50C0613D4
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 06:06:07 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so1254388pge.6
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 06:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RJKbvCtCn89+WUXWjU1z9Yx539VBEXROtVpS4goNlLk=;
        b=FJDGOZ4Qvrudqm68gElDVoV6oiMSb5ze3xk5W2oo3qullia/YsLT6+HubheMZwIrIa
         ugNl2w8UaF1YIluBTbgYuOtv6qD/M4I7rG4ggqSOOm7u6l4kYlSkpRXGmGAJr5BWBmcj
         B7rqmzQj4eJ0cZb7xTwNA2qGzsoOz0FPeMds36Issu6RbYXhsHg7kvrhk1zZOdJEWUnz
         e7d6uLtDkWOyDyhCAWxKe9li86zbNtm7oio21mPBVair4jrGsb7XstLuE01ol5nd/+Ce
         WURnV2aVUPjrfeF789bzqigsEf7JtA6sa28OlDzg3/MfUA1SjvLYcghkyMIUvnIF6OO4
         qiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RJKbvCtCn89+WUXWjU1z9Yx539VBEXROtVpS4goNlLk=;
        b=qJqJtGbF++tO4A8W04bB5CsoMfhRp118MgDTIG7EwSphIqNsKYRPd6qoeKfAAwr2o1
         R9/TY5w0D1em2lpikgNYN2gwgSYz3DNI8ssZpx9eXHTNcEq9nMLd9sjVafgR5vFDOci7
         kKQwtBN0MS2RUSYqokpLMyfhp9o0b0LiLszRRp55UCzlPFbLADEBIsRVqrM3Q1A323y6
         tHgQ0lpEttDtpkzwcNPSmGRe3kQAiEPmVUpR51t48+RAQv9V2Sf9k3zeqLAGnnMg1lHE
         +OK4rsZca+SWsjSN1xVS0LI4oMYS3W916/QHWrgB7MoMkVz1o0v5TKDSU651iGt8ziWK
         1X3w==
X-Gm-Message-State: AOAM5325r+TcrLYblZjy0aK4ASSpJt8Nex/udPE46be/lDVf48+KlMij
        ypjsL47vCQ03KlnUuuylIAA=
X-Google-Smtp-Source: ABdhPJxn24nY6ZYllJ97s6NwTgIspwOqhwmEvHFf3+nm/2dgFoXtYVz6UcGpoTx3YXcuPk1nzlEyuA==
X-Received: by 2002:a62:e901:0:b029:197:ca81:4bb9 with SMTP id j1-20020a62e9010000b0290197ca814bb9mr2875492pfh.26.1606831567265;
        Tue, 01 Dec 2020 06:06:07 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id k17sm2836342pji.50.2020.12.01.06.06.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 06:06:06 -0800 (PST)
Date:   Tue, 1 Dec 2020 23:06:03 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH 3/4] nvme: rename bdev operations
Message-ID: <20201201140603.GD5138@localhost.localdomain>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-4-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201125610.17138-4-javier.gonz@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On 20-12-01 13:56:09, javier@javigon.com wrote:
> From: Javier González <javier.gonz@samsung.com>
> 
> Remane block device operations in preparation to add char device file
> operations.
> 
> Signed-off-by: Javier González <javier.gonz@samsung.com>

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
