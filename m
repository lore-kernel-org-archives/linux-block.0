Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06F4C433E6
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BC1206F4
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594910470;
	bh=k0dYXXZAToi/8gqzRCzGMvsvhUbOMJqT6U+Xx7QxuBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MKQo0QhzXcyz6zjjsKqmpQueM2fZpq/RuXODZrjy6sugL9945cOmO4pdoq2WS4nhO
	 apUBgMNws2i50deoaU44GELwYDqCKVTb1aMIQfPSnQeePw3DYzhwr0vp1OgoeCi+nR
	 9Lliqyja3piHsGCEvJotPoAAgjM+B9m+VqwDwmg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgGPOlK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgGPOlI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 10:41:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACF7C061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:41:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q198so5725663qka.2
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FIbO0H5EqhfNmt48Ye6c1keg4szkKmvuJgf3UDoBUIs=;
        b=l5Fnh/5BQrADX/1/66hm16MyFN2natJUr7clxHgt/kQjraDq3t5woyBuyh1QhaVi3q
         bZXX0ssEs60T9a4LWx5EzqUrqBMqguZXBJWm4EshewWLlwe3Q/+GkoswrcN4acNFeHpj
         Wi4/Tix1yZ6dSDRfhmjR47q0DUjgEm7rBIStC3nBcXz3yrI5Tye5VSeJqZJQ4GXVQdD9
         bLp6494baCoO1nsWtB+4QQQq2bheFyhMQdcfkeXlPZ7WJIEvBU+L3XoRTXxgWCKf1ehZ
         MKmCBceaXcgsWxPo9F1tsg1bEe8AA2zrs/p3M+MVb4nlJEVr6KCqXj0p/JVIWEi+k/Je
         FDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=FIbO0H5EqhfNmt48Ye6c1keg4szkKmvuJgf3UDoBUIs=;
        b=E4jVP2OpL9L9xQjUz1RlPiQQBTgTyXnNIg7KqeNcd4W7yfS/CLW44wiVvHkjoWytei
         ctwN8YLMpuQvTh3VV68j3JDqMYztBl0C6Cg8jY02oPoH+mzejxXvdstYXNsX9DiE7cOD
         KhlORtleNPgi606bZIQauXL/4xpBeA0REEsT0TRQSFLtPC7AYfSe2WIX0OBH6oIHaROI
         JWbTjtKzxgfki0S/JEC0funyF51x2KpsvkP2EN2FCL8GLvroQZZp/YPuRIADrQM4r+Zn
         DyxJbv3ppymTJ9Vbs6s39dEw9F8+biCK71YxWKONKtdcZpzGUzT0+psua9JNgc0082m1
         yUEg==
X-Gm-Message-State: AOAM533rUPaQJ2QzuT8kwsEfLDFzrzsa55Dbjj2mM2jTkShihREzJs0R
        gfEzSPmvCBXvSQUJHga8mGk=
X-Google-Smtp-Source: ABdhPJygpmPTv86PERc077FPQHiXMOaE0iPnMUgd4iFxGUTHt3i5uxDo9h7YtJBZJYQb4KOCXcJBFw==
X-Received: by 2002:a37:4907:: with SMTP id w7mr4321338qka.492.1594910465588;
        Thu, 16 Jul 2020 07:41:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3423])
        by smtp.gmail.com with ESMTPSA id k194sm6717300qke.100.2020.07.16.07.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:41:04 -0700 (PDT)
Date:   Thu, 16 Jul 2020 10:41:03 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] block: refactor bd_start_claiming
Message-ID: <20200716144103.GB135797@mtj.thefacebook.com>
References: <20200716143310.473136-1-hch@lst.de>
 <20200716143310.473136-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716143310.473136-3-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 16, 2020 at 04:33:08PM +0200, Christoph Hellwig wrote:
> Move the locking and assignment of bd_claiming from bd_start_claiming to
> bd_prepare_to_claim.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
