Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E313DC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 18:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiJRSsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJRSsH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 14:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F3F9F75E
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666118885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OMz7ZD6XCaUt0ZSMCX9PyjOg8xnpLboIrO4q8tkKQN4=;
        b=bSh/MrjuVMHS5E75/k2W/3yZVnJwKgzvd2SlbFCoMAmNSb2imUdyzBRjrilnkQXQP+cj4N
        FS8ZB8qmeD3MCP/h+zDfyshF54LjUk/akacRziK7T1ltLIlEvfUidllh18hZlBWtJpW7O+
        SweMFg61gvD0x11xqN09y8n32pFI8kA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-114-Jkd-DdXaM4CVqUpb8sUy7Q-1; Tue, 18 Oct 2022 14:48:04 -0400
X-MC-Unique: Jkd-DdXaM4CVqUpb8sUy7Q-1
Received: by mail-qt1-f197.google.com with SMTP id cb19-20020a05622a1f9300b0039cc64d84edso11274653qtb.15
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 11:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMz7ZD6XCaUt0ZSMCX9PyjOg8xnpLboIrO4q8tkKQN4=;
        b=Dpc3w1+8miu8z1FmUbMgzcaiduF4zfzJhI01BWH2caqQAZM6GeHypCL3rLL1RoAIuM
         FepOOcihy2584K8y933m+BrbYDGfjvAam/s6YDjuv4iHugCGoYesI797ujgzro0ODVTU
         nDHIurEaiG2cPZzTYyc/HvyV1kbabg7f+W2baqtGS5YF5zV739lwJWLGWH06F5iRmkjs
         NaO1sf3nmAa8/mBDcCrJjLs6OJlVKVnyEPV7n/VCY46hXFIfHOvV0MX6tv299aEFIifC
         aN7Y808n2nVQv1NP03FbUzsVyJA3bGGhCcV7gyMSRklzzc1n32/mwP2+xQ7SeciW66qz
         Mssg==
X-Gm-Message-State: ACrzQf2T9MDl8gwbk9tFhteMOyXl0PlbNY1CW5Mu6aLaAvQqiCujkVbm
        RMp42agSwJ0hQUX081tbJzK8tkky9XbUExAo7YcoF4j2NsNO/+mQZzEcDgyHbgJX8sNrDiXeH67
        Uioi63JEJjKkF2+a3XxKvbA==
X-Received: by 2002:ac8:5a04:0:b0:39c:da61:d961 with SMTP id n4-20020ac85a04000000b0039cda61d961mr3283877qta.136.1666118883815;
        Tue, 18 Oct 2022 11:48:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4kYiFrkCC2vcc5l1VMqo1SytTgaACjV5OzWvZuMYrZY7zizmGaHRbxL7hmGyNDT7s+jTC5sg==
X-Received: by 2002:ac8:5a04:0:b0:39c:da61:d961 with SMTP id n4-20020ac85a04000000b0039cda61d961mr3283866qta.136.1666118883616;
        Tue, 18 Oct 2022 11:48:03 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id w29-20020a05620a0e9d00b006ee7e223bb8sm2920872qkm.39.2022.10.18.11.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:48:02 -0700 (PDT)
Date:   Tue, 18 Oct 2022 14:48:01 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Mike Snitzer <snitzer@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: Re: [git pull] device mapper changes for 6.1
Message-ID: <Y0704chr07nUgx3X@redhat.com>
References: <Y07SYs98z5VNxdZq@redhat.com>
 <Y07twbDIVgEnPsFn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07twbDIVgEnPsFn@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18 2022 at  2:17P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Oct 18, 2022 at 12:20:50PM -0400, Mike Snitzer wrote:
> > 
> > - Enhance DM ioctl interface to allow returning an error string to
> >   userspace. Depends on exporting is_vmalloc_or_module_addr() to allow
> >   DM core to conditionally free memory allocated with kasprintf().
> 
> That really does not sound like a good idea at all.  And it does not
> seem to have any MM or core maintainer signoffs.

Sorry, I should've solicited proper review more loudly.

But if you have a specific concern with how DM is looking to use
is_vmalloc_or_module_addr() please say what that is.

Mike

