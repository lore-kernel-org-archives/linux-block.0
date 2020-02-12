Return-Path: <SRS0=TQg9=4A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E9EC352A4
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 21:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FD1206D7
	for <linux-block@archiver.kernel.org>; Wed, 12 Feb 2020 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581542407;
	bh=GIcfLJ/kAlm0Ag1pvocMMuNM0n6xyVSBoWBw0xNFnJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wK663bjtwqkgV/VZ9bC0JyuMEVVBesoT/dq048K1PsjC8kfaFmZoqsIzXwvvUnjKF
	 4jxr1rZZM0H5CWLm9sL681duLlRXtaR9WMTSejaUak9DLQVlDxo0SQcw5ysuTUwE2Y
	 x5UBwqMwtK9jEB7ibAQf9j7I1YBR/gmE4NpexA7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgBLVUG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:20:06 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:37253 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLVUG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 16:20:06 -0500
Received: by mail-qt1-f180.google.com with SMTP id w47so2777923qtk.4
        for <linux-block@vger.kernel.org>; Wed, 12 Feb 2020 13:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1bU26zeh4MdvuXmPDJT4p/4xaGLd8hghveN0fr+YHY4=;
        b=Tv8esNDefrmk6Kmupm/EaTHf5ru45YLxxKqNNXRtAkjaOpWSIkrYF7ukgonzPJtxtI
         VTXwBRSnGvkB52o0AXsJpZ/CEopmaaKj9kAZ44DADajQ0Rx42OL8WGbkptPAWhTsXwQD
         3+CTMy1x3F9kNFtlEf+ecVOcA4HlOPUJxOROaVMZMjxPDNIu92BFIWopQuOYndUs2TZu
         cUpUnTvKx5Phfb3S2mFJsDBSC3gwq1ZDXmRyd8TvhyUqzp3b8o4Eh/l6XJ1Lu6f0ORR6
         SsylezaiR9VrEFGjUrSigplD/+rIaqMtX/d4JDogrHZ7JjQ1Ns82RELnTtPqq2BZJIKp
         2SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1bU26zeh4MdvuXmPDJT4p/4xaGLd8hghveN0fr+YHY4=;
        b=hEP+VcOhbuMiEEn2BvdwNBLLDucwCE5s9oAOWFGKm4Wnzgt9zKKoQ+98veZq7+vX0X
         sAE7RgiW/b2vCNaA+aybhJDofbXi1LoerhYgh2zboGGNu3kbmgHFR4xggJqhUToMV6nJ
         bMA6LUXRlcBIb+LF+uPIxhL5IYLVwoqXlAhhKmFK57GWmDfDdZrKx+RMpIETuX/qYj40
         FKOHCRR9SuUrciDnr79GyITLS02VBxIwcKK4J0L0yvy6qw4Tlkfi2lZsJJ3KnTQnbzPP
         +xQIqVdd7bMK+1mIcbCyDsAQ2I5Q13ZXiOK7v36eQ1eY4y06He/1WqnhYfSEvm4FOdbs
         aBqg==
X-Gm-Message-State: APjAAAVqTw6g4F9rj1Zp1i2fu1+Ji85NzD6FYjTddhdOnCvHoXzznGSz
        PxFsJGOT6pCCUlAew2gtfB0=
X-Google-Smtp-Source: APXvYqwiKoGH+Fide9YL6ATH4CTwLKYFzJDPZMJBo6X3q/gMEPXa8DYj1BEQ0TXNUKxJtj1UVk0qYg==
X-Received: by 2002:ac8:1ca:: with SMTP id b10mr8779886qtg.314.1581542405153;
        Wed, 12 Feb 2020 13:20:05 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id w41sm211462qtj.49.2020.02.12.13.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:20:04 -0800 (PST)
Date:   Wed, 12 Feb 2020 16:20:04 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>
Subject: Re: iocost_monitor.py tells that iocost is not enabled
Message-ID: <20200212212004.GD80993@mtj.thefacebook.com>
References: <8FD4B865-5984-476F-BE47-98938D162749@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8FD4B865-5984-476F-BE47-98938D162749@linaro.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There was a change to drgn which required a minor update to the script
(9ea37e24d4a9). Can you see whether you see the failure w/ the commit
applied?

Thanks.

-- 
tejun
