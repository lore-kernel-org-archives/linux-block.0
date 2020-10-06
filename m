Return-Path: <SRS0=/MU2=DN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE1CC47095
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 19:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD683206F4
	for <linux-block@archiver.kernel.org>; Tue,  6 Oct 2020 19:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J/Zz9jHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgJFT1V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 15:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgJFT1V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 15:27:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E53C061755
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 12:27:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a17so2040202pju.1
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2020 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/FQDIufyeY+3eSU+XdlVdXanOltJ0rr8lTRjNrvtFQE=;
        b=J/Zz9jHfDyw45iowK19MyF6YW1KAVFokGcWYRVLPvXn5SNX9F80QM6RcXTexasOFBe
         LlgR/CKfc3daGnCdDdtucZ7DMVWUx1qg+U4CbwJaYr+yxTQIneP7lZS6WC1X2y9bGZJO
         MDy1P2WYyFgZAFLd6Au0qvi4zT9rB36JGw+h5Fl1mMaAHKfFv+9I42PLPi7iDqMoaGUP
         +0cpfl2mJwck4dhHaEjQ88mjKi3caOcrGiSgsXFDqjucVdKdN9T4F4d88WTiaJFRlqJ9
         sRiJcfpC19zKG0mDWV5ob5ZogXkysyqR13l59HzF3vwRDeoyP1qB/Gi3d39FWuEEOgd5
         PciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/FQDIufyeY+3eSU+XdlVdXanOltJ0rr8lTRjNrvtFQE=;
        b=a8+Mb2M//cVeSTnfbx2ZQt2ip869zT/U/hDpHoUsmHvZfZF1NCDSlLTcKAB03FA3uc
         DqjhYIXq03WmSlcUGdWTs2rOcRU7xr8fTg76SQPfypPq4EngbiGofzhOIQioSCPIIuNz
         0OVtYtKJave23oUuWmgOjxMPcqxmogSL9Y1VioY4zXMCA2y46Z4W5KqvfBNaONlWbxgY
         bxKZpdiiOlRNOGsKL+dH6S6xPAJOiAL1EmBNv5GnJSN7vAi8hpKyUazIcCsn+oLqoDzL
         iAWU2DKOBk8DHZVtMOcAvPn5C3/1zgL88+WjDO6lZ2tt9N2WcHt92IR7R/u/l16vOLYp
         TCWw==
X-Gm-Message-State: AOAM5319gJDK2UI3EtNkDfZHkUAs++tm6eLPB5E5qdhlmDbHgc9iD5Co
        Xs6KY5KGoccA++6Om2N14v73Dg==
X-Google-Smtp-Source: ABdhPJyMJkzV5kUPcERiyihVDC8sAVcmzZBHt75+VlhjKng8lILReD0RCxFUGLaecvcZJ+JefKyGEg==
X-Received: by 2002:a17:902:8a96:b029:d2:8cdd:d8f5 with SMTP id p22-20020a1709028a96b02900d28cddd8f5mr4596715plo.69.1602012439609;
        Tue, 06 Oct 2020 12:27:19 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id m4sm3838746pgv.87.2020.10.06.12.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 12:27:19 -0700 (PDT)
Subject: Re: [RESEND PATCH v2] block: Consider only dispatched requests for
 inflight statistic
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com,
        kernel@collabora.com, Omar Sandoval <osandov@fb.com>
References: <20201006191509.2482378-1-krisman@collabora.com>
 <20201006192038.2484672-1-krisman@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8e53dcca-bd5f-4b81-cf73-d905f2c36dcd@kernel.dk>
Date:   Tue, 6 Oct 2020 13:27:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201006192038.2484672-1-krisman@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/20 1:20 PM, Gabriel Krisman Bertazi wrote:
> 
> Oops, I have no idea what happened, but something ate the hunk at the
> last submission.  My apologies.  Please find it below.

Care to just resend a fixed up one? Saves me the time from fixing
things up.

I guess we'll just try and see if this flies, not sure how else to
make progress on it.

-- 
Jens Axboe

