Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D4C4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 13:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJRNY2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 09:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiJRNYR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 09:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374CDC90F0
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666099454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pcyZjCPgGIhvNeou0iELtPdI8MmA4xaqyx82U1JKIfw=;
        b=EmCl6SXPlui1uKWCMLWo9lxX4wrfn4ReFNXpUapZ4W5dv9wUUt/JLU376O6gaQES26b15a
        le/X1xuV27G5Zd2bbjgd1ETMkYA2dol6JNuc//FhyAyM4jlt9sEs0ECMVkHJKqnbQzyuCv
        PJaF03w4U78KsUIwavBm59jbFJoRuZk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-gcQKCe-0M-uPEKiee2GNlw-1; Tue, 18 Oct 2022 09:24:11 -0400
X-MC-Unique: gcQKCe-0M-uPEKiee2GNlw-1
Received: by mail-pf1-f199.google.com with SMTP id cw4-20020a056a00450400b00561ec04e77aso7809355pfb.12
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 06:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcyZjCPgGIhvNeou0iELtPdI8MmA4xaqyx82U1JKIfw=;
        b=Z+bSdlXxD7XokD/X2NCZH55RCCgDR37zHl0uMPCiaHEQ7XP8jwD+Hz4cMotqjG6+NP
         rhf02bgwHYLt1iP0kb+bR72vO/kThflG+CnRmyTKblOs22Yqr/NP8IK3S3ev7oijZ6Dz
         XtNSgGMi0hIB1awY24LdEpgbOHx5v+NtUfYXzVi7vwx7Q4vF77T7TUzaZBUNnVQCj70R
         3HXKDy3idiw3GOJBHsomBa4LnYG0eIc+3TBEOI8WzGtrlPiefmle3avrdgJ94qKFZr6Q
         1QHkENrwxKINSHN7QxgxgFsU2BodexOtQojguDUzsDEW1TMsNgWCSrkLz3qS01PCyX3p
         8ing==
X-Gm-Message-State: ACrzQf3Xy1LiI/pbwJPMEwVSqg3aG3Vxu0DxYHjg4/48RIxD3qYC7heF
        TXHJwEXRPPlOjJt+C8jnKkX3Ar2yzKnilZJzXdL1CjsJIjTpfGkgHo/DmBHfFsxdYvmST0+NOnw
        +SA7VQwUAbAqL5MQD+YLaVp0hf1GGo0wL7q4tk3s=
X-Received: by 2002:a17:90b:1b42:b0:20d:6ddd:9ed2 with SMTP id nv2-20020a17090b1b4200b0020d6ddd9ed2mr40056160pjb.232.1666099445557;
        Tue, 18 Oct 2022 06:24:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6HN4Jqn0EbsIpkVOssduahw+LRIDPFdjmyXjFNonPr+OHXDdOO8/xJ+SgOzrxRyTXPA4AJY/8xd0PyET5zbgc=
X-Received: by 2002:a17:90b:1b42:b0:20d:6ddd:9ed2 with SMTP id
 nv2-20020a17090b1b4200b0020d6ddd9ed2mr40056148pjb.232.1666099445325; Tue, 18
 Oct 2022 06:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221011174325.311286-1-yi.zhang@redhat.com> <Y00Im55493i+BWBi@infradead.org>
In-Reply-To: <Y00Im55493i+BWBi@infradead.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Tue, 18 Oct 2022 21:23:53 +0800
Message-ID: <CAHj4cs-J2FKR7JdjtStj9E=gyomPGk5UQEfnzeAcNvy=L=EJtw@mail.gmail.com>
Subject: Re: [PATCH blktests] tests/nvme: set hostnqn after hostid uuidgen
To:     Christoph Hellwig <hch@infradead.org>
Cc:     hare@suse.de, shinichiro.kawasaki@wdc.com,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 17, 2022 at 3:48 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Please explain why here.
>
Hi Christoph
Here is part of the original code, hostid will not be appended to
hostnqn, I also added more info in V2, thanks for reviewing.

        local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
        hostid="$(uuidgen)"
        if [ -z "$hostid" ] ; then
                echo "uuidgen failed"
                return 1
        fi
-- 
Best Regards,
  Yi Zhang

