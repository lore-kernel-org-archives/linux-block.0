Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0838C35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 21:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D29520838
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 21:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="VqmOsK9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgBCVnW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 16:43:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35222 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgBCVnV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 16:43:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id y73so8280081pfg.2
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 13:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0N0jt0TdNXYtdHHJ7QYNGqp+RSiMiocKh3FIkSNyIBw=;
        b=VqmOsK9IvcHYJduTaWEviQm+3Mi48pVjvagbx+lwWJ1ynij0ayIadiX9+byWpRpRfZ
         1oAfLWXPRtLFA2NnU3oarhrwJLiUZ2NhTiC60RQAbeZ7XN/mk+pzpP5IhfTFGXsdZaJk
         1ufgJHG7oYEkThb9MPfNzRyshOiaoV/m6ZhsFci4Ca0cqJ0h+JezTTXGjzrcdi4PICI3
         ZfnnsOv6CHkIULUhVr32T51SAGrG4313IIySZj8DYZuv+ISJhIRxBMlx85mFZtX4NhES
         P0OwSkXyYeyu07Phwe2qakCMLe40/SLPAIGE1erXuLBay4fwloXdSQK2gx6CQT7nmNpk
         0Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0N0jt0TdNXYtdHHJ7QYNGqp+RSiMiocKh3FIkSNyIBw=;
        b=cecX94l2H4zdUxioIOhQil10A/LWOHgnjkmtmEfbHjEeU4HgcXT/qkoMlapQEWX5IE
         vyUlN54iLy0bobqKGe3hLm2YMnst+i+euGWI2BnfTOo4gPnrvJ2UbZwwWGMV76NcT+YB
         BQ4KpXyJ9uuA8C+zwPui8VR9+/0CVyPRRIqOz7E4zAVFPeYHQnc0z7lWUj5HxhLBuBvg
         VxGdlYUKzL3Iq4EBGns+65lzo36HxgFMr4S45rCFMUz2Bkl2LsOfimzS0xhYoFxWa0/Z
         OQJW+GFVOrQiL7mlxnnwTl9rwEECFWmGWmFTEE2Ut7m14aWLdxeFs25VhDVJjnOpSQ7Q
         nOcw==
X-Gm-Message-State: APjAAAUr3EvUvd2Xyd8aHYP03h62ZAMhVyV9OcQZsOGTPTxhFLCfa6VY
        PNxSieCHNAJzCaA9UGDuaPI1dg==
X-Google-Smtp-Source: APXvYqyc4l95HrYrwmbrvVYbia/Mt2JBI91KSuz6SlcbKefWbhaGPb4IFHYk7iHI/KgLLVGxsSVLbA==
X-Received: by 2002:a17:902:8f91:: with SMTP id z17mr25468067plo.234.1580766201154;
        Mon, 03 Feb 2020 13:43:21 -0800 (PST)
Received: from vader ([2620:10d:c090:200::d68d])
        by smtp.gmail.com with ESMTPSA id b98sm431115pjc.16.2020.02.03.13.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:43:20 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:43:20 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Klaus Jensen <k.jensen@samsung.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, its@irrelevant.dk
Subject: Re: [PATCH blktests] common/fio: do not use norandommap with verify
Message-ID: <20200203214320.GB1025074@vader>
References: <CGME20200130084950eucas1p2dac69024658d531d5f69ea0bdbd2be81@eucas1p2.samsung.com>
 <20200130084941.60943-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130084941.60943-1-k.jensen@samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 30, 2020 at 09:49:41AM +0100, Klaus Jensen wrote:
> As per the fio documentation, using norandommap with an async I/O engine
> and I/O depth > 1, can cause verification errors.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Good catch, applied. Thanks!
